const mysql = require('mysql2/promise');
const config = require('../config');

// Create a connection pool
const pool = mysql.createPool(config.database);

module.exports = pool;