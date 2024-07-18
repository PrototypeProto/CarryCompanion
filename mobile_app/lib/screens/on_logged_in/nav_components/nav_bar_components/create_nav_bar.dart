import 'package:flutter/material.dart';
import 'package:gun/screens/on_logged_in/main_features/reciprocity.dart';
import '../../main_features/map_page.dart';
import '../../main_features/armory_page.dart';
import 'create_page_app_bar.dart';
import '../drawer_components/create_drawer.dart';

/* responsible for creating the "main" page upon logging in / \
    Includes the navBar and buttons for opening drawers*/
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [MapPage(), Armory(), ReciprocityPage()];
  final titles = ['Concealed Carry Map', 'Armory', 'Reciprocity Map'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: titles[index]),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          // This is where your dynamic content goes
          SafeArea(child: screens[index]),

          // Static button above the bottom navigation bar
          Positioned(
            bottom: 5.0, // Adjust this value as needed to position the button
            left: 0,
            right: 0,
            child: Visibility(
              visible: index != 1, // Hide button when index is 1
              child: Center(
                child: TextButton(
                  onPressed: () => setState(() => index = (index == 2 ? 0 : 2)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red, // Button color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 26.0),
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(index == 2 ?  'Show Concealed Carry' : 'Show Reciprocity'  ), // Change text based on index
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.red,
          backgroundColor: Colors.black,
          labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: index == 2 ? 0 : index, // Reset to index 0 if index is 2
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.map_outlined,
                color: Colors.white,
              ),
              selectedIcon: Icon(Icons.map, color: Colors.white),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.cases_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.cases_rounded, color: Colors.white),
              label: 'Armory',
            ),
          ],
        ),
      ),
    );
  }
}
