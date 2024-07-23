import React from "react";
import Footer from './Footer'
import { Confetti } from 'react-confetti';


const EmailSent = () => {
  return (
    
    <div className="w-full h-screen">
    <div class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
        <div class="max-w-xl px-5 py-5 text-center shadow-lg rounded-md bg-white">
            <h2 class="mb-2 text-[42px] font-bold text-zinc-800">Email has been sent to your inbox! </h2>
            <p class="mb-2 text-lg text-zinc-500">You should receive an email no more than five minutes. If not, please try again in 30 minutes.</p>
        </div>
    </div>
    <Footer />
    </div>
    
  );
};

export default EmailSent;