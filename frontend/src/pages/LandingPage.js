import React from 'react';
import Navbar from '../components/Navbar.js';
import AboutWebsite from '../components/AboutWebsite.js';
import UnitedStatesMap from '../components/ConcealCarryMap.js';

const LandingPage = () =>
{
    return(
        <div>
            <div>
                <Navbar />
            </div>
        
            <div className="h-full">  
                <div className="h-auto">
                    <AboutWebsite />
                </div>
                <div className="h-auto">
                    {/* <UnitedStatesMap /> */}
                </div>
            </div>
        </div>
    )
};

export default LandingPage;