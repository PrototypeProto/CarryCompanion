import React, { useState } from 'react';
import logo from '../images/bearLogo.png';

function SigninNavbar()
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
        <nav className="relative flex top-0 h-20 bg-neutral-950 w-full items-center justify-center mx-auto px-4">
            <div className="inline-flex">
                <a href="#">
                    <img
                        className="h-20 w-auto inline-flex justify-items-start"
                        // src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500"
                        src={logo}
                        alt="Your Company"
                    />
                </a>
            </div>

            {/* Div containing login and signup buttons */}
            {/* <div className="absolute inline-flex right-2 space-x-3" >
                <button 
                // className="border border-solid border-white rounded text-white"
                    onClick={gotoSignup}
                    type="button"
                    className="flex rounded-md bg-red-700 px-5 py-1.5 
                    text-sm font-semibold leading-6 text-white shadow-sm hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    Join now
                </button>
                
                <button 
                    onClick={gotoLogin}
                    type="button"
                    className="flex rounded-md bg-red-700 px-3 py-1.5 
                    text-sm font-semibold leading-6 text-white shadow-sm hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    Sign in
                </button>
            </div> */}
        </nav>
    )
};

export default SigninNavbar;