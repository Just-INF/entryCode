const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  const data = {
    message: 'JustCompile - A simple C++ compiler',
    version: '1.0',
    author: 'JustINF',
  };

  res.set('Content-Type', 'application/json');
  res.send(JSON.stringify(data, null, 2)); // Send a JSON response with information about the compiler
});

module.exports = router;
