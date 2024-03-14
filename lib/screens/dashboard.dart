import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padika/screens/drawer_screen.dart';
import 'package:padika/screens/signup_screen.dart';
import '../widgets/Bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  bool isSearchFocused = false;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInScreen()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFacc4ac),
        title: Row(
          children: [
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
        actions: [ // Add this actions property
          IconButton(
            onPressed: logOut, // Call logOut function when the button is pressed
            icon: Icon(Icons.logout), // Use the logout icon
          ),
        ],
      ),
      drawer: DrawerScreen(), // Use DrawerScreen widget here
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0), // Add padding from the top
            child: Center(
              child: Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Product Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: Color(0xFFacc4ac),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
