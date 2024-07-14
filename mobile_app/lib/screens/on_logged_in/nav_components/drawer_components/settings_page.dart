import 'package:flutter/material.dart';
import 'close_app_bar.dart';

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