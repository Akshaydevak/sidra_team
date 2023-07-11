// import 'package:cluster/common_widgets/gradient_button.dart';
// import 'package:cluster/common_widgets/loading.dart';
// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
// import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import '../../common_widgets/custom_radio_button.dart';
// import '../mpos/mpos_svg.dart';
// import '../mpos/product_card.dart';
// import '../mpos/search_card.dart';
// import '../order_app/order_svg.dart';
// import '../product_hub/Filter_screen.dart';
// import 'model/inventory_model.dart';
// import 'widget/Inventory_product_card.dart';

// class ManageInventoryScreen extends StatefulWidget {
//   ManageInventoryScreen({Key? key}) : super(key: key);

//   @override
//   State<ManageInventoryScreen> createState() => _ManageDeliveryScreenState();
// }

// class _ManageDeliveryScreenState extends State<ManageInventoryScreen> {
//   int selected = 0;
//   int isItemSelect = 0;
//   List<String> sortList = [
//     'Stock items',
//     'Out of stock items',
//   ];
//   List<String> productTypeList = [
//     'All products',
//     'Recently Added',
//     'Most Selling',
//     'Offer Applied'
//   ];

//   void onSelect(int val) {
//     selected = val;
//     setState(() {});
//   }

//   List<InventoryModel> allVariants = [];
//   bool isEmptyPage = false;
//   bool _hasNextPage = true;
//   dynamic _isFirstLoadRunning = false;
//   bool _isLoadMoreRunning = false;
//   int page = 1;
//   String url = "";
//   RefreshController refreshController = RefreshController(
//     initialRefresh: false,
//   );

//   _loadMore() async {
//     print("inside load more");
//     if (_hasNextPage == true &&
//         // _isFirstLoadRunning == false &&
//         _isLoadMoreRunning == false) {
//       setState(() {
//         _isLoadMoreRunning = true;
//       });
//       page += 1;
//       print("inside");
//       try {
//         BlocProvider.of<InventoryBloc>(context)
//             .add(ListVariantEvent(url: url, search: ""));
//       } catch (err) {
//         print('Something went wrong!');
//       }

//       setState(() {
//         _isLoadMoreRunning = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     BlocProvider.of<InventoryBloc>(context)
//         .add(ListVariantEvent(url: url, search: ""));

//     //ListVariantEvent

