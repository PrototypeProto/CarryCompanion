import React from "react";
import Footer from './Footer'
import { Confetti } from 'react-confetti';


const EmailCon = () => {
  return (
    
    <div className="w-full h-screen">
    <div class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
        <div class="max-w-xl px-5 py-5 text-center shadow-lg rounded-md bg-white">
            <h2 class="mb-2 text-[42px] font-bold text-zinc-800">Congratulations!</h2>
            <p class="mb-2 text-lg text-zinc-500">Your email has already been confirmed. You can now login to the application.</p>
            <a href="/login" class="mt-3 inline-block w-96 rounded bg-red-600 px-5 py-3 font-medium text-white shadow-md shadow-indigo-500/20 hover:bg-red-700">Return to Login</a>
        </div>
    </div>
    <Footer />
    </div>
    
  );
};

export default EmailCon;