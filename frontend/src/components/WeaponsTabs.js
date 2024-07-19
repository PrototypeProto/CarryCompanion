import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faMagnifyingGlass } from '@fortawesome/free-solid-svg-icons' 

import AddCard from './AddCard';

const WeaponsTabs = ({ onAddCard }) =>
{
    const searchIcon = <FontAwesomeIcon icon={faMagnifyingGlass} className=""/>
    
    const [selectedFilter, setSelectedFilter] = useState(null);

    const handleFilterClick = (filter) => {
      setSelectedFilter(filter);
    };

    const handleInventorySearch = async event =>
    {

    };
    // h-28 og
    return(
        <div className="flex justify-between items-center p-4 bg-neutral-800 h-28 w-12/12">
            <div className="flex-1 flex justify-start ">
                {['Full Inventory', 'Handguns', 'Rifles', 'Shotguns', 'Attachments', 'Ammo'].map((filter) => (
                    <button
                        key={filter}
                        onClick={() => handleFilterClick(filter)}
                        className={`h-16 w-fit p-4 rounded-md text-white text-xl font-medium ${selectedFilter === filter ? 'bg-red-600 ' : ''}`}
                    >
                        {filter}
                    </button>
                ))}
                {/* <span className="text-gray-600">Filters</span> */}
            </div>
            <div className="flex-2 flex justify-center mx-4 h-12">
                
                <input type="text" placeholder="Search Inventory" className="border-0 border-solid rounded-l-md w-96"></input>
                <button onClick={handleInventorySearch} className="text-white border-0 rounded-r-md border-solid w-12 bg-red-600">{searchIcon}</button>
                
                {/* <input
                type="text"
                placeholder="Search..."
                className="w-full p-2 border border-gray-300 rounded-md"
                /> */}
            </div>
            <div className="flex-1 flex justify-end">
                {/* For some reason div makes the form pop up below the button */}
                <div>
                    <AddCard onAddCard={onAddCard} />
                </div>
                {/* <button className="bg-blue-500 text-white px-4 py-2 rounded-md">Add</button> */}
            </div>
        </div>


        // <div className="grid grid-cols-3 bg-neutral-800 h-28 items-center">
        //     <div className="flex col-span-1 border-2 border-solid h-fit">
        //         {/* Look at chat gpt chat for explanation if you forget. bg-gray-700.old w-32 h-16 for button. bg-red-600*/}
        //         <div className="space-x-6 justify-self-start">
        //             {['Full Inventory', 'Handguns', 'Rifles', 'Shotguns', 'Attachments', 'Ammo'].map((filter) => (
        //                 <button
        //                     key={filter}
        //                     onClick={() => handleFilterClick(filter)}
        //                     className={`h-16 w-fit p-4 rounded-md text-white text-xl font-medium ${selectedFilter === filter ? 'bg-red-600 ' : ''}`}
        //                 >
        //                     {filter}
        //                 </button>
        //             ))}
        //         </div>
        //     </div>

        //     {/* Overflow hidden makes the search icon go below when shrinking 
        //     Old search bar btn color: bg-slate-400*/}
        //     <div className="col-span-1 border-0 border-solid justify-self-center">
        //         <div className="flex h-12">
        //             <input type="text" placeholder="Search Inventory" className="border-0 border-solid rounded-l-md w-96"></input>
        //             <button onClick={handleInventorySearch} className="text-white border-0 rounded-r-md border-solid w-12 bg-red-600">{searchIcon}</button>
        //         </div>
        //     </div>

        //     {/* Right side of website where add card functionality is located */}
        //     <div className="col-span-1 border-2 border-solid justify-self-end">
        //         <div className="">
        //             <AddCard onAddCard={onAddCard} />
        //         </div>
        //     </div>
            
        // </div>
        
    );
};

export default WeaponsTabs;