import 'package:flutter/material.dart';
import 'ViewMap.dart';
import 'Armory.dart';
import 'page3.dart';
/*
  This is responsible for the 3 buttons at the bottom, but is also technically 
  the main wrapper for all pages.
      So the 3? pages load under this belt.
 */
class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 1; // Default to the middle page aka Armory

  final List<Widget> _pages = [
    ViewMap(),
    Armory(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Armory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings?',
          ),
        ],
      ),
    );
  }
}
