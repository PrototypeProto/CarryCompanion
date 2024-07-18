import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_core/theme.dart';


class ReciprocityPage extends StatefulWidget {
  const ReciprocityPage({super.key});

  @override
  State<ReciprocityPage> createState() => _ReciprocityPageState();
}

class _ReciprocityPageState extends State<ReciprocityPage> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _mapData = _getMapData();
    _updateShapeSource();
  }

  void _updateShapeSource() {
    _shapeSource = MapShapeSource.asset(
      "assets/usa.json",
      shapeDataField: "name",
      dataCount: _mapData.length,
      primaryValueMapper: (int index) => _mapData[index].state,
      dataLabelMapper: (int index) => '',
      shapeColorValueMapper: (int index) => _mapData[index].color,
    );
  }

void _updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
      dropdownValue = states[selectedIndex+1];
    });
  }


final List<String> states = [
    "Select a Permit State", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
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
  String dropdownValue = "Select a Permit State";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reciprocity Map'), backgroundColor: Colors.black,titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), iconTheme: IconThemeData(color: Colors.white),),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              hint: Text('Please Select a State'),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  selectedIndex = states.indexOf(newValue)-1;
                  _applyPermitFilter();
                  _updateShapeSource();
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
                //TODO need to have 2-3 maps maybe since Alaska && Hawaii is not visible w current zoom
                //most likely map objects are not movable hence more maps
                child: SfMapsTheme(
                  data: SfMapsThemeData(
                    selectionColor: Colors.grey,
                    selectionStrokeWidth: 1,
                    selectionStrokeColor: Colors.white,
                  ),
                  child: SfMaps(
                    layers: [
                      MapShapeLayer(
                        source: _shapeSource,
                        showDataLabels: true,
                        strokeColor: Colors.white,
                        dataLabelSettings: MapDataLabelSettings(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selectedIndex: selectedIndex,
                        onSelectionChanged: (int index) {
                          _updateSelectedIndex(index);
                          print('SelectedIndex : $selectedIndex');
                          dropdownValue = states[index+1];
                          _applyPermitFilter();
                          _updateShapeSource();
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
          )
        ],
      ),
    );
  }
  
  void _applyPermitFilter() {
    //TODO make the drop down select multiple indexes
    for (int i=0; i<50; i++){
      _mapData[i].color = Colors.red;
    }
     var noRestrictions = permitRecognitionMapNoRestrictions[selectedIndex];
    for (int x in noRestrictions!){
      _mapData[x].color = Colors.green;
    }
     var restrictions = permitRecognitionMapWithRestrictions[selectedIndex];
    for (int x in restrictions!){
      _mapData[x].color = Colors.yellow;
    }
    _mapData[selectedIndex].color = Colors.green;
  }
}


List<MapModel> _getMapData() {
  // first is NAME from json, then 2nd is name displayed on the map
  //need variables here for colors so we can change them

  return <MapModel>[
    MapModel('Alabama', 'AL', Colors.grey),
    MapModel('Alaska', 'AK', Colors.grey),
    MapModel('Arizona', 'AZ', Colors.grey),
    MapModel('Arkansas', 'AR', Colors.grey),
    MapModel('California', 'CA', Colors.grey),
    MapModel('Colorado', 'CO', Colors.grey),
    MapModel('Connecticut', 'CT', Colors.grey),
    MapModel('Delaware', 'DE', Colors.grey),
    MapModel('Florida', 'FL', Colors.grey),
    MapModel('Georgia', 'GA', Colors.grey),
    MapModel('Hawaii', 'HI', Colors.grey),
    MapModel('Idaho', 'ID', Colors.grey),
    MapModel('Illinois', 'IL', Colors.grey),
    MapModel('Indiana', 'IN', Colors.grey),
    MapModel('Iowa', 'IA', Colors.grey),
    MapModel('Kansas', 'KS', Colors.grey),
    MapModel('Kentucky', 'KY', Colors.grey),
    MapModel('Louisiana', 'LA', Colors.grey),
    MapModel('Maine', 'ME', Colors.grey),
    MapModel('Maryland', 'MD', Colors.grey),
    MapModel('Massachusetts', 'MA', Colors.grey),
    MapModel('Michigan', 'MI', Colors.grey),
    MapModel('Minnesota', 'MN', Colors.grey),
    MapModel('Mississippi', 'MS', Colors.grey),
    MapModel('Missouri', 'MO', Colors.grey),
    MapModel('Montana', 'MT', Colors.grey),
    MapModel('Nebraska', 'NE', Colors.grey),
    MapModel('Nevada', 'NV', Colors.grey),
    MapModel('New Hampshire', 'NH', Colors.grey),
    MapModel('New Jersey', 'NJ', Colors.grey),
    MapModel('New Mexico', 'NM', Colors.grey),
    MapModel('New York', 'NY', Colors.grey),
    MapModel('North Carolina', 'NC', Colors.grey),
    MapModel('North Dakota', 'ND', Colors.grey),
    MapModel('Ohio', 'OH', Colors.grey),
    MapModel('Oklahoma', 'OK', Colors.grey),
    MapModel('Oregon', 'OR', Colors.grey),
    MapModel('Pennsylvania', 'PA', Colors.grey),
    MapModel('Rhode Island', 'RI', Colors.grey),
    MapModel('South Carolina', 'SC', Colors.grey),
    MapModel('South Dakota', 'SD', Colors.grey),
    MapModel('Tennessee', 'TN', Colors.grey),
    MapModel('Texas', 'TX', Colors.grey),
    MapModel('Utah', 'UT', Colors.grey),
    MapModel('Vermont', 'VT', Colors.grey),
    MapModel('Virginia', 'VA', Colors.grey),
    MapModel('Washington', 'WA', Colors.grey),
    MapModel('West Virginia', 'WV', Colors.grey),
    MapModel('Wisconsin', 'WI', Colors.grey),
    MapModel('Wyoming', 'WY', Colors.grey)
  ];
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);
  String state;
  String stateCode;
  Color color;
}





