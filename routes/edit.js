// routes/edit.js
const express = require('express');
const router = express.Router();
const Users = require('../models/Users');
const { verifyToken } = require('../services/verifyToken');

// Change first name
router.post('/edit/firstName', verifyToken, async (req, res) => {
    console.log('firstName change request body:', req.body);

    const { firstName } = req.body;

    try {
        const user = await Users.findOne({ _id: req.userId });

        if (!user) {
            console.log('Invalid token:', req.headers['authorization']);
            return res.status(400).json({ message: 'Invalid token' });
        }

        user.firstName = firstName;
        await user.save();
        console.log('User first name changed to %s', firstName);

        return res.status(200).json({
            message: 'firstName change successful',
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
        console.error('Error during firstName change:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Change last name
router.post('/edit/lastName', verifyToken, async (req, res) => {
    console.log('lastName change request body:', req.body);

    const { lastName } = req.body;

    try {
        const user = await Users.findOne({ _id: req.userId });

        if (!user) {
            console.log('Invalid token:', req.headers['authorization']);
            return res.status(400).json({ message: 'Invalid token' });
        }

        user.lastName = lastName;
        await user.save();
        console.log('User last name changed to %s', lastName);

        return res.status(200).json({
            message: 'lastName change successful',
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
        console.error('Error during lastName change:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Change profile picture
router.post('/edit/profilePicture', verifyToken, async (req, res) => {
    console.log('profilePicture change request body:', req.body);

    const { profilePicture } = req.body;

    try {
        const user = await Users.findOne({ _id: req.userId });
        if (!user) {
            return res.status(400).json({ message: 'An error occurred in verifying the current user' });
        }

        user.profilePicture = profilePicture;
        await user.save();
        console.log('User profile picture changed to %s', profilePicture);

        return res.status(200).json({
            message: 'profilePicture change successful',
            user: {
                id: user._id,
                username: user.username,
                email: user.email,
                firstName: user.firstName,
                lastName: user.lastName,
                verification: user.verification,
                profilePicture: user.profilePicture
            }
        });
    } catch (error) {
        console.error('Error during profilePicture change:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
