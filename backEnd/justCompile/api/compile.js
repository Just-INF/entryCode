const express = require('express');
const router = express.Router();
const fs = require('fs');
const os = require('os');
path = require('path');
const childProcess = require('child_process');
const config = require('./index');

//Rate Limiter
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: config.apiTimeLimit,
  max: config.apiMaxRequest,
  delayMs: 0
});

router.use(limiter);

// Enable parsing JSON request bodies
router.use(express.json()); 

function compileAndRunCode(cppCode, compileTimeOut, execTimeOut, compileMaxMemory, execMaxMemory) {
  return new Promise((resolve, reject) => {
    // Create a temporary directory for the code and output files
    const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), 'code-'));
    const codeFile = path.join(tempDir, 'code.cpp');
    const outputFile = path.join(tempDir, 'output');

    // Write the C++ code to the code file
    fs.writeFileSync(codeFile, cppCode);

    // Compile the code using g++ with the specified timeout and memory limits
    const compileCommand = 'g++';
    const compileArgs = [codeFile, '-o', outputFile];

    // Convert memory limits from MB to bytes
    const compileMaxMemoryBytes = compileMaxMemory * 1024 * 1024;
    const execMaxMemoryBytes = execMaxMemory * 1024 * 1024;

    // Convert timeouts from seconds to milliseconds
    compileTimeOut *= 1000;
    execTimeOut *= 1000;

    // Set up a timeout for the compilation process
    const compileTimeoutId = setTimeout(() => {
      reject({ error: 'Compilation timed out' });
    }, compileTimeOut);

    const compileProcess = childProcess.spawn(compileCommand, compileArgs, {
      maxBuffer: compileMaxMemoryBytes,
    });

    let compileError = '';

    // Collect compilation errors
    compileProcess.stderr.on('data', (data) => {
      compileError += data.toString();
    });

    // Handle compilation process exit
    compileProcess.on('close', (code) => {
      clearTimeout(compileTimeoutId);

      if (code !== 0) {
        // Remove or mask paths in the compileError
        const maskedCompileError = compileError.replace(new RegExp(tempDir, 'g'), '[tempDir]');
        reject({ error: `Compilation failed with code ${code}: ${maskedCompileError}` });
        return;
      }

      // Set up a timeout for the execution process
      const execTimeoutId = setTimeout(() => {
        reject({ error: 'Execution timed out' });
      }, execTimeOut);

      const execProcess = childProcess.spawn(outputFile, [], {
        maxBuffer: execMaxMemoryBytes,
      });

      let execOutput = '';
      let execError = '';

      // Collect execution output and errors
      execProcess.stdout.on('data', (data) => {
        execOutput += data.toString();
      });

      execProcess.stderr.on('data', (data) => {
        execError += data.toString();
      });

      // Handle execution process exit
      execProcess.on('close', (code) => {
        clearTimeout(execTimeoutId);
        if (code !== 0) {
          const maskedExecError = execError.replace(new RegExp(tempDir, 'g'), '[tempDir]');
          reject({ error: `Execution failed with code ${code}: ${maskedExecError}` });
        } else {
          resolve({ output: execOutput });
        }
        // Clean up temporary files and directory
        fs.rmSync(tempDir, { recursive: true, force: true });
      });

      // Handle execution process errors
      execProcess.on('error', (error) => {
        clearTimeout(execTimeoutId);
        reject({ error: error.message });
      });
    });

    // Handle compilation process errors
    compileProcess.on('error', (error) => {
      clearTimeout(compileTimeoutId);
      reject({ error: error.message });
    });
  });
}


function validCode(code) {
  const blacklistedFunctions = config.blacklistedFunctions;
  for (const func of blacklistedFunctions) {
    if (code.includes(func)) {
      return false; // invalid code
    }
  }
  return true; // valid code
}

// Handle /compile route
router.post('/', (req, res) => {
  if (!req.body || !req.body.code) {
    res.status(400).json({ error: 'Missing "code" key' });
  } else {
    // Extract timeout and memory limit values from the request body
    compileTimeOut = req.body.compileTimeOut || config.compileTimeOut;
    execTimeOut = req.body.execTimeOut || config.execTimeOut;
    compileMaxMemory = req.body.compileMaxMemory || config.compileMaxMemory;
    execMaxMemory = req.body.execMaxMemory || config.execMaxMemory;

    // Validate and sanitize code content to prevent unsafe code execution
    if (!validCode(req.body.code)) {
      res.status(400).json({ error: 'Unsafe code detected' });
      return;
    }

    // Call the compileAndRunCode function with the extracted values
    compileAndRunCode(req.body.code, compileTimeOut, execTimeOut, compileMaxMemory, execMaxMemory)
      .then((output) => res.json(output))
      .catch((error) => res.status(400).json(error));
  }
});

module.exports = router;
