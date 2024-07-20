const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const JWT_SECRET = 'bazinga'; // Replace with your JWT secret

// Middleware to verify JWT token
const verifyToken = (req, res, next) => {
    const token = req.headers['authorization'];
    if (!token) return res.status(403).json({ message: 'No token provided' });

    const tokenParts = token.split(' ');
    if (tokenParts.length !== 2 || tokenParts[0] !== 'Bearer') {
        return res.status(401).json({ message: 'Token format is invalid' });
    }

    jwt.verify(tokenParts[1], JWT_SECRET, (err, decoded) => {
        if (err) return res.status(500).json({ message: 'Failed to authenticate token' });
        req.userId = decoded.id;
        next();
    });
};

router.post('/edit/firstName', verifyToken, async (req, res) => {
    console.log('firstName change request body:', req.body);

    const { firstName } = req.body;

    try {
        const user = await Users.findOne({ _id : req.userId });

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

router.post('/edit/lastName', verifyToken, async (req, res) => {
    console.log('lastName change request body:', req.body);

    const { lastName } = req.body;

    try {
        const user = await Users.findOne({ _id : req.userId  });

        if (!user) {
            console.log('Invalid token:', token);
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

router.post('/edit/profilePicture', verifyToken, async (req, res) => {
    console.log('profilePicture change request body:', req.body);
    
    const { profilePicture } = req.body;

    try {
        const user = await Users.findOne({ _id : req.userId  });
        if (!user) {
            return res.status(400).json({ message: 'An error occurred in verifying the current user' });
        }

        user.profilePicture = profilePicture;
        await user.save();
        console.log('User profilePicture changed to %d', profilePicture);

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