import 'package:flutter/material.dart';

class Armory extends StatefulWidget {
  @override
  _ArmoryState createState() => _ArmoryState();
}

// TODO: /* Should fetch from API */
class _ArmoryState extends State<Armory> {
  final List<Map<String, dynamic>> _items = [
    {'type': 'Pistol', 'make': 'pipes', 'model': 'revvy'},
    {'type': 'Shotgun', 'make': 'wood/metal', 'model': 'eoka'},
    {'type': 'Rifle', 'make': 'energy', 'model': 'HaVoc'},
    {'type': '???', 'make': 'chaotic', 'model': '???'},
  ];

  int _hoverIndex = -1;

  void _onItemTapped(String name) {
    print('Tapped on $name');
  }

  void _onHoverStart(int index) {
    setState(() {
      _hoverIndex = index;
    });
  }

  void _onHoverEnd() {
    setState(() {
      _hoverIndex = -1;
    });
  }

  String createImagePath(String type) {
    if (type == "Pistol") {
      return "lib/img/pistol.png";
    } else if (type == "Rifle") {
      return "lib/img/rifle.png";
    } else if (type == "Shotgun") {
      return "lib/img/shotgun.png";
    } else {
      return "lib/img/unknown.png";  
    }
  }

  void _showAddGunDialog(BuildContext context) {
    String? newType;
    String? newMake;
    String? newModel;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Gun'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Type'),
                  value: newType,
                  items: ['Pistol', 'Rifle', 'Shotgun'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    newType = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Make'),
                  onChanged: (value) {
                    newMake = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Model'),
                  onChanged: (value) {
                    newModel = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newType != null && newMake != null && newModel != null) {
                  setState(() {
                    _items.add({
                      'type': newType!,
                      'make': newMake!,
                      'model': newModel!,
                    });
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Armory'),
      // ),
      backgroundColor: Colors.blue[50], // Setting background color
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return MouseRegion(
            onEnter: (_) => _onHoverStart(index),
            onExit: (_) => _onHoverEnd(),
            child: InkWell(
              splashColor: Color.fromARGB(255, 103, 158, 204),
              onTap: () => _onItemTapped(_items[index]['model']),
              child: Card(
                color: _hoverIndex == index ? Colors.blue : Color.fromARGB(255, 139, 177, 209),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [  
                    Image.asset(
                      createImagePath(_items[index]['type']),
                      height: 80.0,
                      width: 80.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(_items[index]['model']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGunDialog(context);
        },
        tooltip: 'Add Gun',
        child: Icon(Icons.add),
      ),
    );
  }
}
