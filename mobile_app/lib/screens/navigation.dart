import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gun/drawer_pages.dart';
import 'home.dart';
import 'map.dart';
import 'armory.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  final screens = [HomePage(), MapPage(), ArmoryPage()];
  final titles = ['Home', 'Map', 'Armory'];
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
          labelTextStyle:
              WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
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

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_sharp),
            // put permits, armory, etc. here
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

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({required this.title, super.key});
  final String title;
 // final double height = 60;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      title: Text(title),
    );
  }
  
  @override
  //Size get preferredSize => Size.fromHeight(height);
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  // this ^^ is default implementation for auto height for app bar
}

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScreenAppBar({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
