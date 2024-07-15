import React from "react";
import Footer from './Footer'


const EditProfile = () => {
  return (
    
    <div className="w-full h-screen">
        <div class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
            <div class="flex flex-col  px-5 py-10 text-center shadow-lg rounded-md bg-white">
                <h1 class="mb-2 text-[42px] font-bold text-zinc-800">Edit Your <span className="text-red-600">Profile</span></h1>
                <div class="flex flex-col px-8 gap-4 font-bold text-red-600">Change Your Profile Picture? 
                    <div class="flex flex-row gap-4">
                    <button className="flex rounded-full w-40 h-40 overflow-hidden">
                        <img src="/Images/image0.jpg" alt="PFP1" className="object-cover w-full h-full" />
                    </button>
                    <button className="flex rounded-full w-40 h-40 overflow-hidden">
                        <img src="/Images/image0.jpg" alt="PFP2" className="object-cover w-full h-full" />
                    </button>
                    <button className="flex rounded-full w-40 h-40 overflow-hidden">
                        <img src="/Images/image0.jpg" alt="PFP3" className="object-cover w-full h-full" />
                    </button>
                    <button className="flex rounded-full w-40 h-40 overflow-hidden">
                        <img src="/Images/image0.jpg" alt="PFP4" className="object-cover w-full h-full" /></button>
                    </div>
                </div>
                <br/>
                <div class="flex flex-col px-5 gap-4 font-bold text-red-600">
                    Change Username?
                    <input type="text" placeholder="Username" class="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600" />
                    <input type="email" placeholder="Confirm Username" class="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600" />
                    <button class="w-1/3 h-14 px-5 py-1 rounded-md bg-red-600 text-white font-medium shadow-md shadow-indigo-500/20 hover:bg-red-700">Save Changes</button>
                    Change Password?
                    <input type="password" placeholder="Password" class="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600" />
                    <input type="password" placeholder="Confirm Password" class="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600" />
                    <button class="w-1/3 h-14 px-5 py-1 rounded-md bg-red-600 text-white font-medium shadow-md shadow-indigo-500/20 hover:bg-red-700">Save Changes</button>
                </div>
            </div>
        </div>
        <Footer />
    </div>
    
  );
};

export default EditProfile;