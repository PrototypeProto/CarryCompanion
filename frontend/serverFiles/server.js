const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const signupRoutes = require('./routes/signup');
const loginRoutes = require('./routes/login');
const resetRoutes = require('./routes/reset');
const verificationRoutes = require('./routes/verification');
const mobileRoutes = require('./routes/mobile');

const path = require('path');
const PORT = process.env.PORT || 5000;
const app = express();
app.set('port', (process.env.PORT || 5000));

mongoose.connect('mongodb+srv://geno:chungus@cluster0.8xrrp47.mongodb.net/Team9LargeProject?retryWrites=true&w=majority', {
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.error(err.message);
});

app.use(cors());
app.use(bodyParser.json());
app.use((req, res, next) =>
{
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader(
        'Access-Control-Allow-Headers',
        'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    );
    res.setHeader(
        'Access-Control-Allow-Methods',
        'GET, POST, PATCH, DELETE, OPTIONS'
    );
    next();
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

// For Heroku deployment
// Server static assets if in production
if (process.env.NODE_ENV === 'production')
{
    // Set static folder
    app.use(express.static('frontend/build'));

    app.get('*', (req, res) =>
    {
        res.sendFile(path.resolve(__dirname, 'frontend', 'build', 'index.html'));
    });
}
