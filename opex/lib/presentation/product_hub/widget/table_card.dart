import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/variations_tab.dart';
import 'package:cluster/presentation/promotion_app/buy_more_get_form/costumtable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../mpos/mpos_svg.dart';
import '../product_svg.dart';

class TableCard extends StatefulWidget {
  TextEditingController? headController;
  List<TextEditingController> keyController = [];
  List<TextEditingController> valueController = [];
  final String? title1, title2, content1, content2;

  TableCard(
      {Key? key,
        this.content1,
        this.content2,
        this.title1,
        this.title2,
        this.headController,required this.valueController,required this.keyController,})
      : super(key: key);

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  TextEditingController headController = TextEditingController();
  // List<TextEditingController> keyController = [];
  // List<TextEditingController> valueController = [];
  int count = 1;

  // Abouttheproducts? aboutProduct;
  // List<KeyValues> keyValue = [];

  onAdd() {

    widget.keyController.add(TextEditingController());
    widget.valueController.add(TextEditingController());
    setState(() {
      count++;

    });
  }

  @override
  void initState() {

    // headController = TextEditingController(
    //   text: widget.head,
    // );
    // widget.keyController.clear();
    // widget.valueController.clear();

    // for (int i = 0; i < widget.keyController.length; i++) {

    widget.keyController.add(TextEditingController());
    widget.valueController.add(TextEditingController());
    // }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.keyController.isNotEmpty){
      print("inside builder");
      count=widget.keyController.length;}
    // print("additional Info addddd ${widget.keyController[0].text}");
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
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  width: w,
                                  height: 53,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    color: Color(0xff4c4c4c),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Edit Info",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                              Container(
                                width: w,
                                // height: 227,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: widget.headController,
                                      onChanged: (val) {
                                        setState(() {
                                          widget.headController =
                                              TextEditingController(text: val);
                                          aboutProduct = Abouttheproducts(
                                              name: widget.headController?.text);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Table Name",
                                        hintStyle: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GradientButton(
                                        color: ColorPalette.primary,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: const [
                                              ColorPalette.primary,
                                              ColorPalette.primary
                                            ]),
                                        child: Text(
                                          "Update",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: SvgPicture.string(ProductSvg().editIcon))
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
                  widget.title1 ?? 'Technical name',
                  height: 50,
                  size: 13,
                ),
                tableHeadtextTwo(
                  widget.title2 ?? 'Details',
                  height: 50,
                  size: 13,
                ),
              ]),
              // if(countList.isNotEmpty)...[
              //   for(var i=0;i<countList.length;i++)
              if (count != 0) ...[
                for (var i = 0; i < count; i++)
                // keyController[i].add(TextEditingController());
                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child: TextFormField(
                            controller:widget. keyController[i],
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            onChanged: (val) {
                              // keyController[i] =
                              //     TextEditingController(text: val);

                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText: widget.content1 ?? "Enter  name",
                                hintStyle: TextStyle(
                                  color: Color(0x7f666161),
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
                              controller: widget.valueController[i],
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              onChanged: (val) {
                                // valueController[i]
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: widget.content2 ?? "Enter  name",
                                  hintStyle: TextStyle(
                                    color: Color(0x7f666161),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none)),
                        )),
                  ]),
              ],
            ]),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            onAdd();
          },
          child: Text(
            "+ Add New Raw",
            style: GoogleFonts.roboto(
              color: ColorPalette.primary,
              fontSize: w / 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}

class SingleTableCard extends StatefulWidget {
  final String? title, content, head;
  TextEditingController? headController;
  List<TextEditingController>? nameController ;
  // ReadVariantModel? variantList;
  SingleTableCard({Key? key, this.content, this.title, this.head, this.headController, this.nameController})
      : super(key: key);

  @override
  State<SingleTableCard> createState() => _SingleTableCardState();
}

class _SingleTableCardState extends State<SingleTableCard> {
  int count = 1;
  onAdd() {
    widget.nameController?.add(TextEditingController());
    setState(() {
      count++;
    });

  }

  @override
  void initState() {
    print("Inside init");
    print("Storage name controller ${widget.nameController?.length}");

    // if(widget.nameController!.isNotEmpty){
    //   print("Inside Condition");
    //   count=widget.nameController!.length;
    //   // print("inside init${widget.nameController?[0].text}");
    //   // for(var i=0;i<widget.nameController!.length;i++) {
    //   //   widget.nameController?.add(TextEditingController());
    //   // }
    // }
    // else{
    count=1;
    widget.nameController?.add(TextEditingController());

    // }
    // print("................. controller${widget.nameController}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("inside build${widget.nameController?.length}");
    if(widget.nameController!.isNotEmpty){
      count=widget.nameController!.length;}
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
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  width: w,
                                  height: 53,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    color: Color(0xff4c4c4c),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Edit Info",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                              Container(
                                width: w,
                                // height: 227,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: widget.headController,
                                      onChanged: (val) {
                                        setState(() {
                                          widget.headController =
                                              TextEditingController(text: val);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Table Name",
                                        hintStyle: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xffe6ecf0))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GradientButton(
                                        color: ColorPalette.primary,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: const [
                                              ColorPalette.primary,
                                              ColorPalette.primary
                                            ]),
                                        child: Text(
                                          "Update",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: SvgPicture.string(ProductSvg().editIcon))
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
                  widget.title ?? 'Technical name',
                  height: 50,
                  size: 13,
                ),
              ]),
              // if(countList.isNotEmpty)...[
              //   for(var i=0;i<countList.length;i++)
              if (count != 0) ...[
                for (var i = 0; i < count; i++)
                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        height: 50,
                        child: TextFormField(
                            cursorColor: Colors.black,
                            controller: widget.nameController?[i],
                            onChanged: (val) {
                              print("Value: $val");
                              // value.setAll(
                              //     i, [Name(name: widget.nameController[i].text)]);

                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                hintText: widget.content ?? "Enter  name",
                                hintStyle: TextStyle(
                                  color: Color(0x7f666161),
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none)),
                      ),
                    ),
                  ]),
              ],
            ]),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            onAdd();
          },
          child: Text(
            "+ Add New Raw",
            style: GoogleFonts.roboto(
              color: ColorPalette.primary,
              fontSize: w / 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
