import React from 'react';
import { useEffect, useState } from "react";
// import { MapsComponent, LayersDirective, LayerDirective } from '@syncfusion/ej2-react-maps';
import { MapsComponent, Inject, LayersDirective, LayerDirective, Selection, Highlight, MapsTooltip, Legend, changeBorderWidth } from '@syncfusion/ej2-react-maps';
import { isNullOrUndefined } from '@syncfusion/ej2-base';

import * as data from '../map-data/selection-datasource.json';
import * as usa from '../map-data/usa.json';

let datasource = data;

// Old popup max-width: 220px;

const SAMPLE_CSS = `
   .control-fluid {
      padding: 0px !important;
   }
   #container{
      margin-top: -10px;        
   }
   .tip {
      border: 1px solid #4D4D4D;
      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
      border-radius: 7px;
      margin-right: 25px;
      min-width: 110px;
      padding-top: 9px;
      padding-right: 10px;
      padding-left: 10px;
      width: auto;
      height: auto;
      background: #4D4D4D;
   }
   .popup {
      border: 0.5px groove #CCCCCC;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
      left: 70%;
      top: 65%;   
      margin-bottom: 2em;
      border-radius: 2px;
      display: none;
      width: 400px;
      position: absolute;
      padding: 1em;
      background: #F4F4F4;
   }
   .close-btn {
      border: 2px solid #5B5B5B;
      margin-left: -9px;
      position: absolute;
      opacity: 0.8;
      background-color: #605F61;
      border-radius: 50%/50%;
      width: 20px;
      height: 19px;
      display: none;
      z-index: 1000;
      
   }
   .close-btn a {
      margin-left: 2px;
      font-weight: bold;
      color: white;
      text-decoration: none;
   }
   #closebutton {
      float:right;
      font-size:16px; 
      display:inline-block; 
      padding:2px 5px; 
      cursor:pointer; 

   }
   .firstLine td{
      border-bottom: 2px solid black;
   }`;

