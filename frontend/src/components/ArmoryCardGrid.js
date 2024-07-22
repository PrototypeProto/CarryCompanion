import React, { useState } from 'react';
import WeaponCard from './WeaponCard';

const ArmoryCardGrid = ({ cards }) => 
{
    return(

        // grid-rows-2 justify-items-center bg-neutral-950
        <div className="grid grid-cols-3 grid-rows-2 border-0 border-solid border-green-600 h-screen bg-neutral-950">
            
            {cards.map((card, index) => (
                <div className="col-span-1 row-span-1 mt-20 h-6/6 w-1/2 border-0 border-solid border-purple-700 justify-self-center">
                    <WeaponCard key={index} card={card} />
                </div>
            
            ))}
            
        </div>
    );
};

export default ArmoryCardGrid;