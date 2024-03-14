import 'package:flutter/material.dart';
import '../screens/news_screen.dart';
import '../screens/SearchPage.dart'; // Assuming the search page file is named search_page.dart and located in the screens directory
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
          top: BorderSide(color: Colors.green.shade700, width: 1.0),
        ),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                _onItemTapped(0, context);
              },
              child: Icon(Icons.search), // Search icon
            ),
            label: 'Search',
            backgroundColor: Color(0xFFacc4ac),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                _onItemTapped(1, context);
              },
              child: Icon(Icons.article), // News icon
            ),
            backgroundColor: Color(0xFFacc4ac),
            label: 'News', // Changed label to News
          ),
        ],
      ),
    );
  }
}
