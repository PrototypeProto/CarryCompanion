import 'package:flutter/material.dart';
import 'close_app_bar.dart';
import 'settings_page_functions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: ScreenAppBar(title: 'Settings'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30 , 0, 20),
            child: Text(
              'Change Password',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Change the color here
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 65.0, right: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: currentPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Current Password',
                      filled: true,
                      fillColor: Colors.white60),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      filled: true,
                      fillColor: Colors.white60),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmNewPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      filled: true,
                      fillColor: Colors.white60),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    requestPasswordChange(currentPasswordController.text, newPasswordController.text, confirmNewPasswordController.text, context);
                    },
                  child: Text('Change My Password'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  requestAccountDeletion(context);
                } ,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('DELETE MY ACCOUNT'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
