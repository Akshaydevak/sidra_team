// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/common_widgets/string_extensions.dart';
// import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
// import 'package:colorize_text_avatar/colorize_text_avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../common_widgets/gradient_button.dart';
// import '../../core/color_palatte.dart';
// import '../../core/common_snackBar.dart';
// import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
// import '../dashboard_screen/profile/business_details_screen.dart';
// import '../seller_app/seller_svg.dart';
// import '../task_operation/image_preview_task.dart';
// import 'model_seller_admin/seller_admin_models.dart';
//
// class SellerRequestListScreen extends StatefulWidget {
//   const SellerRequestListScreen({super.key});
//
//   @override
//   State<SellerRequestListScreen> createState() =>
//       _SellerRequestListScreenState();
// }
//
// class _SellerRequestListScreenState extends State<SellerRequestListScreen> {
//   @override
//   void initState() {
//     context.read<SellerAdminBloc>().add(UserVerifyListEvent("", "", ''));
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w1 = MediaQuery.of(context).size.width;
//     double w = w1 > 700 ? 400 : w1;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: BackAppBar(
//           label: "Seller Request",
//           isAction: false,
//         ),
//       ),
//       body: ScrollConfiguration(
//         behavior: NoGlow(),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: BlocBuilder<SellerAdminBloc, SellerAdminState>(
//                 builder: (context, state) {
//                   if (state is UserVerifyListLoading) {
//                     return Container(
//                       height: 200,
//                       width: w,
//                       alignment: Alignment.center,
//                       child: LoadingAnimationWidget.threeRotatingDots(
//                         color: Colors.red,
//                         size: 30,
//                       ),
//                     );
//                   }
//                   if (state is UserVerifyListSuccess) {
//                     return Column(
//                       children: [
//                         ListView.separated(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   width: w,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(
//                                       color: Color(0xffe6ecf0),
//                                       width: 1,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(0x16000000),
//                                         blurRadius: 5,
//                                         offset: Offset(0, 5),
//                                       ),
//                                     ],
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           _showModalBottomSheetOfferGroup(
//                                               state.role?[index]);
//                                           setState(() {});
//                                         },
//                                         child: Container(
//                                           color: Colors.white,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(16.0),
//                                             child: Row(
//                                               children: [
//                                                 TextAvatar(
//                                                   shape: Shape.Circular,
//                                                   size: 45,
//                                                   numberLetters: 1,
//                                                   fontSize: w / 16,
//                                                   textColor: Colors.white,
//                                                   fontWeight: FontWeight.w500,
//                                                   text: state
//                                                           .role?[index]
//                                                           .businessData
//                                                           ?.businessName?.toUpperCase() ??
//                                                       "".toUpperCase(),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       state
//                                                               .role?[index]
//                                                               .businessData
//                                                               ?.businessName.toString().toTitleCase() ??
//                                                           "",
//                                                       style: GoogleFonts.roboto(
//                                                         color: Colors.black,
//                                                         fontSize: w / 22,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Text(
//                                                       state
//                                                               .role?[index]
//                                                               .businessData
//                                                               ?.taxNumber ??
//                                                           "",
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff7d7d7d),
//                                                         fontSize: w / 26,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Container(
//                                                       width: w / 1.55,
//                                                       child: Text(
//                                                         state
//                                                                 .role?[index]
//                                                                 .businessData
//                                                                 ?.name ??
//                                                             "",
//                                                         style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontSize: w / 25,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         width: w1,
//                                         height: 1,
//                                         color: Color(0xffE6ECF0),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           GestureDetector(
//                                             onTap: (){
//                                               context
//                                                   .read<SellerAdminBloc>()
//                                                   .add(VerifyUserEvent(
//                                                   state.role?[index].code ??
//                                                       "",true));
//                                               context
//                                                   .read<SellerAdminBloc>()
//                                                   .add(UserVerifyListEvent(
//                                                   "", "", ''));
//
//                                               setState(() {});
//                                             },
//                                             child: Container(
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Row(
//                                                   children: [
//                                                     SvgPicture.string(
//                                                         SellerSvg().crossIcon),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     Text(
//                                                       "Reject",
//                                                       style: GoogleFonts.roboto(
//                                                         color: Colors.red,
//                                                         fontSize: w / 32,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                           ),
//                                           Container(
//                                             width: 1,
//                                             height: 46,
//                                             color: Color(0xffE6ECF0),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               context
//                                                   .read<SellerAdminBloc>()
//                                                   .add(VerifyUserEvent(
//                                                       state.role?[index].code ??
//                                                           "",false));
//                                               context
//                                                   .read<SellerAdminBloc>()
//                                                   .add(UserVerifyListEvent(
//                                                       "", "", ''));
//
//                                               setState(() {});
//                                             },
//                                             child: Container(
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Row(
//                                                   children: [
//                                                     SvgPicture.string(
//                                                         SellerSvg().tick),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     Text(
//                                                       "Accept",
//                                                       style: GoogleFonts.roboto(
//                                                         color: Colors.green,
//                                                         fontSize: w / 32,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) => SizedBox(
//                                   height: 10,
//                                 ),
//                             itemCount: state.role!.length)
//                       ],
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showModalBottomSheetOfferGroup(VerifyUserList? listData) {
//     final TextEditingController groupName = TextEditingController();
//     int select = 0;
//     void onselect(int index) {
//       setState(() {
//         select = index;
//       });
//     }
//
//     void saveGallery(String doc) async {
//       await GallerySaver.saveImage(doc,toDcim: true);
//       showSnackBar(context,
//           message: "File Saved To Gallery",
//           color: ColorPalette.green);
//     }
//
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//         ),
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           var h = MediaQuery.of(context).size.height;
//           double w1 = MediaQuery.of(context).size.width;
//           double w = w1 > 700 ? 400 : w1;
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Container(
//                 height: h / 1.2,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       topLeft: Radius.circular(10),
//                     )),
//                 alignment: Alignment.center,
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: h / 180,
//                         ),
//                         Container(
//                           width: w / 5.3,
//                           height: h / 160,
//                           decoration: ShapeDecoration(
//                             color: Color(0xFFD9D9D9),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: h / 40,
//                         ),
//                         Text(
//                           "Details",
//                           style: GoogleFonts.roboto(
//                             color: Colors.black,
//                             fontSize: w / 22,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         SizedBox(
//                           height: h / 40,
//                         ),
//                         SizedBox(
//                           height: h / 1.5,
//                           child: ScrollConfiguration(
//                             behavior: NoGlow(),
//                             child: SingleChildScrollView(
//                               physics: AlwaysScrollableScrollPhysics(),
//                               child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 10, right: 10),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: w,
//                                         height: 100,
//                                         padding: EdgeInsets.all(16),
//                                         // decoration: BoxDecoration(
//                                         //   borderRadius: BorderRadius.circular(10),
//                                         //   border: Border.all(
//                                         //     color: Color(0xffe6ecf0),
//                                         //     width: 1,
//                                         //   ),
//                                         //   boxShadow: [
//                                         //     BoxShadow(
//                                         //       color: Color(0x05000000),
//                                         //       blurRadius: 8,
//                                         //       offset: Offset(1, 1),
//                                         //     ),
//                                         //   ],
//                                         //   color: Colors.white,
//                                         // ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                     // height: 200,
//                                                     // width: 100,
//                                                     padding: EdgeInsets.all(10),
//                                                     decoration: BoxDecoration(
//                                                         border: Border.all(
//                                                             width: 0.2,
//                                                             color:
//                                                                 Colors.black),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5)),
//                                                     child: Image.network(
//                                                         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDjBgVbhq2t5c9NQe_MJVctRObLpz-55aX_g&usqp=CAU')),
//                                                 SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       listData?.businessData
//                                                               ?.businessName ??
//                                                           "",
//                                                       style: GoogleFonts.roboto(
//                                                         color: Colors.black,
//                                                         fontSize: w / 22,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       listData?.businessData
//                                                               ?.name ??
//                                                           "",
//                                                       style: TextStyle(
//                                                         color:
//                                                             Color(0xff7d7d7d),
//                                                         fontSize: w / 26,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Divider(
//                                         color: Colors.grey.withOpacity(0.2),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 15, right: 15, top: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Description",
//                                               style: GoogleFonts.roboto(
//                                                   fontSize: w / 24,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.black),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               listData?.businessData
//                                                       ?.businessName ??
//                                                   "",
//                                               style: GoogleFonts.roboto(
//                                                   fontSize: w / 26,
//                                                   color: Colors.black),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Business Name",
//                                               text: listData?.businessData
//                                                       ?.businessName ??
//                                                   "",
//                                               icons: Icons.business_center,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Status",
//                                               text: listData?.status ?? "",
//                                               icons: Icons.business,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "TRN Number",
//                                               text: listData?.businessData
//                                                       ?.taxNumber ??
//                                                   "",
//                                               icons: Icons.numbers,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Import/Export Code",
//                                               text: "TR17364732642367",
//                                               icons: Icons.import_export,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Businesss E-Mail",
//                                               text: listData
//                                                       ?.businessData?.email ??
//                                                   "",
//                                               icons: Icons.email_sharp,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Phone Number",
//                                               text: listData
//                                                       ?.businessData?.phone ??
//                                                   "",
//                                               icons: Icons.phone_android_sharp,
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             DetailsCardText(
//                                               label: "Address",
//                                               text:
//                                                   "${listData?.businessData?.address} | ${listData?.businessData?.location} | ${listData?.businessData?.city}  | "
//                                                   "${listData?.businessData?.state} | ${listData?.businessData?.country}",
//                                               icons: Icons.location_pin,
//                                             ),
//                                             SizedBox(
//                                               height: 25,
//                                             ),
//                                         Text(
//                                           'Documents :',
//                                           style: GoogleFonts.roboto(
//                                               fontSize: w/24,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black
//                                           ),),
//                                             SizedBox(height: 10,),
//                                             Container(
//                                               width: w1,
//                                               padding: EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(color: Colors.grey,width: 0.2),
//                                                 borderRadius: BorderRadius.circular(5)
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                  SizedBox(
//                                                    // height: 50,
//                                                    // width: 50,
//                                                    child:  SvgPicture.string(
//                                                      SellerSvg().fileIcon,),
//                                                  ),
//                                                   SizedBox(width: 10,),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       showDialog(
//                                                           context: context,
//                                                           barrierDismissible: true,
//                                                           builder: (BuildContext context) {
//                                                             return AlertDialog(
//                                                               content: ImagePreview(
//                                                                 assetName: listData?.docOne??"",
//                                                               ),
//                                                             );
//                                                           }
//                                                       );
//                                                     },
//                                                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Text(
//                                                           'Document One',
//                                                           style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 14,
//                                                             fontFamily: 'Roboto',
//                                                             fontWeight: FontWeight.w400,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           width: w1/1.8,
//                                                           child: Text(
//                                                             listData?.docOne??"",
//                                                             maxLines: 1,
//                                                             overflow: TextOverflow.ellipsis,
//                                                             style: GoogleFonts.roboto(
//                                                               color: Color(0x91151522),
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.w400,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Spacer(),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       saveGallery(listData?.docOne??"");
//                                                     },
//                                                     child: SizedBox(
//                                                       // height: 50,
//                                                       // width: 50,
//                                                       child:  SvgPicture.string(
//                                                         SellerSvg().download,),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(height: 15,),
//                                             Container(
//                                               width: w1,
//                                               padding: EdgeInsets.all(10),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   border: Border.all(color: Colors.grey,width: 0.2),
//                                                   borderRadius: BorderRadius.circular(5)
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     // height: 50,
//                                                     // width: 50,
//                                                     child:  SvgPicture.string(
//                                                       SellerSvg().fileIcon,),
//                                                   ),
//                                                   SizedBox(width: 10,),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       showDialog(
//                                                           context: context,
//                                                           barrierDismissible: true,
//                                                           builder: (BuildContext context) {
//                                                             return AlertDialog(
//                                                               content: ImagePreview(
//                                                                 assetName: listData?.docTwo??"",
//                                                               ),
//                                                             );
//                                                           }
//                                                       );
//                                                     },
//                                                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Text(
//                                                           'Document Two',
//                                                           style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 14,
//                                                             fontFamily: 'Roboto',
//                                                             fontWeight: FontWeight.w400,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           width: w1/1.8,
//                                                           child: Text(
//                                                             listData?.docTwo??"",
//                                                             maxLines: 1,
//                                                             overflow: TextOverflow.ellipsis,
//                                                             style: GoogleFonts.roboto(
//                                                               color: Color(0x91151522),
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.w400,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Spacer(),
//                                                   GestureDetector(
//                                                     onTap: (){
//                                                       saveGallery(listData?.docTwo??"");
//                                                     },
//                                                     child: SizedBox(
//                                                       // height: 50,
//                                                       // width: 50,
//                                                       child:  SvgPicture.string(
//                                                         SellerSvg().download,),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Positioned(
//                     //   bottom: 0,
//                     //   left: 0,
//                     //   right: 0,
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
//                     //     child: GradientButton(
//                     //         color: ColorPalette.primary,
//                     //         onPressed: () {
//                     //
//                     //         },
//                     //         gradient: const LinearGradient(
//                     //             begin: Alignment.topCenter,
//                     //             end: Alignment.bottomCenter,
//                     //             colors: [
//                     //               ColorPalette.primary,
//                     //               ColorPalette.primary
//                     //             ]),
//                     //         child: Text(
//                     //           "Create New",
//                     //           textAlign: TextAlign.center,
//                     //           style: GoogleFonts.roboto(
//                     //             color: Colors.white,
//                     //             fontSize: w / 22,
//                     //             fontWeight: FontWeight.w600,
//                     //           ),
//                     //         )),
//                     //   ),)
//                   ],
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
