const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Users = require('../models/Users');
const JWT_SECRET = 'bazinga'; // Replace with your JWT secret

router.post('/editFirstName', async (req, res) => {
    const { token, firstName } = req.body;
    console.log('firstName change request body:', req.body);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ username: decoded.username });

        if (!user) {
            console.log('Invalid token:', token);
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

router.post('/editLastName', async (req, res) => {
    const { token, lastName } = req.body;
    console.log('lastName change request body:', req.body);

    try {
        const user = await Users.findOne({ username:username });
        if (!user) {
            return res.status(400).json({ message: 'An error occurred in verifying the current user' });
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

module.exports = router;