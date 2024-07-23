import React, { useState } from "react";
import axios from 'axios';
import Footer from './Footer';

const ChangePass = () => {



  return (
    <div className="w-full h-screen">
      <div className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
        <div className="flex flex-col px-10 py-28 text-center shadow-lg rounded-md bg-white">
          <h1 className="mb-2 text-[42px] font-bold text-zinc-800">Reset Your <span className="text-red-600">Password</span></h1><br/><br/>
          <div className="flex flex-col px-8 gap-4 font-bold text-red-600">
            <input
              type="password"
              placeholder="Password"
              className="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
              
            />
            <input
              type="password"
              placeholder="Confirm Password"
              className="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
              
            />
            <button
              
              className="w-1/3 h-14 px-5 py-1 rounded-md bg-red-600 text-white font-medium shadow-md shadow-indigo-500/20 hover:bg-red-700"
            >
              Enter
            </button>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default ChangePass;
