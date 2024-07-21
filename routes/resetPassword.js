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
            console.log('User not found for ID:', req.userId);
            return res.status(400).json({ message: 'User not found' });
        }
        console.log('User found:', user);

        const isMatch = await bcrypt.compare(currentPassword, user.password);
        if (!isMatch) {
            console.log('Current password does not match for user:', req.userId);
            return res.status(400).json({ message: 'Invalid current password' });
        }
        console.log('Current password matches for user:', req.userId);

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        user.password = hashedPassword;
        await user.save();
        console.log('New password saved for user:', req.userId);

        res.status(200).json({ message: 'Password reset successful' });
    } catch (error) {
        console.error('Error during password reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
