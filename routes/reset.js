require('dotenv').config();
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const { sendPasswordResetEmail, sendVerificationEmail } = require('../services/email');
const JWT_SECRET = process.env.JWT_SECRET;

// Request password reset
router.post('/request-password-reset', async (req, res) => {
    const { email } = req.body;

    try {
        const user = await Users.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Email not found' });
        }

        const token = jwt.sign({ email }, JWT_SECRET, { expiresIn: '1h' });
        const resetUrl = `http://localhost:5000/api/reset-password?token=${token}`;
        await sendPasswordResetEmail(email, resetUrl);

        res.status(200).json({ message: 'Password reset email sent' });
    } catch (error) {
        console.error('Error during password reset request:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Serve the password reset form
router.get('/reset-password', async (req, res) => {
    const { token } = req.query;
    console.log('Password reset token:', token);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        // Serve the password reset page (you can replace this with your frontend URL)
        res.send(`
            <form action="/api/reset-password" method="POST">
                <input type="hidden" name="token" value="${token}" />
                <input type="password" name="newPassword" placeholder="Enter new password" required />
                <button type="submit">Reset Password</button>
            </form>
        `);
    } catch (error) {
        console.error('Error during password reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Handle password reset form submission
router.post('/reset-password', async (req, res) => {
    const { token, newPassword } = req.body;
    console.log('Reset password request:', req.body);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        user.password = hashedPassword;
        await user.save();

        res.status(200).json({ message: 'Password reset successful' });
    } catch (error) {
        console.error('Error during password reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Email reset route
router.post('/reset-email', async (req, res) => {
    const { username, password, newEmail } = req.body;
    console.log('Email reset request body:', req.body);

    try {
        const user = await Users.findOne({ username });
        if (!user) {
            return res.status(400).json({ message: 'Invalid username or password' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid username or password' });
        }

        user.email = newEmail;
        user.verification = false;
        await user.save();

        const token = jwt.sign({ email: newEmail }, JWT_SECRET, { expiresIn: '1h' });
        const verificationUrl = `http://localhost:5000/api/verify-email?token=${token}`;
        console.log('New verification URL:', verificationUrl);
        await sendVerificationEmail(newEmail, verificationUrl);

        res.status(200).json({ message: 'Email reset successful. Verification email sent.' });
    } catch (error) {
        console.error('Error during email reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
