const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const JWT_SECRET = 'bazinga'; // Replace with your JWT secret

// Verify email
router.get('/verify-email', async (req, res) => {
    const { token } = req.query;
    console.log('Verify email token:', token);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        user.verification = true;
        await user.save();
        console.log('User email verified:', user);

        res.status(200).json({ message: 'Email verified' });
    } catch (error) {
        console.error('Error during email verification:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
