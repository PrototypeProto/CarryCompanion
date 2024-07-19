import React, { useState, useEffect, useRef } from 'react';
import { MapsComponent, Inject, LayersDirective, LayerDirective, Selection, Highlight, MapsTooltip, Legend } from '@syncfusion/ej2-react-maps';
import { DropDownListComponent } from '@syncfusion/ej2-react-dropdowns';
import reciprocityData from '../map-data/reciprocity-datasource.json';
import * as usa from '../map-data/usa.json';

const SAMPLE_CSS = `
   .control-fluid {
      padding: 0px !important;
   }
   #container{
      margin-top: 0px;        
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
   }
   .e-ddl.e-input-group.e-control-wrapper .e-input 
   {
      font-size: 20px;
      font-family: emoji;
      color: white;
      background: ;
   }

   e-ddl.e-input-group .e-input-group-icon,.e-ddl.e-input-group.e-control-wrapper .e-input-group-icon:hover 
   {
      color: gray;
      font-size: 13px;
   }`;

function ReciprocityMap() {
   const typeElement = useRef(null);
   const initialSelectedState = 'Florida'; // Set initial selected state
   const [selectedState, setSelectedState] = useState(initialSelectedState);
   const [stateData, setStateData] = useState([]);

   const dropList = Object.keys(reciprocityData).map(state => ({ text: state, value: state }));
   // const dropList = Object.keys(reciprocityData).sort().map(state => ({ text: state, value: state }));


   useEffect(() => {
      console.log('Selected State:', selectedState); // Debug log
      console.log('Reciprocity Data:', reciprocityData[selectedState]); // Debug log

      const recognition = reciprocityData[selectedState]?.recognition || {};
      const data = Object.keys(recognition).map(state => ({
         State: state,
         'Permit Status': recognition[state] ? 'Yes' : 'No'
      }));
      setStateData(data);
   }, [selectedState]);

   const shapeSettings = {
      colorValuePath: 'Permit Status',
      colorMapping: [
         { value: 'Yes', color: '#388E3C' },
         { value: 'No', color: '#D32F2F' },
         { value: 'Yes, With Restriction', color: '#F57F17' }
      ],
      border: { color: 'white', width: 1.5 },
   };

   const onMapsLoad = () => {
      let maps = document.getElementById('container');
      maps.setAttribute('title', '');
   };

   const load = (args) => {};

   const shapeSelected = (args) => {
      // Add any shape selected logic here if needed
   };

   const typeChange = (event) => {
      setSelectedState(event.value);
   };

   return (
      <div>
         <style>{SAMPLE_CSS}</style>
         <div className="">
            <label className="text-white">Permit State</label>
               <DropDownListComponent 
                  allowFiltering={true}
                  filterBarPlaceholder="Search a state"
                  // id="Type" 
                  id="ddlelement"
                  index={dropList.findIndex(item => item.value === initialSelectedState)} 
                  change={typeChange.bind(this)} 
                  ref={typeElement} 
                  dataSource={dropList} 
                  fields={{ text: 'text', value: 'value' }}
                  placeholder="Select a State"
                  popupHeight="200px"
                  popupWidth="200px"
               />
         </div>
         <div>
            <MapsComponent 
               // border={{ color: 'purple', width: 2 }} 
               height="800px" 
               id="container" 
               loaded={onMapsLoad} 
               load={load} 
               zoomSettings={{ enable: false }} 
               titleSettings={{ text: 'Right to Conceal Carry Laws', textStyle: { size: '50px' } }} 
               legendSettings={{ 
                  visible: true, 
                  mode: "Default",
                  position: "Top", 
                  alignment: "Center", 
                  shape: "Rectangle", 
                  shapeHeight: 25, 
                  shapeWidth: 25,
                  width: '50%', 
                  orientation: "Horizontal",
                  labelPosition: "After",
                  textStyle: { fontWeight: '500', size: '14px' }, 
                  toggleLegendSettings: {
                     enable: true,
                     border: { width: 2, color: 'red' }
                  } 
               }} 
               shapeSelected={shapeSelected.bind(this)}
            >
               <Inject services={[MapsTooltip, Selection, Highlight, Legend]}/> 
               <LayersDirective>
                  <LayerDirective 
                     shapeData={usa} 
                     shapePropertyPath='name' 
                     shapeDataPath='State' 
                     dataSource={stateData} 
                     tooltipSettings={{ visible: true, valuePath: 'State' }} 
                     highlightSettings={{ enable: true, fill: '', opacity: .7, border: { color: 'white', width: 2 }}} 
                     selectionSettings={{ enable: true, fill: 'gold', opacity: 1 }} 
                     shapeSettings={shapeSettings} 
                  >
                  </LayerDirective>
               </LayersDirective>
            </MapsComponent>

            {/* <div className="ml-10 mt-10"> */}
               {/* <DropDownListComponent 
                  allowFiltering={true}
                  filterBarPlaceholder="Search a state"
                  // placeholder="Enter Permit State"

                  id="Type" 
                  // width="100%" 
                  index={dropList.findIndex(item => item.value === initialSelectedState)} 
                  change={typeChange.bind(this)} 
                  ref={typeElement} 
                  dataSource={dropList} 
                  fields={{ text: 'text', value: 'value' }}

               /> */}
            {/* </div> */}
         </div>
      </div>
   );
}

export default ReciprocityMap;
