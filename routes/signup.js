// routes/signup.js
require('dotenv').config();
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const { sendVerificationEmail } = require('../services/email');
const JWT_SECRET = process.env.JWT_SECRET

// User registration (signup)
router.post('/signup', async (req, res) => {
    const { username, password, firstName, lastName, email } = req.body;
    console.log('Signup request body:', req.body);

    try {
        const existingEmail = await Users.findOne({ email });
        if (existingEmail) {
            console.log('Email already exists:', email);
            return res.status(400).json({ message: 'Email already exists' });
        }

        const existingUsername = await Users.findOne({ username });
        if (existingUsername) {
            console.log('Username already exists:', username);
            return res.status(400).json({ message: 'Username already exists' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new Users({
            username,
            password: hashedPassword,
            firstName,
            lastName,
            email,
            verification: false,
        });

        const token = jwt.sign(
            { email },
            JWT_SECRET,
            { expiresIn: '1h' }
        );

        const verificationUrl = `http://localhost:5000/api/verify-email?token=${token}`;
        console.log('Verification URL:', verificationUrl);
        await sendVerificationEmail(email, verificationUrl);

        await newUser.save();
        console.log('New user saved:', newUser);

        res.status(200).json({ message: 'Verification email sent' });
    } catch (error) {
        console.error('Error during signup:', error);
        res.status(500).json({ message: 'Server error', error });
    }
});

module.exports = router;
