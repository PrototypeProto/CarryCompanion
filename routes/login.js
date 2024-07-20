// routes/login.js
require('dotenv').config();
const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Users = require('../models/Users');
const { sendVerificationEmail } = require('../services/email');
const JWT_SECRET = process.env.JWT_SECRET;

// User login
router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    console.log('Login request body:', req.body);

    try {
        const user = await Users.findOne({ username });
        if (!user) {
            return res.status(400).json({ message: 'Invalid username or password' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid username or password' });
        }

        if (!user.verification) {
            const token = jwt.sign({ email: user.email }, JWT_SECRET, { expiresIn: '1h' });
            const verificationUrl = `http://localhost:5000/api/verify-email?token=${token}`;
            console.log('Resending verification URL:', verificationUrl);
            await sendVerificationEmail(user.email, verificationUrl);

            return res.status(403).json({ message: 'Account not verified. Verification email resent.' });
        }

        const token = jwt.sign({ id: user._id, username: user.username }, JWT_SECRET, { expiresIn: '1h' });

        return res.status(200).json({
            message: 'Login successful',
            token,
            user: {
                id: user._id,
                username: user.username,
                email: user.email,
                firstName: user.firstName,
                lastName: user.lastName,
                verification: user.verification
            }
        });
    } catch (error) {
        console.error('Error during login:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
