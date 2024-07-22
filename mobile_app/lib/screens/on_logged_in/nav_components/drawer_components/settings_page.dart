import 'dart:developer';
import 'package:flutter/material.dart';
import 'close_app_bar.dart';
import 'settings_page_functions.dart';
import '../../../on_app_launch/validate_input.dart';
import '../../../../api/persist.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadPersistentData();
  }

  Future<void> _loadPersistentData() async {
    final PreferencesHelper prefsHelper = PreferencesHelper();
    final password = await prefsHelper.retrievePassword();
    setState(() {
      _password = password ?? '';
    });
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: ScreenAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: currentPasswordController,
              decoration: _inputDecoration('Current Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: newPasswordController,
              decoration: _inputDecoration('New Password'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return isValidPasswordMessage(
                    newPasswordController.text, confirmNewPasswordController.text);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: confirmNewPasswordController,
              decoration: _inputDecoration('Confirm New Password'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return isValidPasswordMessage(
                    confirmNewPasswordController.text, newPasswordController.text);
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  requestPasswordChange(
                    _password,
                    currentPasswordController.text,
                    newPasswordController.text,
                    confirmNewPasswordController.text,
                    context,
                  );
                  _loadPersistentData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Change My Password'),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextButton(
                onPressed: () {
                  requestAccountDeletion(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: Text('Delete My Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}