Map<int, List<int>> permitRecognitionMapWithRestrictions = {
  0: [5, 6, 7, 8,   21,  30, 33, 36, 37, 43, 47], // Alabama
  1: [5, 6, 7, 8,   21,  33, 36, 37, 43], // Alaska
  2: [5,   21,  33, 36, 43, 47], // Arizona
  3: [5,   21,  33, 36, 43, 47], // Arkansas
  4: [0, 5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // California
  5: [0, 1, 2, 3,  8,   21,  33, 36, 43, 47], // Colorado
  6: [5, 8,   21,  33, 36, 37, 43, 47], // Connecticut
  7: [5, 6, 8,   21,  33, 36, 37, 43, 47], // Delaware
  8: [5, 6, 7,   21,  33, 36, 37, 43, 47], // Florida
  9: [ 5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Georgia
  10: [0, 1, 2, 3,  5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Hawaii
  11: [ 5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Idaho
  12: [ 5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Illinois
  13: [ 5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Indiana
  14: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Iowa
  15: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Kansas
  16: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Kentucky
  17: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Louisiana
  18: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Maine
  19: [0, 1, 2, 3,  5, 6, 7, 8, 11, 12, 13, 14, 15, 16, 17, 18,  21, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Maryland
  20: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,  21, 22, 23, 24, 25, 26, 27, 28,  30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Massachusetts
  21: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   22, 23, 24, 25, 26, 27, 28,  30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Michigan
  22: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Minnesota
  23: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Mississippi
  24: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Missouri
  25: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Montana
  26: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Nebraska
  27: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Nevada
  28: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // New Hampshire
  29: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // New Jersey
  30: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28,   32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // New Mexico
  31: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28,  30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // New York
  32: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // North Carolina
  33: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28,  30,  32, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // North Dakota
  34: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Ohio
  35: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Oklahoma
  36: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28,  30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // Oregon
  37: [ 5, 6, 7, 8,   21,  33, 36, 43, 47], // Pennsylvania
  38: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Rhode Island
  39: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // South Carolina
  40: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // South Dakota
  41: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Tennessee
  42: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Texas
  43: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,   21, 22, 23, 24, 25, 26, 27, 28,  30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Utah
  44: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Vermont
  45: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Virginia
  46: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Washington
  47: [0, 1, 2, 3,  5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // West Virginia
  48: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Wisconsin
  49: [5, 6, 7, 8,   21,  33, 36, 37, 43, 47], // Wyoming
};

Map<int, List<int>> permitRecognitionMapNoRestrictions = {
  0: [1, 3, 9,  11, 13, 16, 17, 18, 22, 23, 25, 26, 27, 28, 32, 34, 35, 39, 41, 42, 45, 46, 48, 49], // Alabama
  1: [0, 3,  9,  11, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30, 32, 33, 34, 35, 38, 40, 41, 42, 44, 45, 46, 48, 49], // Alaska
  2: [1, 3,  6, 7, 9,  12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 28, 30,  32, 34, 35, 36, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Arizona
  3: [0, 1, 2,  6, 9,  12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 28, 30,  32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Arkansas
  4: [1, 2, 3, 5, 9, 11, 13, 16, 17, 18, 22, 23, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // California
  5: [2, 3,  9, 12, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Colorado
  6: [0, 2, 3,  7, 9,  11, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Connecticut
  7: [2, 6, 9, 11, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Delaware
  8: [2, 9,  12, 13, 16, 17, 18, 22, 23, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Florida
  9: [0, 1, 2, 3,  6, 7, 8,  11, 12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Georgia
  10: [1, 2, 3,  8, 9, 12, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Hawaii
  11: [0, 1, 2, 3,  6, 7, 9, 12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Idaho
  12: [0, 2, 3,  5, 6, 8, 9, 11, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Illinois
  13: [0, 1, 2, 3,  5, 6, 7, 8, 9, 11, 12, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Indiana
  14: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Iowa
  15: [0, 1, 2, 3,  6, 9,  11, 12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Kansas
  16: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 17, 18, 22, 23, 24, 25, 26, 27, 28,  30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Kentucky
  17: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Louisiana
  18: [0, 1, 2, 3,  5, 6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Maine
  19: [11, 13, 17, 22, 24, 25, 27, 28, 30, 32, 33, 34, 35, 38, 39, 41, 42, 44, 45, 46, 48, 49], // Maryland
  20: [1, 2, 3,  9,  11, 12, 13, 16, 17, 18, 22, 23, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // Massachusetts
  21: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Michigan
  22: [0, 1, 2, 3,  6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18,  21, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Minnesota
  23: [0, 1, 2, 3,  6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Mississippi
  24: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Missouri
  25: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Montana
  26: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 25, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Nebraska
  27: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 25, 26, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Nevada
  28: [0, 1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 25, 26, 27, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // New Hampshire
  29: [1, 2, 3,  9, 11, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // New Jersey
  30: [1, 2, 3,  5, 6, 8, 9, 11, 12, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // New Mexico
  31: [0, 1, 2, 3,  6, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49], // New York
  32: [0, 1, 2, 3,  6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // North Carolina
  33: [1, 2, 3,  6, 7, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // North Dakota
  34: [0, 1, 2, 3,  6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Ohio
  35: [0, 1, 2, 3,  6, 7, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Oklahoma
  36: [1, 2, 3,  5, 6, 8, 9, 11, 12, 13, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Oregon
  37: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Pennsylvania
  38: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Rhode Island
  39: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 44, 45, 46, 48, 49], // South Carolina
  40: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // South Dakota
  41: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 44, 45, 46, 48, 49], // Tennessee
  42: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 44, 45, 46, 48, 49], // Texas
  43: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48, 49], // Utah
  44: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 45, 46, 48, 49], // Vermont
  45: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 46, 48, 49], // Virginia
  46: [0, 1, 2, 3,  5, 6, 8, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 48, 49], // Washington
  47: [1, 2, 3,  5, 9, 11, 13, 16, 17, 18, 22, 23, 25, 26, 27, 28, 30,  32, 34, 35, 37, 38, 39, 41, 42, 44, 45, 46, 48, 49], // West Virginia
  48: [0, 1, 2, 3,  6, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 49], // Wisconsin
  49: [0, 1, 2, 3,  6, 9,  11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 26, 27, 28, 30,  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 48], // Wyoming
};
