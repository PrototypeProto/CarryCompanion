import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapScreenState();
}

class MapScreenState extends State<MapPage> {
  late MapShapeSource shapeSource;
  late List<MapModel> mapData;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    mapData = getMapData();
    updateShapeSource();
  }

  void updateSelectedIndex(int index) {
    setState(() {
      if (selectedIndex != -1) {
        mapData[selectedIndex].color =
            Colors.red; // TODO make this a variable for filtering
      }
      selectedIndex = index;
      mapData[selectedIndex].color =
          Colors.grey.shade50; // Set color of newly selected index
      updateShapeSource();
      dropdownValue = states[selectedIndex+1];
    });
  }

  void updateShapeSource() {
    shapeSource = MapShapeSource.asset(
      "assets/usa.json",
      shapeDataField: "name",
      dataCount: mapData.length,
      primaryValueMapper: (int index) => mapData[index].state,
      dataLabelMapper: (int index) =>
          (index == selectedIndex ? mapData[index].stateCode : ''),
      shapeColorValueMapper: (int index) => mapData[index].color,
      shapeColorMappers: [
  MapColorMapper(from: 0, to: 50, color: Color(0xFF0088D1), text: 'No Permit Required'),
  MapColorMapper(from: 51, to: 100, color: Color(0xFF00245E), text: 'Permit Required'),
  MapColorMapper(from: 101, to: 150, color: Color(0xFF922100), text: 'Rights Restricted'),
  MapColorMapper(from: 151, to: 200, color: Color(0xFFF57F17), text: 'Discretionary Issue'),
],

    );
  }



final List<String> states = [
    "Select a State", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
    "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
    "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", 
    "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", 
    "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", 
    "New Hampshire", "New Jersey", "New Mexico", "New York", 
    "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", 
    "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", 
    "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
    "West Virginia", "Wisconsin", "Wyoming",
  ];

