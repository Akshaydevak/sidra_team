// import 'package:cluster/common_widgets/cluster_card.dart';
// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/presentation/inventory/inventory_svg.dart';
// import 'package:cluster/presentation/inventory/model/inventory_model.dart';
// import 'package:cluster/presentation/inventory/update_varient.dart';
// import 'package:cluster/presentation/mpos/mpos_svg.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../../../common_widgets/gradient_button.dart';
// import '../../../core/color_palatte.dart';
// import '../../order_app/order_svg.dart';
// import '../../order_app/orderapp_card.dart';

// class InventoryProductCard extends StatefulWidget {
//   bool isSearch;
// InventoryModel? data;
// VoidCallback? onTap;
//   InventoryProductCard({Key? key, this.isSearch = false,this.data,this.onTap}) : super(key: key);

//   @override
//   State<InventoryProductCard> createState() => _InventoryProductCardState();
// }

// class _InventoryProductCardState extends State<InventoryProductCard> {
//   int? select;

//   bool isSelected = false;

//   void onSelect(int val) {
//     select = val;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w1 = MediaQuery.of(context).size.width ;
//     double w = w1> 700
//         ? 400
//         : w1;
//     print("Imagess${widget.data?.image1}");
//     return GestureDetector(
//       onTap: () {
//         PersistentNavBarNavigator.pushNewScreen(
//           context,
//           screen:  UpdateVariant(id: widget.data?.id??0,),
//           withNavBar: true,
//           // OPTIONAL VALUE. True by default.
//           pageTransitionAnimation: PageTransitionAnimation.fade,
//         );
//         // _showModalBottomSheet();
//       },
//       child: Container(
//         width: w1,
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Color(0xffe6ecf0),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x05000000),
//               blurRadius: 8,
//               offset: Offset(1, 1),
//             ),
//           ],
//           color: Colors.white,
//         ),
//         child: Stack(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 76,
//                   height: 76,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Color(0xfff0f1f2),
//                   ),
//                   child: Image.network(widget.data?.image1!=null?widget.data?.image1??"":""
//                   // "https://constructivo.com/images/not-found.png"
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: w1 / 1.65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             widget.data?.code.toString()??"15464646545 ",
//                             style: GoogleFonts.roboto(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: widget.onTap,
//                               child: Icon(Icons.delete_outlined))
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       width: w1 / 1.8,
//                       child: Text(
//                         widget.data?.name??"Lorem ipsum dolor sit amet, consectetur adipiscing ea...",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                        Container(
//                          width: w/4,
//                          child: Text(
//                               "Quantity",
//                               style: TextStyle(
//                                 color: Color(0xff666161),
//                                 fontSize: w/24,
//                               ),
//                             ),
//                        ),
//                         Text(
//                           ":",
//                           style: TextStyle(
//                             color: Color(0xff666161),
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(width: 10,),
//                         Text(
//                           widget.data?.stockCount.toString()??"24",
//                           style: GoogleFonts.roboto(
//                             color: Colors.black,
//                             fontSize: w/25,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )

//                       ],
//                     ),
//                     Row(
//                       children: [
//                        Container(
//                          width: w/4,
//                          child: Text(
//                               "Brand",
//                               style: TextStyle(
//                                 color: Color(0xff666161),
//                                 fontSize: w/24,
//                               ),
//                             ),
//                        ),
//                         Text(
//                           ":",
//                           style: TextStyle(
//                             color: Color(0xff666161),
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(width: 10,),
//                         Container(
//                           width: w/4,
//                           child: Text(
//                             widget.data?.brandName??"Specimen",
//                             style: GoogleFonts.roboto(
//                               color: Colors.black,
//                               fontSize: w/25,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         )

//                       ],
//                     ),
//                     // Row(
//                     //   children: [
//                     //    Container(
//                     //      width: w/4,
//                     //      child: Text(
//                     //           "Price ",
//                     //           style: TextStyle(
//                     //             color: Color(0xff666161),
//                     //             fontSize: w/24,
//                     //           ),
//                     //         ),
//                     //    ),
//                     //     Text(
//                     //       ":",
//                     //       style: TextStyle(
//                     //         color: Color(0xff666161),
//                     //         fontSize: 16,
//                     //       ),
//                     //     ),
//                     //     SizedBox(width: 10,),
//                     //     Text(
//                     //       "AED 145.50",
//                     //       style: GoogleFonts.roboto(
//                     //         color: Colors.black,
//                     //         fontSize: w/25,
//                     //         fontWeight: FontWeight.w500,
//                     //       ),
//                     //     )
//                     //
//                     //   ],
//                     // ),

