import React, { useState } from 'react';

function AboutWebsite()
{
    return(
        // <div className="relative border border-solid border-red-600">
            <div className="grid grid-cols-12 border border-solid border-green-600 bg-slate-900 w-full">
                <div className="text-white">01</div>
                <div className="text-white">02</div>
                <div className="border border-solid border-white col-start-5 col-span-4 ">
                    <div>
                        <h1 className="text-white text-center text-7xl font-sans font-bold">
                            Carry<br />Companion
                        </h1>
                        <p className="text-white text-center font-sans mt-5">
                            Your guide to U.S firearm restrictions and personal digital armory for responsible firearm ownership
                        </p>
                        <p className="text-white text-center font-sans">
                            Sign in now or create an account to get started!
                        </p>
                    </div>
                </div>

            </div>
        // </div>
    )   
};

export default AboutWebsite;