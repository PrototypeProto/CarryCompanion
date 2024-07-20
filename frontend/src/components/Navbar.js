import React, { useState } from 'react';
import logo from '../images/bearLogo.png';

function Navbar()
{
    const gotoLogin = async event =>
    {
        event.preventDefault();
        window.location.href = '/Login';
    };

    const gotoSignup = async event =>
    {
        window.location.href = '/Signup';
    };

    return(
        <nav className="relative flex top-0 h-16 bg-neutral-950 w-full items-center mx-auto px-4">
            <div className="inline-flex justify-start">
                <a href="#">
                    <img
                        className="h-16 w-auto inline-flex justify-items-start"
                        // src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500"
                        // src="/~/concealCompanion/frontend/src/images/ccLogo.png"
                        src={logo}
                        alt="Your Company"
                    />
                </a>
            </div>

            {/* Div containing login and signup buttons */}
            <div className="absolute inline-flex right-6 space-x-3" >
            <button 
                    onClick={gotoLogin}
                    type="button"
                    className="flex items-center justify-center w-24 h-12 rounded-full bg-red-700 
                    text-md font-semibold leading-6 text-white shadow-sm hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    Sign in
                </button>
                
                <button 
                // className="border border-solid border-white rounded text-white"
                    onClick={gotoSignup}
                    type="button"
                    className="flex w-24 h-12 items-center justify-center rounded-full bg-gray-600
                    text-md font-semibold leading-6 text-white shadow-sm hover:bg-gray-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    Join now
                </button>
                
            
            </div>
        </nav>
    )
};

export default Navbar;