import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Text(
            productId,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
