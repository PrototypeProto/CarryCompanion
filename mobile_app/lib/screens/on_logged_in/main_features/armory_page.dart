import 'package:flutter/material.dart';
import 'armory_methods/add_gun_popup.dart';
import 'armory_methods/delete_gun_confirmation.dart';

class Armory extends StatefulWidget {
  const Armory({super.key});

  @override
  _ArmoryState createState() => _ArmoryState();
}

// TODO: /* Should fetch from API / id should be objectID from mongodb */
class _ArmoryState extends State<Armory> {
  final List<Map<String, dynamic>> _items = [
    {'type': 'Pistol', 'make': 'pipes', 'model': 'p250', "id": 1},
    {'type': 'Shotgun', 'make': 'wood/metal', 'model': 'xm1014', "id": 2},
    {'type': 'Rifle', 'make': 'energy', 'model': 'AWP', "id": 3},
    {'type': '???', 'make': 'chaotic', 'model': 'Juan-perez', "id": 4},
  ];

  int numGuns = 0;
  int recentDeletedItem = 0;

  bool _isDeleteMode = false;

  int itemSelected = -1;

  void updateNumGuns() {
    numGuns = _items.length;
  }

  void decrementGunCounter() {
    (numGuns > 0) ? numGuns-- : numGuns = 0;
  }

  int incrementGunCounter() {
    return ++numGuns;
  }

  void _addItem(Map<String, dynamic> newItem) {
    setState(() {
      _items.add(newItem);
    });
  }

  /* Responsible for logic with deletion */
  /* Set item selected to -1 if not in delete mode
      upon changing from delete to nondelete, if there is a itemSelected, remove
      Pop up a confirm delete
   */
  void _onItemTapped(String name, int index) {
    print('Tapped on $name');
    print('Tapped on id: ${_items[index]['id']}');
    itemSelected = index;

    if (_isDeleteMode) {
      itemSelected = index;
    } else {
      itemSelected = -1;
    }
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

  void _toggleDeleteMode() async {
    setState(() {
      _isDeleteMode = !_isDeleteMode;
    });

    if (!_isDeleteMode && itemSelected != -1) {
      bool? confirmDelete = await showConfirmDeleteDialog(context, _items[itemSelected]['model']);
      if (confirmDelete == true) {
        setState(() {
          _items.removeAt(itemSelected);
          decrementGunCounter();
          itemSelected = -1;
        });
      } /* else do nothing*/
    }
  }

  @override
  Widget build(BuildContext context) {
    updateNumGuns();
    return Scaffold(
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
            child: InkWell(
              splashColor: Color.fromARGB(255, 103, 158, 204),
              onTap: () => _onItemTapped(_items[index]['model'], index),
              child: Card(
                color: Color.fromARGB(255, 139, 177, 209),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _toggleDeleteMode,
            tooltip: _isDeleteMode ? 'Cancel Delete' : 'Delete Guns',
            backgroundColor: _isDeleteMode ? Colors.red : null,
            child: Icon(Icons.delete),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              showAddGunDialog(context, _addItem, numGuns);
              incrementGunCounter();
            },
            tooltip: 'Add Gun',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}