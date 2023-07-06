import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/product_hub/product_hub_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import 'Filter_screen.dart';

class ProductScreen extends StatelessWidget {
  bool isVerified;
  String? selGender;
  String? selectedGender;
  List<String> gender = ["Male", "Female", "Other"];
   ProductScreen({Key? key,this.isVerified=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Product",isAction: false,
          ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width:w/1.35,child: SearchCard()),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen:  FilterScreen(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        //  FilterScreen
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: 50,
                          height: 50,
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
                          child: SvgPicture.string(MposSvg().filterIcon),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4,),
                // ListView.builder(itemBuilder: (context, index) => ,)
               Container(
                 height: 40,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   padding: EdgeInsets.only(left: 16,right: 16),
                   physics: ScrollPhysics(),
                   children: [
                     Container(
                       width: w / 3,
                       // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                       //height: 20.0,
                       padding: EdgeInsets.symmetric(horizontal: 5.0),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0x05000000),
                             blurRadius: 8,
                             offset: Offset(1, 1),
                           ),
                         ],
                         color: Color(0xfff2f2f2),
                       ),
                       child: DropdownButton(
                           isExpanded: true,

                           icon: Icon(Icons.arrow_drop_down_outlined),
                           underline: Container(),
                           items: gender.map((String items) {
                             return DropdownMenuItem(

                               enabled: true,
                               value: items,
                               child: Text(items,
                                   style: TextStyle(color: Colors.black)),
                             );
                           }).toList(),
                           value: selectedGender,
                           onChanged: (dynamic value) {},
                           hint: Text(
                             "Group",
                             style: GoogleFonts.roboto(
                               color: Colors.black,
                               fontSize: w/24,
                               fontWeight: FontWeight.w500,
                             ),
                           )),
                     ),
                     SizedBox(width: 10,),
                     Container(
                       width: w / 3,

                       padding: EdgeInsets.symmetric(horizontal: 5.0),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0x05000000),
                             blurRadius: 8,
                             offset: Offset(1, 1),
                           ),
                         ],
                         color: Color(0xfff2f2f2),
                       ),
                       child: DropdownButton(
                           isExpanded: true,

                           icon: Icon(Icons.arrow_drop_down_outlined),
                           underline: Container(),
                           items: gender.map((String items) {
                             return DropdownMenuItem(

                               enabled: true,
                               value: items,
                               child: Text(items,
                                   style: TextStyle(color: Colors.black)),
                             );
                           }).toList(),
                           value: selectedGender,
                           onChanged: (dynamic value) {},
                           hint: Text(
                             "Group",
                             style: GoogleFonts.roboto(
                               color: Colors.black,
                               fontSize: w/24,
                               fontWeight: FontWeight.w500,
                             ),
                           )),
                     ),
                     SizedBox(width: 10,),
                     Container(
                       width: w / 3,
                       // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                       //height: 20.0,
                       padding: EdgeInsets.symmetric(horizontal: 5.0),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0x05000000),
                             blurRadius: 8,
                             offset: Offset(1, 1),
                           ),
                         ],
                         color: Color(0xfff2f2f2),
                       ),
                       child: DropdownButton(
                           isExpanded: true,

                           icon: Icon(Icons.arrow_drop_down_outlined),
                           underline: Container(),
                           items: gender.map((String items) {
                             return DropdownMenuItem(

                               enabled: true,
                               value: items,
                               child: Text(items,
                                   style: TextStyle(color: Colors.black)),
                             );
                           }).toList(),
                           value: selectedGender,
                           onChanged: (dynamic value) {},
                           hint: Text(
                             "Group",
                             style: GoogleFonts.roboto(
                               color: Colors.black,
                               fontSize: w/24,
                               fontWeight: FontWeight.w500,
                             ),
                           )),
                     ),
                   ],
                 ),
               ),
                SizedBox(height: 20,),
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) => ProductHubCard(isVerified: isVerified,),
                ),
                SizedBox(height: 80,)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: ColorPalette.primary,
        onPressed: () {

        },
      ),

    );
  }
}
