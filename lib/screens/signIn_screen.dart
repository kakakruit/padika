import 'package:flutter/material.dart';
import 'package:padika/main.dart';
import 'package:padika/screens/dashboard.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFea3c12),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'AUTHENTICATE',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFea3c12)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (username == 'nir' && password == '123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid credentials'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              
              child: Text("Next"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFFea3c12),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
