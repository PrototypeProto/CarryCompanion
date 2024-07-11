import React, { useState } from 'react';

function WeaponsTabs()
{
    const displayAllFirearms = async event =>
    {
        event.preventDefault();

        
    };

    
    return(
        <div className="relative flex items-center border-2 border-solid border-cyan-500 bg-slate-900 h-28">
            <div className="inline-flex mx-14 space-x-2">
                <button onClick={displayAllFirearms} className="flex w-24 items-center justify-center rounded-md h-16 border-2 border-solid text-white hover:bg-red-500">
                    All Firearms
                </button>
                <button className="flex w-24 items-center justify-center rounded-md h-16 border-2 border-solid  text-white">Handguns</button>
                <button className="flex w-24 items-center justify-center rounded-md h-16 border-2 border-solid  text-white">Rifles</button>
                <button className="flex w-24 items-center justify-center rounded-md h-16 border-2 border-solid  text-white">Shotguns</button>
                <button className="flex w-24 items-center justify-center rounded-md h-16 border-2 border-solid  text-white">Attachments</button>
            </div>

            <div>
                <input type="text" placeholder="Search" className=" absolute flex items-center right-6"></input>
            </div>
           
        </div>
    );
};

export default WeaponsTabs;