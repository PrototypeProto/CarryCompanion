import React from 'react';
import HomeNavbar from '../components/HomeNavbar';
import UnitedStatesMap from '../components/UnitedStatesMap.js';

const HomePage = () =>
{
    return(
        <div className="justify-items-center">
            <div>
                <HomeNavbar />
            </div>
            <div className="mt-10">
                <UnitedStatesMap />
            </div>
        </div>
    
    );
};

export default HomePage;