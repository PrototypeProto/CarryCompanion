const cron = require('node-cron');
const Users = require('../models/Users');
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

async function sendDeletionConfirmationEmail(email) {
    const mailOptions = {
        from: EMAIL,
        to: email,
        subject: 'Account Deleted',
        html: `<p>Your CarryCompanion account has been successfully deleted.</p>`,
    };

    return transporter.sendMail(mailOptions);
}

// Runs every day at midnight and deletes accounts scheduled for deletion
cron.schedule('0 0 * * *', async () => {
    try {
        const now = new Date();
        const usersToDelete = await Users.find({ deletionDate: { $lte: now } });

        for (const user of usersToDelete) {
            await Users.deleteOne({ _id: user._id });
            await sendDeletionConfirmationEmail(user.email);
        }

        console.log(`Deleted ${usersToDelete.length} user(s) scheduled for deletion.`);
    } catch (error) {
        console.error('Error deleting users:', error);
    }
});
