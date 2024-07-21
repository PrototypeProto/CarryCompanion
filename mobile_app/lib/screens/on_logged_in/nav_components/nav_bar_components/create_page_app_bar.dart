import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;

  const PageAppBar({required this.title, required this.onMenuPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: onMenuPressed,
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
