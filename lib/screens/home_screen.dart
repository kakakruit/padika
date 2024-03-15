import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padika/screens/drawer_screen.dart';
import 'package:padika/screens/signup_screen.dart';
import 'package:padika/services/product.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  bool isSearchFocused = false;
  List<Product> jsonData = [];
  String searchText = '';

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('http://172.17.25.66:3000/api/search/products/o'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      // Handle API error
      throw Exception('Failed to load products');
    }
  }

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch products on initial load
    fetchProducts().then((data) => setState(() => jsonData = data));
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
        actions: [
          IconButton(
            onPressed: logOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchText.isEmpty
                  ? jsonData.length
                  : jsonData
                      .where((product) => product.productName!
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList()
                      .length,
              itemBuilder: (context, index) {
                final product = searchText.isEmpty
                    ? jsonData[index]
                    : jsonData
                        .where((product) => product.productName!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))
                        .toList()[index];
                return ListTile(
                  title: Text(product.productName!),
                  // Add other product details as needed (e.g., barcode)
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
