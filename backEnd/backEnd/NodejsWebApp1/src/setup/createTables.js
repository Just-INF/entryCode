const db = require('../database'); // Ensure this is the correct path

async function createTables() {
  // Create User Table
  const createUsersTableSQL = `
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY, 
      email VARCHAR(255) NOT NULL UNIQUE,
      username VARCHAR(255) DEFAULT NULL,
      password VARCHAR(255) DEFAULT NULL,
      currentPIN VARCHAR(6) DEFAULT NULL
    )
  `;

  try {
    const [results] = await db.query(createUsersTableSQL);
    console.log('Table created or already exists.');
  } catch (error) {
    console.error('Error creating table:', error.message);
  }
}

module.exports = { createTables };
