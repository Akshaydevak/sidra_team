import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../common_widgets/title_app_bar.dart';
class NewVendor extends StatelessWidget {
  const NewVendor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TitleAppBar(label: "New Vendor"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormReusable(
                label: "Business Name",
                hint: "eg.rawabi market",
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Industry",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: w,
                // height: 60,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "eg.supermarket",
                      style: TextStyle(
                        color: Color(0x66151522),
                        fontSize: 15,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "TRN No",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: w,
                // height: 60,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "eg.supermarket",
                      style: TextStyle(
                        color: Color(0x66151522),
                        fontSize: 15,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormReusable(
                label: "Import or Export Code",
                hint: "eg.12548RE5",
              ),
              SizedBox(
                height: 16,
              ),
              TextFormReusable(
                label: "Business Email",
                hint: "eg.example@email.com",
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Business Phone Number",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              IntlPhoneField(
                initialCountryCode: "IN",
                // controller: emailphonecontroller,
                validator: (text) {
                  if (text == null) {
                    return 'Text is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon:TextButton(
                    onPressed: (){},
                    child: Text(
                      "Update",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hintText: "eg.8606200441",
                  hintStyle:
                  GoogleFonts.roboto(color: Colors.grey, fontSize: 14),
                  contentPadding:
                  const EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe6ecf0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe6ecf0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color(0xffe6ecf0), width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                onChanged: (phone) {
                  // contactNumber = phone.completeNumber.toString();
                  // emailphonecontroller =
                  //     TextEditingController(text: phone.number);
                },
                onCountryChanged: (country) {},
                cursorColor: Colors.black,
                dropdownIcon: const Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                dropdownIconPosition: IconPosition.trailing,
                flagsButtonMargin: const EdgeInsets.only(left: 10, right: 30),
                disableLengthCheck: false,
                showDropdownIcon: false,
              ),
              SizedBox(height: 5,),
              Text(
                "Profile related info placed here.  Whishlist is used to save your favourite items for later.",
                style: TextStyle(
                  color: Color(0xff3c3b3b),
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 30,),
              GradientButton(
                  color:Color(0xfffe5762),
                  onPressed: () {},
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xfffe5762),
                        Color(0xfffe5762)
                      ]
                  ),
                  child: Text(
                    "Add New Seller",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),),
        ),
      ),
    );
  }
}
