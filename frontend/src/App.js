import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './App.css';

import LandingPage from './pages/LandingPage';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import HomePage from './pages/HomePage';
import ArmoryPage from './pages/ArmoryPage';
import AccountSettingsPage from './pages/AccountSettingsPage';
import ChangePasswordPage from './pages/ChangePasswordPage';
import SuccessfulVerificationPage from './pages/SuccessfulVerificationPage';
import EmailSentPage from './pages/EmailSentPage';
import ForgotPass from './components/ForgotPass';




function App()
{
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/Login" element={<LoginPage />} />
        <Route path="/Signup" element={<SignupPage />} />
        <Route path="/Home" element={<HomePage  />} />
        <Route path="/Armory" element={<ArmoryPage />} />
        <Route path="/Account" element={<AccountSettingsPage />} />
        <Route path="/ChangePasswordPage" element={<ChangePasswordPage />} />
        <Route path="/SuccessfulVerification" element={<SuccessfulVerificationPage />} />
        <Route path="/EmailSent" element={<EmailSentPage />} />
        <Route path="/forgot-password" component={ForgotPass} />


      </Routes>
    </BrowserRouter>
  );
}

export default App;
