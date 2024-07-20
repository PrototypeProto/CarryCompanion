// routes/resetEmail.js
require('dotenv').config();
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const { sendVerificationEmail } = require('../services/email');
const { verifyToken } = require('../services/verifyToken');
const JWT_SECRET = process.env.JWT_SECRET;

// Request email reset
router.post('/reset-email', verifyToken, async (req, res) => {
    const { password, newEmail } = req.body;
    console.log('Email reset request body:', req.body);

    try {
        const user = await Users.findById(req.userId);
        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid password' });
        }

        const token = jwt.sign({ newEmail }, JWT_SECRET, { expiresIn: '1h' });
        const verificationUrl = `http://localhost:5000/api/verify-new-email?token=${token}`;
        console.log('New verification URL:', verificationUrl);
        await sendVerificationEmail(newEmail, verificationUrl);

        res.status(200).json({ message: 'Verification email sent. Please verify your new email.' });
    } catch (error) {
        console.error('Error during email reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Verify new email
router.get('/verify-new-email', async (req, res) => {
    const { token } = req.query;
    console.log('Verify new email token:', token);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findById(req.userId);

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        user.email = decoded.newEmail;
        await user.save();
        console.log('User email updated:', user);

        res.status(200).json({ message: 'Email verified and updated' });
    } catch (error) {
        console.error('Error during new email verification:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
