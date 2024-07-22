import React, { useState, useEffect } from 'react';
import ArmoryNavbar from '../components/ArmoryNavbar';
import WeaponsTabs from '../components/WeaponsTabs';
import ArmoryCardGrid from '../components/ArmoryCardGrid';
import WeaponCard from '../components/WeaponCard';

const ArmoryPage = () =>
{
    const [cards, setCards] = useState([]);

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

    useEffect(() => {
        const fetchCards = async () => {
            try {
                const getToken = () => localStorage.getItem('jwtToken'); // Function to get the JWT token from local storage
                // const response = await fetch('http://localhost:5000/api/armory/search', {
                const response = await fetch(buildPath(`api/armory/search`), {
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

                const data = await response.json();
                setCards(data);
            } catch (error) {
                console.error('Error fetching cards:', error);
            }
        };

        fetchCards();
    }, []);

    const addCard = (card) => 
        {
        setCards([...cards, card]);
    };

    // Handle search 
    const setSearchResults = (results) => {
        setCards(results);
    };

    const deleteCard = (id) => {
        setCards(cards.filter(card => card._id !== id));
    };

    const getGridRows = (cards, colsPerRow) => 
    {
        const rows = [];
        for (let i = 0; i < cards.length; i += colsPerRow) 
        {
            rows.push(cards.slice(i, i + colsPerRow));
        }
        return rows;
    };
    
    const cardRows = getGridRows(cards, 3); // Assuming 3 columns per row
    
    return(
        <div>
            <ArmoryNavbar />
        
            <WeaponsTabs onAddCard={addCard}  onSearchResults={setSearchResults} />

            {/* <div className="container mx-auto mt-8 border border-solid border-green-500"> h-6/6 w-1/2*/}
            <div className="mt-8 border-0 border-solid border-green-500 bg-white">
                {cardRows.map((row, rowIndex) => 
                (
                    <div key={rowIndex} className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 border-0 border-solid border-red-500 ">
                        {row.map((card, index) => 
                        (
                            <WeaponCard key={index} card={card} onDelete={deleteCard}/>
                        ))}
                    </div>
                ))}
            </div>

        </div>
    );
};

export default ArmoryPage;