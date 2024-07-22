// services/verifyToken.js
require('dotenv').config();
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');
const JWT_SECRET = process.env.JWT_SECRET; 

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

const verifyEmailToken = async (token) => {
    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            throw new Error('Invalid token');
        }

        user.verification = true;
        await user.save();
        return { message: 'Email verified', user };
    } catch (error) {
        throw new Error(`Error during email verification: ${error.message}`);
    }
};

module.exports = {
    verifyToken,
    verifyEmailToken,
};
