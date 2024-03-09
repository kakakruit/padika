import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('HOME PAGE'),
      ),
      body: Center(
        child: Text(
          "HOME",
          style: TextStyle(fontSize: 21),
        ),
      ),
    );
  }
}