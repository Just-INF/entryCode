const express = require('express');
const multer = require('multer');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const sendEmail = require('./sendEmail');
const db = require('../database');
const config = require('../../config');

const router = express.Router();



// Change UserName
router.post('/username', async (req, res) => {
  const { oldUserName, newUserName } = req.body;
  try {
    // Check if the new username already exists
    const [existingUser] = await db.query('SELECT * FROM users WHERE username = ?', [newUserName]);
    if (existingUser.length > 0) {
      return res.status(400).json({ message: 'Username already exists' });
    }

    // Update the username in the database
    await db.query(
      'UPDATE users SET username = ? WHERE username = ?',
      [newUserName, oldUserName]
    );

    // Retrieve the updated user info from the database
    const [updatedUser] = await db.query('SELECT * FROM users WHERE username = ?', [newUserName]);
    
    // Generate a new JWT with the updated username
    const newToken = jwt.sign(
      { id: updatedUser[0].id, username: updatedUser[0].username, email: updatedUser[0].email },
      config.jwtSecret,
      { expiresIn: '1h' }
    );

    // Respond with the new token
    res.json({ newToken });
  } catch (err) {
    res.status(500).send(err.message);
  }
});



// Upload Profile Picture

const upload = multer({ dest: 'pfp/' }); // Folder where uploaded files will be stored

router.post('/upload', upload.single('profile_picture'), (req, res) => {
    if (!req.file) {
        return res.status(400).send('No file uploaded.');
    }
    res.send(`File uploaded successfully: ${req.file.path}`);
});



module.exports = router;