function UnitedStatesMap() 
{
   const [popup, setPopup] = useState('none');
   const [closebutton, setClosebutton] = useState({
         display: '',
         top: '',
         left: '',
         color: ''
   });

   const [state, setState] = useState('');
   const [handgunPurchasePermit, setPermitToPurchaseHandguns] = useState('');
   const [otherPurchasePermit, setPermitToPurchaseOtherFirearms] = useState('');
   const [permitToCarryHandgun, setPermitToCarryHandgun] = useState('');
   const [permitToCarryOtherFirearms, setPermitToCarryOtherFirearms] = useState('');
   const [registrationOfHandguns, setRegistrationOfHandgunsRequired] = useState('');
   const [registrationOfOtherFirearms, setRegistrationOfOtherFirearmsRequired] = useState('');

   // Old green color for no permit #388E3C 
   // Old blue for permit required #0D47A1 or #0000FF
   let shapeSetting = {
      colorValuePath: 'Right to Carry Law',
      colorMapping: [
         { value: 'No Permit Required', color: '#388E3C' },
         { value: 'Permit Required', color: '#0000FF'},
         { value: 'Rights Restricted', color: '#D32F2F' },
         { value: 'Discretionary/Reasonable Issue', color: '#F57F17' }
      ],
      // strokeThickness: ".5",
      // stroke: "White", 
      // highlightBorderWidth: "1",
      border: { color: 'white', width: 1.5},
   };

   const onMapsLoad = () => {
      let maps = document.getElementById('container');
      maps.setAttribute('title', '');
   };

   const load = (args) => {
   };

   const shapeSelected = (args) => {
         if (args.shapeData !== isNullOrUndefined) {
            setPopup('block');
            setClosebutton({
               display: 'block',
               top: '-15px',
               left: '206px',
               color: 'black',
            });
            setState(args.data.State);
            setPermitToPurchaseHandguns(args.data.PermitToPurchaseHandguns);
            setPermitToPurchaseOtherFirearms(args.data.PermitToPurchaseOtherFirearms);
            setPermitToCarryHandgun(args.data.PermitToCarryHandgun);
            setPermitToCarryOtherFirearms(args.data.PermitToCarryOtherFirearms);
            setRegistrationOfHandgunsRequired(args.data.RegistrationOfHandguns);
            setRegistrationOfOtherFirearmsRequired(args.data.RegistrationOfOtherFirearms);
         }
   };

   const closeButtonClick = () => {
         setPopup('none');
         setClosebutton({ ...closebutton, display: 'none' });
   };

   return (
      <div>
         <style>{SAMPLE_CSS}</style>
         <div>
            <MapsComponent border ={{color : 'purple', width: 2}} height="800px" id="container" loaded={onMapsLoad} load={load} zoomSettings={{ enable: false }} 
            titleSettings={{ 
               text: 'Right to Conceal Carry Laws',
               textStyle: { size: '50px' } }} 
            
               // legendSettings={{ visible: true, mode: 'Interactive', position: 'Bottom', width: '50%', textStyle: { fontWeight: '400', size: '14px' } }}
            legendSettings={{ 
               visible: true, mode: "Default",
               position: "Top", alignment: "Center", 
               // location: {x: 100, y:50},
               shape: "Rectangle", shapeHeight: 25, shapeWidth: 25,
               width: '50%', 
               orientation: "Horizontal",
               labelPosition: "After",
               textStyle: { fontWeight: '500', size: '14px' } }} 
            shapeSelected={shapeSelected.bind(this)}>

               {/* Makes map interactive */}
               {/* Default highlight color was: #A3B0D0 #FFD54F*/}
               {/* Default selection fill was: #4C515B */}
               <Inject services={[MapsTooltip, Selection, Highlight, Legend]}/> 
               <LayersDirective>
                  <LayerDirective shapeData={usa} shapePropertyPath='name' shapeDataPath='State' 
                  dataSource={datasource} 
                  tooltipSettings={{ visible: true, valuePath: 'name'}} 
                  highlightSettings={{ enable: true, fill: '', opacity: .7 }} 
                  selectionSettings={{ enable: true, fill: 'grey', opacity: 1 }} 
                  shapeSettings={shapeSetting} >
                  </LayerDirective>
               </LayersDirective>
            </MapsComponent>
         </div>

         {/* <div className="popup" id="closepopu" style={{ display: popup }}> */}
         <div className="popup" id="closepopu" style={{ display: popup }}>
         <label id="winner" style={{ color: '#666666', fontSize: 12, fontFamily: 'Roboto', fontWeight: 700 }}>{state}'s Gun Laws Overview
            <br></br>Minimum Age for Concealed Carry: 18</label>
         {/* <label style={{ color: '#666666', fontSize: 12, fontFamily: 'Roboto', fontWeight: 700 }}>Min Age for Concealed Carry: 18</label> */}
         <span id="closebutton" style={closebutton} onClick={closeButtonClick}>x</span>
            <table className="border border-solid" role='none' style={{ marginTop: '5px', width: 'auto' }}>
               {/* <tr style={{ borderTop: '1px' }}>
                     <td style={{ padding: '0.3px', float: 'left' }}>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal' }}>State</label>
                     </td>
                     <td style={{ padding: '0.3px', float: 'left' }}>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>:</label>
                     </td>
                     <td style={{ padding: '0.3px', float: 'left' }}>
                        <label id="state" style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{state}</label>
                     </td>
               </tr> */}

               <tr className="border border-solid">
                  <th>
                     {/* <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}> </label> */}
                  </th>
                  <th className="border border-solid">
                     <label className="text-sm font-normal" style={{ color: 'Black'}}>Rifles & Shotguns</label>
                  </th>
                  <th className="border border-solid">
                     <label className="text-sm" style={{ color: 'Black', fontWeight: 'normal', marginLeft: '8px' }}>Handguns</label>
                  </th>
               </tr>
               <tr className="border border-solid bg-gray-300">
                     <td className="border border-solid">
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal' }}>Permit to Carry</label>
                     </td>
                     <td>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{permitToCarryOtherFirearms}</label>
                     </td>
                     <td>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{permitToCarryHandgun}</label>
                     </td>
               </tr>
               <tr className='border border-solid '>
                  <td className="border border-solid">
                     <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal' }}>Permit to Purchase  </label>
                  </td> 
                  <td>
                     <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{otherPurchasePermit}</label>
                  </td>
                  <td>
                     <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{handgunPurchasePermit}</label>
                  </td>
               </tr>
               <tr className='border border-solid bg-gray-300'>
                     <td className='border border-solid'>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal' }}>Registration of Firearms  </label>
                     </td>
                     <td className='border border-solid'>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{registrationOfOtherFirearms}</label>
                     </td>
                     <td className='border border-solid'>
                        <label style={{ color: 'Black', fontSize: '12px', fontWeight: 'normal', marginLeft: '8px' }}>{registrationOfHandguns}</label>
                     </td>
               </tr>
            </table>
         </div>
      </div>
   );
}

export default UnitedStatesMap;
