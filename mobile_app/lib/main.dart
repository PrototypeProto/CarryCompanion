import 'package:flutter/material.dart';
import 'screens/on_app_launch/login.dart'; // Import Login page
import 'screens/on_app_launch/landing_page.dart'; // Import the LandingPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              LandingPage(),
              Login(),
            ],
          ),
          if (_currentIndex > 0)
            Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height / 2 - 40,
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Container(
                  width: 40,
                  height: 80,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          if (_currentIndex < 1)
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 2 - 40,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Container(
                  width: 40,
                  height: 80,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
