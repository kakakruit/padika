import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padika/services/product.dart';

class HeroCard extends StatefulWidget {
  HeroCard({
    Key? key,
    required this.productId,
    required this.productName,
  }) : super(key: key);

  final String productId;
  final String productName; // Add product name parameter
  // Add product name parameter

  @override
  _HeroCardState createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
  final TextEditingController _commentController = TextEditingController();
  List<String> _comments = [];
  bool _showComments = false;
  List<Map<String, dynamic>> _ingredients = [];
  late List<Product> product;

  Future<List<Map<String, dynamic>>> fetchIngredients() async {
    final response = await http.get(Uri.parse(
        'http://172.17.25.66:3000/api/search/ingredients_list/${widget.productId}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      // Map each item in the list to a Map<String, dynamic>
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }

  Future<List<Product>> fetchBarcode(String barcode) async {
    try {
      print("inside try");
      final response = await http.get(
          Uri.parse('http://172.17.25.66:3000/api/search/barcode/$barcode'));
      print('Scanned data response: $response');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        print('Scanned data data: $data');
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        // Handle API errors (e.g., non-200 status code)
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle connection timeout or other exceptions
      throw Exception('Failed to load products: $error');
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchBarcode(widget.productId).then((products) {
      setState(() {
        product = products;
      });
    }).catchError((error) {
      print('Error fetching product: $error');
    });
    // Fetch ingredients when the widget initializes
    fetchIngredients().then((ingredients) {
      setState(() {
        _ingredients = ingredients;
      });
    }).catchError((error) {
      print('Error fetching ingredients: $error');
    });
    Firebase.initializeApp().then((value) {
      _fetchComments();
    });
  }

  void _postComment(String comment) {
    if (comment.isNotEmpty) {
      _firestore.collection('comments').add({
        'commentText': comment,
        'productId': widget.productId,
        // Optionally add timestamps or user information
      }).then((value) {
        setState(() {
          _comments.insert(0, comment);
          _commentController.clear();
        });
      });
    }
  }

  void _fetchComments() {
    _firestore
        .collection('comments')
        .where('productId', isEqualTo: widget.productId)
        .orderBy('timestamp',
            descending: true) // Assuming a timestamp field for ordering
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _comments = snapshot.docs
            .map((doc) => doc.get('commentText') as String)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontSize: 20),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF0D7207),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context)
                  .padding
                  .top, // Add padding to accommodate the AppBar
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF0D7207),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      widget.productId.length >= 2
                          ? widget.productId.substring(0, 2)
                          : 'NV',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D7207),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.productName!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Ingredients',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Ingredients List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = _ingredients[index];
                return ListTile(
                  title: Text(ingredient['ingredient_name'] ?? 'Unknown'),
                  subtitle: Text(ingredient['description'] ?? 'No description'),
                  // You can add more information about the ingredient here
                );
              },
            ),
            SizedBox(height: 20),
            // Comment Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _postComment(_commentController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0D7207), // Button color
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Post', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            // Comments Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showComments = !_showComments;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0D7207), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  _showComments ? 'Hide Comments' : 'Show Comments',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            // Comments Section
            if (_showComments) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(_comments[index]),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
