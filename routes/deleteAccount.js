require('dotenv').config();
const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Users = require('../models/Users');
const { verifyToken } = require('../services/verifyToken');
const { sendAccountDeletionEmail, sendDeletionNotificationEmail } = require('../services/email');
const JWT_SECRET = process.env.JWT_SECRET;

// Request account deletion
router.post('/request-deletion', verifyToken, async (req, res) => {
    try {
        const user = await Users.findById(req.userId);
        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        const token = jwt.sign({ email: user.email }, JWT_SECRET, { expiresIn: '1h' });
        const deletionUrl = `http://localhost:5000/api/deletion?token=${token}`;
        await sendAccountDeletionEmail(user.email, deletionUrl);

        res.status(200).json({ message: 'Account deletion email sent' });
    } catch (error) {
        console.error('Error during account deletion request:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Serve the account deletion form
router.get('/deletion', async (req, res) => {
    const { token } = req.query;
    console.log('Account deletion token:', token);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        // Serve the account deletion page
        res.send(`
            <form action="/api/deletion" method="POST">
                <input type="hidden" name="token" value="${token}" />
                <input type="password" name="password" placeholder="Confirm your password" required />
                <button type="submit">Confirm Account Deletion</button>
            </form>
        `);
    } catch (error) {
        console.error('Error during account deletion:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Handle account deletion form submission
router.post('/deletion', async (req, res) => {
    const { token, password } = req.body;
    console.log('Account deletion request:', req.body);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Incorrect password' });
        }

        // Schedule account deletion
        const deletionDate = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days from now
        user.deletionDate = deletionDate;
        await user.save();
        await sendDeletionNotificationEmail(user.email);

        res.status(200).json({ message: 'Account deletion scheduled' });
    } catch (error) {
        console.error('Error during account deletion:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
