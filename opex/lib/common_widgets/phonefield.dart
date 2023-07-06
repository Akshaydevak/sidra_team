import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class PhoneField extends StatelessWidget {
  String ?label;
  bool isMandatory;
   PhoneField({Key? key,this.label,this.isMandatory=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label??"Phone Number",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            isMandatory?   Text(
              "*",
              style: GoogleFonts.roboto(
                fontSize: w/23,
                color: ColorPalette.primary,
                fontWeight: FontWeight.w500,
              ),
            ):Container()
          ],
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
            // suffixIcon:TextButton(
            //   onPressed: (){},
            //   child: Text(
            //     "Update",
            //     style: GoogleFonts.roboto(
            //       color: Color(0xfffe5762),
            //       fontSize: w/22,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
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
      ],
    );
  }
}
