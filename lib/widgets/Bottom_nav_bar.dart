import 'package:flutter/material.dart';
import '../screens/product_upload_page.dart';
import '../screens/SearchPage.dart'; // Assuming the search page file is named search_page.dart and located in the screens directory

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
        MaterialPageRoute(builder: (context) => ProductUploadPage()),
      );
    } else if (index == 0) { // Check if the search icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()), // Navigate to the SearchPage
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
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.red),

      ),
    );
  }
}
