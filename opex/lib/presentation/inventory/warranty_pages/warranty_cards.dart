import 'package:cluster/presentation/inventory/model/division_model.dart';
import 'package:cluster/presentation/promotion_app/dropdown_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../promotion_app/buy_more_get_form/costumtable.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';

class WarrantyCardInventory extends StatefulWidget {
  String? label;
  final bool? edit;
   List<AdditionalWarrantyList> additionalRead=[];
  final Function(List<WarrantyDetailsModel>) addditionalList;
  WarrantyCardInventory({Key? key, this.label, required this.addditionalList, required this.additionalRead, this.edit}) : super(key: key);

  @override
  State<WarrantyCardInventory> createState() => _WarrantyCardInventoryState();
}

class _WarrantyCardInventoryState extends State<WarrantyCardInventory> {
  bool isExpand = false;
  bool isExpandRead = false;
  List<ConditionList> termsList = [];
  List<List<ConditionList>> passList=[[]];
  List<TextEditingController> termsListController = [];
  TextEditingController termsControllr = TextEditingController();
  bool? onChangeVal = false;
  TextEditingController additionalDescription = TextEditingController();
  TextEditingController additionalDuration = TextEditingController();
  TextEditingController additionalWarrantySection = TextEditingController();
  TextEditingController additionalmaximumOccurance = TextEditingController();
  List<WarrantyDetailsModel> additional = [];
  readData(){
    for(var i=0;i<widget.additionalRead!.length;i++){
      additional.add(WarrantyDetailsModel(description: widget.additionalRead?[i].description));
      setState(() {

      });
      // termsList.add(ConditionList(
      //     title: readWarrantyData!.warrantyCoditions?[i].title,
      //     id: readWarrantyData!.warrantyCoditions?[i].id));
      // termsListController.add(TextEditingController(text: readWarrantyData!.warrantyCoditions?[i].title));
    }
  }
  @override
  Widget build(BuildContext context) {
    readData();
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additional.isNotEmpty) ...[

            for (var i = 0; i < additional.length; i++)

              Container(
                  width: w,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.all(14.0),
                  margin: EdgeInsets.only(bottom: 5),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            additional[i].description ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                          // Icon(Icons.keyboard_arrow_down_outlined),
                          // GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         isExpandRead = !isExpandRead;
                          //       });
                          //     },
                          //     child: isExpandRead
                          //         ? Icon(
                          //       Icons.remove,
                          //       color: ColorPalette.primary,
                          //     )
                          //         : Icon(Icons.add))
                        ],
                      ),
                      // isExpandRead?
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     SizedBox(
                      //       height: 10,
                      //     ),
                      //     TextFieldTab(
                      //       label: "Description",
                      //       hint: "Eg. SEM",
                      //       controller: additionalDescription,
                      //     ),
                      //     SizedBox(
                      //       height: 16,
                      //     ),
                      //     TextFormReusable(
                      //       hint: "Eg. Lorem ipsum dolar sit amet.",
                      //       label: "Duration",
                      //       controller: additionalDuration,
                      //     ),
                      //     SizedBox(
                      //       height: 16,
                      //     ),
                      //     TextFormReusable(
                      //       hint: "Eg. Lorem ipsum dolar sit amet.",
                      //       label: "Warranty Section",
                      //       controller: additionalWarrantySection,
                      //     ),
                      //     SizedBox(
                      //       height: 16,
                      //     ),
                      //     TextFieldTab(
                      //       label: "Maximum Occurrence",
                      //       hint: "Eg. SEM",
                      //       controller: additionalmaximumOccurance,
                      //     ),
                      //     SizedBox(
                      //       height: 16,
                      //     ),
                      //     Text(
                      //       "Warranty Parts",
                      //       style: GoogleFonts.roboto(
                      //         color: Colors.black,
                      //         fontSize: w / 24,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 14,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius:
                      //           BorderRadius.only(topLeft: Radius.circular(20))),
                      //       width: w,
                      //       child: customTableTwo(
                      //         border: TableBorder(
                      //           borderRadius: BorderRadius.circular(100),
                      //
                      //           verticalInside: BorderSide(
                      //               color: Color(0xffccdae3),
                      //               width: 1,
                      //               style: BorderStyle.solid),
                      //           horizontalInside: const BorderSide(
                      //               color: Color(0xffccdae3),
                      //               width: 1,
                      //               style: BorderStyle.solid),
                      //           // top: BorderSide(color: Color(0xffccdae3),width: 1,
                      //           //     style:
                      //           //     BorderStyle.solid),
                      //           right: const BorderSide(
                      //               color: Color(0xffccdae3),
                      //               width: 1,
                      //               style: BorderStyle.solid),
                      //           left: const BorderSide(
                      //               color: Color(0xffccdae3),
                      //               width: 1,
                      //               style: BorderStyle.solid),
                      //           bottom: const BorderSide(
                      //               color: Color(0xffccdae3),
                      //               width: 1,
                      //               style: BorderStyle.solid),
                      //         ),
                      //         tableWidth: .5,
                      //         widths: {
                      //           0: const FlexColumnWidth(5),
                      //           1: const FlexColumnWidth(1),
                      //         },
                      //         childrens: [
                      //           TableRow(children: [
                      //             tableHeadtextTwo(
                      //               'Data',
                      //               height: 50,
                      //               size: 13,
                      //             ),
                      //             tableHeadtextTwo(
                      //               '',
                      //               height: 50,
                      //               size: 13,
                      //             ),
                      //           ]),
                      //           if (termsList.isNotEmpty) ...[
                      //             for (var i = 0; i < termsList.length; i++)
                      //               TableRow(children: [
                      //                 TableCell(
                      //                   verticalAlignment:
                      //                   TableCellVerticalAlignment.middle,
                      //                   child: Container(
                      //                     padding: const EdgeInsets.all(5),
                      //                     height: 50,
                      //                     child: TextFormField(
                      //                       controller: termsListController[i],
                      //                       onChanged: (va) {
                      //                         onChangeVal = true;
                      //                         termsList[i] = ConditionList(
                      //                             data: termsListController[i].text);
                      //                         print("term$termsList");
                      //                         print("ters${termsControllr.text}");
                      //                         setState(() {});
                      //                       },
                      //                       // inputFormatters: [
                      //                       //   FilteringTextInputFormatter.digitsOnly,],
                      //                       // keyboardType: TextInputType.number,
                      //                       decoration: InputDecoration(
                      //                           fillColor: const Color(0xfff9f9f9),
                      //                           filled: true,
                      //                           border: OutlineInputBorder(
                      //                               borderRadius:
                      //                               BorderRadius.circular(8),
                      //                               borderSide: const BorderSide(
                      //                                   color: Color(0xffccdae3),
                      //                                   width: 1)),
                      //                           enabledBorder: OutlineInputBorder(
                      //                               borderRadius:
                      //                               BorderRadius.circular(8),
                      //                               borderSide: const BorderSide(
                      //                                   color: Color(0xffccdae3),
                      //                                   width: 1)),
                      //                           focusedBorder: OutlineInputBorder(
                      //                               borderRadius:
                      //                               BorderRadius.circular(8),
                      //                               borderSide: const BorderSide(
                      //                                   color: Color(0xffccdae3),
                      //                                   width: 1)),
                      //                           contentPadding:
                      //                           const EdgeInsets.only(left: 10)),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 TableCell(
                      //                     verticalAlignment:
                      //                     TableCellVerticalAlignment.middle,
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: TextButton(
                      //                           onPressed: () {
                      //                             print("index delete $i");
                      //                             print(
                      //                                 "index delete ${termsList[i]}");
                      //
                      //                             termsList.removeAt(i);
                      //                             termsListController.removeAt(i);
                      //                             print("index delete $termsList");
                      //                             setState(() {});
                      //                           },
                      //                           style: TextButton.styleFrom(
                      //                               foregroundColor: Colors.white,
                      //                               backgroundColor: ColorPalette
                      //                                   .primary // Text Color
                      //                           ),
                      //                           child: Icon(Icons.delete)),
                      //                     )),
                      //               ]),
                      //           ],
                      //           TableRow(children: [
                      //             TableCell(
                      //               verticalAlignment:
                      //               TableCellVerticalAlignment.middle,
                      //               child: Container(
                      //                 padding: EdgeInsets.all(5),
                      //                 height: 50,
                      //                 child: TextFormField(
                      //                   controller: termsControllr,
                      //                   decoration: InputDecoration(
                      //                       fillColor: Color(0xfff9f9f9),
                      //                       filled: true,
                      //                       border: OutlineInputBorder(
                      //                           borderRadius:
                      //                           BorderRadius.circular(8),
                      //                           borderSide: const BorderSide(
                      //                               color: Color(0xffccdae3),
                      //                               width: 1)),
                      //                       enabledBorder: OutlineInputBorder(
                      //                           borderRadius:
                      //                           BorderRadius.circular(8),
                      //                           borderSide: const BorderSide(
                      //                               color: Color(0xffccdae3),
                      //                               width: 1)),
                      //                       focusedBorder: OutlineInputBorder(
                      //                           borderRadius:
                      //                           BorderRadius.circular(8),
                      //                           borderSide: BorderSide(
                      //                               color: Color(0xffccdae3),
                      //                               width: 1)),
                      //                       contentPadding:
                      //                       EdgeInsets.only(left: 10)),
                      //                 ),
                      //               ),
                      //             ),
                      //             TableCell(
                      //                 verticalAlignment:
                      //                 TableCellVerticalAlignment.middle,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: TextButton(
                      //                       onPressed: () {
                      //                         termsList.add(ConditionList(id: null,isActive: true,
                      //                             data: termsControllr.text));
                      //
                      //                         print("addddddd length ${additional.length}");
                      //                         // for(var i=0;i<=additional.length;i++){
                      //                         passList[additional.length].add(ConditionList(id: null,isActive: true,
                      //                             data: termsControllr.text));
                      //                         // for(var j=0;j<termsList.length;j++) {
                      //                         //   print(
                      //                         //       "termsss list at plus buttoon ${termsList[i]
                      //                         //           .data}");
                      //                         //
                      //                         //   // passList[i].add(termsList[j]);
                      //                         // }
                      //                         // }
                      //
                      //
                      //
                      //                         termsListController.add(
                      //                             TextEditingController(
                      //                                 text: termsControllr.text));
                      //
                      //                         print("termsList$termsList");
                      //                         print(
                      //                             "termsList$passList");
                      //
                      //                         setState(() {
                      //                           termsControllr.clear();
                      //                         });
                      //                       },
                      //                       style: TextButton.styleFrom(
                      //                           foregroundColor: Colors.white,
                      //                           backgroundColor:
                      //                           ColorPalette.primary // Text Color
                      //                       ),
                      //                       child: Icon(Icons.add)),
                      //                 )),
                      //           ]),
                      //         ],
                      //       ),
                      //     ),
                      //     // GestureDetector(
                      //     //   onTap: (){
                      //     //     passList.add(termsList);
                      //     //   },
                      //     //   child: Text("ADD TO LIST",
                      //     //     style: GoogleFonts.roboto(
                      //     //       color: Colors.red,
                      //     //       fontSize: 18,
                      //     //       fontWeight: FontWeight.w600,
                      //     //     ),),
                      //     // ),
                      //     Container(
                      //       padding: EdgeInsets.all(16),
                      //       child: GradientButton(
                      //           onPressed: () { passList.add([]);
                      //           print("LIST TERMS$termsList");
                      //
                      //           // for(int i=0;i<passList.length;i++){
                      //           additional.add(WarrantyDetailsModel(
                      //             warrantySection: additionalWarrantySection.text,
                      //             duration: int.tryParse(additionalDuration.text),
                      //             maximumOccurence: double.tryParse(
                      //                 additionalmaximumOccurance.text),
                      //             description: additionalDescription.text,
                      //             isActive: true,
                      //             conditionList: passList[additional.length],
                      //             id: null,
                      //           ));
                      //           // }
                      //           // for(var i=0;i<additional.length;i++){
                      //           // for(var j=0;j<termsList.length;j++) {
                      //           //   print("termsss list at save button${additional[i].conditionList?[j].data}");
                      //           //   print("termsss list at save button${additional[i].description}");
                      //           // }
                      //           // }
                      //
                      //           widget.addditionalList(additional);
                      //           additionalWarrantySection.clear();
                      //           additionalDuration.clear();
                      //           additionalmaximumOccurance.clear();
                      //           additionalDescription.clear();
                      //           isExpand=false;
                      //           // termsList.clear();
                      //           // termsControllr.clear();
                      //           // termsListController.clear();
                      //           setState(() {});
                      //
                      //           print("DATA$additional");
                      //           },
                      //           gradient: const LinearGradient(
                      //             colors: [
                      //               ColorPalette.primary,
                      //               ColorPalette.primary,
                      //             ],
                      //             begin: Alignment.topCenter,
                      //             end: Alignment.bottomCenter,
                      //           ),
                      //           color: ColorPalette.primary,
                      //           child: Text(
                      //             "Save",
                      //             textAlign: TextAlign.center,
                      //             style: GoogleFonts.roboto(
                      //               color: Colors.white,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           )),
                      //     ),
                      //   ],
                      // ):Container()
                    ],
                  ),

              ),


          ],
          SizedBox(height: 30,),
          widget.edit==true?Container():Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label ?? "ADDITIONAL WARRANTY",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpand = !isExpand;
                      termsList.clear();
                      termsControllr.clear();
                      termsListController.clear();
                    });
                  },
                  child: isExpand
                      ? Icon(
                          Icons.remove,
                          color: ColorPalette.primary,
                        )
                      : Icon(Icons.add))
            ],
          ),
          isExpand
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldTab(
                      label: "Description",
                      hint: "Eg. SEM",
                      controller: additionalDescription,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Duration",
                      controller: additionalDuration,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Warranty Section",
                      controller: additionalWarrantySection,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFieldTab(
                      label: "Maximum Occurrence",
                      hint: "Eg. SEM",
                      controller: additionalmaximumOccurance,
                    ),
                    SizedBox(
                      height: 16,
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
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                      width: w,
                      child: customTableTwo(
                        border: TableBorder(
                          borderRadius: BorderRadius.circular(100),

                          verticalInside: BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          horizontalInside: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          // top: BorderSide(color: Color(0xffccdae3),width: 1,
                          //     style:
                          //     BorderStyle.solid),
                          right: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          left: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          bottom: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        tableWidth: .5,
                        widths: {
                          0: const FlexColumnWidth(5),
                          1: const FlexColumnWidth(1),
                        },
                        childrens: [
                          TableRow(children: [
                            tableHeadtextTwo(
                              'Data',
                              height: 50,
                              size: 13,
                            ),
                            tableHeadtextTwo(
                              '',
                              height: 50,
                              size: 13,
                            ),
                          ]),
                          if (termsList.isNotEmpty) ...[
                            for (var i = 0; i < termsList.length; i++)
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 50,
                                    child: TextFormField(
                                      controller: termsListController[i],
                                      onChanged: (va) {
                                        onChangeVal = true;
                                        termsList[i] = ConditionList(
                                            data: termsListController[i].text);
                                        print("term$termsList");
                                        print("ters${termsControllr.text}");
                                        setState(() {});
                                      },
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,],
                                      // keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          fillColor: const Color(0xfff9f9f9),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          contentPadding:
                                              const EdgeInsets.only(left: 10)),
                                    ),
                                  ),
                                ),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                          onPressed: () {
                                            print("index delete $i");
                                            print(
                                                "index delete ${termsList[i]}");

                                            termsList.removeAt(i);
                                            termsListController.removeAt(i);
                                            print("index delete $termsList");
                                            setState(() {});
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: ColorPalette
                                                  .primary // Text Color
                                              ),
                                          child: Icon(Icons.delete)),
                                    )),
                              ]),
                          ],
                          TableRow(children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                child: TextFormField(
                                  controller: termsControllr,
                                  decoration: InputDecoration(
                                      fillColor: Color(0xfff9f9f9),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      contentPadding:
                                          EdgeInsets.only(left: 10)),
                                ),
                              ),
                            ),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {
                                        termsList.add(ConditionList(id: null,isActive: true,
                                            data: termsControllr.text));

                                        print("addddddd length ${additional.length}");
                                        // for(var i=0;i<=additional.length;i++){
                                          passList[additional.length].add(ConditionList(id: null,isActive: true,
                                              data: termsControllr.text));
                                          // for(var j=0;j<termsList.length;j++) {
                                        //   print(
                                        //       "termsss list at plus buttoon ${termsList[i]
                                        //           .data}");
                                        //
                                        //   // passList[i].add(termsList[j]);
                                        // }
                                        // }



                                        termsListController.add(
                                            TextEditingController(
                                                text: termsControllr.text));

                                        print("termsList$termsList");
                                        print(
                                            "termsList$passList");

                                        setState(() {
                                          termsControllr.clear();
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              ColorPalette.primary // Text Color
                                          ),
                                      child: Icon(Icons.add)),
                                )),
                          ]),
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     passList.add(termsList);
                    //   },
                    //   child: Text("ADD TO LIST",
                    //     style: GoogleFonts.roboto(
                    //       color: Colors.red,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //     ),),
                    // ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: GradientButton(
                          onPressed: () { passList.add([]);
                            print("LIST TERMS$termsList");

                            // for(int i=0;i<passList.length;i++){
                              additional.add(WarrantyDetailsModel(
                                warrantySection: additionalWarrantySection.text,
                                duration: int.tryParse(additionalDuration.text),
                                maximumOccurence: double.tryParse(
                                    additionalmaximumOccurance.text),
                                description: additionalDescription.text,
                                isActive: true,
                                conditionList: passList[additional.length],
                                id: null,
                              ));
                            // }
                            // for(var i=0;i<additional.length;i++){
                            // for(var j=0;j<termsList.length;j++) {
                            //   print("termsss list at save button${additional[i].conditionList?[j].data}");
                            //   print("termsss list at save button${additional[i].description}");
                            // }
                            // }

                            widget.addditionalList(additional);
                            additionalWarrantySection.clear();
                            additionalDuration.clear();
                            additionalmaximumOccurance.clear();
                            additionalDescription.clear();
                            isExpand=false;
                            // termsList.clear();
                            // termsControllr.clear();
                            // termsListController.clear();
                            setState(() {});

                            print("DATA$additional");
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
                )
              : Container(),
        ],
      ),
    );
  }
}

