const mongoose = require('mongoose');

const ArsenalSchema = new mongoose.Schema({
    type: {
        type: String,
        required: true,
    },
    datePurchased: {
        type: Date,
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
}, { collection: 'Arsenal', versionKey: false });

module.exports = mongoose.model('Arsenal', ArsenalSchema);
