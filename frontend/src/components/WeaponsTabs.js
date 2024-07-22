import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faMagnifyingGlass } from '@fortawesome/free-solid-svg-icons' 

import AddCard from './AddCard';

const WeaponsTabs = ({ onSearchResults, onAddCard }) =>
{
    const [message,setMessage] = useState('');

    const app_name = 'carry-companion-02c287317f3a'
    function buildPath(route)
    {
        if (process.env.NODE_ENV === 'production')
        {
            return 'https://' + app_name + '.herokuapp.com/' + route;
        }
        else
        {
            return 'http://localhost:5000/' + route;
        }
    }

    const searchIcon = <FontAwesomeIcon icon={faMagnifyingGlass} className=""/>
    
    var search = '';
    
    const [selectedFilter, setSelectedFilter] = useState(null);

    const handleFilterClick = (filter) => {
      setSelectedFilter(filter);
    };

    const handleInventorySearch = async event =>
    {
        event.preventDefault();
        
        const getToken = () => localStorage.getItem('jwtToken'); // Function to get the JWT token from local storage

        // Get the api url and query value
        const url = 'http://localhost:5000/api/armory/search?query=' + search.value;

        try 
        {
            // const response = await fetch(url, {
            const response = await fetch(buildPath(`api/armory/search?query=${search.value}`), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getToken()}`, // Include the JWT token for authentication
                },
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(`Error: ${response.status} - ${errorData.message}`);
            }

            const responseData = await response.json();
            onSearchResults(responseData); // Pass results to parent component

            for (var i = 0; i < responseData.length; i++)
            {
                // Loop through each card and create the card using the information and add to the grid
            }
            console.log(responseData);
        }
        catch (error)
        {
            console.error('Error:', error);
            setMessage(error.message || 'Unable to Search Weapon!');
        }


    };
    // h-28 og
    return(
        <div className="flex justify-between items-center p-4 bg-neutral-800 h-28 w-12/12">
            <div className="flex-1 flex justify-start ">
                {/* {['Full Inventory', 'Handguns', 'Rifles', 'Shotguns', 'Attachments', 'Ammo'].map((filter) => (
                    <button
                        key={filter}
                        onClick={() => handleFilterClick(filter)}
                        className={`h-16 w-fit p-4 rounded-md text-white text-xl font-medium ${selectedFilter === filter ? 'bg-red-600 ' : ''}`}
                    >
                        {filter}
                    </button>
                ))} */}
                {/* <span className="text-gray-600">Filters</span> */}
            </div>
            <div className="flex-2 flex justify-center mx-4 h-12">
                
                <input ref={(c) => search = c} type="text" placeholder="Search Inventory" className="border-0 border-solid rounded-l-md w-96"></input>
                <button onClick={handleInventorySearch} className="text-white border-0 rounded-r-md border-solid w-12 bg-red-600 hover:bg-red-700">{searchIcon}</button>
                
            </div>
            <div className="flex-1 flex justify-end">
                <div>
                    <AddCard onAddCard={onAddCard} />
                </div>
            </div>
        </div>
    );
};

export default WeaponsTabs;