const mongoose = require('mongoose');

const ArsenalSchema = new mongoose.Schema({
    type: {
        type: String,
        required: true,
    },
    manufacturer: {
        type: String,
        required: true,
    },
    model: {
        type: String,
        required: true,
    },
    ammoType: {
        type: String,
        required: false,
    },
    attachments: {
        type: String,
        required: false,
    },
    description: {
        type: String,
        required: false,
    },
    datePurchased: {
        type: Date,
        required: false,
    },
}, { collection: 'Arsenal', versionKey: false });

module.exports = mongoose.model('Arsenal', ArsenalSchema);
