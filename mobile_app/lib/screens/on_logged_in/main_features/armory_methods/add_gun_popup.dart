import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gun/api/api.dart';
import 'package:gun/api/persist.dart';

Future<void> addGun(String newType, String newMake, String newModel, Function(Map<String, dynamic>) addItem, String jwt) async {
  log(jwt);
  // ApiService serv = ApiService(
  //   baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com",
  // );
  ApiService serv = ApiService(baseUrl: "https://www.thisisforourclass.xyz");

  final PreferencesHelper prefsHelper = PreferencesHelper();
  String token = await prefsHelper.getJwt();

  Map<String, dynamic> gun = await serv.addWeapon({
    "type": newType,
    "datePurchased": "111", // TODO: Replace with actual date purchased
    "manufacturer": newMake,
    "model": newModel
  }, jwt);

  if (gun["success"]) {
    await prefsHelper.addWeapon(gun["data"]["weapon"]);
    log("added gun\n");
    addItem(gun['data']['weapon'] as Map<String, dynamic>);
  } else {
    log(gun['message']);
    log(token);
    log("FAILED\n");
  }
}

void showAddGunDialog(BuildContext context, Function(Map<String, dynamic>) addItem, String token) {
  String? newType;
  String? newMake;
  String? newModel;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Add New Gun',
          style: TextStyle(color: Colors.black), // Title text color
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Type',
                  labelStyle: TextStyle(color: Colors.black), // Label text color
                  filled: true,
                  fillColor: Colors.white, // Background color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Focus color
                  ),
                ),
                value: newType,
                items: ['Handgun', 'Rifle', 'Shotgun'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  newType = value;
                },
              ),
              SizedBox(height: 10), // Add spacing between fields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Manufacturer',
                  labelStyle: TextStyle(color: Colors.black), // Label text color
                  filled: true,
                  fillColor: Colors.white, // Background color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Focus color
                  ),
                ),
                onChanged: (value) {
                  newMake = value;
                },
              ),
              SizedBox(height: 10), // Add spacing between fields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Model',
                  labelStyle: TextStyle(color: Colors.black), // Label text color
                  filled: true,
                  fillColor: Colors.white, // Background color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Focus color
                  ),
                ),
                onChanged: (value) {
                  newModel = value;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (newType != null && newMake != null && newModel != null) {
                    await addGun(newType as String, newMake as String, newModel as String, addItem, token);
                    Navigator.of(context).pop();
                  }
                  /* TODO: maybe display saying fill in the fields */
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.grey[300], // Background color for dialog
      );
    },
  );
}
