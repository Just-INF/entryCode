# justCompile Node.js Application

## Overview

justCompile is a Node.js application that provides a RESTful API for compiling and running C++ code. The application supports optional timeouts and memory limits for compilation and execution. It also includes features for code validation, sanitization, and rate limiting to control the frequency of API requests. The application is designed to run in a Docker container.

## Features

- **Compiles and runs C++ code using the g++ compiler**
- **Supports optional timeouts and memory limits for compilation and execution**
- **Validates and sanitizes code content to prevent unsafe code execution**
- **Returns the output of the executed code**
- **Rate limiting to control the frequency of API requests**

## Configuration

The configuration settings for the application include rate limiting parameters, default parameters for compilation and execution, and a list of blacklisted functions. These settings are defined in the `config` object and exported for use in other parts of the application.

```javascript
const config = {
// Rate Limiter
apiTimeLimit: '7500',  // Time window for rate limiting in milliseconds
apiMaxRequest: '1',    // Maximum number of requests allowed within the time window

// Default Parameters
compileTimeOut: '10000',  // Maximum time allowed for code compilation in milliseconds
execTimeOut: '5000',      // Maximum time allowed for code execution in milliseconds
compileMaxMemory: '64',   // Maximum memory allowed for compilation in megabytes
execMaxMemory: '4',       // Maximum memory allowed for execution in megabytes

// Blacklisted Functions
blacklistedFunctions: ['system', 'exec', 'fork', 'pawn']  // Functions that are not allowed in the submitted code
};

module.exports = config;
```

## Index JS Code

The main application code initializes the Express.js server, sets up middleware for JSON request parsing, and defines route handlers for handling incoming requests.

```javascript
const express = require('express');
const app = express();

// Enable parsing JSON request bodies
app.use(express.json());

// Import route handlers
const indexRoute = require('./main');
const compileRoute = require('./compile');

// Use route handlers
app.use('/', indexRoute);
app.use('/compile', compileRoute);

// Start the server
const PORT = process.env.PORT || 6969;
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
```

### Explanation

1. **Express Application Setup**:
   - The `express` module is used to create an instance of an Express application named `app`.
   - `app.use(express.json())` middleware is employed to parse incoming JSON request bodies, enabling the application to handle JSON data sent by clients effectively.

2. **Route Handlers**:
    - **Index Route (`./`)**
The index route is essential for providing basic information about the application and handling any necessary health checks.
   - **Compile Route (`'/compile'`)**: The `compileRoute` variable holds the route handler imported from `./compile`. This handler is specialized for handling requests related to compiling and executing C++ code submitted via the API. It ensures that the code is validated, compiled with specified parameters (such as timeouts and memory limits), and executed securely within the constraints set by the application.

3. **Server Initialization**:
   - The server begins listening for incoming connections on a specified port (`PORT`), which is determined by the `process.env.PORT` environment variable. If the environment variable is not set, the server defaults to listening on port `6969`.
   - Upon successfully starting the server, a message is logged to the console indicating the port number on which the server is now actively listening for incoming requests.
   - 
   
---
## Compile Route (/compile)
The compile route handles POST requests containing C++ code to be compiled and executed. It utilizes the compileAndRunCode function to perform the compilation and execution securely within the application's configured limits.

### Dependencies
```javascript
const express = require('express');
const router = express.Router();
const fs = require('fs');
const os = require('os');
const path = require('path');
const childProcess = require('child_process');
const config = require('./index');
```
 - express: Framework for building web applications in Node.js.
 - fs: File system module for interacting with the file system.
 - os: Operating system-related utility functions.
 - path: Utility for working with file and directory paths.
 - childProcess: Provides the ability to spawn child processes in Node.js.
 - config: Configuration settings for the application, including timeouts, memory limits, and blacklisted functions.

### Rate Limiting Middleware
```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: config.apiTimeLimit,
  max: config.apiMaxRequest,
  delayMs: 0
});

router.use(limiter);

```
 - rateLimit: Middleware for rate limiting incoming requests to prevent abuse.
 - limiter: Configured with parameters from config to limit API requests within a specified time window (windowMs) and maximum number (max) without delay (delayMs).

 
### JSON Body Parsing
```javascript
router.use(express.json()); 
```
 - Middleware to parse JSON request bodies, enabling the server to handle JSON data sent by clients.

### Compile And Run Function
```javascript
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
        // Mask sensitive information in the error message
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
```

The `compileAndRunCode` function is designed to compile and execute C++ code securely within a Node.js and Docker environment. Let's break down each part of the function:

1. **Temporary Directory and Files Setup:**
   - `tempDir`: Creates a temporary directory using `fs.mkdtempSync` in the system's temporary directory (`os.tmpdir()`), with a prefix of `'code-'`.
   - `codeFile`: Path to the file where the C++ code (`cppCode`) will be written (`code.cpp`).
   - `outputFile`: Path where the compiled output will be saved (`output`).

2. **Writing C++ Code to File:**
   - `fs.writeFileSync(codeFile, cppCode);`: Writes the provided C++ code (`cppCode`) to `codeFile`.

