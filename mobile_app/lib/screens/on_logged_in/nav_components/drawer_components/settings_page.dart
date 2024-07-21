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
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Current Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                return isValidPasswordMessage(
                    newPasswordController.text, confirmNewPasswordController.text);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: confirmNewPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.always,
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
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Change My Password'),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 200, // Smaller width for the button
                child: ElevatedButton(
                  onPressed: () {
                    requestAccountDeletion(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Delete My Account'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
