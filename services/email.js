const nodemailer = require('nodemailer');
const EMAIL = 'carrycompanion@gmail.com';
const APP_PASSWORD = 'cqouitjjpehmjjqr'; // Replace with your app password

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

module.exports = {
    sendVerificationEmail,
    sendPasswordResetEmail,
};
