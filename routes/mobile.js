// routes/mobile.js
const express = require('express');
const router = express.Router();
const axios = require('axios');

// Function to forward requests
const forwardRequest = async (req, res, endpoint) => {
    const url = `${req.protocol}://${req.get('host')}/api/${endpoint}`;
    console.log(`Forwarding request to: ${url}`); // Debug log to see the full URL
    console.log('Request body:', req.body); // Log request body
    try {
        const response = await axios.post(url, req.body, { headers: { 'Content-Type': 'application/json' } });
        console.log('Response from API:', response.data); // Log the response from the API
        res.status(response.status).json(response.data);
    } catch (error) {
        console.error('Error forwarding request:', error.message); // Log the error
        if (error.response) {
            console.error('Error response status:', error.response.status); // Log error response status
            console.error('Error response data:', error.response.data); // Log error response data
            res.status(error.response.status).json(error.response.data);
        } else {
            res.status(500).json({ message: 'Server error' });
        }
    }
};

// Forward signup requests
router.post('/mobile/signup', (req, res) => {
    console.log('Received request at /mobile/signup'); // Log incoming request
    forwardRequest(req, res, 'signup');
});

// Forward login requests
router.post('/mobile/login', (req, res) => {
    console.log('Received request at /mobile/login'); // Log incoming request
    forwardRequest(req, res, 'login');
});

// Forward forgot password requests
router.post('/mobile/request-password-reset', (req, res) => {
    console.log('Received request at /mobile/request-password-reset'); // Log incoming request
    forwardRequest(req, res, 'request-password-reset');
});

// Forward email reset requests
router.post('/mobile/reset-email', (req, res) => {
    console.log('Received request at /mobile/reset-email'); // Log incoming request
    forwardRequest(req, res, 'reset-email');
});

// Forward email verification requests
router.get('/mobile/verify-email', (req, res) => {
    console.log('Received request at /mobile/verify-email'); // Log incoming request
    forwardRequest(req, res, 'verify-email');
});

// Forward password reset form submission
router.post('/mobile/reset-password', (req, res) => {
    console.log('Received request at /mobile/reset-password'); // Log incoming request
    forwardRequest(req, res, 'reset-password');
});

// Forward armory CRUD operations
router.post('/mobile/armory', (req, res) => {
    console.log('Received request at /mobile/armory'); // Log incoming request
    forwardRequest(req, res, 'armory');
});

router.put('/mobile/armory/:id', (req, res) => {
    console.log(`Received request at /mobile/armory/${req.params.id}`); // Log incoming request
    forwardRequest(req, res, `armory/${req.params.id}`);
});

router.delete('/mobile/armory/:id', (req, res) => {
    console.log(`Received request at /mobile/armory/${req.params.id}`); // Log incoming request
    forwardRequest(req, res, `armory/${req.params.id}`);
});

router.get('/mobile/armory/search', (req, res) => {
    console.log('Received request at /mobile/armory/search'); // Log incoming request
    forwardRequest(req, res, 'armory/search');
});

// Forward edit requests
router.post('/mobile/edit/firstName', (req, res) => {
    console.log('Received request at /mobile/edit/firstName'); // Log incoming request
    forwardRequest(req, res, 'edit/firstName');
});

router.post('/mobile/edit/lastName', (req, res) => {
    console.log('Received request at /mobile/edit/lastName'); // Log incoming request
    forwardRequest(req, res, 'edit/lastName');
});

router.post('/mobile/edit/profilePicture', (req, res) => {
    console.log('Received request at /mobile/edit/profilePicture'); // Log incoming request
    forwardRequest(req, res, 'edit/profilePicture');
});

module.exports = router;
