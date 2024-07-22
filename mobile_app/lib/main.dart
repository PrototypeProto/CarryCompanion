import 'package:flutter/material.dart';
import 'package:gun/screens/on_app_launch/reset_password.dart';
import 'package:gun/screens/on_app_launch/signup.dart';
import 'package:gun/screens/on_logged_in/main_features/armory_page.dart';
import 'package:gun/screens/on_logged_in/main_features/map_page.dart';
import 'package:gun/screens/on_logged_in/main_features/reciprocity.dart';
import 'package:gun/screens/on_logged_in/nav_components/drawer_components/about_us_page.dart';
import 'package:gun/screens/on_logged_in/nav_components/drawer_components/create_drawer.dart';
import 'package:gun/screens/on_logged_in/nav_components/drawer_components/settings_page.dart';
import 'package:gun/screens/on_logged_in/nav_components/nav_bar_components/create_nav_bar.dart';
import 'screens/on_app_launch/login.dart'; // Import Login page
import 'screens/on_app_launch/landing_page.dart'; // Import the LandingPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MainPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => Login(),
        '/settings': (context) => SettingsScreen(), 
        '/forgotPassword': (context) => ForgotPassword(), 
        '/drawer': (context) => MyDrawer(), 
        '/signup': (context) => SignUp(), 
        '/armory': (context) => Armory(), 
        '/map': (context) => MapPage(), 
        '/reciprocityMap': (context) => ReciprocityPage(), 
        '/aboutUs': (context) => AboutUsScreen(), 
        '/nav': (context) => NavBar(), 
        // '/settings': (context) => SettingsScreen(), 
        // '/settings': (context) => SettingsScreen(), 
        // Add other routes here
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
            children: const [
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
