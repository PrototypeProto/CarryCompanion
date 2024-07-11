import React from 'react';
import ArmoryNavbar from '../components/ArmoryNavbar';
import WeaponsTabs from '../components/WeaponsTabs';
import WeaponCard from '../components/WeaponCard';

const ArmoryPage = () =>
{
    return(
        <div>
            <ArmoryNavbar />
        
            <WeaponsTabs />

            <WeaponCard></WeaponCard>
        </div>
       
    );
};

export default ArmoryPage;