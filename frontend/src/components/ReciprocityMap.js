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
   .e-ddl.e-input-group.e-control-wrapper .e-input 
   {
      font-size: 20px;
      font-family: emoji;
      color: black;
      background: ;
   }

   e-ddl.e-input-group .e-input-group-icon,.e-ddl.e-input-group.e-control-wrapper .e-input-group-icon:hover 
   {
      color: #dc2626;
      font-size: 13px;
   }
   .e-ddl.e-input-group.e-control-wrapper.e-input-focus::before, .e-ddl.e-input-group.e-control-wrapper.e-input-focus::after {
      background: #dc2626;
   }   
   `;

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
         // 'Permit Status': recognition[state] ? 'Yes' : 'No'
         'Permit Status': recognition[state]
      }));
      setStateData(data);
   }, [selectedState]);

   // Greens: #006128, 009e47
   // other shade of orange #FF9800, #d97900, #d17200, ffcb35
   const shapeSettings = {
      colorValuePath: 'Permit Status',
      colorMapping: [
         { value: 'Yes', color: '#006128' },
         { value: 'No', color: '#922100' },
         { value: 'Yes, With Restrictions', color: '#ffcb35' }
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
         <div>
            <MapsComponent 
               // border={{ color: 'purple', width: 2 }} 
               height="800px" 
               id="container" 
               loaded={onMapsLoad} 
               load={load} 
               zoomSettings={{ enable: false }} 
               titleSettings={{ text: 'Concealed Carry Reciprocity Map', textStyle: { size: '50px' } }} 
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
                     selectionSettings={{ enable: true, fill: '', opacity: 1 }} 
                     shapeSettings={shapeSettings} 
                  >
                  </LayerDirective>
               </LayersDirective>
            </MapsComponent>

         </div>
         <div className="bg-white w-52 absolute top-44 right-4 p-4 rounded-md shadow-md">
            <label className="font-semibold text-xl">Permit State</label>
            <DropDownListComponent 
               allowFiltering={true}
               filterBarPlaceholder="Search a state"
               id="Type" 
               // id="ddlelement"
               index={dropList.findIndex(item => item.value === initialSelectedState)} 
               change={typeChange.bind(this)} 
               ref={typeElement} 
               dataSource={dropList} 
               fields={{ text: 'text', value: 'value' }}
               placeholder="Select a State"
               popupHeight="200px"
               popupWidth="200px"
               className="bg-red-600"
            />
         </div>
      </div>
   );
}

export default ReciprocityMap;
