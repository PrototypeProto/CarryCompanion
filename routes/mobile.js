// routes/mobile.js
const express = require('express');
const router = express.Router();
const axios = require('axios');

// Function to forward requests
const forwardRequest = async (req, res, endpoint, method) => {
    const url = `${req.protocol}://${req.get('host')}/api/${endpoint}`;
    console.log(`Forwarding ${method} request to: ${url}`); // Debug log to see the full URL
    console.log('Request body:', req.body); // Log request body
    try {
        const options = {
            method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': req.headers.authorization,
            },
            params: req.query,
            data: req.body,
        };
        const response = await axios(url, options);
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
    forwardRequest(req, res, 'signup', 'POST');
});

// Forward login requests
router.post('/mobile/login', (req, res) => {
    console.log('Received request at /mobile/login'); // Log incoming request
    forwardRequest(req, res, 'login', 'POST');
});

// Forward forgot password requests
router.post('/mobile/request-password-reset', (req, res) => {
    console.log('Received request at /mobile/request-password-reset'); // Log incoming request
    forwardRequest(req, res, 'request-password-reset', 'POST');
});

// Forward email reset requests
router.post('/mobile/reset-email', (req, res) => {
    console.log('Received request at /mobile/reset-email'); // Log incoming request
    forwardRequest(req, res, 'reset-email', 'POST');
});

// Forward email verification requests
router.get('/mobile/verify-email', (req, res) => {
    console.log('Received request at /mobile/verify-email'); // Log incoming request
    forwardRequest(req, res, 'verify-email', 'GET');
});

// Forward password reset form submission
router.post('/mobile/reset-password', (req, res) => {
    console.log('Received request at /mobile/reset-password'); // Log incoming request
    forwardRequest(req, res, 'reset-password', 'POST');
});

// Forward armory CRUD operations
router.post('/mobile/armory', (req, res) => {
    console.log('Received request at /mobile/armory'); // Log incoming request
    forwardRequest(req, res, 'armory', 'POST');
});

router.put('/mobile/armory/:id', (req, res) => {
    console.log(`Received request at /mobile/armory/${req.params.id}`); // Log incoming request
    forwardRequest(req, res, `armory/${req.params.id}`, 'PUT');
});

router.delete('/mobile/armory/:id', (req, res) => {
    console.log(`Received request at /mobile/armory/${req.params.id}`); // Log incoming request
    forwardRequest(req, res, `armory/${req.params.id}`, 'DELETE');
});

router.get('/mobile/armory/search', (req, res) => {
    console.log('Received request at /mobile/armory/search'); // Log incoming request
    forwardRequest(req, res, 'armory/search', 'GET');
});

// Forward edit requests
router.post('/mobile/edit/firstName', (req, res) => {
    console.log('Received request at /mobile/edit/firstName'); // Log incoming request
    forwardRequest(req, res, 'edit/firstName', 'POST');
});

router.post('/mobile/edit/lastName', (req, res) => {
    console.log('Received request at /mobile/edit/lastName'); // Log incoming request
    forwardRequest(req, res, 'edit/lastName', 'POST');
});

router.post('/mobile/edit/profilePicture', (req, res) => {
    console.log('Received request at /mobile/edit/profilePicture'); // Log incoming request
    forwardRequest(req, res, 'edit/profilePicture', 'POST');
});

module.exports = router;