//                   ],
//                 )
//               ],
//             ),
//             Positioned(
//                 right: 0,
//                 child:widget.isSearch? SvgPicture.string(InventorySvg().arrowIcon):Container()
//                    )
//           ],
//         ),
//       ),
//     );
//   }
//   //
//   // _showModalBottomSheet() {
//   //   showModalBottomSheet(
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.only(
//   //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//   //       ),
//   //       context: context,
//   //       builder: (context) {
//   //         var h = MediaQuery.of(context).size.height;
//   //         var w = MediaQuery.of(context).size.width;
//   //         return StatefulBuilder(
//   //           builder: (BuildContext context, StateSetter setState) {
//   //             return Container(
//   //               padding: EdgeInsets.only(
//   //                 top: 20,
//   //               ),
//   //               // height: 350,
//   //               width: double.infinity,
//   //               decoration: const BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.only(
//   //                     topRight: Radius.circular(10),
//   //                     topLeft: Radius.circular(10),
//   //                   )),
//   //               // alignment: Alignment.center,
//   //               child: ScrollConfiguration(
//   //                 behavior: NoGlow(),
//   //                 child: SingleChildScrollView(
//   //                   child: Column(
//   //                     mainAxisAlignment: MainAxisAlignment.start,
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Container(
//   //                         width: w,
//   //                         margin: EdgeInsets.all(16),
//   //                         padding: EdgeInsets.all(10),
//   //                         decoration: BoxDecoration(
//   //                           borderRadius: BorderRadius.circular(10),
//   //                           border: Border.all(
//   //                             color: Color(0xffe6ecf0),
//   //                             width: 1,
//   //                           ),
//   //                           boxShadow: [
//   //                             BoxShadow(
//   //                               color: Color(0x05000000),
//   //                               blurRadius: 8,
//   //                               offset: Offset(1, 1),
//   //                             ),
//   //                           ],
//   //                           color: Colors.white,
//   //                         ),
//   //                         child: Row(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Container(
//   //                               width: 76,
//   //                               height: 76,
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(5),
//   //                                 color: Color(0xfff0f1f2),
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               width: 10,
//   //                             ),
//   //                             Column(
//   //                               mainAxisAlignment: MainAxisAlignment.start,
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 Text(
//   //                                   "15464646545 ",
//   //                                   style: GoogleFonts.roboto(
//   //                                     color: Colors.black,
//   //                                     fontSize: 16,
//   //                                     fontWeight: FontWeight.w600,
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(
//   //                                   height: 5,
//   //                                 ),
//   //                                 Container(
//   //                                   width: w / 1.8,
//   //                                   child: Text(
//   //                                     "Lorem ipsum dolor sit amet, consectetur adipiscing ea...",
//   //                                     style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontSize: 16,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(
//   //                                   height: 5,
//   //                                 ),
//   //                                 Row(
//   //                                   children: [
//   //                                     SizedBox(
//   //                                       width: 63,
//   //                                       height: 41,
//   //                                       child: Text(
//   //                                         "Brand\nPrice ",
//   //                                         style: TextStyle(
//   //                                           color: Color(0xff666161),
//   //                                           fontSize: 16,
//   //                                         ),
//   //                                       ),
//   //                                     ),
//   //                                     SizedBox(
//   //                                       width: 150,
//   //                                       height: 47,
//   //                                       child: Text(
//   //                                         "Specimen\nAED 145.50 / Piece",
//   //                                         style: GoogleFonts.roboto(
//   //                                           color: Colors.black,
//   //                                           fontWeight: FontWeight.w500,
//   //                                         ),
//   //                                       ),
//   //                                     )
//   //                                   ],
//   //                                 )
//   //                               ],
//   //                             )
//   //                           ],
//   //                         ),
//   //                       ),
//   //                       Container(
//   //                         padding: EdgeInsets.all(16),
//   //                         child: Column(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Text(
//   //                               "Change Quantity",
//   //                               style: GoogleFonts.roboto(
//   //                                 color: Colors.black,
//   //                                 fontSize: w / 22,
//   //                                 fontWeight: FontWeight.w500,
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             Text(
//   //                               "Available Offers",
//   //                               style: GoogleFonts.roboto(
//   //                                 color: Colors.black,
//   //                                 fontSize: w / 22,
//   //                                 fontWeight: FontWeight.w500,
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             Container(
//   //                               width: 140,
//   //                               height: 43.08,
//   //                               padding: EdgeInsets.all(2),
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(27),
//   //                                 border: Border.all(
//   //                                   color: Color(0xffe6ecf0),
//   //                                   width: 1,
//   //                                 ),
//   //                                 boxShadow: [
//   //                                   BoxShadow(
//   //                                     color: Color(0x05000000),
//   //                                     blurRadius: 8,
//   //                                     offset: Offset(1, 1),
//   //                                   ),
//   //                                 ],
//   //                                 color: Colors.white,
//   //                               ),
//   //                               child: Row(
//   //                                 mainAxisAlignment:
//   //                                 MainAxisAlignment.spaceBetween,
//   //                                 children: [
//   //                                   Container(
//   //                                       width: 38,
//   //                                       height: 38,
//   //                                       decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(27),
//   //                                         color: Color(0xfff0f1f2),
//   //                                       ),
//   //                                       child: Icon(Icons.minimize_rounded)),
//   //                                   Text(
//   //                                     "19",
//   //                                     style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontSize: 24,
//   //                                     ),
//   //                                   ),
//   //                                   Container(
//   //                                     width: 38,
//   //                                     height: 38,
//   //                                     decoration: BoxDecoration(
//   //                                       borderRadius: BorderRadius.circular(37),
//   //                                       boxShadow: [
//   //                                         BoxShadow(
//   //                                           color: Color(0x05000000),
//   //                                           blurRadius: 8,
//   //                                           offset: Offset(1, 1),
//   //                                         ),
//   //                                       ],
//   //                                       color: Color(0xfffe5762),
//   //                                     ),
//   //                                     child: Icon(
//   //                                       Icons.add,
//   //                                       color: Colors.white,
//   //                                     ),
//   //                                   )
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             Container(
//   //                               child: ListView.separated(
//   //                                   shrinkWrap: true,
//   //                                   primary: false,
//   //                                   physics: NeverScrollableScrollPhysics(),
//   //                                   itemBuilder: (context, index) {
//   //                                     return Container(
//   //                                       width: 382,
//   //                                       padding: EdgeInsets.all(16),
//   //                                       decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(5),
//   //                                         border: Border.all(
//   //                                           color: Color(0xffe6ecf0),
//   //                                           width: 1,
//   //                                         ),
//   //                                         boxShadow: [
//   //                                           BoxShadow(
//   //                                             color: Color(0x05000000),
//   //                                             blurRadius: 8,
//   //                                             offset: Offset(1, 1),
//   //                                           ),
//   //                                         ],
//   //                                         color: Colors.white,
//   //                                       ),
//   //                                       child: Row(
//   //                                         mainAxisAlignment:
//   //                                         MainAxisAlignment.start,
//   //                                         crossAxisAlignment:
//   //                                         CrossAxisAlignment.start,
//   //                                         children: [
//   //                                           Container(
//   //                                             width: 26,
//   //                                             height: 28,
//   //                                             decoration: BoxDecoration(
//   //                                               borderRadius:
//   //                                               BorderRadius.circular(3),
//   //                                               color: Color(0xfff2efea),
//   //                                             ),
//   //                                           ),
//   //                                           SizedBox(
//   //                                             width: 10,
//   //                                           ),
//   //                                           Container(
//   //                                             width: w / 1.4,
//   //                                             child: Column(
//   //                                               children: [
//   //                                                 Row(
//   //                                                   mainAxisAlignment:
//   //                                                   MainAxisAlignment
//   //                                                       .spaceBetween,
//   //                                                   children: [
//   //                                                     Text(
//   //                                                       "Instant Discount",
//   //                                                       style: GoogleFonts.roboto(
//   //                                                         color: Colors.black,
//   //                                                         fontSize: w / 22,
//   //                                                         fontWeight:
//   //                                                         FontWeight.w500,
//   //                                                       ),
//   //                                                     ),
//   //                                                     Text(
//   //                                                       "Upto 65% Off",
//   //                                                       style: TextStyle(
//   //                                                         color:
//   //                                                         Color(0xff666161),
//   //                                                         fontSize: 14,
//   //                                                       ),
//   //                                                     )
//   //                                                   ],
//   //                                                 ),
//   //                                                 SizedBox(
//   //                                                   height: 5,
//   //                                                 ),
//   //                                                 Text(
//   //                                                   "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
//   //                                                   style: TextStyle(
//   //                                                     color: Colors.black,
//   //                                                     fontSize: 15,
//   //                                                   ),
//   //                                                 )
//   //                                               ],
//   //                                             ),
//   //                                           )
//   //                                         ],
//   //                                       ),
//   //                                     );
//   //                                   },
//   //                                   separatorBuilder: (context, index) =>
//   //                                       Container(
//   //                                         height: 10,
//   //                                       ),
//   //                                   itemCount: 5),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 16,
//   //                             ),
//   //                             GradientButton(
//   //                                 color: ColorPalette.primary,
//   //                                 onPressed: () {
//   //                                   FocusScope.of(context)
//   //                                       .requestFocus(FocusNode());
//   //                                   Navigator.pop(context);
//   //                                   showDialog(
//   //                                       context: context,
//   //                                       builder: (BuildContext context) {
//   //                                         return AlertDialog(
//   //                                             contentPadding:
//   //                                             EdgeInsets.symmetric(
//   //                                                 vertical: 14,
//   //                                                 horizontal: 10),
//   //                                             content: StatefulBuilder(builder:
//   //                                                 (BuildContext context,
//   //                                                 StateSetter setState) {
//   //                                               return Column(
//   //                                                 mainAxisSize: MainAxisSize.min,
//   //                                                 children: <Widget>[
//   //                                                   Container(
//   //                                                     width: w,
//   //                                                     // height: h/7,
//   //                                                     alignment:
//   //                                                     Alignment.topLeft,
//   //                                                     child: Row(
//   //                                                       mainAxisAlignment:
//   //                                                       MainAxisAlignment
//   //                                                           .spaceBetween,
//   //                                                       children: [
//   //                                                         Text(
//   //                                                           "Select Collection Name",
//   //                                                           style: GoogleFonts
//   //                                                               .poppins(
//   //                                                             color: Color(
//   //                                                                 0xff1b1b1f),
//   //                                                             fontSize: w / 24,
//   //                                                             fontWeight:
//   //                                                             FontWeight.w500,
//   //                                                           ),
//   //                                                         ),
//   //                                                         SvgPicture.string(
//   //                                                             MposSvg()
//   //                                                                 .closeIcon),
//   //                                                       ],
//   //                                                     ),
//   //                                                   ),
//   //                                                   SizedBox(
//   //                                                     height: 15,
//   //                                                   ),
//   //                                                   Container(
//   //                                                     height: 300,
//   //                                                     decoration: BoxDecoration(
//   //                                                       borderRadius:
//   //                                                       BorderRadius.circular(
//   //                                                           2),
//   //                                                       border: Border.all(
//   //                                                         color:
//   //                                                         Color(0xccd9d9d9),
//   //                                                         width: 1,
//   //                                                       ),
//   //                                                     ),
//   //                                                     child: ListView.separated(
//   //                                                         shrinkWrap: true,
//   //                                                         primary: false,
//   //                                                         physics:
//   //                                                         ScrollPhysics(),
//   //                                                         itemBuilder:
//   //                                                             (context, index) {
//   //                                                           return GestureDetector(
//   //                                                             onTap: () {
//   //                                                               onSelect(index);
//   //                                                               setState(() {
//   //                                                                 isSelected =
//   //                                                                 true;
//   //                                                               });
//   //                                                             },
//   //                                                             child: Container(
//   //                                                               padding:
//   //                                                               EdgeInsets
//   //                                                                   .all(10),
//   //                                                               child: Row(
//   //                                                                 mainAxisAlignment:
//   //                                                                 MainAxisAlignment
//   //                                                                     .start,
//   //                                                                 crossAxisAlignment:
//   //                                                                 CrossAxisAlignment
//   //                                                                     .start,
//   //                                                                 children: [
//   //                                                                   select ==
//   //                                                                       index
//   //                                                                       ? Stack(
//   //                                                                     children: [
//   //                                                                       Container(
//   //                                                                         width: 61,
//   //                                                                         height: 44,
//   //                                                                         decoration: BoxDecoration(
//   //                                                                           borderRadius: BorderRadius.circular(2),
//   //                                                                           color: Color(0xff1ecac0),
//   //                                                                         ),
//   //                                                                         alignment: Alignment.center,
//   //                                                                         child: Text(
//   //                                                                           "P",
//   //                                                                           style: GoogleFonts.roboto(
//   //                                                                             color: Colors.white,
//   //                                                                             fontSize: 32,
//   //                                                                             fontWeight: FontWeight.w600,
//   //                                                                           ),
//   //                                                                         ),
//   //                                                                       ),
//   //                                                                       Container(
//   //                                                                         width: 61,
//   //                                                                         height: 44,
//   //                                                                         padding: EdgeInsets.all(15),
//   //                                                                         decoration: BoxDecoration(
//   //                                                                           borderRadius: BorderRadius.circular(2),
//   //                                                                           color: Color(0xccfe5762),
//   //                                                                         ),
//   //                                                                         child: SvgPicture.string(MposSvg().tickIcon),
//   //                                                                       )
//   //                                                                     ],
//   //                                                                   )
//   //                                                                       : Container(
//   //                                                                     width:
//   //                                                                     61,
//   //                                                                     height:
//   //                                                                     44,
//   //                                                                     decoration:
//   //                                                                     BoxDecoration(
//   //                                                                       borderRadius:
//   //                                                                       BorderRadius.circular(2),
//   //                                                                       color:
//   //                                                                       Color(0xff1ecac0),
//   //                                                                     ),
//   //                                                                     alignment:
//   //                                                                     Alignment.center,
//   //                                                                     child:
//   //                                                                     Text(
//   //                                                                       "P",
//   //                                                                       style:
//   //                                                                       GoogleFonts.roboto(
//   //                                                                         color: Colors.white,
//   //                                                                         fontSize: 32,
//   //                                                                         fontWeight: FontWeight.w600,
//   //                                                                       ),
//   //                                                                     ),
//   //                                                                   ),
//   //                                                                   SizedBox(
//   //                                                                     width: 10,
//   //                                                                   ),
//   //                                                                   Column(
//   //                                                                     mainAxisAlignment:
//   //                                                                     MainAxisAlignment
//   //                                                                         .start,
//   //                                                                     crossAxisAlignment:
//   //                                                                     CrossAxisAlignment
//   //                                                                         .start,
//   //                                                                     children: [
//   //                                                                       const Text(
//   //                                                                         "POS",
//   //                                                                         style:
//   //                                                                         TextStyle(
//   //                                                                           color:
//   //                                                                           Colors.black,
//   //                                                                           fontSize:
//   //                                                                           16,
//   //                                                                         ),
//   //                                                                       ),
//   //                                                                       Text(
//   //                                                                         "Created on Today",
//   //                                                                         style: GoogleFonts
//   //                                                                             .roboto(
//   //                                                                           color:
//   //                                                                           Color(0xff666161),
//   //                                                                           fontSize:
//   //                                                                           10,
//   //                                                                           fontWeight:
//   //                                                                           FontWeight.w500,
//   //                                                                         ),
//   //                                                                       )
//   //                                                                     ],
//   //                                                                   )
//   //                                                                 ],
//   //                                                               ),
//   //                                                             ),
//   //                                                           );
//   //                                                         },
//   //                                                         separatorBuilder:
//   //                                                             (context, index) =>
//   //                                                             Divider(
//   //                                                               height: 1,
//   //                                                               thickness: 1,
//   //                                                               color: Color(
//   //                                                                   0xffD9D9D9)
//   //                                                                   .withOpacity(
//   //                                                                   0.5),
//   //                                                             ),
//   //                                                         itemCount: 5),
//   //                                                   ),
//   //                                                   SizedBox(
//   //                                                     height: 30,
//   //                                                   ),
//   //                                                   Row(
//   //                                                       mainAxisAlignment:
//   //                                                       MainAxisAlignment
//   //                                                           .spaceBetween,
//   //                                                       children: <Widget>[
//   //                                                         GestureDetector(
//   //                                                           onTap: () {
//   //                                                             FocusScope.of(
//   //                                                                 context)
//   //                                                                 .requestFocus(
//   //                                                                 FocusNode());
//   //                                                             Navigator.pop(
//   //                                                                 context);
//   //                                                             showDialog(
//   //                                                                 context:
//   //                                                                 context,
//   //                                                                 builder:
//   //                                                                     (BuildContext
//   //                                                                 context) {
//   //                                                                   return AlertDialog(
//   //                                                                       contentPadding: EdgeInsets.symmetric(
//   //                                                                           vertical:
//   //                                                                           14,
//   //                                                                           horizontal:
//   //                                                                           10),
//   //                                                                       content: StatefulBuilder(builder: (BuildContext
//   //                                                                       context,
//   //                                                                           StateSetter
//   //                                                                           setState) {
//   //                                                                         return Column(
//   //                                                                           mainAxisSize:
//   //                                                                           MainAxisSize.min,
//   //                                                                           children: <
//   //                                                                               Widget>[
//   //                                                                             Container(
//   //                                                                               width: w,
//   //                                                                               // height: h/7,
//   //                                                                               alignment: Alignment.topLeft,
//   //                                                                               child: Row(
//   //                                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                                                                                 children: [
//   //                                                                                   Text(
//   //                                                                                     "Create New",
//   //                                                                                     style: GoogleFonts.roboto(
//   //                                                                                       color: Color(0xff1b1b1f),
//   //                                                                                       fontSize: w / 24,
//   //                                                                                       fontWeight: FontWeight.w500,
//   //                                                                                     ),
//   //                                                                                   ),
//   //                                                                                   SvgPicture.string(MposSvg().closeIcon),
//   //                                                                                 ],
//   //                                                                               ),
//   //                                                                             ),
//   //                                                                             SizedBox(
//   //                                                                               height: 15,
//   //                                                                             ),
//   //                                                                             TextFormField(
//   //                                                                               decoration: InputDecoration(
//   //                                                                                 hintText: "Enter collection Name",
//   //                                                                                 hintStyle: TextStyle(
//   //                                                                                   color: Color(0x66151522),
//   //                                                                                   fontSize: 15,
//   //                                                                                 ),
//   //                                                                                 contentPadding: EdgeInsets.only(left: 10),
//   //                                                                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xffE6ECF0))),
//   //                                                                                 enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xffE6ECF0))),
//   //                                                                               ),
//   //                                                                             ),
//   //                                                                             SizedBox(
//   //                                                                               height: 16,
//   //                                                                             ),
//   //                                                                             GestureDetector(
//   //                                                                               onTap: () {},
//   //                                                                               child: Container(
//   //                                                                                   width: w,
//   //                                                                                   padding: EdgeInsets.symmetric(vertical: 13),
//   //                                                                                   decoration: BoxDecoration(
//   //                                                                                     borderRadius: BorderRadius.circular(5),
//   //                                                                                     gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//   //                                                                                       Color(0xfffe5762),
//   //                                                                                       Color(0xfffe5762)
//   //                                                                                     ]),
//   //                                                                                   ),
//   //                                                                                   alignment: Alignment.center,
//   //                                                                                   child: Text(
//   //                                                                                     "Create New Collection",
//   //                                                                                     style: GoogleFonts.roboto(
//   //                                                                                       color: Colors.white,
//   //                                                                                       fontSize: 18,
//   //                                                                                       fontWeight: FontWeight.w500,
//   //                                                                                     ),
//   //                                                                                   )),
//   //                                                                             ),
//   //                                                                             SizedBox(
//   //                                                                               height: h / 80,
//   //                                                                             )
//   //                                                                           ],
//   //                                                                         );
//   //                                                                       }));
//   //                                                                 });
//   //                                                           },
//   //                                                           child: Row(
//   //                                                             children: [
//   //                                                               SvgPicture.string(
//   //                                                                   MposSvg()
//   //                                                                       .addNewIcon),
//   //                                                               SizedBox(
//   //                                                                 width: 5,
//   //                                                               ),
//   //                                                               Text(
//   //                                                                 "Create New",
//   //                                                                 style:
//   //                                                                 GoogleFonts
//   //                                                                     .roboto(
//   //                                                                   color: Color(
//   //                                                                       0xfffe5762),
//   //                                                                   fontSize: 15,
//   //                                                                   fontWeight:
//   //                                                                   FontWeight
//   //                                                                       .w500,
//   //                                                                 ),
//   //                                                               ),
//   //                                                             ],
//   //                                                           ),
//   //                                                         ),
//   //                                                         GestureDetector(
//   //                                                           onTap: () {},
//   //                                                           child: Container(
//   //                                                               width: w / 3.1,
//   //                                                               padding: EdgeInsets
//   //                                                                   .symmetric(
//   //                                                                   vertical:
//   //                                                                   13),
//   //                                                               decoration:
//   //                                                               BoxDecoration(
//   //                                                                 borderRadius:
//   //                                                                 BorderRadius
//   //                                                                     .circular(
//   //                                                                     5),
//   //                                                                 gradient:
//   //                                                                 LinearGradient(
//   //                                                                   begin: Alignment
//   //                                                                       .topCenter,
//   //                                                                   end: Alignment
//   //                                                                       .bottomCenter,
//   //                                                                   colors:
//   //                                                                   isSelected
//   //                                                                       ? [
//   //                                                                     Color(0xfffe5762),
//   //                                                                     Color(0xfffe5762)
//   //                                                                   ]
//   //                                                                       : [
//   //                                                                     Color(0xffe7e7e7),
//   //                                                                     Color(0xffe7e7e7)
//   //                                                                   ],
//   //                                                                 ),
//   //                                                               ),
//   //                                                               alignment:
//   //                                                               Alignment
//   //                                                                   .center,
//   //                                                               child: Text(
//   //                                                                 "Save",
//   //                                                                 style:
//   //                                                                 GoogleFonts
//   //                                                                     .roboto(
//   //                                                                   color: Colors
//   //                                                                       .white,
//   //                                                                   fontSize: 18,
//   //                                                                   fontWeight:
//   //                                                                   FontWeight
//   //                                                                       .w500,
//   //                                                                 ),
//   //                                                               )),
//   //                                                         ),
//   //                                                       ]),
//   //                                                   SizedBox(
//   //                                                     height: h / 80,
//   //                                                   )
//   //                                                 ],
//   //                                               );
//   //                                             }));
//   //                                       });
//   //                                 },
//   //                                 gradient: LinearGradient(
//   //                                     begin: Alignment.topCenter,
//   //                                     end: Alignment.bottomCenter,
//   //                                     colors: const [
//   //                                       ColorPalette.primary,
//   //                                       ColorPalette.primary
//   //                                     ]),
//   //                                 child: Text(
//   //                                   "Add to Collect",
//   //                                   textAlign: TextAlign.center,
//   //                                   style: GoogleFonts.roboto(
//   //                                     color: Colors.white,
//   //                                     fontSize: 18,
//   //                                     fontWeight: FontWeight.w600,
//   //                                   ),
//   //                                 )),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             );
//   //           },
//   //         );
//   //       });
//   // }
//   // _showofferModalBottomSheet() {
//   //   showModalBottomSheet(
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.only(
//   //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//   //       ),
//   //       context: context,
//   //       builder: (context) {
//   //         var h = MediaQuery.of(context).size.height;
//   //         var w = MediaQuery.of(context).size.width;
//   //         return StatefulBuilder(
//   //           builder: (BuildContext context, StateSetter setState) {
//   //             return Container(
//   //               padding: EdgeInsets.only(
//   //                   top: 20,left: 16,right: 16,bottom: 10
//   //               ),
//   //               // height: 350,
//   //               width: double.infinity,
//   //               decoration: const BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.only(
//   //                     topRight: Radius.circular(10),
//   //                     topLeft: Radius.circular(10),
//   //                   )),
//   //               // alignment: Alignment.center,
//   //               child: SingleChildScrollView(
//   //                 child: Column(
//   //                   mainAxisAlignment: MainAxisAlignment.start,
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text(
//   //                       "Available Offers",
//   //                       style: GoogleFonts.roboto(
//   //                         color: Colors.black,
//   //                         fontSize: 16,
//   //
//   //                         fontWeight: FontWeight.w500,
//   //                       ),
//   //                     ),
//   //                     SizedBox(
//   //                       height: 10,
//   //                     ),
//   //                     ClusterCard(
//   //                         padding: EdgeInsets.all(8),
//   //                         child: Row(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Container(
//   //                               width: 26,
//   //                               height: 28,
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(3),
//   //                                 color: Color(0xfff2efea),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 5,),
//   //                             Column(
//   //                               mainAxisAlignment: MainAxisAlignment.start,
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Row(
//   //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                                     children: [
//   //                                       Text(
//   //                                         "Extra AED.10 Off on UPI",
//   //                                         style: GoogleFonts.roboto(
//   //                                           color: Colors.black,
//   //                                           fontSize: w / 24,
//   //                                           fontWeight: FontWeight.w500,
//   //                                         ),
//   //                                       ),
//   //                                       Text(
//   //                                         "Min.Order 200",
//   //                                         style: TextStyle(
//   //                                           color: Color(0xff666161),
//   //                                           fontSize: w / 27,
//   //                                         ),
//   //                                       )
//   //                                     ],
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(
//   //                                   height: 10,
//   //                                 ),
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Text(
//   //                                     "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
//   //                                     style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontSize: 15,
//   //                                     ),
//   //                                   ),
//   //                                 )
//   //                               ],
//   //                             )
//   //                           ],
//   //                         )),
//   //                     SizedBox(
//   //                       height: 10,
//   //                     ),
//   //                     ClusterCard(
//   //                         padding: EdgeInsets.all(8),
//   //                         child: Row(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Container(
//   //                               width: 26,
//   //                               height: 28,
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(3),
//   //                                 color: Color(0xfff2efea),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 5,),
//   //                             Column(
//   //                               mainAxisAlignment: MainAxisAlignment.start,
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Row(
//   //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                                     children: [
//   //                                       Text(
//   //                                         "Instant Discount",
//   //                                         style: GoogleFonts.roboto(
//   //                                           color: Colors.black,
//   //                                           fontSize: w / 24,
//   //                                           fontWeight: FontWeight.w500,
//   //                                         ),
//   //                                       ),
//   //                                       Text(
//   //                                         "Upto 65% Off",
//   //                                         style: TextStyle(
//   //                                           color: Color(0xff666161),
//   //                                           fontSize: w / 27,
//   //                                         ),
//   //                                       )
//   //                                     ],
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(
//   //                                   height: 10,
//   //                                 ),
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Text(
//   //                                     "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
//   //                                     style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontSize: 15,
//   //                                     ),
//   //                                   ),
//   //                                 )
//   //                               ],
//   //                             )
//   //                           ],
//   //                         )),SizedBox(
//   //                       height: 10,
//   //                     ),
//   //                     ClusterCard(
//   //                         padding: EdgeInsets.all(8),
//   //                         child: Row(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Container(
//   //                               width: 26,
//   //                               height: 28,
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(3),
//   //                                 color: Color(0xfff2efea),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 5,),
//   //                             Column(
//   //                               mainAxisAlignment: MainAxisAlignment.start,
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Row(
//   //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                                     children: [
//   //                                       Text(
//   //                                         "Instant Discount",
//   //                                         style: GoogleFonts.roboto(
//   //                                           color: Colors.black,
//   //                                           fontSize: w / 24,
//   //                                           fontWeight: FontWeight.w500,
//   //                                         ),
//   //                                       ),
//   //                                       Text(
//   //                                         "Upto 65% Off",
//   //                                         style: TextStyle(
//   //                                           color: Color(0xff666161),
//   //                                           fontSize: w / 27,
//   //                                         ),
//   //                                       )
//   //                                     ],
//   //                                   ),
//   //                                 ),
//   //                                 SizedBox(
//   //                                   height: 10,
//   //                                 ),
//   //                                 Container(
//   //                                   width: w / 1.35,
//   //                                   child: Text(
//   //                                     "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
//   //                                     style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontSize: 15,
//   //                                     ),
//   //                                   ),
//   //                                 )
//   //                               ],
//   //                             )
//   //                           ],
//   //                         )),
//   //                     SizedBox(
//   //                       height: 16,
//   //                     ),
//   //                     GradientButton(
//   //                         color: ColorPalette.primary,
//   //                         onPressed: () {
//   //
//   //                         },
//   //                         gradient: LinearGradient(
//   //                             begin: Alignment.topCenter,
//   //                             end: Alignment.bottomCenter,
//   //                             colors: const [
//   //                               ColorPalette.primary,
//   //                               ColorPalette.primary
//   //                             ]),
//   //                         child: Text(
//   //                           "Apply Offer",
//   //                           textAlign: TextAlign.center,
//   //                           style: GoogleFonts.roboto(
//   //                             color: Colors.white,
//   //                             fontSize: 18,
//   //                             fontWeight: FontWeight.w600,
//   //                           ),
//   //                         )),
//   //                   ],
//   //                 ),
//   //               ),
//   //
//   //             );
//   //           },
//   //         );
//   //       });
//   // }
// }
