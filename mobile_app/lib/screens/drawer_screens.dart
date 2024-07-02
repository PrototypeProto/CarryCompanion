import 'package:flutter/material.dart';
import 'navigation.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(title: 'Settings'),
      body: SafeArea(child:Center(child: Text('Settings'))),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(title: 'Account'),
      body: SafeArea(child:Center(child: Text('Account'))),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(title: 'About Us'),
      body: SafeArea(child:Center(child: Text('About Us'))),
    );
  }
}
