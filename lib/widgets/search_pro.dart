import 'package:flutter/material.dart';

class SearchPro extends StatefulWidget {
  @override
  _SearchProState createState() => _SearchProState();
}

class _SearchProState extends State<SearchPro> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 100), // Adjust the top margin
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Rounded corners
          border: Border.all(
            color: _isFocused ? Colors.blue : Colors.grey[400]!, // Border color
            width: 2.0, // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Container(
          height: 40,
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for products...',
              hintStyle: TextStyle(color: Colors.grey[400]), // Hint text color
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[400], // Icon color
              ),
              border: InputBorder.none, // Remove border
              contentPadding: EdgeInsets.zero, // Remove default padding
            ),
            onChanged: (value) {
              // Implement search functionality here
            },
            onTap: () {
              setState(() {
                _isFocused = true;
              });
            },
            onSubmitted: (value) {
              setState(() {
                _isFocused = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                _isFocused = false;
              });
            },
          ),
        ),
      ),
    );
  }
}
