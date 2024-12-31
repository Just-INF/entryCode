const tables = require('./createTables');
const db = require('../database');

const reset = "\x1b[0m"; // Reset to default
const red = "\x1b[31m"; // Red

let isDbOn = false; // Flag to indicate database status

// Test Connection
async function testConnection() {
    let connection;
    try {
        connection = await db.getConnection();
        console.log('Database connection successful.');
        isDbOn = true;

        // Optionally perform a simple query to verify connection
        const [rows] = await connection.query('SELECT 1 + 1 AS result');
        console.log('Test query result:', rows[0].result);
    } catch (err) {
        console.error('Error connecting to the database:', err.message);
        isDbOn = false;
    } finally {
        if (connection) connection.release(); // Ensure the connection is released if it was acquired
    }
}

// Initialize function
async function init(app) {
    await testConnection();         // Test database connection
    await tables.createTables();    // Run table creation
}

async function getDbStatus() {
    return isDbOn;
}

module.exports = { init, getDbStatus };
