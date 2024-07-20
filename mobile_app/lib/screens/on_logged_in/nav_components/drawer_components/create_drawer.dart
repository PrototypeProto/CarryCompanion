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
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadPersistentData();
  }

  Future<void> _loadPersistentData() async {
    final PreferencesHelper prefsHelper = PreferencesHelper();
    final username = await prefsHelper.retrieveUsername();
    final email = await prefsHelper.retrieveEmail();
    setState(() {
      _username = username ?? '';
      _email = email ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_username),
            accountEmail: Text(_email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            /* TODO: Implement Logout feature correctly, including removing relevant auth tokens */
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_sharp),
            title: const Text('My Account'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.public),
            title: const Text('About Us'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
