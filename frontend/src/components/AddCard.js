import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faPlus } from '@fortawesome/free-solid-svg-icons'
import NewCardForm from './NewCardForm.js';

const AddCard = ({ onAddCard }) =>
{
    const plusIcon = <FontAwesomeIcon icon={faPlus} className="size-1/2"/>
    
    const [showForm, setShowForm] = useState(false);
    const [cards, setCards] = useState([]);
   
    const handleAddCard = () =>
    {
        setShowForm(!showForm);
        // window.location.href = '/NewCard';
    }

    const addCard = (card) => 
    {
        // setCards([...cards, card]);
        // Call the onAddCard function passed from the parent component
        onAddCard(card);
        setShowForm(false); // Optionally hide the form after adding a card
    };

    return(
        <>
            <button 
                onClick={handleAddCard}
                className="rounded-lg border-0 border-solid border-black h-16 w-fit p-4 text-white font-medium bg-gray-600 mr-10 py-2"
            >
                {plusIcon}
                <br></br>
                Add Item
            </button>
            {showForm && (<NewCardForm onAddCard={addCard} />)}
        </>
    );
};

export default AddCard;