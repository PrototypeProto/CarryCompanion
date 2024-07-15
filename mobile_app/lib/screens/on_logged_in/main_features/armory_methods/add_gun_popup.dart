import 'package:flutter/material.dart';

void showAddGunDialog(BuildContext context, Function(Map<String, dynamic>) addItem, int numGuns) {
  String? newType;
  String? newMake;
  String? newModel;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New Gun'),
        content: SizedBox(
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
                addItem({
                  'type': newType!,
                  'make': newMake!,
                  'model': newModel!,
                  'id': ++numGuns, // Use a unique ID
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
