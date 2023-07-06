import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/product_hub/warranty/warranty_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';

class CreateWarranty extends StatefulWidget {
  const CreateWarranty({Key? key}) : super(key: key);

  @override
  State<CreateWarranty> createState() => _CreateWarrantyState();
}

class _CreateWarrantyState extends State<CreateWarranty> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Create Warranty", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
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
                    TextFieldTab(
                      label: "Duration",
                      hint: "Eg. SEM",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFieldTab(
                      label: "Description",
                      hint: "Eg. SEM",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFieldTab(
                      label: "Description",
                      hint: "Eg. SEM",
                      child: Text(
                        "Create New",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        width: w,
                        // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        //height: 20.0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
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
                              "Is_Active",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isActive = !isActive;
                                  });
                                },
                                child: SvgPicture.string(isActive
                                    ? HomeSvg().toggleActive
                                    : HomeSvg().toggleInActive)),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Warranty Parts",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: w,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Color(0xff373737),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 1.6,
                            child: Text(
                              "Condition",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: ColorPalette.divider,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Is_active",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: w,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: w / 1.55,
                                // height: 71,
                                child: Text(
                                  "Lorem ipsum dolar sit amet this is a dummy text for you",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 70,
                                color: ColorPalette.divider,
                              ),
                              SizedBox(width: 16,),
                              isActive
                                  ? SvgPicture.string(HomeSvg().toggleActive)
                                  : SvgPicture.string(HomeSvg().toggleInActive),
                            ],
                          ),
                          Container(
                            width: w,
                            height: 1,
                            color: ColorPalette.divider,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: w / 1.55,
                                // height: 71,
                                child: Text(

                                  "Is_Active",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 70,
                                color: ColorPalette.divider,
                              ),
                              SizedBox(width: 16,),
                              isActive
                                  ? SvgPicture.string(HomeSvg().toggleActive)
                                  : SvgPicture.string(HomeSvg().toggleInActive),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "+ Add New Raw",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.primary,
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              WarrantyCard(),
              SizedBox(height: 20,),
              WarrantyCard(label: "EXTENDED WARRANTY"),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(16),
                child: GradientButton(
                    onPressed: () {

                    },
                    gradient: const LinearGradient(
                      colors: [
                        ColorPalette.primary,
                        ColorPalette.primary,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: ColorPalette.primary,
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
