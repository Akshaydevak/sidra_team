import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:cluster/presentation/product_hub/varient/create_varient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import 'manage_data_card.dart';
class ManageVarientScreen extends StatelessWidget {
  const ManageVarientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Manage Variant", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchCard(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffeef3f6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Could not see in this list ?",
                      style: TextStyle(
                        fontSize: w / 23,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateVarient(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                        //  CreateNewList
                      },
                      child: Text(
                        " Create new Variant",
                        style: TextStyle(
                            fontSize: w / 23, color: ColorPalette.primary),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) =>
                    ManageDataCard(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "121542235",
                                  style: TextStyle(
                                    color: Color(0xff666161),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "HERO PINEAPPLE PRESERVE 350GM",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 5,
                              top: 5,
                              child: GestureDetector(
                                onTap: () {
                                  // _showModalBottomSheet();
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.string(
                                      ProductSvg().deleteIcon),
                                ),
                              ))
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) =>
                    SizedBox(
                      height: 8,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
  //
  // _showModalBottomSheet() {
  //   final TextEditingController groupName = TextEditingController();
  //   showModalBottomSheet(
  //
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //
  //         var h = MediaQuery.of(context).size.height;
  //         var w = MediaQuery.of(context).size.width;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               height: 300,
  //               padding: EdgeInsets.all(25 ),
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               alignment: Alignment.center,
  //               child: Column(
  //                 children: [
  //                   SvgPicture.string(ProductSvg().bottomDeleteIcon),
  //                   SizedBox(height: 20,),
  //                   Text(
  //                     "Delete Item",
  //                     style: GoogleFonts.roboto(
  //                       color: Colors.black,
  //                       fontSize: w/16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   SizedBox(height: 5,),
  //                   Text(
  //                     "Are you sure you want to delete this item from product hub ?",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: w/22,
  //                     ),
  //                   ),
  //                   SizedBox(height: 25,),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                         width: w/2.5,
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(8),
  //                           border: Border.all(color: Color(0xfffe5762), width: 1, ),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Color(0x05000000),
  //                               blurRadius: 8,
  //                               offset: Offset(1, 1),
  //                             ),
  //                           ],
  //                           color: Colors.white,
  //                         ),
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           "Yes, Delete",
  //                           textAlign: TextAlign.center,
  //                           style: GoogleFonts.roboto(
  //                             color: ColorPalette.primary,
  //                             fontSize: w/22,
  //
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: w/2.5,
  //                         height: 50,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(5),
  //                           color: Color(0xfffe5762),
  //                         ),
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           "No, Don’t Delete",
  //                           textAlign: TextAlign.center,
  //                           style:  GoogleFonts.roboto(
  //                             color: Colors.white,
  //                             fontSize: w/22,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   // SizedBox(height: 30,)
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
