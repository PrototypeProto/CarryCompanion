import React, { useState } from 'react';
import ArmoryNavbar from '../components/ArmoryNavbar';
import WeaponsTabs from '../components/WeaponsTabs';
import ArmoryCardGrid from '../components/ArmoryCardGrid';
import WeaponCard from '../components/WeaponCard';

const ArmoryPage = () =>
{
    const [cards, setCards] = useState([]);

    const addCard = (card) => 
        {
        setCards([...cards, card]);
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
        
            <WeaponsTabs onAddCard={addCard} />

            {/* <div className="container mx-auto mt-8 border border-solid border-green-500"> h-6/6 w-1/2*/}
            <div className="mt-8 border-0 border-solid border-green-500">
                {cardRows.map((row, rowIndex) => 
                (
                    <div key={rowIndex} className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4 border border-solid border-red-500 ">
                        {row.map((card, index) => 
                        (
                            <WeaponCard key={index} card={card} />
                        ))}
                    </div>
                ))}
            </div>

        </div>
    );
};

export default ArmoryPage;