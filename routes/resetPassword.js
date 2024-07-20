// routes/resetPassword.js
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const Users = require('../models/Users');
const { verifyToken } = require('../services/verifyToken');

// Reset password for logged-in users
router.post('/reset-password', verifyToken, async (req, res) => {
    const { currentPassword, newPassword } = req.body;
    console.log('Reset password request:', req.body);

    try {
        const user = await Users.findById(req.userId);
        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        const isMatch = await bcrypt.compare(currentPassword, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid current password' });
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

module.exports = router;
