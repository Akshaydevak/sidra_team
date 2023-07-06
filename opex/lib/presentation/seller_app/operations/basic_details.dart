import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../purchase_app/table_widget.dart';

class BasicDetails extends StatelessWidget {
  const BasicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Basic Details", isAction: false),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w,
                      height: 80,
                      padding: EdgeInsets.all(16),
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
                          Row(
                            children: [
                              CircleAvatar(
                                foregroundColor: Colors.grey,
                                radius: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rawabi Market",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Super Market",
                                    style: TextStyle(
                                      color: Color(0xff7d7d7d),
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SvgPicture.string(SellerSvg().callIcon)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffdf2f2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.string(
                                HomeSvg().chatGroupIcon,
                                color: ColorPalette.primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Chat with a Seller",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 20,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.string(TaskSvg().arrowIcon)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Business Details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      // margin: EdgeInsets.all(20),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(160.0),
                        border: TableBorder.all(
                            color: Color(0xffE6ECF0),
                            borderRadius: BorderRadius.circular(10),
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(children: [
                            TableTitle(
                              label: "Business Name",
                            ),
                            SubTextCard(
                              label: "Rawabi Market",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Industry",
                            ),
                            SubTextCard(
                              label: "Hypermarket",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "TRN No.",
                            ),
                            SubTextCard(
                              label: "TR12021NDBXB",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Import/Export Code",
                            ),
                            SubTextCard(
                              label: "TR12021NDBXB",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Business E-Mail",
                            ),
                            SubTextCard(
                              label: "rawabimarket@gmail.com",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Business Phone Number",
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

                                hintText: "eg.8606200441",
                                hintStyle:
                                GoogleFonts.roboto(color: Colors.grey, fontSize: 14),
                                contentPadding:
                                const EdgeInsets.only(left: 5, top: 10, bottom: 10,right: 10),
                                border: InputBorder.none,

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
                                color: Colors.white,size: 0,
                              ),
                              dropdownIconPosition: IconPosition.trailing,
                              flagsButtonMargin: const EdgeInsets.only(left: 10, right: 0),
                              disableLengthCheck: false,
                              showDropdownIcon: false,
                            ),
                          ]),


                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                width: w,
                height: 6,
                color: Color(0xfff8f7f5),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Business Details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Rawabi Market  |  Hypermarket \nTRN : 65328HG5IY4 ",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),

                    Divider(
                      color: Color(0xffE6ECF0).withOpacity(0.5),
                      thickness: 1.1,
                    ),
                    SizedBox(height: 16,),Text(
                      "Delivery Address",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "MP Tower, Thondayad bypass, \nKozhikode, 673572",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),

                    Divider(
                      color: Color(0xffE6ECF0).withOpacity(0.5),
                      thickness: 1.1,
                    ),
                    SizedBox(height: 16,),
                    Text(
                      "Pickup Address",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "MP Tower, Thondayad bypass, \nKozhikode, 673572",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: w,
                      // height: 100,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffdf2f2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AED 201.50",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffe5762),
                                  fontSize: w / 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Total Points",
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: w/24,
                                ),
                              )
                            ],
                          ),
                          SvgPicture.string(SellerSvg().trophyIcon)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
