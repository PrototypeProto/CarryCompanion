import React, { useState } from 'react';

function CreateWeaponCard()
{
    return(
        <div className="bg-white-800 border-0 border-solid border-red-800 justify-items-center">
            <div className="bg-white shadow-2xl h-[504px] w-[352px] border border-solid rounded mt-20 mx-auto px-5">
                <form className="space-y-6" action="#" method="POST" >
                    
                    <h2 className="mt-10 mb-12 text-center text-4xl font-semibold leading-9 tracking-tight text-gray-900">
                        Sign in
                    </h2>
                
                    <div className="border-solid border-indigo-600">
                        <label htmlFor="email" className="block text-md font-medium leading-6 text-gray-900">
                            Email or username 
                        </label>
                        <div className="mt-2">
                            <input
                            id="email"
                            name="email"
                            placeholder="Email or Username"
                            // type="email"
                            type="text"
                            autoComplete="email"
                            required
                            className="block w-full rounded-md border-0 py-3
                            text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                            
                            />
                        </div>
                    </div>

                    <div className="border-solid border-indigo-600">
                        <div className="flex items-center justify-between">
                            <label htmlFor="password" className="block text-md font-medium leading-6 text-gray-900">
                            Password
                            </label>
                            <div className="text-sm">
                                <a href="#" className="font-semibold text-blue-500 hover:text-indigo-500">
                                    Forgot password?
                                </a>
                            </div>
                        </div>
                        <div className="mt-2">
                            <input
                            id="password"
                            name="password"
                            placeholder="Password"
                            type="password"
                            autoComplete="current-password"
                            required
                            className="block w-full rounded-md border-0 py-3 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300
                            placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                            // not sure if this is the best practice to get reference
                            />
                        </div>
                    </div>

                    <div className="border-solid border-indigo-600 py-6">
                        <button
                            type="submit"
                            className=" 
                            flex w-full justify-center rounded-md bg-red-700 py-3 text-lg font-semibold text-white shadow-sm hover:bg-red-600 
                            focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
                        >
                            Sign in
                        </button>
                    </div>
                </form>

            </div>

            {/* Find a way to  make the link go to the signup page*/}
            <p className="border-solid border-indigo-600 mt-10 text-center text-md text-black">
                Don't have an account?{' '}
                <a href="/Signup" className="font-semibold leading-6 text-blue-500 hover:text-indigo-500">  
                Sign Up
                </a>
            </p>
        </div>
    );
};

export default CreateWeaponCard;