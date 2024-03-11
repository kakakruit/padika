import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/barcode_scanner.dart';
import '../widgets/image_picker_widget.dart';

class ProductUploadPage extends StatefulWidget {
  @override
  _ProductUploadPageState createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  String productName = '';
  double productRating = 0.0;
  String? barcodeData;
  String? productDetails; // Store the fetched product details
  File? _image;

  // Define a list to hold uploaded products
  List<Product> uploadedProducts = [];

  void onBarcodeScan(String scannedData) {
    setState(() {
      barcodeData = scannedData;
      // Call a method to fetch product details based on the scanned barcode
      fetchProductDetails(scannedData);
    });
  }

  void fetchProductDetails(String barcode) {
    // For demonstration purposes, I'll just simulate fetching product details
    // based on the scanned barcode
    // Replace this with actual logic to fetch product details
    setState(() {
      productDetails = 'Product details for barcode $barcode'; // Mock product details
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '-->Scan Product Barcode:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            BarcodeScanner(onScan: onBarcodeScan),
            SizedBox(height: 20),
            if (barcodeData != null)
              Text(
                'Scanned Barcode: $barcodeData',
                style: TextStyle(fontSize: 18),
              ),

            SizedBox(height: 20),
            // Text "Upload Product Image"
            Text(
              '-->Upload Product Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ImagePickerWidget(
              onImageSelected: (image) {
                setState(() {
                  _image = image;
                });
              },
            ),
            SizedBox(height: 10),
            if (_image != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.file(_image!),
                ),
              ),
            SizedBox(height: 10),
            // Add more steps for description, rating, etc.
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add logic to post the product
                    // For now, add the product to the list and navigate back to the dashboard
                    Product product = Product(
                      name: productName,
                      rating: productRating,
                      barcode: barcodeData,
                      image: _image,
                    );
                    uploadedProducts.add(product);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Red color for post button
                  ),
                  icon: Icon(Icons.post_add),
                  label: Text(
                    'POST',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Close the page
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.red, // Red color for cancel button
                  ),
                  icon: Icon(Icons.cancel),
                  label: Text('CANCEL'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Define a data model for the product
class Product {
  final String name;
  final double rating;
  final String? barcode;
  final File? image;

  Product({
    required this.name,
    required this.rating,
    this.barcode,
    this.image,
  });
}
