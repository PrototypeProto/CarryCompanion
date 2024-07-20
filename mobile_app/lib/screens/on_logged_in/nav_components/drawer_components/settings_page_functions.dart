import 'package:flutter/material.dart';
import 'package:gun/main.dart';
import '../../../on_app_launch/validate_input.dart';
import '../../../../api/persist.dart';

Future<void> updatePassword(String newPass) async {
  final PreferencesHelper prefsHelper = PreferencesHelper();
  await prefsHelper.storePassword(newPass); // Store password here

}

void requestPasswordChange(
    String realPass, String curPass, String newPass1, String newPass2, BuildContext context) {
  bool passwordChanged = false;
  String? invalidPasswordMessage;

  /* TODO: Compare pass with JWT or smnthn
          If true, passwordChanged=true AND update password 
          ELSE RETURN invalid password used*/
  if (realPass.compareTo(curPass) != 0) {
    invalidPasswordMessage = 'incorrect user credentials';
  } else {
    invalidPasswordMessage = isValidPasswordMessage(newPass1, newPass2);
    if (newPass2.compareTo(newPass1) == 0) {
      if (curPass.compareTo(newPass1) == 0) {
        invalidPasswordMessage = 'Can not use your existing password as the new password';
      } else {
        invalidPasswordMessage == null ? passwordChanged = true : passwordChanged = false;
        if (passwordChanged) {
          updatePassword(newPass1);
        }
      }
    } else {
      passwordChanged = false;
    }
  }


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text((passwordChanged) ? 'Successfully Changed Password' : 'Failed to Change Password'),
        content: (passwordChanged)
            ? Text('Your password has been successfully changed.')
            : Text((invalidPasswordMessage == null) ? 'error' : invalidPasswordMessage),
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