import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './App.css';

import LandingPage from './pages/LandingPage';
import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import HomePage from './pages/HomePage';
import ArmoryPage from './pages/ArmoryPage';
import NewCardPage from './pages/NewCardPage';
import AccountSettingsPage from './pages/AccountSettingsPage';

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
        <Route path="/NewCard" element={<NewCardPage />} />
        <Route path="/Account" element={<AccountSettingsPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
