import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRCodeScannerScreen(),
    );
  }
}

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => QRCodeScannerScreenState();
}

class QRCodeScannerScreenState extends State<QRCodeScannerScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    super.initState();
  }

  void _onQRViewCreated() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Custom color for scan overlay
      'Cancel',   // Cancel button text
      true,       // Show flash icon
      ScanMode.BARCODE, // Scan mode
    );

    Clipboard.setData(ClipboardData(text: barcode));
    
    if (barcode != '-1') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanned and copied to clipboard: $barcode'),
        ),
      );

      if (await canLaunchUrl(Uri.parse(barcode))) {
        await launchUrl(Uri.parse(barcode));
      } 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _onQRViewCreated,
          child: const Text('Scan Barcode'),
        ),
      ),
    );
  }
}
