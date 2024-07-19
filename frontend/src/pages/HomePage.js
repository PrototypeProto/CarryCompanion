import React from 'react';
import HomeNavbar from '../components/HomeNavbar';
import ConcealCarryMap from '../components/ConcealCarryMap.js';
import MapSelect from '../components/MapSelect.js';
import LegendInfo from '../components/LegendInfo.js';

const HomePage = () =>
{
    return(
        <div className="justify-items-center">
            
            <HomeNavbar />
            
            <div className=" bg-neutral-800 w-full">
                <MapSelect></MapSelect>
            </div>

            {/* <div className="">
                <UnitedStatesMap />
            </div> */}

            {/* <div>
                <LegendInfo></LegendInfo>
            </div> */}
            
        </div>
    
    );
};

export default HomePage;