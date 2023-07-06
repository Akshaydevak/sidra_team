import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/cart_screen/cart_svg.dart';
import '../delivery_address_card.dart';
import '../history_details.dart';

class CartScreenCallCenter extends StatelessWidget {
  const CartScreenCallCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              padding: EdgeInsets.only(top: 5, bottom: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Color(0xffE0E5E8)
                      // )
                    ),
                    // padding: EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: h / 12,
                              width: w / 8,
                              child: Image.network(
                                  "https://pps.whatsapp.net/v/t61.24694-24/172331222_197810955969643_683336666361143397_n.jpg?ccb=11-4&oh=01_AdQGjOEROtOM21xbjSmg78dv0VQv9zdkamAsJEwhWxtLMg&oe=636CD7E7")),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: w / 30,
                                            color: Color(0xff6d6d6d)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                // gapSize6(),
                                Row(
                                  children: [
                                    Text(
                                      "100",
                                      style: GoogleFonts.poppins(
                                          fontSize: w / 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      " AED ",
                                      style: GoogleFonts.poppins(
                                          fontSize: w / 28,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Container(
                                      // color: Colors.yellow,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        border: Border.all(
                                          color: Color(0x4ca9a8a8),
                                          width: 1,
                                        ),
                                        color: Colors.white,
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      // alignment: Alignment.bottomLeft,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 6, 6, 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),

                                                  shape: BoxShape.rectangle,
                                                  // color: Color(0xffF0D518)
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 14,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              "10",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 6, 6, 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 14,
                                                  color: Colors.black,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "In Stock",
                                      style: GoogleFonts.poppins(
                                        color: Color(0xff079b15),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        "Deliver in ",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: w / 26,
                                        ),
                                      ),
                                      Text(
                                        "select",
                                        // widget.cartItem?.frequencyType!=null||widget.cartItem?.frequencyType!=""?widget.cartItem?.frequencyType??"select":"select",
                                        style: GoogleFonts.poppins(
                                          color: ColorPalette.primary,
                                          fontSize: w / 26,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Seller :",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: w / 26,
                                      ),
                                    ),
                                    Text(
                                      "Rawabi Market",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: w / 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Expected Delivery in: ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: w / 26,
                                      ),
                                    ),
                                    Text(
                                      " widget.deliverytime",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: w / 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(CartSvg().timerIcon),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "30 mins | 6 Km",
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: w / 27,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                                // onTap: onTapListTile(i, context),
                                child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0x33ff9900),
                                  width: 0.50,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child: Text(
                                "name",
                                style: GoogleFonts.poppins(
                                    fontSize: w / 30,
                                    fontWeight: FontWeight.w500),
                              ),
                            ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 5,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ]));
              },
              separatorBuilder: (context, i) => Container(
                width: w,
                height: 6,
                color: Color(0xfff8f7f5),
              ),
              itemCount: 5,
            ),
            Container(
              width: w,
              height: 6,
              color: Color(0xfff8f7f5),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Summary",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "No. Of Items",
                      style: TextStyle(
                        color: Color(0xff676767),
                        fontSize: 18,
                      ),
                    ),
                      Row(
                        children: [
                          Text(
                            "925.25",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "AED ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                  ],),SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Total Discount",
                      style: TextStyle(
                        color: Color(0xff676767),
                        fontSize: 18,
                      ),
                    ),
                      Row(
                        children: [
                          Text(
                            "1025.25",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "AED ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                  ],),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Vatable Amt",
                      style: TextStyle(
                        color: Color(0xff676767),
                        fontSize: 18,
                      ),
                    ),
                      Row(
                        children: [
                          Text(
                            "1025.25",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "AED ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                  ],), SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Actual Cost",
                      style: TextStyle(
                        color: Color(0xff676767),
                        fontSize: 18,
                      ),
                    ),
                      Row(
                        children: [
                          Text(
                            "1025.25",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "AED ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                  ],),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: const AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: const AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Hold this Order",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),GradientButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen:  HistoryDetailsScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            ),
           Container(
             width: w,
             padding: EdgeInsets.all(16),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   "Offers",
                   style: GoogleFonts.roboto(
                     color: Color(0xff151522),
                     fontSize: 18,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
                 SizedBox(height: 10,),
                 
               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
