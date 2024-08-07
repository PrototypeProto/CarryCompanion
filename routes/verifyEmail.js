// routes/verifyEmail.js
const express = require('express');
const router = express.Router();
const { verifyEmailToken } = require('../services/verifyToken'); 

// Email verification endpoint
router.get('/verify-email', async (req, res) => {
    const { token } = req.query;
    console.log('Verify email token:', token);

    try {
        const result = await verifyEmailToken(token);
        console.log('User email verified:', result.user);

        res.redirect(`https://www.thisisforourclass.xyz/SuccessfulVerification`);
    } catch (error) {
        console.error('Error during email verification:', error.message);
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;