import 'package:flutter/material.dart';
import 'package:gun/main.dart';
import 'about_us_page.dart';
import 'account_page.dart';
import 'settings_page.dart';
import '../../../../api/persist.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String _cust_name = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadPersistentData();
  }

  Future<void> _loadPersistentData() async {
    final PreferencesHelper prefsHelper = PreferencesHelper();
    final cust_name = await prefsHelper.retrieveName();
    final email = await prefsHelper.retrieveEmail();
    setState(() {
      _cust_name = cust_name ?? '';
      _email = email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[300], // Set drawer background color
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                _cust_name,
                style: TextStyle(color: Colors.white), // Text color
              ),
              accountEmail: Text(
                _email,
                style: TextStyle(color: Colors.white), // Text color
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black), // Icon color
              ),
              decoration: BoxDecoration(
                color: Colors.black, // Drawer header background color
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: const Text('Logout', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.black),
                    title: const Text('Settings', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_sharp, color: Colors.black),
                    title: const Text('My Account', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AccountScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.public, color: Colors.black),
                    title: const Text('About Us', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}