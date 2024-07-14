import 'package:flutter/material.dart';

/* responsible for opening drawer / creates button to open drawer*/
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
