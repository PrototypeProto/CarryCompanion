const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const Arsenal = require('../models/Arsenal');
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

// Add a weapon to the arsenal
router.post('/armory', verifyToken, async (req, res) => {
    try {
        const { type, datePurchased, manufacturer, model } = req.body;
        const weapon = new Arsenal({ type, datePurchased, manufacturer, model });
        await weapon.save();

        // Add weapon to user's arsenal array
        await Users.findByIdAndUpdate(req.userId, { $push: { arsenal: weapon._id } });

        res.status(201).json({ message: 'Weapon added', weapon });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Edit a weapon in the arsenal
router.put('/armory/:id', verifyToken, async (req, res) => {
    try {
        const { id } = req.params;
        const { type, datePurchased, manufacturer, model } = req.body;
        const updatedWeapon = await Arsenal.findByIdAndUpdate(
            id,
            { type, datePurchased, manufacturer, model },
            { new: true }
        );
        if (!updatedWeapon) {
            return res.status(404).json({ success: false, message: 'Weapon not found' });
        }
        res.status(200).json({ success: true, weapon: updatedWeapon });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// Remove a weapon from the arsenal
router.delete('/armory/:id', verifyToken, async (req, res) => {
    try {
        const { id } = req.params;
        const weapon = await Arsenal.findByIdAndDelete(id);
        if (!weapon) return res.status(404).json({ message: 'Weapon not found' });

        // Remove weapon from user's arsenal array
        await Users.findByIdAndUpdate(req.userId, { $pull: { arsenal: id } });

        res.status(200).json({ message: 'Weapon deleted' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Search weapons in the arsenal
router.get('/armory/search', verifyToken, async (req, res) => {
    try {
        const { query } = req.query;
        console.log('Search Query:', query);
        console.log('User ID:', req.userId);

        // Get user's arsenal
        const user = await Users.findById(req.userId).populate('arsenal');
        const weapons = user.arsenal.filter(weapon =>
            weapon.type.match(new RegExp(query, 'i')) ||
            weapon.manufacturer.match(new RegExp(query, 'i')) ||
            weapon.model.match(new RegExp(query, 'i'))
        );

        console.log('Found Weapons:', weapons);
        res.status(200).json(weapons);
    } catch (error) {
        console.error('Error during search:', error);
        res.status(500).json({ message: 'Server error', error });
    }
});

module.exports = router;
