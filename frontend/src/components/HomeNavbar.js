import React, { useState } from 'react';
import logo from '../images/bearLogo.png';
import profilePicture from '../images/profPic.png';

import { Disclosure, DisclosureButton, DisclosurePanel, Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/react'
import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/react/24/outline'


// Maybe change to name to MapPageNavbar

function HomeNavbar()
{
    const gotoArmory = async event => 
    {
        event.preventDefault();
        window.location.href = '/Armory';
    };
        
    return(
        <nav className="relative flex top-0 h-20 bg-neutral-950 w-full items-center mx-auto px-4 border-b-0 border-solid border-gray-600">
            <div className="inline-flex justify-start">
                <a href="/Home">
                    <img
                        className="h-20 w-auto text-white inline-flex justify-items-start"
                        src={logo}
                        alt="Your Company"
                    />
                </a>
            </div>

            {/* Div containing login and signup buttons */}
            <div className="absolute inline-flex right-6 space-x-10">
                <button 
                // className="border border-solid border-white rounded text-white"
                    onClick={gotoArmory}
                    type="button"
                    className=" flex w-24 h-12 items-center justify-center rounded-sm bg-gray-600
                    text-lg font-semibold leading-6 text-white shadow-sm hover:bg-gray-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    Armory
                </button>

                {/* Profile dropdown */}
                <Menu as="div" className="relative ml-3">
                    <div>
                        <MenuButton className="relative flex rounded-full bg-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800">
                        <span className="absolute -inset-1.5" />
                        <span className="sr-only">Open user menu</span>
                        <img
                            alt=""
                            // src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                            src={profilePicture}
                            className="h-12 w-12 rounded-full"
                        />
                        </MenuButton>
                    </div>
                    <MenuItems
                        transition
                        className="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 transition focus:outline-none data-[closed]:scale-95 data-[closed]:transform data-[closed]:opacity-0 data-[enter]:duration-100 data-[leave]:duration-75 data-[enter]:ease-out data-[leave]:ease-in"
                    >
                        {/* <MenuItem>
                        <a href="/Account" className="block px-4 py-2 text-sm text-gray-700 data-[focus]:bg-gray-100">
                            Your Profile
                        </a>
                        </MenuItem> */}
                        {/* <MenuItem>
                        <a href="#" className="block px-4 py-2 text-sm text-gray-700 data-[focus]:bg-gray-100">
                            Settings
                        </a>
                        </MenuItem> */}
                        <MenuItem>
                        <a href="/" className="block px-4 py-2 text-sm text-gray-700 data-[focus]:bg-gray-100">
                            Sign out
                        </a>
                        </MenuItem>
                    </MenuItems>
                </Menu>
                
                
                {/* <button 
                    type="button"
                    className="flex items-center justify-center w-20 h-12 rounded-full bg-red-700 
                    text-md font-semibold leading-6 text-white shadow-sm hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                    <img src="" alt="Profile" className="text-white" />
                </button> */}
            </div>
        </nav>
    )
};

export default HomeNavbar;