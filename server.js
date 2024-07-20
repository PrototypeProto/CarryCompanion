require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const signupRoutes = require('./routes/signup');
const loginRoutes = require('./routes/login');
const forgotPasswordRoutes = require('./routes/forgotPassword');
const resetPasswordRoutes = require('./routes/resetPassword');
const resetEmailRoutes = require('./routes/resetEmail');
const armoryRoutes = require('./routes/armory');
const editRoutes = require('./routes/edit');
const mobileRoutes = require('./routes/mobile');

const app = express();
const PORT = process.env.PORT || 5000;

mongoose.connect(process.env.MONGODB_URI, {
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.error(err.message);
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/api', signupRoutes);
app.use('/api', loginRoutes);
app.use('/api', forgotPasswordRoutes);
app.use('/api', resetPasswordRoutes);
app.use('/api', resetEmailRoutes);
app.use('/api', armoryRoutes);
app.use('/api', editRoutes);
app.use('/api', mobileRoutes);

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
