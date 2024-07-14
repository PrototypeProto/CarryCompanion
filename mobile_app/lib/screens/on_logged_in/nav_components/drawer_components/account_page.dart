import 'package:flutter/material.dart';
import 'close_app_bar.dart';

/* Might Not include/use this page */
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