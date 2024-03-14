import 'package:flutter/material.dart';
import '../screens/news_screen.dart';
import '../screens/SearchPage_ing.dart'; // Assuming the search page file is named search_page.dart and located in the screens directory
import '../screens/news_screen.dart'; // Assuming the news page file is named news_screen.dart and located in the screens directory

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    } else if (index == 0) { // Check if the search icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()), // Navigate to the SearchPage
      );
    } else if (index == 2) { // Check if the news icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()), // Navigate to the NewsPage
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article), // Changed icon to News icon
            label: 'News', // Changed label to News
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.red),

      ),
    );
  }
}
