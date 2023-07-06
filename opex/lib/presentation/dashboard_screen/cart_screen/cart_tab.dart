import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/prize_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../infinity_screen/list_product.dart';
import 'cart_svg.dart';

class CartTab extends StatefulWidget {
  final Function(bool)? onChange;
  const CartTab({Key? key, this.onChange}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h/9,),
            SvgPicture.string(CartSvg().cartEmptyIcon)
            // ListView.separated(
            //   padding: EdgeInsets.only(top: 5, bottom: 0),
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, i) {
            //     return Container(
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(4),
            //           // border: Border.all(color: Color(0xffE0E5E8)
            //           // )
            //         ),
            //         // padding: EdgeInsets.all(10),
            //         child: Column(children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                   height: h / 12,
            //                   width: w / 8,
            //                   child: Image.network(
            //                       "https://pps.whatsapp.net/v/t61.24694-24/172331222_197810955969643_683336666361143397_n.jpg?ccb=11-4&oh=01_AdQGjOEROtOM21xbjSmg78dv0VQv9zdkamAsJEwhWxtLMg&oe=636CD7E7")),
            //               Container(
            //                 padding: EdgeInsets.only(top: 5),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         SizedBox(
            //                           width:
            //                               MediaQuery.of(context).size.width / 1.6,
            //                           child: Text(
            //                             "Name",
            //                             style: TextStyle(
            //                                 fontSize: w / 30,
            //                                 color: Color(0xff6d6d6d)),
            //                             maxLines: 2,
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ),
            //                         IconButton(
            //                             onPressed: () {}, icon: Icon(Icons.close))
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //
            //                     // gapSize6(),
            //                     Row(
            //                       children: [
            //                         Text(
            //                           "100",
            //                           style: GoogleFonts.poppins(
            //                               fontSize: w / 22,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w600),
            //                         ),
            //                         Text(
            //                           " AED ",
            //                           style: GoogleFonts.poppins(
            //                               fontSize: w / 28,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w600),
            //                         ),
            //                         SizedBox(
            //                           width: 10,
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //
            //                     Row(
            //                       children: [
            //                         Container(
            //                           // color: Colors.yellow,
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(17),
            //                             border: Border.all(
            //                               color: Color(0x4ca9a8a8),
            //                               width: 1,
            //                             ),
            //                             color: Colors.white,
            //                           ),
            //                           padding:
            //                               EdgeInsets.only(left: 10, right: 10),
            //                           // alignment: Alignment.bottomLeft,
            //                           child: Row(
            //                             // mainAxisAlignment: MainAxisAlignment.center,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               InkWell(
            //                                 onTap: () {},
            //                                 child: Container(
            //                                     padding: EdgeInsets.fromLTRB(
            //                                         6, 6, 6, 6),
            //                                     decoration: BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(3),
            //
            //                                       shape: BoxShape.rectangle,
            //                                       // color: Color(0xffF0D518)
            //                                     ),
            //                                     child: Icon(
            //                                       Icons.remove,
            //                                       size: 14,
            //                                       color: Colors.black,
            //                                     )),
            //                               ),
            //                               Container(
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 18, vertical: 5),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(5),
            //                                 ),
            //                                 child: Text(
            //                                   "10",
            //                                   style: TextStyle(
            //                                       fontSize: 16,
            //                                       color: Colors.black),
            //                                 ),
            //                               ),
            //                               InkWell(
            //                                 onTap: () {},
            //                                 child: Container(
            //                                     padding: EdgeInsets.fromLTRB(
            //                                         6, 6, 6, 6),
            //                                     decoration: BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(3),
            //                                       shape: BoxShape.rectangle,
            //                                     ),
            //                                     child: Icon(
            //                                       Icons.add,
            //                                       size: 14,
            //                                       color: Colors.black,
            //                                     )),
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 5,
            //                         ),
            //                         Text(
            //                           "In Stock",
            //                           style: GoogleFonts.poppins(
            //                             color: Color(0xff079b15),
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w500,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //
            //                     GestureDetector(
            //                       onTap: () {},
            //                       child: Row(
            //                         children: [
            //                           Text(
            //                             "Deliver in ",
            //                             style: GoogleFonts.poppins(
            //                               color: Colors.black,
            //                               fontSize: w / 26,
            //                             ),
            //                           ),
            //                           Text(
            //                             "select",
            //                             // widget.cartItem?.frequencyType!=null||widget.cartItem?.frequencyType!=""?widget.cartItem?.frequencyType??"select":"select",
            //                             style: GoogleFonts.poppins(
            //                               color: ColorPalette.primary,
            //                               fontSize: w / 26,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text(
            //                           "Seller :",
            //                           style: GoogleFonts.poppins(
            //                             color: Colors.black,
            //                             fontSize: w / 26,
            //                           ),
            //                         ),
            //                         Text(
            //                           "Rawabi Market",
            //                           style: GoogleFonts.poppins(
            //                             color: Colors.black,
            //                             fontSize: w / 26,
            //                             fontWeight: FontWeight.w600,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text(
            //                           "Expected Delivery in: ",
            //                           style: GoogleFonts.poppins(
            //                             color: Colors.black,
            //                             fontSize: w / 26,
            //                           ),
            //                         ),
            //                         Text(
            //                           " widget.deliverytime",
            //                           style: GoogleFonts.poppins(
            //                             color: Colors.black,
            //                             fontSize: w / 26,
            //                             fontWeight: FontWeight.w600,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.only(bottom: 10),
            //                       child: Row(
            //                         children: [
            //                           SvgPicture.string(CartSvg().timerIcon),
            //                           SizedBox(
            //                             width: 10,
            //                           ),
            //                           Text(
            //                             "30 mins | 6 Km",
            //                             style: GoogleFonts.poppins(
            //                               color: Colors.grey,
            //                               fontSize: w / 27,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 40,
            //             child: ListView.separated(
            //               scrollDirection: Axis.horizontal,
            //               padding: EdgeInsets.only(right: 10, left: 10),
            //               physics: ScrollPhysics(),
            //               shrinkWrap: true,
            //               itemCount: 5,
            //               itemBuilder: (BuildContext context, int i) {
            //                 return GestureDetector(
            //                     // onTap: onTapListTile(i, context),
            //                     child: Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(10),
            //                     border: Border.all(
            //                       color: Color(0x33ff9900),
            //                       width: 0.50,
            //                     ),
            //                     boxShadow: const [
            //                       BoxShadow(
            //                         color: Color(0x26000000),
            //                         blurRadius: 1,
            //                         offset: Offset(0, 0),
            //                       ),
            //                     ],
            //                     color: Colors.white,
            //                   ),
            //                   padding: EdgeInsets.all(5),
            //                   alignment: Alignment.center,
            //                   child: Text(
            //                     "name",
            //                     style: GoogleFonts.poppins(
            //                         fontSize: w / 30,
            //                         fontWeight: FontWeight.w500),
            //                   ),
            //                 ));
            //               },
            //               separatorBuilder: (BuildContext context, int index) {
            //                 return SizedBox(
            //                   width: 5,
            //                 );
            //               },
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           )
            //         ]));
            //   },
            //   separatorBuilder: (context, i) => Container(
            //     width: w,
            //     height: 6,
            //     color: Color(0xfff8f7f5),
            //   ),
            //   itemCount: 5,
            // ),
            // Container(
            //   width: w,
            //   height: 6,
            //   color: Color(0xfff8f7f5),
            // ),
            // Container(
            //   width: w,
            //   color: Colors.white,
            //   child: Container(
            //     width: w,
            //     margin: EdgeInsets.only(top: 10, bottom: 10),
            //     color: Color(0xfff8f7f5),
            //     padding: EdgeInsets.all(10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Get 15% off",
            //               style: GoogleFonts.roboto(
            //                 color: Colors.black,
            //                 fontSize: w / 22,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Text(
            //               "Save more on every order with coupons",
            //               style: TextStyle(
            //                 color: Color(0xff3c3b3b),
            //                 fontSize: w / 26,
            //               ),
            //             ),
            //             Row(
            //               children: [
            //                 Text(
            //                   "ADD YOUR FIRST COUPON",
            //                   style: GoogleFonts.roboto(
            //                     color: Color(0xff1b1b1f),
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 // SvgPicture.string(
            //                 //     ProductSvg().arrowIcon)
            //               ],
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const PrizeCard(),
            // Container(
            //   width: w,
            //   padding: EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 35),
            //   color: Color(0xfffff6f7),
            //   child: const Text(
            //     "Get free shipping on order above AED100. For more information",
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16),
            //   child: const Text(
            //     "You save AED 25.25 with this offer",
            //     style: TextStyle(
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            // Container(
            //     padding: EdgeInsets.all(10),
            //     child: GradientButton(
            //         color: ColorPalette.primary,
            //         onPressed: () {
            //           widget.onChange!(true);
            //
            //         },
            //         gradient: const LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [
            //               ColorPalette.primary,
            //               ColorPalette.primary
            //             ]),
            //         child: Text(
            //           "Add to Cart",
            //           textAlign: TextAlign.center,
            //           style: GoogleFonts.roboto(
            //             color: Colors.white,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ))),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "By and large, credit cards are easily the most secure & safe payment method to use when you shop online.",
            //         style: TextStyle(
            //           fontFamily: "Roboto",
            //           fontWeight: FontWeight.w700,
            //           color: Color(0xff676767)
            //         ),
            //       ),
            //       SizedBox(height: 16,),
            //       Text(
            //         "We can accept :",
            //         style: TextStyle(
            //           fontFamily: "Roboto",
            //
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       SizedBox(height: 10,),
            //       Row(
            //         children: [
            //           Container(
            //             width: 60,
            //             height: 33.19,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(8),
            //               color: Color(0xfff8f7f5),
            //             ),
            //           ),
            //           SizedBox(width: 5,),  Container(
            //             width: 60,
            //             height: 33.19,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(8),
            //               color: Color(0xfff8f7f5),
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   color: Color(0xfff8f8f8),
            //   padding: EdgeInsets.only(top: 16),
            //   child:  Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.only(left: 10,bottom: 10),
            //         child: Text(
            //           "More Samsung Products",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 18,
            //           ),
            //         ),
            //       ),
            //
            //       SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //               children: List<Widget>.generate(3, (index) {
            //                 return Container(
            //                     margin: const EdgeInsets.only(left: 10,bottom: 10),
            //                     child: const ListProductCard(
            //                       // product: state.categoryList.product![index],
            //                     ));
            //               }))),
            //     ],
            //   ),
            // ),
            //
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
