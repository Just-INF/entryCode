**README.md**
================

**Project Overview**
-------------------

This project is a Node.js application that provides a RESTful API for compiling and running C++ code. The API allows users to submit C++ code, along with optional compilation and execution timeouts and memory limits, and returns the output of the executed code.

**Features**
------------

* Compiles and runs C++ code using the `g++` compiler
* Supports optional timeouts and memory limits for compilation and execution
* Validates and sanitizes code content to prevent unsafe code execution
* Returns the output of the executed code
* Rate limiting to control the frequency of API requests

**API Endpoints**
----------------

### `/.`

* **Method:** `GET`
* **Request Body:**
	+ `message`: Simple message to show that the server is running
	+ `version`: Version of running justCompile project
	+ `author`: Author of the project ( Just-INF )

### `/compile`

* **Method:** `POST`
* **Request Body:**
	+ `code`: The C++ code to be compiled and executed
	+ `compileTimeOut`: Optional compilation timeout in seconds (default: 10 seconds)
	+ `execTimeOut`: Optional execution timeout in seconds (default: 5 seconds)
	+ `compileMaxMemory`: Optional compilation memory limit in MB (default: 64 MB)
	+ `execMaxMemory`: Optional execution memory limit in MB (default: 4 MB)
* **Response:**
	+ `output`: The output of the executed code
	+ `error`: An error message if compilation or execution fails

**API Configuration**
-------------------
The configuration is defined in the `index.js` file as follows:
```js
const config = {
  // Rate Limiter
  apiTimeLimit: '7500',
  apiMaxRequest: '1',

  // Default Parameters
  compileTimeOut: '10000',
  execTimeOut: '5000',
  compileMaxMemory: '64',
  execMaxMemory: '4',

  // BlackListed Functions
  blacklistedFunctions: ['system', 'exec', 'fork', 'spawn']
};
```
**API Explanation**
-------------------

The API consists of a single endpoint, `/compile`, which accepts a POST request with a JSON body containing the C++ code to be compiled and executed. The request body can also include optional parameters for compilation and execution timeouts and memory limits.

Here is an example of a valid request body:
```json
{
  "code": "#include <iostream>\nint main() {\n    std::cout << \"Hello, World!\" << std::endl;\n    return 0;\n}",
  "compileTimeOut": 10,
  "execTimeOut": 5,
  "compileMaxMemory": 64,
  "execMaxMemory": 4
}
```
The API will respond with a JSON object containing the output of the executed code, or an error message if compilation or execution fails.

Here is an example of a successful response:
```json
{
  "output": "Hello, World!\n"
}
```
And here is an example of an error response:

```json
{
  "error": "Compilation failed with code 1"
}
```

**Security**
------------

The project includes a `validCode` function that checks the submitted code for blacklisted functions, such as `system`, `exec`, `fork`, and `spawn`, to prevent unsafe code execution.

**Dependencies**
---------------
* `express`: A Node.js web framework for building the API
* `fs`: A Node.js module for interacting with the file system
* `os`: A Node.js module for interacting with the operating system
* `child_process`: A Node.js module for spawning child processes

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
