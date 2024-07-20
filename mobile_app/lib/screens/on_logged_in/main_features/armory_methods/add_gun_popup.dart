import 'package:flutter/material.dart';

void showAddGunDialog(BuildContext context, Function(Map<String, dynamic>) addItem, int numGuns) {
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
              SizedBox(height: 10), // Add spacing between fields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Make',
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
                onPressed: () {
                  if (newType != null && newMake != null && newModel != null) {
                    addItem({
                      'type': newType!,
                      'make': newMake!,
                      'model': newModel!,
                      'id': ++numGuns, // Use a unique ID
                    });
                  }
                  Navigator.of(context).pop();
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
