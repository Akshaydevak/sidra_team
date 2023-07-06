import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/cart_screen/cart_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_svg.dart';
import 'coupons_card.dart';

class SelfCheckoutHome extends StatefulWidget {
  SelfCheckoutHome({Key? key}) : super(key: key);

  @override
  State<SelfCheckoutHome> createState() => _SelfCheckoutHomeState();
}

class _SelfCheckoutHomeState extends State<SelfCheckoutHome> {
  var _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

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
    String a = barcodeScanRes.replaceAll(RegExp('{'), '');
    String b = a.replaceAll(RegExp('}'), '');
    print(b);
    var parts = b.split(':');
    var prefix = parts[0].trim();
    print(prefix);
    String prefixreplace = prefix.replaceAll(RegExp("'"), '');
    var scanDatacode = parts[1].trim();
    //order id name
    print(prefixreplace);
    //data
    print(scanDatacode);

    if (_scanBarcode != 'Unknown' && _scanBarcode.isNotEmpty) {
      print("scanModel.orderLineId");
      // Navigator.push(context, MaterialPageRoute(builder: (_) => ScanOrder(code:scanDatacode,prefix:prefixreplace)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.checkoutBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 50,
                right: 0,
                width: w,
                height: h,
                child: Container(
                    height: h / 6,
                    width: w / 3,
                    child: Image.asset("asset/bg1.png"))),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hi, Afthab",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SvgPicture.string(
                              TaskSvg().notificationIcon,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SearchCard(),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset("asset/dummy1.png"),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: w,
                          padding: EdgeInsets.all(16),
                          // height: 228,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0f000000),
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                            color: Color(0xfffcfdfc),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Easy Checkout",
                                style: GoogleFonts.inter(
                                  color: Color(0xff1b1b1f),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lorem ipsum dolar sit maet this is a dummy",
                                style: TextStyle(
                                  color: Color(0xff3d3d3d),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      scanQR();
                                    },
                                    child: Container(
                                      width: 139,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffff467a),
                                            Color(0xff9c0e36)
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.string(
                                              SelfSvg().scannerIcon),
                                          SizedBox(height: 10,),
                                          Text(
                                            "Scan a product",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 139,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffff467a),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.string(CartSvg().searchIcon),
                                          SizedBox(height: 10,),
                                          Text(
                                            "Scan a product",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          )
                                    ]),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Coupons",
                          style: GoogleFonts.inter(
                            color: ColorPalette.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ScrollConfiguration(
                    behavior: NoGlow(),
                    child: Container(
                      height: 220,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) => Column(
                          children: [CouponsCard()],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        primary: true,
                        shrinkWrap: true,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
