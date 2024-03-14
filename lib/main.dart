import 'package:flutter/material.dart';
import 'package:padika/firebase_options.dart';
import 'package:padika/screens/dashboard.dart';
import 'package:padika/screens/news_screen.dart';
import 'package:padika/screens/signup_screen.dart';
import 'package:padika/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padika',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Display SplashScreen initially
    );
  }
}
