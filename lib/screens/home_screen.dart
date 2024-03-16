import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padika/screens/drawer_screen.dart';
import 'package:padika/screens/hero_card.dart';
import 'package:padika/screens/news_screen.dart';
import 'package:padika/screens/signup_screen.dart';
import 'package:padika/services/product.dart';
import 'dart:convert';
import 'package:padika/widgets/barcode_scanner.dart';

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

  navigateToProductDetails(String productId, List product, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HeroCard(
          productId: productId,
          productName: product[index]
              .productName, // Access product name from product list
        ),
      ),
    );
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.17.25.66:3000/api/search/products/$searchText'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
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

  void handleScan(String scannedData) async {
    print('Scanned data: $scannedData');
    final products =
        await fetchBarcode(scannedData); // Call fetchBarcode with scanned data

    if (products.isNotEmpty) {
      setState(() {
        jsonData = products;
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
                onTap: () => {
                  navigateToProductDetails(
                      product.productId.toString(), jsonData, index),
                },
                // Add other product details as needed (e.g., barcode)
              );
            },
          ),
        ); // Update jsonData with fetched products
      });
    } else {
      // Handle case where no product is found for the barcode
      print("No product found for barcode: $scannedData");
    }

    // You can handle the scanned data here (e.g., search for a product, etc.)
    // For now, let's just print it.
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
                fetchProducts().then((products) {
                  setState(() {
                    jsonData = products;
                  });
                }).catchError((error) {
                  print(error);
                });
              },
              decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  suffixIcon: BarcodeScanner(
                    onScan: handleScan,
                  )),
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
                  onTap: () => {
                    navigateToProductDetails(
                        product.productId.toString(), jsonData, index),
                  },
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
