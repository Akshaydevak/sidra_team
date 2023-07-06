import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class InventoryNewBaseUOM extends StatelessWidget {
  const InventoryNewBaseUOM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "New Base UOM", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
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
              SizedBox(height: 10,),
              TextFormReusable(
                label: "Description",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(height: 10,),
              TextFormReusable(
                label: "Category",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(height: 10,),
              TextFieldTab(
                label: "Attribute Name",
                hint: "-  Select  -",
              ), SizedBox(height: 10,),
              TextFieldTab(
                label: "Attribute Type",
                hint: "-  Select  -",
              ),
              SizedBox(height: 10,),
              Text(
                "Values",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30,),
              GradientButton(
                  onPressed: () {

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
                    "Continue",
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
    );
  }
}
