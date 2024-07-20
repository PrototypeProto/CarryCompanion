import React, { useState } from 'react';
import handgun from '../images/handgun.png';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faTrash, faPenToSquare, faEye, faDiamond } from '@fortawesome/free-solid-svg-icons'

const WeaponCard = ({ card }) => 
{
    // Maybe change to the name of the gun
    const deleteIcon = <FontAwesomeIcon icon={faTrash} className=""/>
    const editIcon = <FontAwesomeIcon icon={faPenToSquare} className=""/>
    const inspectIcon = <FontAwesomeIcon icon={faEye} className=""/>
    const diamondIcon = <FontAwesomeIcon icon={faDiamond} className="w-2"/>

    const handleInspectCard = async event =>
    {

    };

    const handleEditCard = async event =>
    {

    };

    const handleDeleteCard = async event =>
    {
        
    };

    return(
        // h-2/5 w-2/4 or  h-4/5 w-1/2 <- more recent
        // Full makes the child fit the parent's size container (div in the armory in this case).
        // Fit makes the size of the card be the size needed to fit all the child tags. E.g if we add something below the button group, the card will get longer bc of fit
        // Used to have w-full h-fit but this works instead
        <div className="flex flex-col border border-solid border-gray-500 rounded-sm bg-white h-6/6 w-1/2 justify-self-center mt-8">
            
            {/* <div className="font-sans inset-x-0 top-0 h-16 text-center text-3xl font-semibold tracking-normal py-3 border border-solid border-purple-600 truncate">
                {itemType}
            </div> */}
            <div className="flex self-center font-sans h-16 text-center text-3xl text-neutral-800 font-semibold tracking-normal py-3 border-0 border-solid border-purple-600 w-">
                {card.make} {card.model}
            </div>
            <div className="flex border-t border-b border-solid border-black size-fit">
                <img
                    className=""
                    src={handgun}
                >
                </img>
            </div>

            {/* Add diamond next to each thing as a bullet point */}
            <div class="space-y-4 border-0 border-solid border-cyan-500 text-base font-medium">
                <div className="ml-1">
                    {/* Can add a update maintenance feature but default date can be the purchase date */}
                    Last maintenance: {card.datePurchased}
                </div>
                <div className="ml-1">
                    Ammo type: {card.ammoType}
                </div>
                <div className="ml-1 py-3">
                    Attachments: {card.attachments} 
                </div>
            </div>
            
            
            {/* bg colors in order:  bg-green-600  bg-blue-500 bg-red-600*/}
            {/* button width splits: 3/5 1/5 1/5*/}
            {/* button width splits: 1/3 1/3 1/3 */}
            {/* Maybe make a 3 bar logo button that opens up the button group to abstract button*/}
            {/* Could add border-l border-r to edit icon */}
            <div class=" mt-auto w-full border-t border-b border-solid border-gray-400 text-black h-12">
                <button onClick={handleInspectCard} className="border-r border-solid round-bl-sm border-gray-400 w-1/3 h-full text-gray-600">{inspectIcon} Inspect</button>
                <button onClick={handleEditCard} className=" border-b-0 border-solid border-gray-400 w-1/3 h-full text-blue-500">{editIcon} Edit</button>
                <button onClick={handleDeleteCard} className="border-l border-b-0 border-solid round-br-sm border-gray-400 w-1/3 h-full text-red-600">{deleteIcon} Delete</button>
            </div>
        </div>

    );
};

export default WeaponCard;