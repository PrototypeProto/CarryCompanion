import React, { useState } from 'react';

const NewCardForm = ({ onAddCard }) =>
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
    
    const [make, setMake] = useState('');
    const [model, setModel] = useState('');
    const [datePurchased, setDatePurchased] = useState('');
    const [description, setDescription] = useState('');
    const [itemType, setItemType] = useState('Handgun');
    const [ammoType, setAmmoType] = useState('');
    const [attachments, setAttachments] = useState('');

    const handleSubmit = async (e) => 
    {
        e.preventDefault();
        
        // onAddCard({ model, datePurchased, itemType, ammoType, attachments, description });
        setMake('');
        setModel('');
        setDatePurchased('');
        setDescription('');
        setItemType('Handgun');
        setAttachments('');
        setAmmoType('');

        const card ={ make, model, datePurchased, itemType, ammoType, attachments, description };
        onAddCard(card);
        
        const url = 'http://localhost:5000/api/armory';

        const getToken = () => localStorage.getItem('jwtToken'); // Function to get the JWT token from local storage

        var obj = {type:itemType,datePurchased:datePurchased,manufacturer:make,model:model};
        var js = JSON.stringify(obj); // Convert the weapon data to JSON

        try 
        {
            const response = await fetch(url, {
                method: 'POST',
                body: js,
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
            console.log(responseData);
        }
        catch (error)
        {
            console.error('Error:', error);
            setMessage(error.message || 'Unable to Add Weapon!');
        }
    };

    return(
        <div className="absolute right-0 mt-2 w-64 bg-white border border-gray-300 shadow-lg rounded-md p-4 z-10" style={{ bottom: 'auto'}} >
            <form onSubmit={handleSubmit}>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="title">
                        Item Type
                    </label>
                    <select
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="itemType"
                        value={itemType}
                        onChange={(e) => setItemType(e.target.value)}
                        required
                    >
                        <option value="Handgun">Handgun</option>
                        <option value="Rifle">Rifle</option>
                        <option value="Shotgun">Shotgun</option>
                        <option value="Ammo">Ammo</option>
                    </select>
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="Model">
                        Make
                    </label>
                    <input
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="make"
                        type="text"
                        value={make}
                        onChange={(e) => setMake(e.target.value)}
                        placeholder="Make"
                        // required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="Model">
                        Model
                    </label>
                    <input
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="model"
                        type="text"
                        value={model}
                        onChange={(e) => setModel(e.target.value)}
                        placeholder="Model"
                        // required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="Date Purchased">
                        Date Purchased
                    </label>
                    <input
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="datePurchased"
                        value={datePurchased}
                        onChange={(e) => setDatePurchased(e.target.value)}
                        placeholder="N/A"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="Ammo Type">
                        Ammo Type
                    </label>
                    <input
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="description"
                        value={ammoType}
                        onChange={(e) => setAmmoType(e.target.value)}
                        placeholder="N/A"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="Attachments">
                        Attachments
                    </label>
                    <input
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="attachments"
                        value={attachments}
                        onChange={(e) => setAttachments(e.target.value)}
                        placeholder="N/A"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="description">
                        Description
                    </label>
                    <textarea
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                        id="description"
                        value={description}
                        onChange={(e) => setDescription(e.target.value)}
                        placeholder="Optional notes"
                    />
                </div>
                <div className="flex justify-center">
                    <button
                        className="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
                        type="submit"
                    >
                        Add
                    </button>
                </div>
            </form>
        </div>
    )
};

export default NewCardForm;
