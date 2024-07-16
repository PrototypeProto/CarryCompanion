import 'package:flutter/material.dart';
import 'close_app_bar.dart';
import 'settings_page_functions.dart';
import '../../../on_app_launch/validate_input.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: ScreenAppBar(title: 'Settings'),
      body: Form(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 0, 20),
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 50.0, top: 70.0, right: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: currentPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      filled: true,
                      fillColor: Colors.white60,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      filled: true,
                      fillColor: Colors.white60,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      return isValidPasswordMessage(newPasswordController.text,
                          confirmNewPasswordController.text);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmNewPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      filled: true,
                      fillColor: Colors.white60,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      return isValidPasswordMessage(
                          confirmNewPasswordController.text,
                          newPasswordController.text);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      requestPasswordChange(
                        currentPasswordController.text,
                        newPasswordController.text,
                        confirmNewPasswordController.text,
                        context,
                      );
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('DELETE MY ACCOUNT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
