const express = require('express');
const router = express.Router();
const axios = require('axios');

// Helper function to forward requests
const forwardRequest = async (req, res, endpoint) => {
    try {
        const response = await axios({
            method: req.method,
            url: `${req.protocol}://${req.get('host')}/api/${endpoint}`,
            data: req.body,
            params: req.query,
            headers: req.headers,
        });
        res.status(response.status).json(response.data);
    } catch (error) {
        if (error.response) {
            res.status(error.response.status).json(error.response.data);
        } else {
            res.status(500).json({ message: 'Server error' });
        }
    }
};

// Forward signup requests
router.post('/mobile/signup', (req, res) => {
    forwardRequest(req, res, 'signup');
});

// Forward login requests
router.post('/mobile/login', (req, res) => {
    forwardRequest(req, res, 'login');
});

// Forward password reset requests
router.post('/mobile/request-password-reset', (req, res) => {
    forwardRequest(req, res, 'request-password-reset');
});

// Forward email reset requests
router.post('/mobile/reset-email', (req, res) => {
    forwardRequest(req, res, 'reset-email');
});

// Forward email verification requests
router.get('/mobile/verify-email', (req, res) => {
    forwardRequest(req, res, 'verify-email');
});

// Forward password reset form submission
router.post('/mobile/reset-password', (req, res) => {
    forwardRequest(req, res, 'reset-password');
});

module.exports = router;
