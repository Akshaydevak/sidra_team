import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:cluster/presentation/promotion_app/buy_more_get_form/costumtable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../mpos/mpos_svg.dart';


class ProductBehaviourCard extends StatefulWidget {
  bool ?isUpdate;
  final TextEditingController? ethnicController;
  final TextEditingController? purposeController;
  final TextEditingController? ageGroupController;
  final TextEditingController? countryController;
  final TextEditingController? genderController;
    TextEditingController? headController;
  // FocusNode ?focusNode;
  FocusNode? ethnicFocus ;
  FocusNode ?purposeFocus ;
  FocusNode ?ageFocus;
  FocusNode ?countriesFocus ;
  FocusNode ? genderFocus;


  ProductBehaviourCard({Key? key,this.ethnicController, this.purposeController, this.ageGroupController, this.countryController, this.genderController, this.headController,this.isUpdate=false,this.ethnicFocus,this.countriesFocus,this.ageFocus,this.purposeFocus,this.genderFocus})
      : super(key: key);

  @override
  State<ProductBehaviourCard> createState() => _TableCardState();
}

class _TableCardState extends State<ProductBehaviourCard> {
  // TextEditingController headController = TextEditingController();


  @override
  void initState() {
   // widget.headController = TextEditingController(text:"Behaviour");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.headController?.text??"",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            // GestureDetector(
            //     onTap: () {
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               contentPadding: EdgeInsets.all(0),
            //               content: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: <Widget>[
            //                   Container(
            //                       width: w,
            //                       height: 53,
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(5),
            //                           topRight: Radius.circular(5),
            //                           bottomLeft: Radius.circular(0),
            //                           bottomRight: Radius.circular(0),
            //                         ),
            //                         color: Color(0xff4c4c4c),
            //                       ),
            //                       padding: EdgeInsets.only(
            //                           left: 16, right: 16, top: 16, bottom: 10),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text(
            //                             "Edit Info",
            //                             textAlign: TextAlign.center,
            //                             style: GoogleFonts.roboto(
            //                               color: Colors.white,
            //                               fontSize: w / 24,
            //                               fontWeight: FontWeight.w500,
            //                             ),
            //                           ),
            //                           Icon(
            //                             Icons.close,
            //                             color: Colors.white,
            //                           )
            //                         ],
            //                       )),
            //                   Container(
            //                     width: w,
            //                     // height: 227,
            //                     padding: EdgeInsets.all(16),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(5),
            //                       color: Colors.white,
            //                     ),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         TextFormField(
            //                           controller: widget.headController,
            //                           onChanged: (val) {
            //                             setState(() {
            //                               widget.headController =
            //                                   TextEditingController(text: val);
            //                             });
            //                           },
            //                           decoration: InputDecoration(
            //                             hintText: "Technical Information",
            //                             hintStyle: GoogleFonts.roboto(
            //                               color: Colors.black,
            //                               fontSize: w / 24,
            //                               fontWeight: FontWeight.w500,
            //                             ),
            //                             border: OutlineInputBorder(
            //                                 borderRadius:
            //                                 BorderRadius.circular(5),
            //                                 borderSide: BorderSide(
            //                                     color: Color(0xffe6ecf0))),
            //                             focusedBorder: OutlineInputBorder(
            //                                 borderRadius:
            //                                 BorderRadius.circular(5),
            //                                 borderSide: BorderSide(
            //                                     color: Color(0xffe6ecf0))),
            //                             enabledBorder: OutlineInputBorder(
            //                                 borderRadius:
            //                                 BorderRadius.circular(5),
            //                                 borderSide: BorderSide(
            //                                     color: Color(0xffe6ecf0))),
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           height: 20,
            //                         ),
            //                         GradientButton(
            //                             color: ColorPalette.primary,
            //                             onPressed: () {
            //                               Navigator.pop(context);
            //                             },
            //                             gradient: LinearGradient(
            //                                 begin: Alignment.topCenter,
            //                                 end: Alignment.bottomCenter,
            //                                 colors: const [
            //                                   ColorPalette.primary,
            //                                   ColorPalette.primary
            //                                 ]),
            //                             child: Text(
            //                               "Update",
            //                               textAlign: TextAlign.center,
            //                               style: GoogleFonts.roboto(
            //                                 color: Colors.white,
            //                                 fontSize: w / 22,
            //                                 fontWeight: FontWeight.w600,
            //                               ),
            //                             )),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             );
            //           });
            //     },
            //     child: SvgPicture.string(ProductSvg().editIcon))
          ],
        ),
        SizedBox(
          height: 14,
        ),
        customTableTwo(
            border: TableBorder(
              borderRadius: BorderRadius.circular(100),

              verticalInside: BorderSide(
                  color: Color(0xffccdae3), width: 1, style: BorderStyle.solid),
              horizontalInside: BorderSide(
                  color: Color(0xffccdae3), width: 1, style: BorderStyle.solid),

              right: BorderSide(
                  color: Color(0xffccdae3), width: 1, style: BorderStyle.solid),
              left: BorderSide(
                  color: Color(0xffccdae3), width: 1, style: BorderStyle.solid),
              bottom: BorderSide(
                  color: Color(0xffccdae3), width: 1, style: BorderStyle.solid),
            ),
            tableWidth: .5,
            widths: {
              0: const FlexColumnWidth(2),
              1: const FlexColumnWidth(2),
              // 2: const FlexColumnWidth(2),
            },
            childrens: [
              TableRow(children: [
                tableHeadtextTwo(
                   'Technical name',
                  height: 50,
                  size: 13,
                ),
                tableHeadtextTwo(
                  'Details',
                  height: 50,
                  size: 13,
                ),
              ]),
              // if(countList.isNotEmpty)...[
              //   for(var i=0;i<countList.length;i++)

                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child: TextFormField(
                          readOnly: true,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText:
                                 "Ethnic",
                                hintStyle: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 50,
                          child: TextFormField(
                            controller: widget.ethnicController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.isUpdate==true?"":"Enter  name",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child: TextFormField(
                            readOnly: true,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText:
                                "Purpose",
                                hintStyle: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 50,
                          child: TextFormField(
                              cursorColor: Colors.black,
                              controller: widget.purposeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.isUpdate==true?"":"Enter  Purpose",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child:  TextFormField(
                            readOnly: true,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText:
                                "Age Group",
                                hintStyle: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 50,
                          child: TextFormField(
                            controller: widget.ageGroupController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.isUpdate==true?"":"Enter Age group",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child:  TextFormField(
                            readOnly: true,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText:
                                "countries",
                                hintStyle: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 50,
                          child: TextFormField(
                            controller: widget.countryController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.isUpdate==true?"":"Enter country",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child:  TextFormField(
                            readOnly: true,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText:
                                "Gender Group",
                                hintStyle: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: const EdgeInsets.only(left: 5),
                          height: 50,
                          child: TextFormField(
                            controller: widget.genderController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.isUpdate==true?"":"Enter Gender Group",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),


            ]),
        SizedBox(
          height: 5,
        ),
        // GestureDetector(
        //   onTap: () {
        //
        //   },
        //   child: Text(
        //     "+ Add New Raw",
        //     style: GoogleFonts.roboto(
        //       color: ColorPalette.primary,
        //       fontSize: w / 24,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
