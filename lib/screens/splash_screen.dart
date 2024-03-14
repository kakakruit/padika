import 'dart:async';
import 'package:flutter/material.dart';
import 'package:padika/screens/signup_screen.dart';
import 'package:padika/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2), // Change the duration as per your requirement
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change the background color if needed
      body: Center(
        child: Container(
          color: Color(0xFFea3c12), // Use hexadecimal color code #960018
          child: Image.asset(
            'assets/images/splash.png', // Path to your custom splash screen image
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
