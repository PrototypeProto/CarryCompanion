import 'package:flutter/material.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context, String itemName) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm Delete',
          style: TextStyle(color: Colors.black), // Title color
        ),
        content: Text(
          'Are you sure you want to delete $itemName?',
          style: TextStyle(color: Colors.black), // Content text color
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false on No
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true on Yes
                },
                child: Text(
                  'Yes',
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
