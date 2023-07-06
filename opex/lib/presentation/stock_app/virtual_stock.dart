import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/stock_app/product_stock.dart';
import 'package:cluster/presentation/stock_app/stock_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class VirtualStock extends StatefulWidget {
  const VirtualStock({Key? key}) : super(key: key);

  @override
  State<VirtualStock> createState() => _VirtualStockState();
}

class _VirtualStockState extends State<VirtualStock> {
  bool isActive=false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Virtual Stock"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Virtual Stock",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0xff373737),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: w / 1.9,
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          "Variant Name",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: ColorPalette.divider,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Quantity",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1,color: ColorPalette.divider),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight:Radius.circular(8) )
                  ),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>Container(

                        child: Row(
                          children: [
                            Container(
                              width: w / 1.9,
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "Lorem ipsum dolar sit amet this is a dummy file",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 60,
                              color: ColorPalette.divider,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child:Row(
                                children: [
                                  Container(
                                    width: 74,
                                    height: 36,
                                    // alignment: Alignment.center,
                                    //
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(8),
                                    //   border: Border.all(color: Color(0xffccdae3), width: 1, ),
                                    //   color: ,
                                    // ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        fillColor: Color(0xfff9f9f9),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Color(0xffccdae3),width: 1
                                          )
                                        ),
                                          enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Color(0xffccdae3),width: 1
                                          )
                                        ), focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Color(0xffccdae3),width: 1
                                          )
                                        ),
                                        contentPadding: EdgeInsets.only(left: 10)
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  SvgPicture.string(StockSvg().deleteIcon)
                                ],
                              )
                            ),

                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          Container(
                            width: w,
                            height: 1,
                            color: Color(0xffE6ECF0),),
                      itemCount: 5),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ProductStock(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Text(
                    "+ Add Product",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                    width: w ,
                    // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //height: 20.0,
                    padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Is_Active",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              setState((){
                                isActive=!isActive;
                              });
                            },
                            child: SvgPicture.string(isActive?HomeSvg().toggleActive:HomeSvg().toggleInActive)),

                      ],
                    )
                ),
                SizedBox(height: 50,),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: PickAndPack(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
                      // //  PickAndPack
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          ColorPalette.primary,
                          ColorPalette.primary
                        ]),
                    child: Text(
                      "Add Virtual Stock",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
