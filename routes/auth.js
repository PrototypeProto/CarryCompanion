const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');
const Users = require('../models/Users');

// Commented out OAuth2 Configuration
/*
const { google } = require('googleapis');
const CLIENT_ID = '1002385152053-stpfhslg9q9b064nsuu163e6a409o8bv.apps.googleusercontent.com';
const CLIENT_SECRET = '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';
const REDIRECT_URI = 'https://developers.google.com/oauthplayground';
const REFRESH_TOKEN = '1//04myo-xc18aYqCgYIARAAGAQSNgF-L9Ir8-xWfBoPY-PCIN3VQYd24HqgkVY18qLoTzxBQXqMDHRauCnQUumid5hWW7rHqDEHrA';
const EMAIL = 'carrycompanion@gmail.com';
const oAuth2Client = new google.auth.OAuth2(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);
oAuth2Client.setCredentials({ refresh_token: REFRESH_TOKEN });
*/

const EMAIL = 'carrycompanion@gmail.com';
const APP_PASSWORD = 'cqouitjjpehmjjqr'; // xnweresracgyzkgv
const JWT_SECRET = 'bazinga';

async function sendVerificationEmail(email, verificationUrl) {
    try {
        // const accessTokenResponse = await oAuth2Client.getAccessToken();
        // const accessToken = accessTokenResponse.token;

        // if (!accessToken) {
        //     throw new Error('Failed to obtain access token');
        // }

        // console.log('Access Token:', accessToken);

        const transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                type: 'login', 
                user: EMAIL,
                pass: APP_PASSWORD, 
            },
        });

        const mailOptions = {
            from: EMAIL,
            to: email,
            subject: 'Verify your email',
            html: `<p>Click <a href="${verificationUrl}">here</a> to verify your email.</p>`,
        };

        const result = await transporter.sendMail(mailOptions);
        console.log('Email sent result:', result);
        return result;
    } catch (error) {
        console.error('Error sending email:', error);
        throw new Error('Failed to send verification email');
    }
}

async function sendPasswordResetEmail(email, resetUrl) {
    try {
        const transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                type: 'login',
                user: EMAIL,
                pass: APP_PASSWORD,
            },
        });

        const mailOptions = {
            from: EMAIL,
            to: email,
            subject: 'Password Reset',
            html: `<p>Click <a href="${resetUrl}">here</a> to reset your password.</p>`,
        };

        const result = await transporter.sendMail(mailOptions);
        console.log('Password reset email sent result:', result);
        return result;
    } catch (error) {
        console.error('Error sending password reset email:', error);
        throw new Error('Failed to send password reset email');
    }
}

router.post('/signup', async (req, res) => {
    const { username, password, firstName, lastName, email } = req.body;
    console.log('Signup request body:', req.body);

    try {
        const existingUser = await Users.findOne({ email });
        if (existingUser) {
            console.log('Email already exists:', email);
            return res.status(400).json({ message: 'Email already exists' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new Users({
            username,
            password: hashedPassword,
            firstName,
            lastName,
            email,
            verification: false,
        });

        const token = jwt.sign(
            { email },
            JWT_SECRET, // replace with your JWT secret
            { expiresIn: '1h' }
        );

        const verificationUrl = `http://localhost:5000/api/auth/verify-email?token=${token}`;
        console.log('Verification URL:', verificationUrl);
        await sendVerificationEmail(email, verificationUrl);

        await newUser.save();
        console.log('New user saved:', newUser);

        res.status(200).json({ message: 'Verification email sent' });
    } catch (error) {
        console.error('Error during signup:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/request-password-reset', async (req, res) => {
    const { email } = req.body;

    try {
        const user = await Users.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Email not found' });
        }

        const token = jwt.sign({ email }, JWT_SECRET, { expiresIn: '1h' });
        const resetUrl = `http://localhost:5000/api/auth/reset-password?token=${token}`;
        await sendPasswordResetEmail(email, resetUrl);

        res.status(200).json({ message: 'Password reset email sent' });
    } catch (error) {
        console.error('Error during password reset request:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/reset-password', async (req, res) => {
    const { token, newPassword } = req.body;
    console.log('Reset password request:', req.body);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        user.password = hashedPassword;
        await user.save();

        res.status(200).json({ message: 'Password reset successful' });
    } catch (error) {
        console.error('Error during password reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/verify-email', async (req, res) => {
    const { token } = req.query;
    console.log('Verify email token:', token);

    try {
        const decoded = jwt.verify(token, 'bazinga');
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        user.verification = true;
        await user.save();
        console.log('User email verified:', user);

        res.status(200).json({ message: 'Email verified' });
    } catch (error) {
        console.error('Error during email verification:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/reset-password', async (req, res) => {
    const { token } = req.query;
    console.log('Password reset token:', token);

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const user = await Users.findOne({ email: decoded.email });

        if (!user) {
            console.log('Invalid token:', token);
            return res.status(400).json({ message: 'Invalid token' });
        }

        // Serve the password reset page (you can replace this with your frontend URL)
        res.send(`
            <form action="/api/auth/reset-password" method="POST">
                <input type="hidden" name="token" value="${token}" />
                <input type="password" name="newPassword" placeholder="Enter new password" required />
                <button type="submit">Reset Password</button>
            </form>
        `);
    } catch (error) {
        console.error('Error during password reset:', error);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
