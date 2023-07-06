import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_screen/bussiness_cart.dart';
import 'cart_screen/cart_svg.dart';
import 'cart_screen/cart_tab.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: ColorPalette.primary, // Status bar
        ),
        backgroundColor: ColorPalette.primary,
        elevation: 0,
        title: Text("Your Cart"),
        actions: [
          SvgPicture.string(CartSvg().searchIcon),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              // padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        labelColor: Colors.black,
                        indicatorColor: ColorPalette.primary,
                        indicatorWeight: 5,
                        unselectedLabelColor: Colors.black,
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        tabs: [
                          Tab(text: "Cart(6 Items)"),
                          const Tab(text: "Business Cart"),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: 5,
              color: Color(0xfff8f7f5),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: IgnorePointer(
                  ignoring: true,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CartTab(),
                        BussinessCart(),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
              );
            },
          );
        });
  }
}
