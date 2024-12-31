const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const sendEmail = require('./sendEmail');
const db = require('../database');
const config = require('../../config');

const router = express.Router();




//Generate Pin
const generatePin = (length = 6) => {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let pin = '';
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * chars.length);
    pin += chars[randomIndex];
  }
  return pin;
};




// Register route
router.post('/register', async (req, res) => {
  const { userEmail } = req.body;
  
  try {
    // Check if the user already exists
    const [email] = await db.query('SELECT * FROM users WHERE email = ?', [userEmail]);
    if (email.length > 0) {
      return res.status(400).json({ message: 'Email already exists' });
    }
    // Generate PIN
    const pin = generatePin();
    console.log(userEmail,pin)
    sendEmail.createNewAccountPin(userEmail,pin);
    // Insert into database
    await db.query('INSERT INTO users (email, currentPIN) VALUES (?, ?)', [userEmail, pin]);
    // Send response with the PIN
    res.status(201).json({ message: 'User registered successfully', pin });

  } catch (err) {
    res.status(500).send(err.message);
  }
});




// Create Account
router.post('/createAccount', async (req, res) => {
  const { userEmail, username, password } = req.body;
  
  try {
    // Check if the user already exists
    const [user] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
    if (user.length > 0) {
      return res.status(400).json({ message: 'Username already exists' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);
    // Insert new user
    await db.query(
      'UPDATE users SET username = ?, password = ?, currentPIN = null WHERE email = ?',
      [username, hashedPassword, userEmail]
    );
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    res.status(500).send(err.message);
  }
});




// Forgot Password
router.post('/forgor', async (req, res) => {
  const { userEmail } = req.body;
  
  try {
    // Check if the user already exists
    const [email] = await db.query('SELECT * FROM users WHERE email = ?', [userEmail]);
    if (email.length < 1) {
      return res.status(400).json({ message: 'Email does not exists' });
    }

    // Generate PIN
    const pin = generatePin();
    sendEmail.forgotPasswordPin(userEmail,pin);
    // Insert into database
    
    await db.query(
      'UPDATE users SET currentPIN = ? WHERE email = ?',
      [pin, userEmail]
    );

    
    res.status(201).json({ message: 'Forgot Password', pin });

  } catch (err) {
    res.status(500).send(err.message);
  }
});




//Recover
router.post('/recover', async (req, res) => {
  const { userEmail, password } = req.body;
  
  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);
    // Insert new user
    await db.query(
      'UPDATE users SET password = ?, currentPIN = null WHERE email = ?',
      [hashedPassword, userEmail]
    );
    res.status(201).json({ message: 'Password Reseted!' });
  } catch (err) {
    res.status(500).send(err.message);
  }
});




// Login route
router.post('/login', async (req, res) => {
  const { identifier, password } = req.body;

  try {
    // Check if the user exists by username or email
    const [user] = await db.query(
      'SELECT * FROM users WHERE username = ? OR email = ?',
      [identifier, identifier]
    );
    if (user.length === 0) {
      return res.status(400).json({ message: 'Invalid username/email or password' });
    }
    const dbPassword = user[0].password;

    // Compare passwords
    const isMatch = await bcrypt.compare(password, dbPassword);
    if (!isMatch) {
      return res.status(400).json({ message: 'Invalid username/email or password' });
    }
    // Generate JWT
    const token = jwt.sign(
      { id: user[0].id, username: user[0].username, email: user[0].email },
      config.jwtSecret,
      { expiresIn: '1h' }
    );

    res.json({ token });

  } catch (err) {
    res.status(500).send(err.message);
  }
});



module.exports = router;
