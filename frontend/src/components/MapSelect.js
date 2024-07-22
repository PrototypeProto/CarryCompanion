'use client'

import { useState } from 'react'
import { Label, Listbox, ListboxButton, ListboxOption, ListboxOptions } from '@headlessui/react'
import { CheckIcon, ChevronUpDownIcon } from '@heroicons/react/20/solid'

import ConcealCarryMap from './ConcealCarryMap';
import ReciprocityMap from './ReciprocityMap';

const maps = 
[
  {
    id: 1,
    mapName: 'Conceal Carry',
    component: ConcealCarryMap
  },
  {
    id: 2,
    mapName: 'Reciprocity',
    component: ReciprocityMap
  }
]

export default function MapSelect() 
{
  const [selectedMap, setSelectedMap] = useState(maps[0])
  const SelectedMapComponent = selectedMap.component;

  return (
    <div>
      {/* src={selected.avatar} (used in img tag) */}
      <Listbox value={selectedMap} onChange={setSelectedMap}>
        <Label className="block text-md font-semibold leading-6 text-white ml-5">Map selected</Label>
        <div className="relative mt-2">
          <ListboxButton className="relative w-1/6 ml-5 cursor-default rounded-md bg-white py-1.5 pl-3 pr-10 text-left text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600 sm:text-sm sm:leading-6">
            <span className="flex items-center">
              <span className="ml-3 block truncate">{selectedMap.mapName}</span>
            </span>
            <span className="pointer-events-none absolute inset-y-0 right-0 ml-3 flex items-center pr-2">
              <ChevronUpDownIcon aria-hidden="true" className="h-5 w-5 text-gray-400" />
            </span>
          </ListboxButton>

          <ListboxOptions
            transition
            className="absolute ml-5 z-10 mt-1 max-h-56 w-1/6 overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none data-[closed]:data-[leave]:opacity-0 data-[leave]:transition data-[leave]:duration-100 data-[leave]:ease-in sm:text-sm"
          >
            {maps.map((maps) => (
              <ListboxOption
                key={maps.id}
                value={maps}
                className="group relative cursor-default select-none py-2 pl-3 pr-9 text-gray-900 data-[focus]:bg-red-600 data-[focus]:text-white"
              >
                <div className="flex items-center">
                  {/* <img alt="" className="h-5 w-5 flex-shrink-0 rounded-full" /> */}
                  <span className="ml-3 block truncate font-normal group-data-[selected]:font-semibold">
                    {maps.mapName}
                  </span>
                </div>

                <span className="absolute inset-y-0 right-0 flex items-center pr-4 text-red-600 group-data-[focus]:text-white [.group:not([data-selected])_&]:hidden">
                  <CheckIcon aria-hidden="true" className="h-5 w-5" />
                </span>
              </ListboxOption>
            ))}
          </ListboxOptions>
        </div>
      </Listbox>
      
      <div className="mt-4 bg-white">
        <SelectedMapComponent />
      </div>
    </div>
  );
}
