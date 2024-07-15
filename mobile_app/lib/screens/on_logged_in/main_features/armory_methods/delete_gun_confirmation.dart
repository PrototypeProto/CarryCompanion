import 'package:flutter/material.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context, String itemName) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete $itemName?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false on no
            },
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true on yes
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
