import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Colors.lightBlue,
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 60,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.newspaper,
            color: Colors.white,
          ),
          icon: Icon(Icons.newspaper),
          label: 'News',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
    );
  }
}
