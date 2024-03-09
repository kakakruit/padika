import 'package:flutter/material.dart';
import 'package:padika/firebase_options.dart';
import 'package:padika/screens/signIn_screen.dart';
import 'package:padika/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(), // Display SplashScreen initially
    );
  }
}