//exWarranty
class ExtendedWarrantyCardInventory extends StatefulWidget {
  String? label;
  final bool? edit;
  final ExtendedWarrantyList? exList;
  final Function(List<WarrantyDetailsModel>) extendedData;
  ExtendedWarrantyCardInventory({Key? key, this.label, required this.extendedData, this.exList, this.edit}) : super(key: key);

  @override
  State<ExtendedWarrantyCardInventory> createState() =>
      _ExtendedWarrantyCardInventoryState();
}

class _ExtendedWarrantyCardInventoryState
    extends State<ExtendedWarrantyCardInventory> {
  bool isExpand = false;
  List<ConditionList> termsList = [];
  List<TextEditingController> termsListController = [];
  TextEditingController termsControllr = TextEditingController();
  bool? onChangeVal = false;
  TextEditingController extendedDescription = TextEditingController();
  TextEditingController extendedDuration = TextEditingController();
  TextEditingController extendedPrice = TextEditingController();
  TextEditingController extendedmaximumOccurance = TextEditingController();

  readData(){
    extendedDescription.text=widget.exList?.description??"";
    extendedDuration.text=widget.exList?.duration.toString()??"";
    extendedPrice.text=widget.exList?.price.toString()??"";
    extendedmaximumOccurance.text=widget.exList?.maxOccurance.toString()??"";
    isExpand=true;
    for(int i=0;i<widget.exList!.condition!.length;i++){
      termsList.add(ConditionList(
          title: widget.exList!.condition?[i].title,
          id: widget.exList!.condition?[i].id));
      termsListController.add(TextEditingController(text: widget.exList!.condition?[i].title));
    }
  }

  @override
  Widget build(BuildContext context) {
    readData();
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label ?? "ADDITIONAL WARRANTY",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpand = !isExpand;
                    });
                  },
                  child: isExpand
                      ? Icon(
                          Icons.remove,
                          color: ColorPalette.primary,
                        )
                      : Icon(Icons.add))
            ],
          ),
          isExpand
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldTab(
                      label: "Ex-Description",
                      hint: "Eg. SEM",
                      controller: extendedDescription,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Ex-Duration",
                      controller: extendedDuration,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Price",
                      controller: extendedPrice,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Maximum Occurence",
                      controller: extendedmaximumOccurance,
                    ),
                    SizedBox(
                      height: 16,
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
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                      width: w,
                      child: customTableTwo(
                        border: TableBorder(
                          borderRadius: BorderRadius.circular(100),

                          verticalInside: BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          horizontalInside: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          // top: BorderSide(color: Color(0xffccdae3),width: 1,
                          //     style:
                          //     BorderStyle.solid),
                          right: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          left: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                          bottom: const BorderSide(
                              color: Color(0xffccdae3),
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        tableWidth: .5,
                        widths: {
                          0: const FlexColumnWidth(5),
                          1: const FlexColumnWidth(1),
                        },
                        childrens: [
                          TableRow(children: [
                            tableHeadtextTwo(
                              'Data',
                              height: 50,
                              size: 13,
                            ),
                            tableHeadtextTwo(
                              '',
                              height: 50,
                              size: 13,
                            ),
                          ]),
                          if (termsList.isNotEmpty) ...[
                            for (var i = 0; i < termsList.length; i++)
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 50,
                                    child: TextFormField(
                                      controller: termsListController[i],
                                      onChanged: (va) {
                                        onChangeVal = true;
                                        termsList[i] = ConditionList(
                                            data: termsListController[i].text);
                                        print("term$termsList");
                                        print("ters${termsControllr.text}");
                                        setState(() {});
                                      },
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,],
                                      // keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          fillColor: const Color(0xfff9f9f9),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Color(0xffccdae3),
                                                  width: 1)),
                                          contentPadding:
                                              const EdgeInsets.only(left: 10)),
                                    ),
                                  ),
                                ),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: widget.edit==true?Container():Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                          onPressed: () {
                                            print("index delete $i");
                                            print(
                                                "index delete ${termsList[i]}");

                                            termsList.removeAt(i);
                                            termsListController.removeAt(i);
                                            print("index delete $termsList");
                                            setState(() {});
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: ColorPalette
                                                  .primary // Text Color
                                              ),
                                          child: Icon(Icons.delete)),
                                    )),
                              ]),
                          ],
                          TableRow(children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: widget.edit==true?Container():Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                child: TextFormField(
                                  controller: termsControllr,
                                  decoration: InputDecoration(
                                      fillColor: Color(0xfff9f9f9),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color(0xffccdae3),
                                              width: 1)),
                                      contentPadding:
                                          EdgeInsets.only(left: 10)),
                                ),
                              ),
                            ),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: widget.edit==true?Container():Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {

                                        termsList.add(ConditionList(
                                            id: null,isActive: true,
                                            data: termsControllr.text));
                                        termsListController.add(
                                            TextEditingController(
                                                text: termsControllr.text));
                                        print("termsList$termsList");
                                        print(
                                            "termsList${termsControllr.text}");

                                        setState(() {
                                          termsControllr.clear();
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              ColorPalette.primary // Text Color
                                          ),
                                      child: Icon(Icons.add)),
                                )),
                          ]),
                        ],
                      ),
                    ),
                    widget.edit==true?Container():Container(
                      padding: EdgeInsets.all(16),
                      child: GradientButton(
                          onPressed: () {
                            List<WarrantyDetailsModel> additional = [];
                            print("TERRRR$termsList");
                            additional.add(WarrantyDetailsModel(
                                exConditionList: termsList,
                                exdescription: extendedDescription.text ?? "",
                                exDuration: int.tryParse(extendedDuration.text),
                                exIsActive: true,
                                isExtendedWarraty: true,
                            price: double.tryParse(extendedPrice.text),
                            maximumOccurence: double.tryParse(extendedmaximumOccurance.text)));
                            widget.extendedData(additional);
                            extendedDescription.clear();
                            extendedDuration.clear();
                            extendedmaximumOccurance.clear();
                            extendedPrice.clear();
                            // termsList.clear();
                            // termsControllr.clear();
                            // termsListController.clear();


                            setState(() {

                            });
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
                )
              : Container(),
        ],
      ),
    );
  }
}
