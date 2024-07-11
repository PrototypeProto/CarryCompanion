const mongoose = require('mongoose');

const UsersSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    firstName: {
        type: String,
        required: true,
    },
    lastName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    verification: {
        type: Boolean,
        default: false,
    },
}, { collection: 'Users', versionKey: false });

module.exports = mongoose.model('Users', UsersSchema);
