import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:padika/screens/signup_screen.dart';

class Developer {
  final String name;
  final String description;
  final String role;
  final String imagePath;

  Developer({
    required this.name,
    required this.description,
    required this.role,
    required this.imagePath,
  });
}

class DrawerScreen extends StatelessWidget {
  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  final List<Developer> developers = [
    Developer(
      name: 'JASH',
      description: 'Passionate about database and APIs.',
      role: 'Lead Developer',
      imagePath: 'assets/images/jash.jpg',
    ),
    Developer(
      name: 'NIR',
      description: 'Building and implementing UI/UX.',
      role: 'UI Developer',
      imagePath: 'assets/images/nir.jpg',
    ),
    Developer(
      name: 'PARAS',
      description: 'Building predictive model and mapping them.',
      role: 'ML Engineer',
      imagePath: 'assets/images/paras.jpg',
    ),
    Developer(
      name: 'YASH',
      description: 'Creative front-end developer with a strong passion for firebase.',
      role: 'Frontend Developer',
      imagePath: 'assets/images/yash.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFacc4ac),
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
            title: Text(
              'Developers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          for (var developer in developers)
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(developer.imagePath),
              ),
              title: Text(developer.name),
              subtitle: Text(developer.description),
              onTap: () {
                // Do something when the developer is tapped
              },
            ),
          ListTile(
            title: Center(child: Text('Logout')),
            onTap: () {
              logOut;
            },
          ),
        ],
      ),
    );
  }
}
