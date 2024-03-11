import 'package:flutter/material.dart';
import '../widgets/Bottom_nav_bar.dart';
import '../widgets/Side_menu_dash.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFea3c12),
        title: Row(
          children: [
            // Add the side menu bar to the app bar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PADIKA !',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Arial',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a drawer to the Scaffold
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFea3c12),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "HOME",
          style: TextStyle(fontSize: 21),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
