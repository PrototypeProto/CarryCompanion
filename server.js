const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/auth');
const loginRoutes = require('./routes/login');

const app = express();
const PORT = process.env.PORT || 5000;

mongoose.connect('mongodb+srv://geno:chungus@cluster0.8xrrp47.mongodb.net/Team9LargeProject?retryWrites=true&w=majority', {
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.error(err.message);
});

app.use(bodyParser.json());
app.use('/api/auth', authRoutes);
app.use('/api/auth', loginRoutes);

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
