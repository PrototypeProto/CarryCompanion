import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({required this.title, super.key});
  final String title;

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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset(
            'assets/bear.png', 
            width: 45, 
            height: 45, 
            fit: BoxFit.contain, 
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
