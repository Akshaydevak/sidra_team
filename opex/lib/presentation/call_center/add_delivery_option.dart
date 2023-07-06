import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/mandatory_textfield.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/phonefield.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
class AddDeliveryOption extends StatelessWidget {
  const AddDeliveryOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Delivery Address",
          isAction: true,
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
                Text(
                  "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam dign.",
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: w/23,
                  ),
                ),
                SizedBox(height: 16,),
                PhoneField(
                  label: "Phone Number",
                  isMandatory: true,
                ),
                SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Email ID" ,
                  hint: "Eg. dummy@gmail.com",
                ),
                SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Emirates" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Building Name/Room Number" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Street" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                MandatoryTextField(
                  label: "City" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Area" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                MandatoryTextField(
                  label: "Zone" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),SizedBox(height: 10,),
                TextFormReusable(
                  label: "Landmark" ,
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),
                SizedBox(height: 30,),
                GradientButton(
                    color:Color(0xfffe5762) ,
                    onPressed: () {

Navigator.pop(context);
                    },
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
