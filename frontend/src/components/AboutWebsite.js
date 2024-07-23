import React from 'react';
import Footer from './Footer';
import mapImage from '../images/mapimage.png';  // Adjust the path as needed

function AboutWebsite() {
  return (
    <div className="h-screen w-full">
      <div className="relative h-screen w-full">
        <div className="grid grid-cols-12 border border-solid border-slate-900 bg-slate-900 w-full h-auto relative z-10">
          <div className="border border-solid border-slate-900 col-start-5 col-span-4 flex flex-col items-center justify-center ml-auto">
            <h1 className="text-white text-center text-7xl font-sans font-bold">
              Carry
              <br />
              Companion
            </h1>
            <p className="text-white text-center font-sans font-bold mt-5">
              Your guide to U.S firearm restrictions and personal digital armory
              for responsible firearm ownership
            </p><br />
            <p className="text-[28px] font-bold text-white italic">
              Mission Statement
            </p>
            <p className="text-white text-center font-sans mt-5 italic py-4">
              CarryCompanion's aim is to provide gun owners with the tools and information needed to navigate the landscape of
              firearm laws across our country. We provide a platform that offers a detailed, interactive map highlighting where 
              firearms can be legally carried, but also features a digital armory for managing firearm collections. We ensure 
              access to current legalities and simplifying gun ownership, striving to promote safety, awareness, and responsible 
              behavior among firearm enthusiasts. 
            </p>
          </div>
        </div>
        <div className="w-full flex justify-center mt-5">
          <img src={mapImage} alt="Right to Conceal Carry Laws" />
        </div><Footer />
      </div>
      
    </div>
  );
}

export default AboutWebsite;
