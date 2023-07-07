import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';
import '../../seller_app/seller_svg.dart';
import '../product_svg.dart';
import '../widget/table_card.dart';
import '../widget/vendor_list_card.dart';

class CreatevarientFour extends StatefulWidget {

   CreatevarientFour({Key? key}) : super(key: key);

  @override
  State<CreatevarientFour> createState() => _CreatevarientFourState();
}

class _CreatevarientFourState extends State<CreatevarientFour> {
  String? selGender;

  String? selectedGender;

  List<String> gender = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Create Variant", isAction: false,
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
                  SvgPicture.string(ProductSvg().varientFourIcon),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Product Highlights",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "You can able to add at maximum of 8 images. Image should be clear and dust free.",
                    style: TextStyle(
                      color: Color(0xff666161),
                      fontSize: w / 27,
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    "Vendor List",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => VendorListCard(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 3),
                  const SizedBox(
                    height: 20,
                  ),
                  // TableCard(),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // TableCard(
                  //   head: "Ingredients",
                  //   title1: "Ingredient Name",
                  //   title2: "Value",
                  //   content1: "Ingredients",
                  //   content2: "Enter details",
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  // TableCard(
                  //   head: "Product Features",
                  //   title1: "Features",
                  //   title2: "Details",
                  //   content1: "Enter Features",
                  //   content2: "Enter details",
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // TableCard(
                  //   head: "Additional Information",
                  //   title1: "Additional Info",
                  //   title2: "Value",
                  //   content1: "Enter Additional info",
                  //   content2: "Enter details",
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  // TableCard(
                  //   head: "Nutrition Facts",
                  //   title1: "Nutrition Facts",
                  //   title2: "Value",
                  //   content1: "Enter Nutrition Facts",
                  //   content2: "Enter details",
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   "Usage Direction",
                  //   style: GoogleFonts.roboto(
                  //     color: Colors.black,
                  //     fontSize: w / 24,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w/1.3,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ),
                            hintText: "Enter your text ..."
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xfff7535e), width: 1, ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Color(0x0cf7535e),
                        ),
                        child: Icon(Icons.add,color: ColorPalette.primary,),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "You can able to add at maximum of 8 images. Image should be clear and dust free.",
                    style: TextStyle(
                      color: Color(0xff666161),
                      fontSize: w/27,
                    ),
                  ),SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Storage",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w/1.3,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                color:  Color(0xffe6ecf0)
                              )
                              ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ),
                            hintText: "Enter your text ..."
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xfff7535e), width: 1, ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Color(0x0cf7535e),
                        ),
                        child: Icon(Icons.add,color: ColorPalette.primary,),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "You can able to add at maximum of 8 images. Image should be clear and dust free.",
                    style: TextStyle(
                      color: Color(0xff666161),
                      fontSize: w/27,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "CONSUMER BEHAVIOUR",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 14,),
                  Row(
                    children: [
                      Container(
                        width: w/3.5,
                        child: Text(
                          "Gender Group",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.string(SellerSvg().validationIcon),
                      SizedBox(width: 16,),
                      Container(
                        width: w / 2,
                        // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        //height: 20.0,
                        padding: EdgeInsets.symmetric(
                             horizontal: 12.0),
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
                        child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            underline: Container(),
                            items: gender.map((String items) {
                              return DropdownMenuItem(
                                enabled: true,
                                value: items,
                                child: Text(items,
                                    style: TextStyle(
                                        color: Colors.black)),
                              );
                            }).toList(),
                            value: selectedGender,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedGender = value;
                                // if (value == "Male") {
                                //   selGender = "M";
                                // } else if (value == "Female") {
                                //   selGender = "F";
                                // } else if (value == "Other") {
                                //   selGender = "N";
                                // }
                                // Gender = value;
                              });
                            },
                            hint: Text(
                              "Select type",
                              style: GoogleFonts.roboto(
                                  color:Colors.grey,fontSize: 14),
                            )),
                      ),
                    ],
                  ) ,
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: w/3.5,
                        child: Text(
                          "Age",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.string(SellerSvg().validationIcon),
                      SizedBox(width: 16,),
                      Container(
                        width: w / 2,
                       child: TextFormField(
                         decoration:  InputDecoration(
                           filled: true,
                           fillColor: Colors.white,
                           hintText: "Eg. 24",
                           hintStyle: TextStyle(
                             color: Color(0x7f666161),
                         fontSize: 16,
                       ),
                           contentPadding: EdgeInsets.symmetric(horizontal: 10),
                           border: OutlineInputBorder(

                             borderRadius:BorderRadius.circular(10) ,
                             borderSide: BorderSide(

                               color: Color(0xffe6ecf0)
                             )
                           ), enabledBorder: OutlineInputBorder(
                             borderRadius:BorderRadius.circular(10) ,
                             borderSide: BorderSide(
                               color: Color(0xffe6ecf0)
                             )
                           ),focusedBorder: OutlineInputBorder(
                             borderRadius:BorderRadius.circular(10) ,
                             borderSide: BorderSide(
                               color: Color(0xffe6ecf0)
                             )
                           ),
                         ),

                       ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: w/3.5,
                        child: Text(
                          "Ethinic",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.string(SellerSvg().validationIcon),
                      SizedBox(width: 16,),
                      Container(
                        width: w / 2,
                        // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        //height: 20.0,
                        padding: EdgeInsets.symmetric(
                             horizontal: 12.0),
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
                        child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            underline: Container(),
                            items: gender.map((String items) {
                              return DropdownMenuItem(
                                enabled: true,
                                value: items,
                                child: Text(items,
                                    style: TextStyle(
                                        color: Colors.black)),
                              );
                            }).toList(),
                            value: selectedGender,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedGender = value;
                                // if (value == "Male") {
                                //   selGender = "M";
                                // } else if (value == "Female") {
                                //   selGender = "F";
                                // } else if (value == "Other") {
                                //   selGender = "N";
                                // }
                                // Gender = value;
                              });
                            },
                            hint: Text(
                              "Select one",
                              style: GoogleFonts.roboto(
                                  color:Colors.grey,fontSize: 14),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: w/3.5,
                        child: Text(
                          "Country",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.string(SellerSvg().validationIcon),
                      SizedBox(width: 16,),
                      Container(
                        width: w / 2,
                        // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        //height: 20.0,
                        padding: EdgeInsets.symmetric(
                             horizontal: 12.0),
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
                        child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            underline: Container(),
                            items: gender.map((String items) {
                              return DropdownMenuItem(
                                enabled: true,
                                value: items,
                                child: Text(items,
                                    style: TextStyle(
                                        color: Colors.black)),
                              );
                            }).toList(),
                            value: selectedGender,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedGender = value;
                                // if (value == "Male") {
                                //   selGender = "M";
                                // } else if (value == "Female") {
                                //   selGender = "F";
                                // } else if (value == "Other") {
                                //   selGender = "N";
                                // }
                                // Gender = value;
                              });
                            },
                            hint: Text(
                              "Select a country",
                              style: GoogleFonts.roboto(
                                  color:Colors.grey,fontSize: 14),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: w/3.5,
                        child: Text(
                          "Behaviour",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.string(SellerSvg().validationIcon),
                      SizedBox(width: 16,),
                      Container(
                        width: w / 2,
                        child: TextFormField(
                          decoration:  InputDecoration(
                            hintText: "Occupations",
                            hintStyle:  TextStyle(
                              color: Color(0x7f666161),
                              fontSize: w/25,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(

                                borderRadius:BorderRadius.circular(10) ,
                                borderSide: BorderSide(

                                    color: Color(0xffe6ecf0)
                                )
                            ), enabledBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(10) ,
                              borderSide: BorderSide(
                                  color: Color(0xffe6ecf0)
                              )
                          ),focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(10) ,
                              borderSide: BorderSide(
                                  color: Color(0xffe6ecf0)
                              )
                          ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  TextFieldTab(
                    label: "Alternative Barcode",
                    hint: "Eg. SEM",
                  ),
                  SizedBox(height: 30,),
                  GradientButton(
                      color:ColorPalette.primary ,
                      onPressed: () {
                        // InvoiceScreen
                      },
                      gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors:[
                            ColorPalette.primary,
                            ColorPalette.primary
                          ]),
                      child: Text(
                        "Add new Variant",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
