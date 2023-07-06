import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'add_varient.dart';

class InventoryVarientScreen extends StatelessWidget {
  const InventoryVarientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Variant Framework",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w/24,

              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: AddVarient(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
            child: Container(
              width: w,
              alignment: Alignment.center,
              child: Container(
                width: 144,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Color(0xffe6ecf0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Color(0xfff7f7f7),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add Variant",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: w,
            // height: 42,
            child:const Text(
              "Add variants to your product if it available in different color, material, size, designs etc...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff666161),
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
