import React from 'react';
import Login from '../components/Login';
import Navbar from '../components/Navbar';
import SigninNavbar from '../components/SigninNavbar';

const LoginPage = () =>
{
    return(
    <div>
        <SigninNavbar />
        <Login />
    </div>
    );
};

export default LoginPage;
