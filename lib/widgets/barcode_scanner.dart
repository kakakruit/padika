import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends StatelessWidget {
  final Function(String) onScan;

  const BarcodeScanner({Key? key, required this.onScan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        try {
          String scannedData = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', // red
            'Cancel',
            true,
            ScanMode.BARCODE,
          );
          onScan(scannedData);
        } catch (e) {
          print('Error scanning barcode: $e');
        }
      },
      icon: Icon(Icons.qr_code_scanner),
      iconSize: 70,
    );
  }
}
