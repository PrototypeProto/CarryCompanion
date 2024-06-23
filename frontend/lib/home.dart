import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;

  @override
  void initState() {
    super.initState();
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset("assets/gz_2010_us_040_00_20m.json",
        shapeDataField: "NAME",
        dataCount: _mapData.length,
        primaryValueMapper: (int index) => _mapData[index].state,
        dataLabelMapper: (int index) => _mapData[index].stateCode,
        shapeColorValueMapper: (int index) => _mapData[index].color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carry Companion")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //debug used to see space of expanded
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                //TODO need to have 2-3 maps maybe since Alaska && Hawaii is not visible w current zoom
                //most likely map objects are not movable hence more maps
                child: SfMaps(
                  layers: [
                    MapShapeLayer(
                        source: _shapeSource,
                        showDataLabels: true,
                        zoomPanBehavior: MapZoomPanBehavior(
                            focalLatLng: MapLatLng(37.0902, -95.7129),
                            zoomLevel: 6)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<MapModel> _getMapData() {
  // first is NAME from json, then 2nd is name displayed on the map
  //need variables here for colors so we can change them
  return <MapModel>[
    MapModel('Alabama', 'AL', Colors.red),
    MapModel('Alaska', 'AK', Colors.red),
    MapModel('Arizona', 'AZ', Colors.red),
    MapModel('Arkansas', 'AR', Colors.red),
    MapModel('California', 'CA', Colors.red),
    MapModel('Colorado', 'CO', Colors.red),
    MapModel('Connecticut', 'CT', Colors.red),
    MapModel('Delaware', 'DE', Colors.red),
    MapModel('Florida', 'FL', Colors.green),
    MapModel('Georgia', 'GA', Colors.red),
    MapModel('Hawaii', 'HI', Colors.red),
    MapModel('Idaho', 'ID', Colors.red),
    MapModel('Illinois', 'IL', Colors.red),
    MapModel('Indiana', 'IN', Colors.red),
    MapModel('Iowa', 'IA', Colors.red),
    MapModel('Kansas', 'KS', Colors.red),
    MapModel('Kentucky', 'KY', Colors.red),
    MapModel('Louisiana', 'LA', Colors.red),
    MapModel('Maine', 'ME', Colors.red),
    MapModel('Maryland', 'MD', Colors.red),
    MapModel('Massachusetts', 'MA', Colors.red),
    MapModel('Michigan', 'MI', Colors.red),
    MapModel('Minnesota', 'MN', Colors.red),
    MapModel('Mississippi', 'MS', Colors.red),
    MapModel('Missouri', 'MO', Colors.red),
    MapModel('Montana', 'MT', Colors.red),
    MapModel('Nebraska', 'NE', Colors.red),
    MapModel('Nevada', 'NV', Colors.red),
    MapModel('New Hampshire', 'NH', Colors.red),
    MapModel('New Jersey', 'NJ', Colors.red),
    MapModel('New Mexico', 'NM', Colors.red),
    MapModel('New York', 'NY', Colors.red),
    MapModel('North Carolina', 'NC', Colors.red),
    MapModel('North Dakota', 'ND', Colors.red),
    MapModel('Ohio', 'OH', Colors.red),
    MapModel('Oklahoma', 'OK', Colors.red),
    MapModel('Oregon', 'OR', Colors.red),
    MapModel('Pennsylvania', 'PA', Colors.red),
    MapModel('Rhode Island', 'RI', Colors.red),
    MapModel('South Carolina', 'SC', Colors.red),
    MapModel('South Dakota', 'SD', Colors.red),
    MapModel('Tennessee', 'TN', Colors.red),
    MapModel('Texas', 'TX', Colors.red),
    MapModel('Utah', 'UT', Colors.red),
    MapModel('Vermont', 'VT', Colors.red),
    MapModel('Virginia', 'VA', Colors.red),
    MapModel('Washington', 'WA', Colors.red),
    MapModel('West Virginia', 'WV', Colors.red),
    MapModel('Wisconsin', 'WI', Colors.red),
    MapModel('Wyoming', 'WY', Colors.red)
  ];
}

class MapModel {
  MapModel(this.state, this.stateCode, this.color);
  String state;
  String stateCode;
  Color color;
}
