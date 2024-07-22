const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
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
    },
    verification: {
        type: Boolean,
        required: true,
    },
    arsenal: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Arsenal'
        }
    ],
    deletionDate: {
        type: Date,
        default: null,
    },
    profilePicture: {
        type: Number,
        required: false,
    },
}, { collection: 'Users', versionKey: false });

module.exports = mongoose.model('Users', UserSchema);