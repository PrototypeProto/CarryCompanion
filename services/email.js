const nodemailer = require('nodemailer');
const EMAIL = 'carrycompanion@gmail.com';
const APP_PASSWORD = process.env.APP_PASSWORD;

const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        type: 'login',
        user: EMAIL,
        pass: APP_PASSWORD,
    },
});

async function sendVerificationEmail(email, verificationUrl) {
    const mailOptions = {
        from: EMAIL,
        to: email,
        subject: 'Verify your email',
        html: `<p>Click <a href="${verificationUrl}">here</a> to verify your email.</p>`,
    };

    return transporter.sendMail(mailOptions);
}

async function sendPasswordResetEmail(email, resetUrl) {
    const mailOptions = {
        from: EMAIL,
        to: email,
        subject: 'Password Reset',
        html: `<p>Click <a href="${resetUrl}">here</a> to reset your password.</p>`,
    };

    return transporter.sendMail(mailOptions);
}

async function sendAccountDeletionEmail(email, deletionUrl) {
    const mailOptions = {
        from: EMAIL,
        to: email,
        subject: 'IMPORTANT: Account Deletion',
        html: `<p>Click <a href="${deletionUrl}">here</a> to delete your account.</p>`,
    };

    console.log('Sending account deletion email:', mailOptions);
    return transporter.sendMail(mailOptions);
}

async function sendDeletionNotificationEmail(email) {
    const mailOptions = {
        from: EMAIL,
        to: email,
        subject: 'IMPORTANT: Account Deletion in 7 Days',
        html: `Your CarryCompanion account will be deleted in 7 days. This process will be canceled if you log in now!`,
    };

    return transporter.sendMail(mailOptions);
}

module.exports = {
    sendVerificationEmail,
    sendPasswordResetEmail,
    sendAccountDeletionEmail,
    sendDeletionNotificationEmail,
};
