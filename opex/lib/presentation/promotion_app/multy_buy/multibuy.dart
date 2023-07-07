import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:cluster/presentation/promotion_app/widget/item_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../add_new_item.dart';

class MultiBuyForm extends StatefulWidget {
  MultiBuyForm({Key? key}) : super(key: key);

  @override
  State<MultiBuyForm> createState() => _MultiBuyFormState();
}

class _MultiBuyFormState extends State<MultiBuyForm> {
  String? selGender;

  String? selectedGender;

  bool isActive = false;
  bool isActive2 = false;

  List<String> gender = ["Grocery", "Lifestyle", "Bulk"];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "New Promotion"),
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
                    SvgPicture.string(PromotionSvg().progressDesign2),
                    SizedBox(
                      height: 16,
                    ),

                    TextFormReusable(
                      label: "Maximum Count",
                      hint: "",
                    ),
                    SizedBox(height: 16,),
                    // Text(
                    //   "Maximum count",
                    //   style: GoogleFonts.roboto(
                    //     color: Colors.black,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: w,
                    //   // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   //height: 20.0,
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(
                    //       color: Color(0xffe6ecf0),
                    //       width: 1,
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color(0x05000000),
                    //         blurRadius: 8,
                    //         offset: Offset(1, 1),
                    //       ),
                    //     ],
                    //     color: Colors.white,
                    //   ),
                    //   child: DropdownButton(
                    //       isExpanded: true,
                    //       icon: Icon(Icons.keyboard_arrow_down_outlined),
                    //       underline: Container(),
                    //       items: gender.map((String items) {
                    //         return DropdownMenuItem(
                    //           enabled: true,
                    //           value: items,
                    //           child: Text(items,
                    //               style: TextStyle(color: Colors.black)),
                    //         );
                    //       }).toList(),
                    //       value: selectedGender,
                    //       onChanged: (dynamic value) {},
                    //       hint: Text(
                    //         "Select segment ",
                    //         style: TextStyle(
                    //           color: Color(0xbf666161),
                    //           fontSize: w / 22,
                    //         ),
                    //       )),
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Text(
                    //   "Buy item list",
                    //   style: GoogleFonts.roboto(
                    //     color: Colors.black,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // ItemListCard(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: w,
                    //   padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(7),
                    //       topRight: Radius.circular(7),
                    //       bottomLeft: Radius.circular(0),
                    //       bottomRight: Radius.circular(0),
                    //     ),
                    //     border: Border.all(
                    //       color: Color(0xffe6ecf0),
                    //       width: 1,
                    //     ),
                    //     color: Color(0xfff0f0f0),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Icon(Icons.notes),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "25445447854",
                    //               style: GoogleFonts.roboto(
                    //                 color: Colors.black,
                    //                 fontSize: w / 24,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             Container(
                    //               width: w / 1.8,
                    //               child: Text(
                    //                 "Amet minim mollit non deserunt ullamconlorem ipsum dolkar sit",
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: w / 24,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Container(
                    //               width: w / 1.31,
                    //               color: ColorPalette.divider,
                    //               height: 1,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: w / 4,
                    //                   child: Text(
                    //                     "Category ",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: w / 26,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   ":",
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 Text(
                    //                   "Baby Products",
                    //                   textAlign: TextAlign.right,
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: w / 26,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Container(
                    //               width: w / 1.31,
                    //               color: ColorPalette.divider,
                    //               height: 1,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: w / 4,
                    //                   child: Text(
                    //                     "Quantity ",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: w / 26,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   ":",
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 Text(
                    //                   "20",
                    //                   textAlign: TextAlign.right,
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: w / 26,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Container(
                    //               width: w / 1.31,
                    //               color: ColorPalette.divider,
                    //               height: 1,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: w / 4,
                    //                   child: Text(
                    //                     "UOM ",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: w / 26,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   ":",
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 Text(
                    //                   "Pack",
                    //                   textAlign: TextAlign.right,
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: w / 26,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Container(
                    //               width: w / 1.31,
                    //               color: ColorPalette.divider,
                    //               height: 1,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: w / 4,
                    //                   child: Text(
                    //                     "Unit Cost ",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: w / 26,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   ":",
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 Text(
                    //                   "AED 25.50",
                    //                   textAlign: TextAlign.right,
                    //                   style: GoogleFonts.roboto(
                    //                     color: Colors.black,
                    //                     fontSize: w / 26,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Container(
                    //               width: w / 1.31,
                    //               color: ColorPalette.divider,
                    //               height: 1,
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Text(
                    //                   "Is_Active",
                    //                   style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: w / 26,
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     setState(() {
                    //                       isActive = !isActive;
                    //                     });
                    //                   },
                    //                   child: isActive
                    //                       ? SvgPicture.string(
                    //                           HomeSvg().toggleActive)
                    //                       : SvgPicture.string(
                    //                           HomeSvg().toggleInActive),
                    //                 ),
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: w / 2.198,
                    //       height: 40,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(0),
                    //           topRight: Radius.circular(0),
                    //           bottomLeft: Radius.circular(7),
                    //           bottomRight: Radius.circular(0),
                    //         ),
                    //         color: Color(0x7fbdc3c6),
                    //       ),
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Edit promotion",
                    //         style: GoogleFonts.roboto(
                    //           color: Color(0xff3d3d3d),
                    //           fontSize: w / 27,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: w / 2.198,
                    //       height: 40,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(0),
                    //           topRight: Radius.circular(0),
                    //           bottomLeft: Radius.circular(0),
                    //           bottomRight: Radius.circular(7),
                    //         ),
                    //         color: Color(0xfff0f0f0),
                    //       ),
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Delete Promotion",
                    //         style: GoogleFonts.roboto(
                    //           color: Color(0xff3d3d3d),
                    //           fontSize: w / 27,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ItemListCard(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: w,
                    //   padding: EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     border: Border.all(
                    //       color: Color(0xfffe5762),
                    //       width: 1,
                    //     ),
                    //     color: Color(0x0cfe5762),
                    //   ),
                    //   child: Text(
                    //     "+ Add new item",
                    //     style: GoogleFonts.roboto(
                    //       color: Color(0xfffe5762),
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Text(
                    //   "Get item list",
                    //   style: GoogleFonts.roboto(
                    //     color: Colors.black,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // ListView.separated(
                    //   shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) => ItemListCard(),
                    //     separatorBuilder: (context, index) => SizedBox(
                    //           height: 10,
                    //         ),
                    //     itemCount: 4),
                    // SizedBox(height: 10,),
                    // GestureDetector(
                    //   onTap: (){
                    //     PersistentNavBarNavigator.pushNewScreen(
                    //       context,
                    //       screen: AddNewItem(),
                    //       withNavBar: true,
                    //       // OPTIONAL VALUE. True by default.
                    //       pageTransitionAnimation:
                    //       PageTransitionAnimation.fade,
                    //     );
                    //     //
                    //   },
                    //   child: Container(
                    //     width: w,
                    //     padding: EdgeInsets.all(16),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(
                    //         color: Color(0xfffe5762),
                    //         width: 1,
                    //       ),
                    //       color: Color(0x0cfe5762),
                    //     ),
                    //     child: Text(
                    //       "+ Add new item",
                    //       style: GoogleFonts.roboto(
                    //         color: Color(0xfffe5762),
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    ClusterCard(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is_Active",
                            style: GoogleFonts.roboto(
                              color: const Color(0xff151522),
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isActive2 = !isActive2;
                              });
                            },
                            child: isActive2
                                ? SvgPicture.string(HomeSvg().toggleActive)
                                : SvgPicture.string(HomeSvg().toggleInActive),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    GradientButton(
                        color:ColorPalette.primary ,
                        onPressed: () {


                        },
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ ColorPalette.primary,
                            ColorPalette.primary]),
                        child: Text(
                          "Save Promotion",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ))),
      ),
    );
  }
}
