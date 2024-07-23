
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gun/api/test.dart';
import 'package:gun/main.dart';
import '../../../on_app_launch/validate_input.dart';
import '../../../../api/persist.dart';
import '../../../../api/api.dart';


Future<void> updatePassword(String newPass) async {
  final PreferencesHelper prefsHelper = PreferencesHelper();
  await prefsHelper.storePassword(newPass); // Store password here
  // resetPassword(newPass, await prefsHelper.getJwt());
}

Future<void> requestPasswordChange(
    String realPass, String curPass, String newPass1, String newPass2, BuildContext context) async {
  bool passwordChanged = false;
  String? invalidPasswordMessage;

  /* TODO: Compare pass with JWT or smnthn
          If true, passwordChanged=true AND update password 
          ELSE RETURN invalid password used*/
  if (curPass.compareTo(newPass1) == 0) {
    invalidPasswordMessage = 'Can not use your existing password as the new password';
    log(invalidPasswordMessage);
    passwordChanged = false;
  } else if (newPass1.compareTo(newPass2) != 0) {
    invalidPasswordMessage = 'New passwords do not match';
    log(invalidPasswordMessage);
  } else {
    final PreferencesHelper _prefsHelper = PreferencesHelper();
    String? token = await _prefsHelper.getJwt();
    // token ??= '';

    // ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
    ApiService serv = ApiService(baseUrl: "https://www.thisisforourclass.xyz");

    Map<String, dynamic> auth = await serv.resetPassword({"currentPassword": curPass, "newPassword": newPass1,}, token!);
    auth['success'] ? passwordChanged = true : false;
    auth['success'] ? invalidPasswordMessage = auth['data']['message'] : invalidPasswordMessage = auth['message'];

    log(invalidPasswordMessage!);

    // invalidPasswordMessage = isValidPasswordMessage(newPass1, newPass2);
    // if (newPass2.compareTo(newPass1) == 0) {
    //   if (curPass.compareTo(newPass1) == 0) {
    //     invalidPasswordMessage = 'Can not use your existing password as the new password';
    //   } else {
    //     invalidPasswordMessage == null ? passwordChanged = true : passwordChanged = false;
    //     if (passwordChanged) {
    //       updatePassword(newPass1);
    //     }
    //   }
    // } else {
    //   passwordChanged = false;
    // }
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
  requestAccountDeletion(context);

  // /* Fix pop up */
  // if (deleteAccount == true) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Account Successfully Deleted'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
                
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   MyApp();
  // } else {
  //   /* Do nothing */
  //   return;
  // }
}
Future<void> requestAccountDeletion(BuildContext context) async {
  bool? deleteConfirmed = await showConfirmDeleteDialog(context, 'your account');

  if (deleteConfirmed == true) {
    //TODO put delete account here
    final PreferencesHelper prefsHelper = PreferencesHelper();
    String token = await prefsHelper.getJwt(); 
    requestDeleteAccount(token);
    await showDeletionSuccessDialog(context);
  } else {
    await showDeletionCancelledDialog(context);
  }
}

Future<bool?> showConfirmDeleteDialog(BuildContext context, String itemName) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm Delete',
          style: TextStyle(color: Colors.black), 
        ),
        content: Text(
          'Are you sure you want to delete $itemName?',
          style: TextStyle(color: Colors.black), 
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.black), 
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); 
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.grey[300], 
      );
    },
  );
}

Future<void> showDeletionSuccessDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap the button to dismiss
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Success!',
          style: TextStyle(color: Colors.black), // Title color
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'An email has been sent to confirm account deletion.',
              style: TextStyle(color: Colors.black), // Content text color
            ),
            SizedBox(height: 20), // Add some space between text and button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close this dialog
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color for button
                ),
                child: Text(
                  'Sign me out!',
                  style: TextStyle(color: Colors.white), // Button text color
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[300], // Background color for dialog
      );
    }
  );
}



Future<void> showDeletionCancelledDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Account Not Deleted',
          style: TextStyle(color: Colors.black), // Title color
        ),
        content: Text(
          'Your account has not been deleted.',
          style: TextStyle(color: Colors.black), // Content text color
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close this dialog
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.black), // Button text color
            ),
          ),
        ],
        backgroundColor: Colors.grey[300], // Background color for dialog
      );
    },
  );
}