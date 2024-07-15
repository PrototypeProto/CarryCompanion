import 'package:flutter/material.dart';
import 'package:gun/main.dart';

void requestPasswordChange(
    String curPass, String newPass1, String newPass2, BuildContext context) {
  bool passwordChanged = false;
  /* TODO: Compare pass with JWT or smnthn
          If true, passwordChanged=true AND update password */

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Password Changed'),
        content: (passwordChanged)
            ? Text('Your password has been successfully changed.')
            : Text('Invalid password. Try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void verifyAccountDeletion(BuildContext context) {
  Future<bool?> deleteAccount = requestAccountDeletion(context);

  /* Fix pop up */
  if (deleteAccount == true) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Successfully Deleted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    MyApp();
  } else {
    /* Do nothing */
    return;
  }
}





Future<bool?> requestAccountDeletion(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete your account?'),
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