3. **Compiling the C++ Code:**
   - `compileCommand` and `compileArgs`: Command (`g++`) and arguments to compile `codeFile` into `outputFile`.
   - `compileMaxMemoryBytes`: Maximum memory limit for the compilation process in bytes.
   - `compileTimeOut`: Timeout for the compilation process converted from seconds to milliseconds.

4. **Compilation Process Handling:**
   - `childProcess.spawn(compileCommand, compileArgs, { maxBuffer: compileMaxMemoryBytes })`: Spawns a child process (`compileProcess`) to execute the compilation command (`g++`).
   - `compileProcess.stderr.on('data', ...)`: Collects compilation errors (`stderr` output).
   - `compileProcess.on('close', ...)`: Handles the completion of the compilation process:
     - Checks if compilation succeeded (`code === 0`). If not, rejects the promise with a masked compilation error message.

5. **Executing the Compiled Output:**
   - `execProcess`: Similar setup as `compileProcess` but spawns a child process to execute `outputFile`.
   - `execProcess.stdout.on('data', ...)`: Collects standard output (`stdout`) from the execution process.
   - `execProcess.stderr.on('data', ...)`: Collects standard error (`stderr`) from the execution process.

6. **Execution Process Handling:**
   - `execProcess.on('close', ...)`: Handles the completion of the execution process:
     - Checks if execution succeeded (`code === 0`). If not, rejects the promise with a masked execution error message.
     - Resolves the promise with the execution output (`execOutput`) if successful.
     - Cleans up (`fs.rmSync`) the temporary directory (`tempDir`) after execution, removing all associated files.

7. **Error Handling:**
   - Various `setTimeout` functions are used to handle timeouts for both compilation and execution processes.
   - Errors from both compilation and execution processes (`error` events) are caught and rejected with appropriate error messages.

This function encapsulates the entire process of compiling and executing C++ code securely within the Node.js  and Docker environment, ensuring proper resource management, error handling, and security measures such as masking sensitive file paths in error messages. Adjustments can be made based on specific application requirements or additional security considerations.


### Validate Code Function
```javascript
function validCode(code) {
  const blacklistedFunctions = config.blacklistedFunctions;
  for (const func of blacklistedFunctions) {
    if (code.includes(func)) {
      return false; // Invalid code
    }
  }
  return true; // Valid code
}

```
 - validCode: Function to validate C++ code (code) against a list of blacklisted functions (config.blacklistedFunctions). Returns true if the code is valid (doesn't contain blacklisted functions) and false otherwise.
 
### Handling POST Requests
```
router.post('/', (req, res) => {
  if (!req.body || !req.body.code) {
    res.status(400).json({ error: 'Missing "code" key' });
  } else {
    // Extract timeout and memory limit values from the request body
    let compileTimeOut = req.body.compileTimeOut || config.compileTimeOut;
    let execTimeOut = req.body.execTimeOut || config.execTimeOut;
    let compileMaxMemory = req.body.compileMaxMemory || config.compileMaxMemory;
    let execMaxMemory = req.body.execMaxMemory || config.execMaxMemory;

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

```
 - POST `/compile` Route: Handles POST requests containing C++ code (`req.body.code`):
    - Validates presence of `code` key in request body.
    - Extracts timeout and memory limit values from request body or uses default values from `config`.
    - Validates code using `validCode` function; responds with an error if code contains blacklisted functions.
    - Calls `compileAndRunCode` function to compile and execute the code, then sends the output or error response.
 
### Export Router
```javascript
module.exports = router;
```
 - Exports the configured Express router (router) to be used in other parts of the application.


----

**Dockerization**
----------------

This project uses Docker to sandbox the Node.js application and ensure isolation from the host system. The Docker image is built using the `Dockerfile` in the root of the project.

**Dockerfile**
-------------

The `Dockerfile` is used to build a Docker image for the Node.js application. It:

* Uses an official Node.js runtime as a parent image
* Installs `g++` and other necessary tools
* Creates a non-root user `compileruser`
* Sets the working directory to `/usr/src/app`
* Copies the `package.json` file and installs dependencies
* Copies the rest of the application code
* Changes to the non-root user
* Exposes port 6969 for the web server
* Sets the command to run the Node.js script

**docker-compose.yml**
---------------------

The `docker-compose.yml` file is used to define and run multi-container Docker applications. It:

* Defines a service `compiler` that uses the Docker image built from the `Dockerfile`
* Maps port 6969 on the host machine to port 6969 in the container
* Sets environment variables for the container

**Purpose of Dockerization**
---------------------------

Dockerization provides several benefits, including:

* **Sandboxing**: The Node.js application runs in a isolated environment, preventing it from accessing sensitive data or system resources on the host machine.
* **Portability**: The Docker image can be run on any system that supports Docker, without worrying about compatibility issues.
* **Easy deployment**: The Docker image can be easily deployed to a cloud platform or a container orchestration system like Kubernetes.
  
**Getting started**
---------------------------
**Host System Package Dependencies**
* Docker
* Docker-Compose
* Node JS (>= 13, preferably 20.14.0)
  
**After system dependencies are installed, clone this repository:**
```bash
# clone and enter repo
git clone https://github.com/Just-INF/justCompile
```
**Build and run**
```bash
bash startDocker.sh
```

**License**
----------

This project is licensed under the MIT License. See `LICENSE` for details.






```