const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const signupRoutes = require('./routes/signup');
const loginRoutes = require('./routes/login');
const resetRoutes = require('./routes/reset');
const verificationRoutes = require('./routes/verification');
const mobileRoutes = require('./routes/mobile');

const app = express();
const PORT = process.env.PORT || 5000;

mongoose.connect('mongodb+srv://geno:chungus@cluster0.8xrrp47.mongodb.net/Team9LargeProject?retryWrites=true&w=majority', {
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.error(err.message);
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/api', signupRoutes);
app.use('/api', loginRoutes);
app.use('/api', resetRoutes);
app.use('/api', verificationRoutes);
app.use('/api', mobileRoutes);

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