//TODO this is only so it is 'invalid' index aka none selected
  String dropdownValue = "Select a State";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              hint: Text('Please Select a State'),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  selectedIndex = states.indexOf(newValue)-1;
                  updateShapeSource();
                  updateSelectedIndex(selectedIndex);
                  showDialog(
                            context: context,
                            builder: (context) =>
                                CustomDialogWidget(index: selectedIndex),
                          );
                });
              },
              items: states.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              //debug used to see space of expanded
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                child: SfMapsTheme(
                  data: SfMapsThemeData(
                    selectionColor: Colors.green[50],
                    selectionStrokeWidth: 1,
                    selectionStrokeColor: Colors.white,
                  ),
                  child: SfMaps(
                    layers: [
                      MapShapeLayer(
                        source: shapeSource,
                        legend: MapLegend(MapElement.shape,position: MapLegendPosition.bottom,title: Text('Right To Conceal Carry Laws'),overflowMode: MapLegendOverflowMode.wrap,iconSize: Size(15.0, 15.0),),
                        showDataLabels: true,
                        strokeColor: Colors.grey[300],
                        dataLabelSettings: MapDataLabelSettings(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selectedIndex: selectedIndex,
                        onSelectionChanged: (int index) {
                          updateSelectedIndex(index);
                          updateShapeSource();
                          showDialog(
                            context: context,
                            builder: (context) =>
                                CustomDialogWidget(index: index),
                          );
                        },
                        selectionSettings: MapSelectionSettings(
                            // TODO what can I do with this??
                            ),
                        zoomPanBehavior: MapZoomPanBehavior(
                            focalLatLng: MapLatLng(37.0902, -95.7129),
                            zoomLevel: 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 60,) //used for whitespace to display the button
        ],
      ),
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  final int index;

  const CustomDialogWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    // Accessing the state data using the provided index
    final stateData = statesData[index];

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  stateData['name']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Pistols:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                stateData['pistolText']!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rifles:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                stateData['rifleText']!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Shotguns:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                stateData['shotgunText']!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<MapModel> getMapData() {
  // first is NAME from json, then 2nd is name displayed on the map
  //need variables here for colors so we can change them
  const noPermitRequired = Color(0xFF0088D1); 
  const permitRequired = Color(0xFF00245E); 
  const rightsRestricted = Color(0xFF922100); 
  const discretionaryIssue = Color(0xFFF57F17); 
  return <MapModel>[
    MapModel('Alabama', 'AL', permitRequired),
    MapModel('Alaska', 'AK', noPermitRequired),
    MapModel('Arizona', 'AZ', noPermitRequired),
    MapModel('Arkansas', 'AR', noPermitRequired),
    MapModel('California', 'CA', rightsRestricted),
    MapModel('Colorado', 'CO', permitRequired),
    MapModel('Connecticut', 'CT', discretionaryIssue),
    MapModel('Delaware', 'DE', rightsRestricted),
    MapModel('Florida', 'FL', permitRequired),
    MapModel('Georgia', 'GA', noPermitRequired),
    MapModel('Hawaii', 'HI', rightsRestricted),
    MapModel('Idaho', 'ID', noPermitRequired),
    MapModel('Illinois', 'IL', permitRequired),
    MapModel('Indiana', 'IN', permitRequired),
    MapModel('Iowa', 'IA', noPermitRequired),
    MapModel('Kansas', 'KS', noPermitRequired),
    MapModel('Kentucky', 'KY', noPermitRequired),
    MapModel('Louisiana', 'LA', permitRequired),
    MapModel('Maine', 'ME', noPermitRequired),
    MapModel('Maryland', 'MD', rightsRestricted),
    MapModel('Massachusetts', 'MA', rightsRestricted),
    MapModel('Michigan', 'MI', permitRequired),
    MapModel('Minnesota', 'MN', permitRequired),
    MapModel('Mississippi', 'MS', noPermitRequired),
    MapModel('Missouri', 'MO', noPermitRequired),
    MapModel('Montana', 'MT', noPermitRequired),
    MapModel('Nebraska', 'NE', permitRequired),
    MapModel('Nevada', 'NV', permitRequired),
    MapModel('New Hampshire', 'NH', noPermitRequired),
    MapModel('New Jersey', 'NJ', rightsRestricted),
    MapModel('New Mexico', 'NM', permitRequired),
    MapModel('New York', 'NY', rightsRestricted),
    MapModel('North Carolina', 'NC', permitRequired),
    MapModel('North Dakota', 'ND', noPermitRequired),
    MapModel('Ohio', 'OH', permitRequired),
    MapModel('Oklahoma', 'OK', noPermitRequired),
    MapModel('Oregon', 'OR', permitRequired),
    MapModel('Pennsylvania', 'PA', permitRequired),
    MapModel('Rhode Island', 'RI', rightsRestricted),
    MapModel('South Carolina', 'SC', permitRequired),
    MapModel('South Dakota', 'SD', noPermitRequired),
    MapModel('Tennessee', 'TN', noPermitRequired),
    MapModel('Texas', 'TX', noPermitRequired),
    MapModel('Utah', 'UT', noPermitRequired),
    MapModel('Vermont', 'VT', noPermitRequired),
    MapModel('Virginia', 'VA', permitRequired),
    MapModel('Washington', 'WA', permitRequired),
    MapModel('West Virginia', 'WV', noPermitRequired),
    MapModel('Wisconsin', 'WI', permitRequired),
    MapModel('Wyoming', 'WY', noPermitRequired)
  ];
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);
  String state;
  String stateCode;
  Color color;
}


Map<int, List<int>> permitRecognitionMap = {
  0: [1, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Alabama
  1: [0, 3, 4, 9, 10, 11, 13, 14, 16, 17, 18, 19, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Alaska
  2: [0, 1, 3, 4, 6, 7, 9, 10, 12, 13, 14, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Arizona
  3: [0, 1, 2, 4, 9, 10, 12, 13, 14, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Arkansas
  4: [], // California
  5: [], // Colorado
  6: [0, 1, 3, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Connecticut
  7: [], // Delaware
  8: [0, 1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Florida
  9: [0, 1, 2, 3, 6, 10, 11, 13, 14, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Georgia
  10: [], // Hawaii
  11: [0, 1, 3, 9, 12, 13, 14, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Idaho
  12: [0, 1, 2, 3, 9, 10, 11, 13, 14, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Illinois
  13: [0, 1, 3, 9, 10, 11, 12, 14, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Indiana
  14: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Iowa
  15: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Kansas
  16: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Kentucky
  17: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Louisiana
  18: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Maine
  19: [], // Maryland
  20: [], // Massachusetts
  21: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Michigan
  22: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Minnesota
  23: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Mississippi
  24: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Missouri
  25: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Montana
  26: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Nebraska
  27: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Nevada
  28: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // New Hampshire
  29: [], // New Jersey
  30: [], // New Mexico
  31: [0, 1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // New York
  32: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // North Carolina
  33: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // North Dakota
  34: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Ohio
  35: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Oklahoma
  36: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Oregon
  37: [], // Pennsylvania
  38: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Rhode Island
  39: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 44, 45, 46, 48, 49], // South Carolina
  40: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // South Dakota
  41: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 44, 45, 46, 48, 49], // Tennessee
  42: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 44, 45, 46, 48, 49], // Texas
  43: [], // Utah
  44: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 45, 46, 48, 49], // Vermont
  45: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 46, 48, 49], // Virginia
  46: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 48, 49], // Washington
  47: [], // West Virginia
  48: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 49], // Wisconsin
  49: [0, 1, 2, 3, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48], // Wyoming
};



List<Map<String, dynamic>> statesData = [
    {
      "index": 0,
      "name": "Alabama",
      "pistolText": "Alabama allows open carry without a permit. Any person who is at least 19 years old and legally entitled to possess a firearm can open carry. Some areas are off-limits, including schools and courthouses. Beginning on January 1, 2023, any law-abiding Alabama resident or other law-abiding citizen (regardless of the state in which he or she resides) who is at least 19 years old or older and legally permitted to carry a firearm will no longer be required to obtain a permit in order to carry a concealed pistol. As of January 1, 2023, Alabama does not require a permit or license to carry a loaded handgun in any vehicle.", 
      "rifleText": "Alabama generally allows the transportation of any rifle with a barrel of 16 inches or longer and an overall length of 26 inches or longer if the firearm is placed in a secure container out of reach of observers and of the driver and any passengers. No permit is required to carry in this manner.",
      "shotgunText": "Alabama generally allows the transportation of any shotgun with a barrel of 18 inches or longer and an overall length of 26 inches or longer if the firearm is placed in a secure container out of reach of observers and of the driver and any passengers. No permit is required to carry in this manner."
    },
    {
      "index": 1,
      "name": "Alaska",
      "pistolText": "Alaska's laws do not prohibit anyone 21 or older who may legally possess a firearm from carrying it concealed or open. A firearms permit is not required. There are general restrictions on where a firearm may be carried. No state permit is required to possess a pistol. An individual may lawfully possess and store a pistol that is locked in his or her private vehicle given that person may legally possess a firearm under state and federal law.",
      "rifleText": "No state permit is required to possess a rifle. An individual may lawfully possess and store a rifle that is locked in his or her private vehicle given that person may legally possess a firearm under state and federal law.",
      "shotgunText": "No state permit is required to possess a shotgun. An individual may lawfully possess and store a shotgun that is locked in his or her private vehicle given that person may legally possess a firearm under state and federal law."
    },
    {
      "index": 2,
      "name": "Arizona",
      "pistolText": "Arizona respects the right of all U.S. citizens to carry a concealed handgun with or without a permit, or to carry openly while in this state. No state permit is required to possess a shotgun, rifle or handgun. It is unlawful for a “prohibited possessor” to possess a firearm. Firearms carried in a vehicle shall be transported in a case, a holster or scabbard, a storage compartment, trunk, pack, luggage, or glove compartment of a means of transportation.",
      "rifleText": "No state permit is required to possess a shotgun, rifle or handgun. It is unlawful for a “prohibited possessor” to possess a firearm. Firearms carried in a vehicle shall be transported in a case, a holster or scabbard, a storage compartment, trunk, pack, luggage, or glove compartment of a means of transportation.",
      "shotgunText": "No state permit is required to possess a shotgun, rifle or handgun. It is unlawful for a “prohibited possessor” to possess a firearm. Firearms carried in a vehicle shall be transported in a case, a holster or scabbard, a storage compartment, trunk, pack, luggage, or glove compartment of a means of transportation."
    },
    {
      "index": 3,
      "name": "Arkansas",
      "pistolText": "Arkansas is a constitutional carry state, “with no permit required to carry a handgun, either unconcealed or concealed”. Ark. Code § 5-73-120(a) makes it a crime to carry a handgun, knife, or club on or about the person or in a vehicle or “otherwise readily available for use with a purpose to attempt to unlawfully employ the handgun, knife, or club as a weapon against a person.”",
      "rifleText": "No state permit is required for the purchase or possession of a rifle, shotgun, or handgun. There are no restrictions on transporting or openly carrying a rifle, excepting the places where they are typically prohibited, such as courhouses, sheriff's department, schools, etc.",
      "shotgunText": "No state permit is required for the purchase or possession of a rifle, shotgun, or handgun. There are no restrictions on transporting or openly carrying a shotgun, excepting the places where they are typically prohibited, such as courhouses, sheriff's department, schools, etc."
    },
    {
      "index": 4,
      "name": "California",
      "pistolText": "...the open carry of any handgun, loaded or unloaded in an incorporated area has now been banned. Limited exceptions apply, such as for 'a person who reasonably believes that he or his property is in immediate danger and the weapon must be carried for “preservation.”' Carrying a handgun concealed is prohibited without a license. A license is required to carry a handgun concealed within a vehicle unless it is placed locked in a container in a place besides the utility or glove compartment.",
      "rifleText": "Nonconcealable firearms (shotguns and rifles) are not generally covered within the provisions of California Penal Code section 25400 and therefore are not required to be transported in a locked container. However, as with any firearm, nonconcealable firearms must be unloaded while they are being transported. ",
      "shotgunText": "Nonconcealable firearms (shotguns and rifles) are not generally covered within the provisions of California Penal Code section 25400 and therefore are not required to be transported in a locked container. However, as with any firearm, nonconcealable firearms must be unloaded while they are being transported. "
    },
    {
      "index": 5,
      "name": "Colorado",
      "pistolText": "A permit is not required to carry a handgun where carrying firearms is legal, if the handgun is not concealed. It is unlawful to carry a firearm concealed on or about one's person without a permit, except for a person in his or her own dwelling, place of business, or on property owned or controlled by him or her. A handgun is not considered concealed if it is in the possession of a person who is in a private automobile or other private means of conveyance who is carrying it for a legal use, or the handgun is in the possession of a person who is legally engaged in hunting activities within the state.",
      "rifleText": "It is unlawful to have a firearm other than a handgun in or on any motor vehicle unless the chamber is unloaded.",
      "shotgunText": "It is unlawful to have a firearm other than a handgun in or on any motor vehicle unless the chamber is unloaded."
    },
    {
      "index": 6,
      "name": "Connecticut",
      "pistolText": "A permit to carry a pistol or revolver is required to carry a handgun on or about one’s person, either openly or concealed, or in a vehicle.",
      "rifleText": "A person may transport a firearm in a motor vehicle without a permit if it is unloaded, not readily accessible or directly accessible from the passenger compartment of the vehicle...",
      "shotgunText": "A person may transport a firearm in a motor vehicle without a permit if it is unloaded, not readily accessible or directly accessible from the passenger compartment of the vehicle..."
    },
    {
      "index": 7,
      "name": "Delaware",
      "pistolText": "Handguns may be carried in open view, or in an inaccessible area like the trunk of an automobile. It is unlawful for any person...to carry any loaded or unloaded firearm concealed upon or about his person without a license to carry. Handguns may be carried in open view, or in an inaccessible area like the trunk of an automobile.",
      "rifleText": "Rifles must be unloaded while being carried in or on any vehicle.",
      "shotgunText": "Shotguns must be unloaded while being carried in or on any vehicle."
    },
    {
      "index": 8,
      "name": "Florida",
      "pistolText": "It is unlawful for any person to openly carry on or about his or her person any firearm or electric weapon or device. Permitless concealed carry is legal for anyone 21 years old or older and not prohibited by law to carry a firearm. It is lawful to possess a concealed firearm for self-defense or other lawful purposes within the interior of a private conveyance (personal vehicle), without a license, if the firearm is securely encased or is otherwise not readily accessible for immediate use.",
      "rifleText": "A firearm other than a handgun may be carried anywhere in a private conveyance (vehicle) when such firearm is being carried for a lawful use. ",
      "shotgunText": "A firearm other than a handgun may be carried anywhere in a private conveyance (vehicle )when such firearm is being carried for a lawful use."
    },
    {
      "index": 9,
      "name": "Georgia",
      "pistolText": "Open carry is legal in Georgia only with a Georgia Weapons Carry License (WCL) or a concealed carry permit from a state Georgia honors. Any person who is not prohibited by law from possessing a handgun may have or carry on his or her person a weapon on his or her property or inside his or her home, motor vehicle, or place of business without a valid weapons carry license.",
      "rifleText": "Any person who is not prohibited by law from possessing a long gun may have or carry on his or her person a weapon or long gun on his or her property or inside his or her home, motor vehicle, or place of business without a valid weapons carry license. Any person who is not prohibited by law from possessing a handgun or long gun may have or carry on his or her person a long gun without a valid weapons carry license, provided that if the long gun is loaded, it shall only be carried in an open and fully exposed manner.",
      "shotgunText": "Any person who is not prohibited by law from possessing a handgun or long gun may have or carry on his or her person a weapon or long gun on his or her property or inside his or her home, motor vehicle, or place of business without a valid weapons carry license. Any person who is not prohibited by law from possessing a handgun or long gun may have or carry on his or her person a long gun without a valid weapons carry license, provided that if the long gun is loaded, it shall only be carried in an open and fully exposed manner."
    },
    {
      "index": 10,
      "name": "Hawaii",
      "pistolText": "Open carrying is generally only allowed in extreme circumstances, and as designated personally by the respective chief of police. Hawaii is now a shall-issue state since the Supreme Court’s ruling on the NYSRPA v Bruen on June 23rd, 2022. Permits are issued by the Chief of Police at the county level. Permits are only valid in the county from which it was issued. It is unlawful to possess or carry a loaded firearm on any public highway without a permit to carry. it is lawful to carry firearms and ammunition in an enclosed container or other suitable container from the place of purchase to the purchaser’s home, place of business or place of sojourn; or between these places when moving.",
      "rifleText": "It is unlawful to possess or carry a loaded firearm on any public highway without a permit to carry. it is lawful to carry firearms and ammunition in an enclosed container or other suitable container from the place of purchase to the purchaser’s home, place of business or place of sojourn; or between these places when moving.",
      "shotgunText": "It is unlawful to possess or carry a loaded firearm on any public highway without a permit to carry. it is lawful to carry firearms and ammunition in an enclosed container or other suitable container from the place of purchase to the purchaser’s home, place of business or place of sojourn; or between these places when moving."
    },
    {
      "index": 11,
      "name": "Idaho",
      "pistolText": "Idaho permits the open carrying of firearms. State law allows any resident of The United States to carry a concealed handgun without a license to carry, provided the person is over 18 years old and not disqualified from being issued a license to carry concealed weapons under state law. The restrictions on carrying a concealed weapon without a license also do not apply to weapons located in plain view; a firearm that is not loaded and is concealed in a motor vehicle; a firearm that is not loaded and is secured in a case;",
      "rifleText": "The restrictions on carrying a concealed weapon without a license also do not apply to weapons located in plain view; any lawfully possessed shotgun or rifle; a firearm that is not loaded and is concealed in a motor vehicle; a firearm that is not loaded and is secured in a case.",
      "shotgunText": "The restrictions on carrying a concealed weapon without a license also do not apply to weapons located in plain view; any lawfully possessed shotgun or rifle; a firearm that is not loaded and is concealed in a motor vehicle; a firearm that is not loaded and is secured in a case."
    },
    {
      "index": 12,
      "name": "Illinois",
      "pistolText": "Open carry of a handgun on your person or in a vehicle is illegal. It is unlawful to carry or possess any firearm in any vehicle or concealed on or about the person, except on one’s land or in one’s abode or fixed place of business, without a license. Also, it is unlawful to possess any firearm or ammunition without a valid FOID (Firearms Owner Identification Card). It is unlawful to have or carry any firearm in or on any vehicle or conveyance unless unloaded and enclosed in a case.",
      "rifleText": "It is unlawful to have or carry any firearm in or on any vehicle or conveyance unless unloaded and enclosed in a case. Also, it is unlawful to possess any firearm or ammunition without a valid FOID (Firearms Owner Identification Card).",
      "shotgunText": "It is unlawful to have or carry any firearm in or on any vehicle or conveyance unless unloaded and enclosed in a case. Also, it is unlawful to possess any firearm or ammunition without a valid FOID (Firearms Owner Identification Card)."
    },
    {
      "index": 13,
      "name": "Indiana",
      "pistolText": "Open carry and concealed carry are legal without a permit. Individuals 18 years old or older not prohibited from carrying or possessing a handgun are no longer required to obtain a license to carry a handgun as of July 1, 2022. Open carry and concealed carry are legal without a permit. Individuals 18 years old or older not prohibited from carrying or possessing a handgun are no longer required to obtain a license to carry a handgun as of July 1, 2022. No person shall carry a handgun in any vehicle or on or about his person without a license being in his possession.",
      "rifleText": "With the exceptions of limitations on carrying during game seasons, state law is silent on the issue of carrying rifles.",
      "shotgunText": "With the exceptions of limitations on carrying during game seasons, state law is silent on the issue of carrying shotguns."
    },
    {
      "index": 14,
      "name": "Iowa",
      "pistolText": "As of July 1, 2021, Iowa is a permitless carry state for both open carry and concealed carry for anyone at least 21 years old that may lawfully possess a handgun. As of July 1, 2021, Iowa is a permitless carry state for both open carry and concealed carry for anyone at least 21 years old that may lawfully possess a handgun. Iowa prohibits any person from knowingly carrying or transporting a handgun in a vehicle. This prohibition does not apply if the person transports an unloaded handgun inside a closed and fastened container or other secure package that cannot be concealed on the person, or in a cargo or luggage compartment where the handgun cannot be readily accessible to any person in the vehicle or common carrier. This prohibition also does not apply to a person with a valid permit to carry, provided his or her conduct is within the limits of that permit.",
      "rifleText": "It is unlawful to have or carry any long gun in or on a vehicle on a public highway, unless the gun is taken down or totally contained in a securely fastened case, and its barrels and magazines are unloaded.",
      "shotgunText": "It is unlawful to have or carry any long gun in or on a vehicle on a public highway, unless the gun is taken down or totally contained in a securely fastened case, and its barrels and magazines are unloaded."
    },
    {
      "index": 15,
      "name": "Kansas",
      "pistolText": "State law does not generally prohibit the open carrying of a handgun. Any person who can legally own a firearm may concealed carry if they are 21 or over.  No permit/license is required. Firearms may be openly carried in cars without any license except where localities have made open carry illegal.",
      "rifleText": "Firearms (rifles) may be openly carried in cars without any license except where localities have made open carry illegal.",
      "shotgunText": "Firearms (shotguns) may be openly carried in cars without any license except where localities have made open carry illegal."
    },
    {
      "index": 16,
      "name": "Kentucky",
      "pistolText": "A permit is not required to carry openly or concealed in Kentucky. A permit is not required to carry openly or concealed in Kentucky. Kentucky will allow a loaded handgun to be carried in a motor vehicle provided that the firearm is stored in any container, compartment, or storage space originally installed in the motor vehicle by its manufacturer.",
      "rifleText": "This is Kentucky's information about rifles.",
      "shotgunText": "This is Kentucky's information about shotguns."
    },
    {
      "index": 17,
      "name": "Louisiana",
      "pistolText": "The state of Louisiana recognizes open carry. No person shall carry a concealed firearm intentionally without a permit unless one is a peace officer in performance of his or her official duties. Lawfully possessed firearms may be transported or stored in a locked, privately owned motor vehicle in any parking lot, parking garage, or other designated parking area.",
      "rifleText": "Lawfully possessed firearms may be transported or stored in a locked, privately owned motor vehicle in any parking lot, parking garage, or other designated parking area.",
      "shotgunText": "Lawfully possessed firearms may be transported or stored in a locked, privately owned motor vehicle in any parking lot, parking garage, or other designated parking area."
    },
    {
      "index": 18,
      "name": "Maine",
      "pistolText": "It is not unlawful to carry a firearm openly. In 2015, Maine enacted a permitless carry law. No carry permit is necessary to carry a concealed handgun if the person is at least 21 years old and is not otherwise prohibited by state or federal law from carrying a firearm. The exceptions [to laws restricting transportation of loaded firearms in vehicles] include a loaded handgun carried in or on a vehicle by a person at least 21 years old who is not otherwise prohibited by law from carrying a firearm.",
      "rifleText": "It is unlawful for a person, while in or on a motor vehicle or trailer or other type of vehicle being hauled by a motor vehicle, to have a loaded crossbow or a loaded firearm (one with a cartridge or shell in the chamber or in an attached magazine, clip or cylinder, or a muzzle-loading firearm charged with powder, lead and a primed ignition device or mechanism).",
      "shotgunText": "It is unlawful for a person, while in or on a motor vehicle or trailer or other type of vehicle being hauled by a motor vehicle, to have a loaded crossbow or a loaded firearm (one with a cartridge or shell in the chamber or in an attached magazine, clip or cylinder, or a muzzle-loading firearm charged with powder, lead and a primed ignition device or mechanism)."
    },
    {
      "index": 19,
      "name": "Maryland",
      "pistolText": "It is unlawful for any person without a permit to wear or carry a handgun, openly or concealed, upon or about his person. It is unlawful for any person without a permit to wear or carry a handgun, openly or concealed, upon or about his person. It is also unlawful for any person to knowingly transport a handgun in any vehicle traveling on public roads, highways, waterways or airways, or upon roads or parking lots generally used by the public.",
      "rifleText": "Rifles and shotguns being transported in motor vehicles must be unloaded.",
      "shotgunText": "Rifles and shotguns being transported in motor vehicles must be unloaded."
    },
    {
      "index": 20,
      "name": "Massachusetts",
      "pistolText": "A license authorizes carrying of handguns, including large capacity handguns, for all lawful purposes, subject to such restrictions relative to the possession, use or carrying of handguns as the licensing authority deems proper. There is no Statute in Massachusetts law that prohibits a Massachusetts license holder from carrying a handgun openly. A license holder may carry a loaded handgun in a vehicle, if it is under his direct control. It is unlawful for any person licensed to carry a handgun to leave the firearm in a vehicle unattended.",
      "rifleText": "A license holder may carry a loaded handgun in a vehicle, if it is under his direct control.  However, this does not apply to large capacity rifles or shotguns.  Such firearms must be carried unloaded, in the locked trunk or in a locked case or other secure container. ",
      "shotgunText": "A license holder may carry a loaded handgun in a vehicle, if it is under his direct control.  However, this does not apply to large capacity rifles or shotguns.  Such firearms must be carried unloaded, in the locked trunk or in a locked case or other secure container. "
    },
    {
      "index": 21,
      "name": "Michigan",
      "pistolText": "Open carry is legal in Michigan only for residents that are at least 18 years old and who can legally possess a firearm, provided the gun is registered in their name. Non-residents must have a valid concealed carry license from their home state in order to conceal or open carry. It is unlawful to carry a handgun concealed on or about one’s person or concealed or openly in a vehicle without a license to carry a concealed pistol.",
      "rifleText": "In order to transport or possess rifles and shotguns in a motor vehicle, Michigan law requires that they be unloaded and be one or more of the following: broken down, enclosed in a case, carried in the trunk of the vehicle, or inaccessible from the interior of the vehicle.",
      "shotgunText": "In order to transport or possess rifles and shotguns in a motor vehicle, Michigan law requires that they be unloaded and be one or more of the following: broken down, enclosed in a case, carried in the trunk of the vehicle, or inaccessible from the interior of the vehicle."
    },
    {
      "index": 22,
      "name": "Minnesota",
      "pistolText": "A person, other than a peace officer, as defined in section 626.84, subdivision 1, who carries, holds, or possesses a pistol in a motor vehicle, snowmobile, or boat, or on or about the person's clothes or the person, or otherwise in possession or control in a public place without first having obtained a permit to carry the pistol is guilty of a gross misdemeanor.",
      "rifleText": "Generally, a permit to carry is not required of a person...to transport in a motor vehicle, snowmobile or boat if the firearm is unloaded and in a closed and fastened case, gun box or securely tied package.",
      "shotgunText": "Generally, a permit to carry is not required of a person...to transport in a motor vehicle, snowmobile or boat if the firearm is unloaded and in a closed and fastened case, gun box or securely tied package."
    },
    {
      "index": 23,
      "name": "Mississippi",
      "pistolText": "A permit to carry is available, but it is not required to carry a handgun either openly or concealed. For persons without a permit, a prohibition does not generally apply to a person lawfully carrying a pistol or revolver in a belt or shoulder holster or in a purse, bag, or other case.",
      "rifleText": "Mississippi permits the open carrying of a long gun in a motor vehicle without a permit or license.",
      "shotgunText": "Mississippi permits the open carrying of a long gun in a motor vehicle without a permit or license."
    },
    {
      "index": 24,
      "name": "Missouri",
      "pistolText": "Open carry and concealed carry are legal in Missouri without a Concealed Carry Permit (CCP) for anyone 19 years or older who can legally possess a firearm. State law does not prohibit the open carrying of firearms, but does prohibit exhibiting “any weapon readily capable of lethal use” in an angry or threatening manner in the presence of one or more persons. A concealed carry permit authorizes the carrying of a concealed firearm on or about the applicant’s person or within a vehicle.",
      "rifleText": "A concealed carry permit authorizes the carrying of a concealed firearm on or about the applicant’s person or within a vehicle. Carrying a concealed firearm (or any other weapon readily capable of lethal use) into any area where firearms are restricted under Mo. Rev. Stat. § 571.107. This does not apply to any person at least 19 years old (18 or older and a member of the US Armed Forces, or honorably discharged) transporting a lawfully possessed concealable firearm in the passenger compartment of a motor vehicle. It does not apply to possession of an exposed firearm or projectile weapon for the lawful pursuit of game, or possession in a person’s dwelling unit or other premises owned or controlled by the person, or anyone traveling in a continuous journey peaceably through the state.",
      "shotgunText": "A concealed carry permit authorizes the carrying of a concealed firearm on or about the applicant’s person or within a vehicle. Carrying a concealed firearm (or any other weapon readily capable of lethal use) into any area where firearms are restricted under Mo. Rev. Stat. § 571.107. This does not apply to any person at least 19 years old (18 or older and a member of the US Armed Forces, or honorably discharged) transporting a lawfully possessed concealable firearm in the passenger compartment of a motor vehicle. It does not apply to possession of an exposed firearm or projectile weapon for the lawful pursuit of game, or possession in a person’s dwelling unit or other premises owned or controlled by the person, or anyone traveling in a continuous journey peaceably through the state."
    },
    {
      "index": 25,
      "name": "Montana",
      "pistolText": "The open carry of a weapon is generally allowed by any person who is not otherwise prohibited from doing so under federal or state law. A person carrying openly may communicate to another person the fact that the person has a weapon. Montana amended its law in 2021 to allow permitless concealed carry. “Concealed” is defined as a firearm that is wholly or partially covered by the clothing or wearing apparel of the person carrying or bearing the weapon. Montana permits open carrying of firearms in a vehicle with no permit or license required.",
      "rifleText": "Montana permits open carrying of firearms in a vehicle with no permit or license required.",
      "shotgunText": "Montana permits open carrying of firearms in a vehicle with no permit or license required."
    },
    {
      "index": 26,
      "name": "Nebraska",
      "pistolText": "Nebraska is an 'open carry' state, which means most adults may carry visible guns in most places. A permitholder shall carry his or her permit to carry a concealed handgun and his or her Nebraska driver's license, Nebraska-issued state identification card, or military identification card any time he or she carries a concealed handgun. A permit holder may bring a permitted handgun onto [certain] prohibiting premises in a vehicle, so long as the firearm remains in the vehicle.",
      "rifleText": "Nebraska generally does not require firearms in vehicles to be unloaded or locked.",
      "shotgunText": "Nebraska generally does not require firearms in vehicles to be unloaded or locked, although Nebraska prohibits carrying a loaded shotgun in or on any vehicle on any highway."
    },
    {
      "index": 27,
      "name": "Nevada",
      "pistolText": "State law does not prohibit the open carrying of a firearm, but one should exercise caution when carrying a firearm in public. It is unlawful to carry concealed upon the person a handgun or other firearm without a permit to carry. State law has been interpreted to allow an individual to carry a firearm in their vehicle as long as it is not actually on the person or in a container carried by the person.",
      "rifleText": "It is unlawful to carry a loaded rifle or shotgun in a vehicle that is being used on a public highway. A firearm is loaded if there is an unexpended cartridge or shell in the firing chamber but not when the only cartridges or shells are in the magazine.",
      "shotgunText": "It is unlawful to carry a loaded rifle or shotgun in a vehicle that is being used on a public highway. A firearm is loaded if there is an unexpended cartridge or shell in the firing chamber but not when the only cartridges or shells are in the magazine."
    },
    {
      "index": 28,
      "name": "New Hampshire",
      "pistolText": "New Hampshire is a permitless carry state, and New Hampshire Statute 159:6(III) provides that 'The availability of a license to carry a loaded pistol or revolver under this section or under any other provision of law shall not be construed to impose a prohibition on the unlicensed transport or carry of a firearm in a vehicle, or on or about one’s person, whether openly or concealed, loaded or unloaded, by a resident, nonresident, or alien if that individual is not otherwise prohibited by statute from possessing a firearm in the state of New Hampshire.'",
      "rifleText": "No person shall have or carry, in or on a motor vehicle, Off-Highway Recreational Vehicle, snowmobile, or aircraft, whether moving, a cocked crossbow or a loaded rifle or loaded shotgun. New Hampshire Statute 207:7(II)",
      "shotgunText": "No person shall have or carry, in or on a motor vehicle, Off-Highway Recreational Vehicle, snowmobile, or aircraft, whether moving, a cocked crossbow or a loaded rifle or loaded shotgun. New Hampshire Statute 207:7(II)"
    },
    {
      "index": 29,
      "name": "New Jersey",
      "pistolText": "It is unlawful to knowingly have in your possession a handgun, including any antique handgun, without first obtaining a Permit to Carry. No distinction is drawn between carrying openly or concealed.",
      "rifleText": "It is unlawful to knowingly have in your possession a rifle without first obtaining a FID card. It is Illegal to carry a loaded shotgun or rifle in any vehicle, or to shoot from any vehicle or across any road.",
      "shotgunText": "It is unlawful to knowingly have in your possession a shotgun without first obtaining a FID card. It is Illegal to carry a loaded shotgun or rifle in any vehicle, or to shoot from any vehicle or across any road."
    },
    {
      "index": 30,
      "name": "New Mexico",
      "pistolText": "New Mexico does not prohibit open carrying. It is unlawful to carry a concealed loaded firearm, unless the person is (1) carrying in the person’s own residence or on real property that he or she owns or controls; (2) carrying in a private automobile or other private means of conveyance, for lawful protection of the person or another person or property; (3) a peace officer in the lawful discharge of his or her duties; or (4) in possession of a valid concealed handgun license issued by the Department of Public Safety. This law does not prohibit the carrying of any unloaded firearm.",
      "rifleText": "The exception for carrying in a vehicle includes motorcycles and bicycles. If the person does not have a New Mexico license to carry or a license from a state that New Mexico recognizes, the person cannot carry the weapon concealed on the person when exiting the vehicle or conveyance",
      "shotgunText": "The exception for carrying in a vehicle includes motorcycles and bicycles. If the person does not have a New Mexico license to carry or a license from a state that New Mexico recognizes, the person cannot carry the weapon concealed on the person when exiting the vehicle or conveyance"
    },
    {
      "index": 31,
      "name": "New York",
      "pistolText": "New York State does not recognize concealed weapons permits issued by other states. New York State issues various types of handgun licenses under NY Penal Law § 400.00(2) (e.g., to have and possess in a dwelling by a householder; to have and possess in a place of business by a merchant). Not all license types allow unrestricted concealed carrying. The license must specify whether it is issued to carry on the person or possess on the premises, and if on the premises, it must specify the place where the licensee may possess the handgun.  Open carry in public is not legal in most instances.",
      "rifleText": "Possession of a loaded rifle or shotgun in a vehicle is generally illegal. N.Y. Envtl. Conserv. Law § 11-0931(2) (permit may be issued to any person who is non-ambulatory to possess a loaded firearm in or on a motor vehicle for hunting).",
      "shotgunText": "Possession of a loaded rifle or shotgun in a vehicle is generally illegal. N.Y. Envtl. Conserv. Law § 11-0931(2) (permit may be issued to any person who is non-ambulatory to possess a loaded firearm in or on a motor vehicle for hunting)."
    },
    {
      "index": 32,
      "name": "North Carolina",
      "pistolText": "It is unlawful to carry concealed about one’s person a firearm except on one’s own premises, or if the person has a concealed handgun permit. Open carry is legal in North Carolina without a permit, if you can legally own a firearm. ",
      "rifleText": "No county or municipality, by zoning or other ordinance, shall regulate in any manner firearms shows with regulations more stringent than those applying to shows of other types of items. Municipalities or counties have the authority under G.S. 153A-129, 160A-189, 14-269, 14-269.2, 14-269.3, 14-269.4, 14-277.2, 14-415.11, 14-415.23, to prohibit the possession of firearms in public-owned buildings, on the grounds or parking areas of those buildings, or in public parks or recreation areas, though nothing shall prohibit a person from storing a firearm within a motor vehicle while the vehicle is on these grounds or areas.",
      "shotgunText": "No county or municipality, by zoning or other ordinance, shall regulate in any manner firearms shows with regulations more stringent than those applying to shows of other types of items. Municipalities or counties have the authority under G.S. 153A-129, 160A-189, 14-269, 14-269.2, 14-269.3, 14-269.4, 14-277.2, 14-415.11, 14-415.23, to prohibit the possession of firearms in public-owned buildings, on the grounds or parking areas of those buildings, or in public parks or recreation areas, though nothing shall prohibit a person from storing a firearm within a motor vehicle while the vehicle is on these grounds or areas."
    },
    {
      "index": 33,
      "name": "North Dakota",
      "pistolText": "Any person who is not otherwise prohibited by law from possessing a firearm may carry an unloaded handgun openly or “secured,” without a license. A person may not carry a concealed firearm or dangerous weapon unless the individual is a law enforcement officer, has a license to do so or qualifies for reciprocity, or meets the requirements for permitless carry.",
      "rifleText": "North Dakota amended its permitless carry law in 2021, but it is still limited to residents of the state. Specifically, a person who is meets the qualifications for a class 2 firearm license (at least 18 years old, resident of the state, not prohibited under North Dakota or federal law from possessing a firearm), and who has possessed for at least 30 days a valid driver’s license or nondriver ID card issued by the North Dakota department of transportation may carry a firearm concealed without a license. “Concealed” means “not discernible by the ordinary observation of a passerby.” A firearm or dangerous weapon is considered concealed if it is not secured, and is worn under clothing or carried in a bundle that is held or carried by the individual, or transported in a vehicle under the individual’s control or direction and available to the individual, including beneath the seat or in a glove compartment.",
      "shotgunText": "North Dakota amended its permitless carry law in 2021, but it is still limited to residents of the state. Specifically, a person who is meets the qualifications for a class 2 firearm license (at least 18 years old, resident of the state, not prohibited under North Dakota or federal law from possessing a firearm), and who has possessed for at least 30 days a valid driver’s license or nondriver ID card issued by the North Dakota department of transportation may carry a firearm concealed without a license. “Concealed” means “not discernible by the ordinary observation of a passerby.” A firearm or dangerous weapon is considered concealed if it is not secured, and is worn under clothing or carried in a bundle that is held or carried by the individual, or transported in a vehicle under the individual’s control or direction and available to the individual, including beneath the seat or in a glove compartment."
    },
    {
      "index": 34,
      "name": "Ohio",
      "pistolText": "It is generally unlawful to carry concealed on the person or concealed ready at hand a handgun without a concealed handgun license. It is illegal to transport or carry a loaded firearm in a motor vehicle, if the gun is accessible to the operator or any passenger without leaving the vehicle. One of the exceptions is a person transporting or carrying a loaded handgun who either has a valid concealed handgun license, or is an active duty member of the US armed forces of the United States with a valid military ID card and documentation of successful completion of firearms training that meets the permit requirements.",
      "rifleText": "State law allows a person, who is not prohibited by law from possessing firearm, to have or transport a firearm in a motor vehicle if the gun is unloaded (as defined below) and carried in one of the following ways: in a closed package, box or case; in plain sight and secured in a rack or holder made for that purpose; for long guns, in plain sight, with the action open or the weapon stripped, or if the firearm’s action will not stay open or it cannot be easily stripped, in plain sight.",
      "shotgunText": "State law allows a person, who is not prohibited by law from possessing firearm, to have or transport a firearm in a motor vehicle if the gun is unloaded (as defined below) and carried in one of the following ways: in a closed package, box or case; in plain sight and secured in a rack or holder made for that purpose; for long guns, in plain sight, with the action open or the weapon stripped, or if the firearm’s action will not stay open or it cannot be easily stripped, in plain sight."
    },
    {
      "index": 35,
      "name": "Oklahoma",
      "pistolText": "State law does not prohibit open carry of firearms (loaded and unloaded) without a license, provided the carrying is not in violation of any other law. For handguns, “unconcealed handgun” or “open carry” is defined as a loaded or unloaded handgun carried upon the person in a holster where the firearm is visible, or carried upon the person using a scabbard, sling or case designed for carrying firearms. ",
      "rifleText": "Carrying a loaded or unloaded shotgun, rifle or handgun without a carry license is specifically allowed under 21 Okla. Stat. Ann. § 1289.6 for:  Lawful self-defense and self-protection or any other legitimate purpose not in violation of any law regarding the use, carrying, ownership and control of firearms. Anyone carrying a firearm, concealed or unconcealed, loaded or unloaded, who is at least 21 years old (at least 18 years old if the person is a member or veteran of the US Armed Forces, Reserves or National Guard or has been discharged under honorable conditions) and the person is otherwise not disqualified from the possession or purchase of a firearm under state or federal law and is not carrying the firearm in furtherance of a crime.",
      "shotgunText": "Carrying a loaded or unloaded shotgun, rifle or handgun without a carry license is specifically allowed under 21 Okla. Stat. Ann. § 1289.6 for:  Lawful self-defense and self-protection or any other legitimate purpose not in violation of any law regarding the use, carrying, ownership and control of firearms. Anyone carrying a firearm, concealed or unconcealed, loaded or unloaded, who is at least 21 years old (at least 18 years old if the person is a member or veteran of the US Armed Forces, Reserves or National Guard or has been discharged under honorable conditions) and the person is otherwise not disqualified from the possession or purchase of a firearm under state or federal law and is not carrying the firearm in furtherance of a crime."
    },
    {
      "index": 36,
      "name": "Oregon",
      "pistolText": "It is unlawful to carry concealed upon the person or concealed about one's person in a vehicle any firearm unless one has a license to carry a concealed weapon. Firearms carried openly in belt holsters are not considered to be concealed.",
      "rifleText": "It is unlawful to carry concealed upon the person or concealed about one's person in a vehicle any firearm unless one has a license to carry a concealed weapon. Firearms carried openly in belt holsters are not considered to be concealed.",
      "shotgunText": "It is unlawful to carry concealed upon the person or concealed about one's person in a vehicle any firearm unless one has a license to carry a concealed weapon. Firearms carried openly in belt holsters are not considered to be concealed."
    },
    {
      "index": 37,
      "name": "Pennsylvania",
      "pistolText": " Any person carrying a handgun in any vehicle or concealed on or about his person’ is required to have a license to carry or a Sportsman’s Firearm Permit (good only for hunting, fishing, trapping and dog training).  However, no license is required: (1) to carry a handgun in one’s home or fixed place of business; (2) when engaged in target shooting or while going to or from shooters’ places of assembly or target practice, provided the firearm is unloaded and the ammunition is carried in a separate container;  (3) for law enforcement personnel, including policemen, jail wardens, and sheriffs and their deputies; (4) to carry an unloaded and securely wrapped firearm from place of purchase to one’s home or place of business, to or from a place of repair, or in moving from one place of abode or business to another, or from one’s home to a vacation or recreational home or dwelling or back, to recover stolen property, or to a location to which the person has been directed to surrender firearms or back upon return of the surrendered firearm;  (5) to carry while lawfully hunting or fishing or going to the place of hunting or fishing, provided one has a hunting or fishing license and a Sportsman’s Firearm Permit; (6) while carrying a firearm in any vehicle when the person possesses a valid and lawfully issued license for that firearm which has been issued under the laws of the U.S. or any other state; (7) by a person who has a lawfully issued license to carry a firearm and said license expired within six months prior to the date of arrest and that individual is otherwise eligible for renewal of that license; (8) by any person who is otherwise eligible to possess a firearm and who is operating a motor vehicle which is registered in the person’s name or the name of a spouse or parent and which contains a firearm for which a valid license has been issued to the spouse or parent owning the firearm. A Sportsman’s Firearm Permit does not authorize carrying a loaded handgun in a vehicle. ",
      "rifleText": "A license to carry or a Sportsman’s Firearm Permit does not authorize carrying a loaded shotgun or rifle in any vehicle. Rifles and shotguns may be transported in a vehicle as long as they are unloaded.",
      "shotgunText": "A license to carry or a Sportsman’s Firearm Permit does not authorize carrying a loaded shotgun or rifle in any vehicle. Rifles and shotguns may be transported in a vehicle as long as they are unloaded."
    },
    {
      "index": 38,
      "name": "Rhode Island",
      "pistolText": "It is unlawful to carry a handgun on or about one’s person or in any vehicle or conveyance without a license to carry. An exception includes 'a person carrying a handgun unloaded and securely wrapped from the place of purchase to his home or place of business, or in moving goods from one's place of abode or business to another.'",
      "rifleText": "It is unlawful to possess a loaded rifle or shotgun “in or on any vehicle or conveyance or its attachments” while on any public road.",
      "shotgunText": "It is unlawful to possess a loaded rifle or shotgun “in or on any vehicle or conveyance or its attachments” while on any public road."
    },
    {
      "index": 39,
      "name": "South Carolina",
      "pistolText": "South Carolina authorizes individuals who are not otherwise prohibited from possessing a firearm, to legally possess a firearm openly or concealed without training and without a concealed weapons permit issued by SLED",
      "rifleText": "Generally, a person who is not otherwise prohibited by law from carrying a firearm may lawfully store a firearm anywhere in a vehicle, whether occupied or unoccupied. Exceptions apply such as on school grounds, parks, and capitol grounds.",
      "shotgunText": "Generally, a person who is not otherwise prohibited by law from carrying a firearm may lawfully store a firearm anywhere in a vehicle, whether occupied or unoccupied. Exceptions apply such as on school grounds, parks, and capitol grounds."
    },
    {
      "index": 40,
      "name": "South Dakota",
      "pistolText": "No person shall carry a pistol concealed in any vehicle or concealed on or about his person, without a license to carry. South Dakota is currently a shall-issue, permitless carry state. Open carry is legal in South Dakota without a permit.",
	  "rifleText": "South Dakota has no explicit laws restricting the transportation of rifles on public roadways, except for restricted areas such as schools. Anyone over the age of 18 and not prohibited from possessing a firearm may carry a rifle in their vehicle.",
      "shotgunText": "South Dakota has no explicit laws restricting the transportation of shotgun on public roadways, except for restricted areas such as schools. Anyone over the age of 18 and not prohibited from possessing a firearm may carry a shotgun in their vehicle."
    },
    {
      "index": 41,
      "name": "Tennessee",
      "pistolText": "Tennessee allows persons 21 and older to lawfully openly or concealed carry a pistol as long as they lawfully possess the handgun and the person is in a place where the person is lawfully present. Tennessee issues permits for carrying handguns.",
      "rifleText": "Persons not prohibited from possessing firearms may lawfully carry on or about their person a rifle given that it is unloaded and the ammunition for the rifle was not in the immediate vicinity of the firearm. Tennessee allows permittees to possess magazine loaded, but chamber unloaded, long guns in vehicles.",
      "shotgunText": "Persons not prohibited from possessing firearms may lawfully carry on or about their person a shotgun given that it is unloaded and the ammunition for the shotgun was not in the immediate vicinity of the firearm. Tennessee allows permittees to possess magazine loaded, but chamber unloaded, long guns in vehicles."
    },
    {
      "index": 42,
      "name": "Texas",
      "pistolText": "As of 2021, people who qualify under the law can carry a handgun in a public place in Texas without a license to carry (LTC).",
      "rifleText": "Texas law does not specifically say how you can carry a long gun such as a rifle. We have not found any Texas laws that restrict transporting a rifle or other long gun in a motor vehicle.",
      "shotgunText": "Texas law does not specifically say how you can carry a long gun such as a shotgun. We have not found any Texas laws that restrict transporting a rifle or other long gun in a motor vehicle. "
    },
    {
      "index": 43,
      "name": "Utah",
      "pistolText": "May carry openly without permit if 21 or older. It is unlawful to carry a concealed firearm without a permit, even if it is unloaded, unless it is securely encased. It is legal to carry a loaded handgun in a vehicle without a permit if the vehicle is in the person's lawful possession or the handgun is carried with the consent of the person in lawful possession of the vehicle.",
      "rifleText": "May carry openly without permit if 21 or older. Utah Code 76-10-505 prohibits the possession of a loaded rifle, shotgun, or muzzle-loading rifle in a vehicle without a permit.",
      "shotgunText": "May carry openly without permit if 21 or older. Utah Code 76-10-505 prohibits the possession of a loaded rifle, shotgun, or muzzle-loading rifle in a vehicle without a permit."
    },
    {
      "index": 44,
      "name": "Vermont",
      "pistolText": "It is lawful to carry a firearm openly or concealed provided the firearm is not carried with the intent or avowed purpose of injuring a fellow man. It is unlawful to carry a firearm within any state institution or upon the grounds or lands owned or leased by such institution.",
      "rifleText": "It is lawful to carry a firearm openly or concealed provided the firearm is not carried with the intent or avowed purpose of injuring a fellow man. It is unlawful to carry a firearm within any state institution or upon the grounds or lands owned or leased by such institution. It is unlawful to carry or possess a loaded rifle or shotgun in or on a motor vehicle within the right of way of a public highway.",
      "shotgunText": "It is lawful to carry a firearm openly or concealed provided the firearm is not carried with the intent or avowed purpose of injuring a fellow man. It is unlawful to carry a firearm within any state institution or upon the grounds or lands owned or leased by such institution. It is unlawful to carry or possess a loaded rifle or shotgun in or on a motor vehicle within the right of way of a public highway."
    },
    {
      "index": 45,
      "name": "Virginia",
      "pistolText": "The open carrying of a handgun in Virginia is lawful. Concealed carrying a handgun is prohibited, except for carrying a loaded handgun by persons who may lawfully possess such gun, inside an unlocked vehicle compartment or container, within reach of a driver or passenger who does not possess a concealed weapons permit. Concealed carry permits may be issued to residents of Virginia.",
      "rifleText": "Openly carrying a rifle is lawful in Virginia, except for semi or fully-automatic rifles that carry more than 20 rounds. When a person is transporting a firearm in Virginia, they must transport the firearm unloaded. It needs to be unloaded, secured in a case, and it should be as far away from the end of the vehicle as possible.",
      "shotgunText": "Openly carrying a shotgun is lawful in Virginia, except for shotguns that hold more than 7 rounds of the longest accepting ammunition. When a person is transporting a firearm in Virginia, they must transport the firearm unloaded. It needs to be unloaded, secured in a case, and it should be as far away from the end of the vehicle as possible."
    },
    {
      "index": 46,
      "name": "Washington",
      "pistolText": "Washington is an ‘open carry’ state, meaning that it is legal in Washington to carry an unconcealed firearm unless the circumstances manifest an intent to intimidate another or warrant alarm for the safety of other person. Except in the person's place of abode or fixed place of business, a person shall not carry a pistol concealed on his or her person without a license to carry a concealed pistol. Open or concealed carry of a loaded handgun in a vehicle is not permitted without a concealed pistol license and (1) the handgun is on the licensee’s person, (2) the licensee is within the vehicle at all times that the handgun is there, or (3) the licensee is away from the vehicle and the handgun is locked within the vehicle and concealed from view from outside the vehicle.",
      "rifleText": "Washington is an ‘open carry’ state, meaning that it is legal in Washington to carry an unconcealed firearm unless the circumstances manifest an intent to intimidate another or warrant alarm for the safety of other person. Loaded shotguns or rifles may not be carried, transported, or possessed inside a motor vehicle or an off-road vehicle, subject to any rules imposed by the Department of Fish and Wildlife.",
      "shotgunText": "Washington is an ‘open carry’ state, meaning that it is legal in Washington to carry an unconcealed firearm unless the circumstances manifest an intent to intimidate another or warrant alarm for the safety of other person. Loaded shotguns or rifles may not be carried, transported, or possessed inside a motor vehicle or an off-road vehicle, subject to any rules imposed by the Department of Fish and Wildlife."
    },
    {
      "index": 47,
      "name": "West Virginia",
      "pistolText": "A permit to carry is available, but it is not required to carry a handgun either openly or concealed for individuals 21 years of age or over. A hunting law requires that firearms in a motor vehicle be unloaded. In addition, firearms must be cased or taken apart and securely wrapped during the evening and night hours. Exempt from this requirement are persons who are lawfully carrying their pistol or revolver for self defense purposes while hunting or while in a motor vehicle.",
      "rifleText": "West Virginia is a permitless carry state. A person who is not prohibited from possessing a firearm may carry a firearm openly or concealed. A hunting law requires that firearms in a motor vehicle be unloaded. In addition, firearms must be cased or taken apart and securely wrapped during the evening and night hours",
      "shotgunText": "West Virginia is a permitless carry state. A person who is not prohibited from possessing a firearm may carry a firearm openly or concealed. A hunting law requires that firearms in a motor vehicle be unloaded. In addition, firearms must be cased or taken apart and securely wrapped during the evening and night hours"
    },
    {
      "index": 48,
      "name": "Wisconsin",
      "pistolText": "Open carry is legal for any person that is 18 years or older and not prohibited from possessing a firearm under state and federal laws. Concealed carry is legal for residents with a Wisconsin Concealed Weapons License (CWL) and for non-residents with a license/permit from a state that Wisconsin honors. You can have a loaded pistol in a car as long as it is visible and not covered or concealed in any way unless you have a concealed carry permit.",
      "rifleText": "TWisconsin is an open carry state with the right to bear arms, meaning anyone who is not otherwise barred from carrying a legal firearm may do so as long as they are in a public location, a building they own, a private establishment that isn't licensed to sell alcohol, or a public building. Rifles must be unloaded and must be displayed above the window line of the vehicle; otherwise it must be in a case.",
      "shotgunText": "Wisconsin is an open carry state with the right to bear arms, meaning anyone who is not otherwise barred from carrying a legal firearm may do so as long as they are in a public location, a building they own, a private establishment that isn't licensed to sell alcohol, or a public building. Shotguns must be unloaded and must be displayed above the window line of the vehicle; otherwise it must be in a case."
    },
    {
      "index": 49,
      "name": "Wyoming",
      "pistolText": "Open carry is legal; Wyoming respects the right of responsible citizens to openly carry a handgun. Permitless concealed carry is legal for any legal resident of the U.S. who is 21 years old or older, and who may lawfully possess a firearm.",
      "rifleText": "Wyoming allows the open carrying of firearms on the person without a permit or license. Wyoming residents who can legally own a firearm can transport a firearm loaded or unloaded in their vehicle without holding a Concealed Carry Permit issued by the state of Wyoming.",
      "shotgunText": "Wyoming allows the open carrying of firearms on the person without a permit or license. Wyoming residents who can legally own a firearm can transport a firearm loaded or unloaded in their vehicle without holding a Concealed Carry Permit issued by the state of Wyoming."
    }
  ];
  