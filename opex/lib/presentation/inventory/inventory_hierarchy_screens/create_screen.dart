import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/product_hub/add_new_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
class InventoryCreateScreen extends StatefulWidget {

  InventoryCreateScreen({Key? key}) : super(key: key);

  @override
  State<InventoryCreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<InventoryCreateScreen> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Create", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
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
                TextFormReusable(
                  label: "Name",
                  hint: "Eg. SEM",
                ),
                SizedBox(height: 5,),
                TextFormReusable(
                  label: "Alternative Name",
                  hint: "Eg. Lorem ipsum dolar sit amet. /",
                ),

                SizedBox(height: 5,),
                TextFormReusable(
                  label: "Description",
                  hint: "Eg. Lorem ipsum dolar sit amet. /",
                ),
                SizedBox(height: 5,),
                TextFormReusable(
                  label: "Category",
                  hint: "Eg. Lorem ipsum dolar sit amet. /",
                ),   SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/2.3,
                      child: TextFormReusable(
                        label: "Selling Price %",
                        hint: "Eg. Lorem ipsum dolar sit amet. /",
                      ),
                    ),  Container(
                      width: w/2.3,
                      child: TextFormReusable(
                        label: "Online Price %",
                        hint: "Eg. Lorem ipsum dolar sit amet. /",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "Description",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 88,
                  height: 103,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0xfff7f7f7),
                  ),
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 16,),
                Container(
                  width: w,
                 padding: EdgeInsets.all(16),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is_Active",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isActive=!isActive;
                        });
                      },
                      child: isActive
                          ? SvgPicture.string(HomeSvg().toggleActive)
                          : SvgPicture.string(HomeSvg().toggleInActive),
                    ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddNewList(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );

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
                      "Create",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
