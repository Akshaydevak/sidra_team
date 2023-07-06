import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class ScannerScreen extends StatefulWidget {
   ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  var _scanBarcode = 'Unknown';

  // @override
  Future<void> scanQR() async {
    dynamic barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    print(mounted);
    //if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;

    });
    print("replace");
    String a =barcodeScanRes.replaceAll(RegExp('{'), '');
    String b =a.replaceAll(RegExp('}'), '');
    print(b);
    var parts = b.split(':');
    var prefix = parts[0].trim();
    print(prefix);
    String prefixreplace =prefix.replaceAll(RegExp("'"), '');
    var scanDatacode = parts[1].trim();
    //order id name
    print(prefixreplace);
    //data
    print(scanDatacode);


    if(_scanBarcode!='Unknown'&&_scanBarcode.isNotEmpty){
      print("scanModel.orderLineId");
      // Navigator.push(context, MaterialPageRoute(builder: (_) => ScanOrder(code:scanDatacode,prefix:prefixreplace)));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
