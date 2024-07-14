import 'package:flutter/material.dart';
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
  final screens = [ MapPage(), Armory()];
  final titles = ['Map', 'Armory'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: titles[index]),
      drawer: MyDrawer(),
      body: SafeArea(child: screens[index]),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.red,
          backgroundColor: Colors.black,
          labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: index,
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
