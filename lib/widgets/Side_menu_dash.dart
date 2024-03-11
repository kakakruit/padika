import 'package:flutter/material.dart';

class SideMenuDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu), // Hamburger menu icon
      onPressed: () {
        Scaffold.of(context).openDrawer(); // Open the drawer when the icon is tapped
      },
    );
  }
}
