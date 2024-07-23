const mailgun = require('mailgun-js');

// Mailgun configuration
const DOMAIN = 'sandbox28639db37e8748b19e31f8b1d4ab625d.mailgun.org';
const MAILGUN_API_KEY = 'a70f7a3345dd336d3375a8f51bb74d56-0f1db83d-e7ad2057';

const mg = mailgun({ apiKey: MAILGUN_API_KEY, domain: DOMAIN });

async function sendVerificationEmail(email, verificationUrl) {
    const data = {
        from: 'carrycompanion@gmail.com',
        to: email,
        subject: 'Verify your email',
        html: `<p>Click <a href="${verificationUrl}">here</a> to verify your email.</p>`,
    };

    return mg.messages().send(data);
}

async function sendPasswordResetEmail(email, resetUrl) {
    const data = {
        from: 'carrycompanion@gmail.com',
        to: email,
        subject: 'Password Reset',
        html: `<p>Click <a href="${resetUrl}">here</a> to reset your password.</p>`,
    };

    return mg.messages().send(data);
}

async function sendAccountDeletionEmail(email, deletionUrl) {
    const data = {
        from: 'carrycompanion@gmail.com',
        to: email,
        subject: 'IMPORTANT: Account Deletion',
        html: `<p>Click <a href="${deletionUrl}">here</a> to delete your account.</p>`,
    };

    console.log('Sending account deletion email:', data);
    return mg.messages().send(data);
}

async function sendDeletionNotificationEmail(email) {
    const data = {
        from: 'carrycompanion@gmail.com',
        to: email,
        subject: 'IMPORTANT: Account Deletion in 7 Days',
        html: `Your CarryCompanion account will be deleted in 7 days. This process will be canceled if you log in now!`,
    };

    return mg.messages().send(data);
}

module.exports = {
    sendVerificationEmail,
    sendPasswordResetEmail,
    sendAccountDeletionEmail,
    sendDeletionNotificationEmail,
};
