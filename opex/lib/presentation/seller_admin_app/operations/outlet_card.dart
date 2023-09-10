// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/presentation/order_app/order_svg.dart';
// import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
// import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
// import 'package:cluster/presentation/seller_app/seller_svg.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// import 'new_outlet.dart';
// import 'outlet.dart';
//
// class OutletCard extends StatelessWidget {
//   bool isSelect;
//   SellerListAdmin? readData;
//   String? legalEntity;
//
//   OutletCard({Key? key, this.isSelect = false,this.readData,this.legalEntity}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double w1 = MediaQuery.of(context).size.width ;
//     double w = w1> 700
//         ? 400
//         : w1;
//     return Container(
//       width: w,
//
//       decoration: isSelect
//           ? BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                 color: Color(0xfffe5762),
//                 width: 1,
//               ),
//               // boxShadow: [
//               //   BoxShadow(
//               //     color: Color(0x16000000),
//               //     blurRadius: 5,
//               //     offset: Offset(0, 5),
//               //   ),
//               // ],
//               color: Color(0x0cfe5762),
//             )
//           : BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                 color: Color(0xffe6ecf0),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0x16000000),
//                   blurRadius: 5,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//               color: Colors.white,
//             ),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: (){
//               context.read<SellerAdminBloc>().add(
//                   GetOutletRead(readData?.id??0));
//               PersistentNavBarNavigator.pushNewScreen(
//                 context,
//                 screen: NewOutlet(
//                     edit: true,
//                     legalEntity: legalEntity),
//                 withNavBar: true,
//                 // OPTIONAL VALUE. True by default.
//                 pageTransitionAnimation:
//                 PageTransitionAnimation.fade,
//               );
//             },
//             child: Container(
//               color: isSelect?const Color(0x0cfe5762):Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Color(0xffb02ba3),
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "R",
//                         style: GoogleFonts.roboto(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           readData?.name??"",
//                           style: GoogleFonts.roboto(
//                             color: Colors.black,
//                             fontSize: w / 22,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           readData?.categoryName??"",
//                           style: TextStyle(
//                             color: Color(0xff7d7d7d),
//                             fontSize: w / 26,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: w / 1.55,
//                           child: Text(
//                             readData?.description??"",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: w / 25,
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           isSelect?Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: w,
//                 height: 1,
//                 color: Color(0xffE6ECF0),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child:
//
//               Column( children: [
//                 Row(
//                   children: [
//                     SvgPicture.string(OrderSvg().mailIcon),
//                     SizedBox(width: 5,),
//                     Text(
//                       readData?.email??"",
//                       style: GoogleFonts.roboto(
//                         color: Colors.black,
//                         fontSize: w/24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     SvgPicture.string(OrderSvg().callIcon,height: 16,color: ColorPalette.primary,),
//                     SizedBox(width: 5,),
//                     Text(
//                       readData?.contact?.primary??"",
//                       style: GoogleFonts.roboto(
//                         color: Colors.black,
//                         fontSize: w/24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.string(OrderSvg().locationIcon,height: 16,color: ColorPalette.primary,),
//                     SizedBox(width: 5,),
//                     SizedBox(
//                       width: w/1.5,
//                       child: Text(
//                         "${readData?.addressOne} | ${readData?.cityortown} | ${readData?.landmark} | "
//                             "${readData?.state} | ${readData?.country}",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ]),
//               )
//             ],
//           ):Container(),
//           Container(
//             width: w,
//             height: 1,
//             color: Color(0xffE6ECF0),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                   child:
//               Row(
//                 children: [
//                   Text(
//                     "DELIVERY AVAILABLE",
//                     style: GoogleFonts.roboto(
//                       color: Color(0xff7d7d7d),
//                       fontSize: w/32,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   SvgPicture.string(SellerSvg().verifyIcon)
//                 ],
//               )),
//               Container(
//                 width: 1,
//                 height: 46,
//                 color: Color(0xffE6ECF0),
//               ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                   child:
//               Row(
//                 children: [
//                   Text(
//                     "LOGISTIC AVAILABLE",
//                     style: GoogleFonts.roboto(
//                       color: Color(0xff7d7d7d),
//                       fontSize: w/32,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(width: 5,),
//                   SvgPicture.string(SellerSvg().verifyIcon)
//                 ],
//               )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
