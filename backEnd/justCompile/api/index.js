const express = require('express');
const app = express();


//Config
const config = {
  //Rate Limiter
  apiTimeLimit: '7500',
  apiMaxRequest: '1',

  //Default Parameters
  compileTimeOut: '10000',
  execTimeOut: '5000',
  compileMaxMemory: '64',
  execMaxMemory: '4',

  //BlackListed Functions
  blacklistedFunctions: ['system', 'exec', 'fork', 'pawn']
};

module.exports = config;

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