//     super.initState();
//   }
// bool isFailed=false;
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: BackAppBar(
//           label: "Manage Inventory",
//           onTap: () {
//             allVariants.clear();
//             Navigator.pop(context);
//           },
//           isAction: false,
//         ),
//       ),
//       body: BlocListener<InventoryBloc, InventoryState>(
//         listener: (context, state) {
//           if (state is DeleteVariantSuccess) {
//             allVariants.clear();
//             BlocProvider.of<InventoryBloc>(context)
//                 .add(ListVariantEvent(url: url, search: ""));
//             Fluttertoast.showToast(
//                 msg: '${state.data}',
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 backgroundColor: Colors.white,
//                 textColor: Colors.black);

//             setState(() {});
//           }
//           if (state is DeleteVariantFailed) {
//             allVariants.clear();
//             BlocProvider.of<InventoryBloc>(context)
//                 .add(ListVariantEvent(url: url, search: ""));
//             Fluttertoast.showToast(
//                 msg: '${state.data}',
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 backgroundColor: Colors.white,
//                 textColor: Colors.black);

//             setState(() {});
//           }
//           if (state is ListVariantSuccess) {
//             isFailed=false;
//             for (var element in state.data!) {
//               allVariants.add(element);
//             }

//             _isFirstLoadRunning = false;
//             if (state.nextPageUrl != null && state.nextPageUrl!.isNotEmpty) {
//               url=state.nextPageUrl??"";
//               print("Inside if");
//               _hasNextPage = true;
//             } else {
//               print("Inside else");
//               _hasNextPage = false;
//             }
//             setState(() {});
//           }
//           if (state is ListVariantFailed){
//             isFailed=true;
//             setState(() {

//             });
//             print("inside failed");
//           }
//         },
//         child:ScrollConfiguration(
//           behavior: NoGlow(),
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   Container(

//                       // width: w / 1.35,
//                       child: SearchCard(
//                     onchange: (val) {
//                       allVariants.clear();
//                       if (val.isEmpty) {
//                         allVariants.clear();
//                         BlocProvider.of<InventoryBloc>(context)
//                             .add(ListVariantEvent(url: "", search: ""));
//                       } else {
//                         allVariants.clear();
//                         BlocProvider.of<InventoryBloc>(context).add(
//                             ListVariantEvent(url: "", search: "?name=$val"));
//                       }
//                       setState(() {});
//                     },
//                   )),
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     _showModalBottomSheet();
//                   //     // PersistentNavBarNavigator.pushNewScreen(
//                   //     //   context,
//                   //     //   screen:  FilterScreen(),
//                   //     //   withNavBar: true, // OPTIONAL VALUE. True by default.
//                   //     //   pageTransitionAnimation: PageTransitionAnimation.fade,
//                   //     // );
//                   //     //  FilterScreen
//                   //   },
//                   //   child: Container(
//                   //     padding: EdgeInsets.all(13),
//                   //     width: 50,
//                   //     height: 50,
//                   //     decoration: BoxDecoration(
//                   //       borderRadius: BorderRadius.circular(10),
//                   //       border: Border.all(
//                   //         color: Color(0xffe6ecf0),
//                   //         width: 1,
//                   //       ),
//                   //       boxShadow: [
//                   //         BoxShadow(
//                   //           color: Color(0x05000000),
//                   //           blurRadius: 8,
//                   //           offset: Offset(1, 1),
//                   //         ),
//                   //       ],
//                   //       color: Colors.white,
//                   //     ),
//                   //     child: SvgPicture.string(
//                   //       MposSvg().filterIcon,
//                   //       color: ColorPalette.subtextGrey,
//                   //     ),
//                   //   ),
//                   // )
//                   //   ],
//                   // ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   // Text("${allVariants.length}"),
//                  isFailed?Container(
//                    height: h/2,
//                    child: Center(
//                      child: Text("Empty data"),
//                    ),
//                  ): allVariants.isNotEmpty?    LimitedBox(
//                     maxHeight: h / 1.23,
//                     child: NotificationListener<ScrollEndNotification>(
//                       onNotification: (scrollEnd) {
//                         print("scrolllll end # $scrollEnd");
//                         final metrics = scrollEnd.metrics;
//                         if (metrics.atEdge) {
//                           bool isTop = metrics.pixels == 0;
//                           if (isTop) {
//                             print('At the top');
//                           } else {
//                             print('At the bottom');
//                             _loadMore();
//                           }
//                         }
//                         return true;
//                       },
//                       child: SmartRefresher(
//                         enablePullUp:
//                             _hasNextPage && _isFirstLoadRunning ? true : false,
//                         controller: refreshController,
//                         enablePullDown: true,
//                         onLoading: () {
//                           BlocProvider.of<InventoryBloc>(context)
//                               .add(ListVariantEvent(url: url, search: ""));
//                         },
//                         onRefresh: () {
//                           allVariants.clear();
//                           BlocProvider.of<InventoryBloc>(context)
//                               .add(ListVariantEvent(url: url, search: ""));
//                           // _firstLoad();
//                           setState(() {});
//                           // refreshController.refreshCompleted();
//                         },
//                         child: ListView.separated(
//                             shrinkWrap: true,
//                             primary: false,
//                             physics: ScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return InventoryProductCard(
//                                 data: allVariants[index],
//                                 onTap: () {
//                                   showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return StatefulBuilder(builder:
//                                             (BuildContext context,
//                                                 StateSetter setState) {
//                                           return AlertDialog(
//                                             contentPadding: EdgeInsets.all(0),
//                                             content: Container(
//                                               color: Colors.white,
//                                               child: Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: <Widget>[
//                                                   Container(
//                                                     height: 50,
//                                                     width: w,
//                                                     padding: EdgeInsets.all(16),
//                                                     color: Color(0xff4D4D4D),
//                                                     alignment:
//                                                         Alignment.topLeft,
//                                                     child: Text(
//                                                       "Confirm Delete",
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: GoogleFonts.roboto(
//                                                         color: Colors.white,
//                                                         fontSize: w / 24,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.all(16),
//                                                     child: Column(
//                                                       children: [
//                                                         Text("confirm this variant deleted"),
//                                                         SizedBox(
//                                                           height: 30,
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Container(
//                                                               width: w / 3.2,
//                                                               child:
//                                                                   GradientButton(
//                                                                       color: ColorPalette
//                                                                           .primary,
//                                                                       onPressed:
//                                                                           () {
//                                                                         Navigator.pop(context);
//                                                                         // InvoiceScreen
//                                                                       },
//                                                                       gradient: LinearGradient(
//                                                                           begin:
//                                                                               Alignment.topCenter,
//                                                                           end: Alignment.bottomCenter,
//                                                                           colors: [
//                                                                             ColorPalette.white,
//                                                                             ColorPalette.white
//                                                                           ]),
//                                                                       child:
//                                                                           Text(
//                                                                         "Cancel",
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: GoogleFonts
//                                                                             .roboto(
//                                                                           color:
//                                                                               ColorPalette.primary,
//                                                                           fontSize:
//                                                                               18,
//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                         ),
//                                                                       )),
//                                                             ),
//                                                             Container(
//                                                               width: w / 3.2,
//                                                               child:
//                                                                   GradientButton(
//                                                                       color: ColorPalette
//                                                                           .primary,
//                                                                       onPressed:
//                                                                           () {

//                                                                             BlocProvider.of<InventoryBloc>(context).add(DeleteVariantEvent(id:allVariants[index].id));
//                                                                             Navigator.pop(context);
//                                                                         // InvoiceScreen
//                                                                       },
//                                                                       gradient: LinearGradient(
//                                                                           begin:
//                                                                               Alignment.topCenter,
//                                                                           end: Alignment.bottomCenter,
//                                                                           colors: [
//                                                                             ColorPalette.primary,
//                                                                             ColorPalette.primary
//                                                                           ]),
//                                                                       child:
//                                                                           Text(
//                                                                         "Delete",
//                                                                         textAlign:
//                                                                             TextAlign.center,
//                                                                         style: GoogleFonts
//                                                                             .roboto(
//                                                                           color:
//                                                                               Colors.white,
//                                                                           fontSize:
//                                                                               18,
//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                         ),
//                                                                       )),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         });
//                                       });
//                                   // BlocProvider.of<InventoryBloc>(context).add(DeleteVariantEvent(id:allVariants[index].id));
//                                 },
//                               );
//                               // return Container(
//                               //   height: 50,
//                               //     child: Text("${allVariants[index].id}"));
//                             },
//                             separatorBuilder: (context, index) => Container(
//                                   height: 10,
//                                 ),
//                             itemCount: allVariants.length),
//                       ),
//                     ),
//                   ):customCupertinoLoading(),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ),
//     );
//   }

//   _showModalBottomSheet() {
//     final TextEditingController groupName = TextEditingController();
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//         ),
//         context: context,
//         builder: (context) {
//           var h = MediaQuery.of(context).size.height;
//           var w = MediaQuery.of(context).size.width;
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Container(
//                 height: h / 1.1,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       topLeft: Radius.circular(10),
//                     )),
//                 alignment: Alignment.center,
//                 child: SafeArea(
//                   child: ScrollConfiguration(
//                     behavior: NoGlow(),
//                     child: CustomScrollView(slivers: [
//                       SliverToBoxAdapter(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 16,
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Filter",
//                                     style: GoogleFonts.roboto(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Apply",
//                                     style: GoogleFonts.roboto(
//                                       color: Color(0xfffe5762),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               indent: 10,
//                               endIndent: 10,
//                               thickness: 1.5,
//                               color: Color(0xffE6ECF0),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Product Type",
//                                     style: GoogleFonts.roboto(
//                                       color: Colors.black,
//                                       fontSize: w / 22,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 16,
//                                   ),
//                                   ListView.separated(
//                                       shrinkWrap: true,
//                                       primary: false,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         return Row(
//                                           children: [
//                                             CustomRadioButton(
//                                               onTap: () {
//                                                 onSelect(index);
//                                                 setState(() {});
//                                               },
//                                               isActive: selected == index,
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(
//                                               productTypeList[index],
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) =>
//                                           Container(
//                                             height: 10,
//                                           ),
//                                       itemCount: productTypeList.length),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               indent: 10,
//                               endIndent: 10,
//                               thickness: 1.5,
//                               color: Color(0xffE6ECF0),
//                             ),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Item Stock ",
//                                     style: GoogleFonts.roboto(
//                                       color: Colors.black,
//                                       fontSize: w / 22,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 16,
//                                   ),
//                                   ListView.separated(
//                                       shrinkWrap: true,
//                                       primary: false,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         return Row(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 onSelect(index);
//                                                 setState(() {});
//                                               },
//                                               child: selected == index
//                                                   ? Container(
//                                                       padding:
//                                                           EdgeInsets.all(10),
//                                                       child: SvgPicture.string(
//                                                           OrderSvg()
//                                                               .checkBoxActiveIcon),
//                                                     )
//                                                   : SvgPicture.string(
//                                                       OrderSvg().checkBoxIcon),
//                                             ),
//                                             // CustomRadioButton(
//                                             //   onTap: () {
//                                             //     onSelect(index);
//                                             //     setState(() {});
//                                             //   },
//                                             //   isActive: selected == index,
//                                             // ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Text(
//                                               sortList[index],
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) =>
//                                           Container(
//                                             height: 10,
//                                           ),
//                                       itemCount: sortList.length),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               indent: 10,
//                               endIndent: 10,
//                               thickness: 1.5,
//                               color: Color(0xffE6ECF0),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Product Category",
//                                     style: GoogleFonts.roboto(
//                                       color: Colors.black,
//                                       fontSize: w / 22,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 16,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           SvgPicture.string(
//                                               OrderSvg().checkBoxIcon),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "All Products",
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 18,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           // PersistentNavBarNavigator.pushNewScreen(
//                                           //   context,
//                                           //   screen: ChangeCategory(),
//                                           //   withNavBar: true, // OPTIONAL VALUE. True by default.
//                                           //   pageTransitionAnimation: PageTransitionAnimation.fade,
//                                           // );
//                                           //ChangeCategory
//                                         },
//                                         child: Text(
//                                           "Change",
//                                           style: GoogleFonts.roboto(
//                                             color: Color(0xfffe5762),
//                                             fontSize: w / 20,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ]),
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
