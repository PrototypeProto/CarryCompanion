import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gun/api/api.dart';
import 'package:gun/api/persist.dart';
import 'armory_methods/add_gun_popup.dart';
import 'armory_methods/delete_gun_confirmation.dart';

class Armory extends StatefulWidget {
  const Armory({super.key});

  @override
  _ArmoryState createState() => _ArmoryState();
}

class _ArmoryState extends State<Armory> {
  List<Map<String, dynamic>> _items = [];
  int numGuns = 0;
  int recentDeletedItem = 0;
  bool _isDeleteMode = false;
  int itemSelected = -1;
  String jwt = "";
  final PreferencesHelper _prefsHelper = PreferencesHelper();


  @override
  void initState() {
    super.initState();
    // _prefsHelper = PreferencesHelper();
    _fetchAndStoreGuns();
  }

  // Method to fetch guns and update state
  Future<void> _fetchAndStoreGuns() async {
    String? _jwt = await _prefsHelper.getJwt();
    // if (jwt == null) {
    //   throw Exception("JWT token is null");
    // }
    try {
      // Fetch guns
      List<Map<String, dynamic>> guns = await _prefsHelper.retrieveGuns();

      // Update state with fetched guns
      setState(() {
        _items = guns;
        numGuns = _items.length;
        jwt = _jwt!;
      });
    } catch (e) {
      // Handle errors (e.g., log the error, show a message to the user)
      print('Failed to fetch or store guns: $e');
      setState(() {
        _items = [
          {'type': 'Pistol', 'make': 'pipes', 'model': 'p250', "id": 1},
          {'type': 'Shotgun', 'make': 'wood/metal', 'model': 'xm1014', "id": 2},
          {'type': 'Rifle', 'make': 'energy', 'model': 'AWP', "id": 3},
          {'type': '???', 'make': 'chaotic', 'model': 'Juan-perez', "id": 4},
        ];
      });
    }
  }

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
      bool? confirmDelete =
          await showConfirmDeleteDialog(context, _items[itemSelected]['model']);
      if (confirmDelete == true) {
        setState(() {
          ApiService serv = ApiService(
            baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com",
          );

          log("DELETING\n");
          log(_items[itemSelected]['_id']);
          serv.deleteWeapon(_items[itemSelected]['_id'], jwt);
          _items.removeAt(itemSelected);
          _prefsHelper.storeGuns(_items);
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
      backgroundColor:
          Colors.grey[300], // Matching background color to Login page
      body: GridView.builder(
        padding:
            const EdgeInsets.all(16.0), // Updated padding to match Login page
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return MouseRegion(
            child: InkWell(
              splashColor: Colors.red
                  .withOpacity(0.5), // Matching splash color to Login page
              onTap: () => _onItemTapped(_items[index]['model'], index),
              child: Card(
                color: Colors.black, // Matching card color to Login page
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Adjusted border radius
                      child: ColoredBox(
                        color:
                            Colors.white.withOpacity(0.2), // Matching opacity
                        child: Image.asset(
                          createImagePath(_items[index]['type']),
                          height: 110.0,
                          width: 110.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _items[index]['model'],
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
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
            backgroundColor: Colors.red, // Red background
            foregroundColor: Colors.white, // White icon
            child: Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              showAddGunDialog(context, _addItem, jwt);
              incrementGunCounter();
            },
            tooltip: 'Add Gun',
            backgroundColor: Colors.red, // Red background
            foregroundColor: Colors.white, // White icon
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
