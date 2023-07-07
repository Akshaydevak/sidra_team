import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/model/manufacture_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/textfield_tab.dart';
import 'package:cluster/presentation/inventory/widget/inventory_vendor_list_card.dart';
import 'package:cluster/presentation/product_hub/widget/vendor_list_card.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../order_app/order_svg.dart';
import 'other_card.dart';

List<VendorDetails> vendorDetails = [];

class OtherTab extends StatefulWidget {
  final TextEditingController? returnTime;
  final TextEditingController? rePlacementTime;
  final TextEditingController? shelfTime;
  final TextEditingController? variantWeight;
  final TextEditingController? variantWidth;
  final TextEditingController? variantLength;
  final TextEditingController? variantHeight;
  final TextEditingController? grossWeight;
  final TextEditingController? netWeight;
  final TextEditingController? unitCost;
  final TextEditingController? actualCost;
  final TextEditingController? minimumSales;
  final TextEditingController? maximumSales;
  final TextEditingController? vat;
  final TextEditingController? excessTax;
  final TextEditingController? minimumGp;
  final TextEditingController? maximumGp;
  final TextEditingController? averageGp;
  final TextEditingController? targetGp;
  final TextEditingController? videoUrl;
  final Function(String, int)? onChangeSibling;
  final Function(bool) onChangeGift;
  final Function(String)? onChangerReturn;
  final Function(String)? onChangerRefund;
  final Function(String)? onChangerShelf;
  final Function(bool?)? onChangeWrap;
  final Function(bool?)? onChangeSales;
  final String? returnType;
  final String? replacementType;
  final String? shelfType;
  final String? sibling;
  final bool? isGift;
  final bool? isWrap;
  final bool? isSales;

  const OtherTab(
      {Key? key,
        this.onChangeSales,
        this.returnType,
        this.isGift,
        this.isWrap,
        this.isSales,
        this.sibling,
        this.replacementType,
        this.shelfType,
      this.rePlacementTime,
      this.returnTime,
      this.shelfTime,
      this.onChangeSibling,
      this.variantWeight,
      this.variantLength,
      this.variantHeight,
      required this.onChangeGift,
      this.onChangeWrap,
      this.variantWidth,
      this.grossWeight,
      this.netWeight,
      this.unitCost,
      this.actualCost,
      this.minimumGp,
      this.maximumGp,
      this.averageGp,
      this.targetGp,
      this.videoUrl,
      this.minimumSales,
      this.maximumSales,
      this.vat,
      this.excessTax,
      this.onChangerReturn,
      this.onChangerRefund,
      this.onChangerShelf})
      : super(key: key);

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> {
  bool isGift = false;
  bool isWrap = false;
  bool isSales = false;
  bool isNoLogistic = false;
  List<String>? returnList = [];

  String? selectReturnType;
  String? selectReplacementType;
  String? selectShelfType;
  List<InventoryModel>? dataList = [];
  String siblings = "- select -";
  int? isSelect;
  List<ManufactureModel> ManufactureList = [];
  List<TextEditingController> vendorReference = [];
  List<VendorDetails> vendorDetails = [];

// TextEditingController heightController = TextEditingController();
// TextEditingController widthController = TextEditingController();
// TextEditingController weightController = TextEditingController();
// TextEditingController lengthController = TextEditingController();
  @override
  void initState() {
    print("Inside init Method");
    selectReturnType=widget.returnType;
    selectReplacementType=widget.replacementType;
    selectShelfType=widget.shelfType;
    isGift=widget.isGift??false;
    isWrap=widget.isWrap??false;
    isSales=widget.isSales??false;
    siblings=widget.sibling??"";
    context.read<InventoryBloc>().add(const ReturnTypeEvent());
    context.read<InventoryBloc>().add(const GetSiblingEvent());
    context.read<InventoryBloc>().add(const GetManufactureEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is ReturnTypeSuccess) {
          for (int i = 0; i < state.data!.length; i++)
            returnList?.add(state.data?[i] ?? '');
          setState(() {});
          // channelList=state.inventory;
          print(".......return list$returnList");
        }
        if (state is SiblingSuccess) {
          dataList = state.data;
        }
        if (state is ManufacturerSuccess) {
          ManufactureList = state.data ?? [];
          for (int i = 0; i < ManufactureList.length; i++)
            vendorReference.add(TextEditingController());
          // vendorReference.add()
          print("ManufactureList$ManufactureList");
          setState(() {});
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Return Type",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(
                      SellerSvg().validationIcon,
                      height: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0x7f666161)),
                        elevation: 1,
                        underline: Container(),
                        value: selectReturnType,
                        items: returnList?.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.black)),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            widget.onChangerReturn!(value ?? "");
                            selectReturnType = value;
                          });
                        },
                        hint: Text(
                          "Select",
                          style: TextStyle(
                            color: Color(0xbf666161),
                            fontSize: w / 24,
                          ),
                        ))),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.returnTime,
                  keyboardType: TextInputType.number,
                  label: "Return Time",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Replacement Type",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(
                      SellerSvg().validationIcon,
                      height: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0x7f666161)),
                        elevation: 1,
                        underline: Container(),
                        value: selectReplacementType,
                        items: returnList?.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.black)),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            widget.onChangerRefund!(value ?? "");

                            selectReplacementType = value;
                          });
                        },
                        hint: Text(
                          "Select",
                          style: TextStyle(
                            color: Color(0xbf666161),
                            fontSize: w / 24,
                          ),
                        ))),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.rePlacementTime,
                  keyboardType: TextInputType.number,
                  label: "Replacement Time",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Shelf Type",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(
                      SellerSvg().validationIcon,
                      height: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0x7f666161)),
                        elevation: 1,
                        underline: Container(),
                        value: selectShelfType,
                        items: returnList?.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.black)),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            widget.onChangerShelf!(value ?? "");
                            selectShelfType = value;
                          });
                        },
                        hint: Text(
                          "Select",
                          style: TextStyle(
                            color: Color(0xbf666161),
                            fontSize: w / 24,
                          ),
                        ))),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.shelfTime,
                  keyboardType: TextInputType.number,
                  label: "Shelf Time",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Siblings",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(
                      SellerSvg().validationIcon,
                      height: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _showModalBottomSheetSales();
                  },
                  child: Container(
                    width: w,
                    // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //height: 20.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w / 1.3,
                          child: Text(
                            siblings ?? "-  Select  -",
                            style: TextStyle(
                              color: Color(0xbf666161),
                              fontSize: w / 24,
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined,
                            color: Color(0x7f666161))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Vendors",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(
                      SellerSvg().validationIcon,
                      height: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                  if (state is ManufacturerSuccess) {
                    ManufactureList = state.data ?? [];
                    vendorDetails.clear();
                    for (int i = 0; i < ManufactureList.length; i++) {
                      vendorDetails.add(VendorDetails(
                          vendorName: ManufactureList[i].name,
                          vendorCode: ManufactureList[i].code,
                          vendorReferenceCode: ""));
                      vendorReference.add(TextEditingController());
                    }
                    print("vendor details${vendorDetails}");

                    return Container(
                      // height: 100,
                      width: w,
                      child: ListView.separated(
                        itemCount: ManufactureList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print("Hello vendor");
                          return InventoryVendorListCard(
                            name: ManufactureList[index].name ?? "",
                            id: ManufactureList[index].id.toString() ?? "",
                            controller: vendorReference[index],
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 6,
                        ),
                      ),
                    );
                  }
                  return Text("Loading........");
                }),
                // InventoryVendorListCard(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Variant Height",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(SellerSvg().validationIcon, height: 15)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                OtherCard(controller: widget.variantHeight,hint: "CM",),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Variant weight",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(SellerSvg().validationIcon, height: 15)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                OtherCard(controller: widget.variantWeight,hint: "KG",),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Variant width",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(SellerSvg().validationIcon, height: 15)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                OtherCard(controller: widget.variantWidth,hint: "CM"),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Variant Length",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.string(SellerSvg().validationIcon, height: 15)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                OtherCard(
                  controller: widget.variantLength,hint: "CM",
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xffE6ECF0),
            thickness: 1.1,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          isGift = !isGift;
                          setState(() {
                            widget.onChangeGift(isGift);

                          });
                        },
                        child: isGift
                            ? Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxActiveIcon))
                            : Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxIcon))),
                    Container(
                      width: w / 1.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gift option available",
                            style: TextStyle(
                              color: ColorPalette.black,
                              fontWeight: FontWeight.w500,
                              fontSize: w / 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 24,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          isSales = !isSales;
                          setState(() {
                            widget.onChangeSales!(isSales);

                          });
                        },
                        child: isSales
                            ? Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxActiveIcon))
                            : Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxIcon))),
                    Container(
                      width: w / 1.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sales Block",
                            style: TextStyle(
                              color: ColorPalette.black,
                              fontWeight: FontWeight.w500,
                              fontSize: w / 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 24,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          isWrap = !isWrap;
                          setState(() {
                            widget.onChangeWrap!(isWrap);

                          });
                        },
                        child: isWrap
                            ? Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxActiveIcon))
                            : Container(
                                padding: EdgeInsets.only(right: 10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxIcon))),
                    Container(
                      width: w / 1.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wrap option available",
                            style: TextStyle(
                                color: ColorPalette.black,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 24,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE6ECF0),
            thickness: 1.1,
          ),
          // SizedBox(height: 10,),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Choose Logistic Details",
          //         style: GoogleFonts.roboto(
          //           color: Colors.black,
          //           fontSize: w/24,
          //
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       SizedBox(height: 16,),
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: (){
          //               setState(() {
          //
          //                 isNoLogistic=true;
          //               });
          //             },
          //               child:isNoLogistic?  SvgPicture.string(HomeSvg().radioButtonActive): SvgPicture.string(HomeSvg().radioInActive)),
          //           SizedBox(width: 10,),
          //           Text(
          //             "Ship by myself",
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: w/24,
          //             ),
          //           )
          //         ],
          //       ),
          //       SizedBox(height: 16,),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           GestureDetector(
          //             onTap: (){
          //               setState(() {
          //
          //                 isNoLogistic=false;
          //               });
          //             },
          //               child:isNoLogistic?  SvgPicture.string(HomeSvg().radioInActive): SvgPicture.string(HomeSvg().radioButtonActive)),
          //           SizedBox(width: 10,),
          //           Container(
          //             width: w/1.25,
          //             child: Text(
          //               "I dont have any logistic option. So i need cluster logistic option ",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: w/24,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //
          //     ],
          //   ),
          // ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.grossWeight,
                  keyboardType: TextInputType.text,
                  label: "Gross Weight",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.netWeight,
                  keyboardType: TextInputType.text,
                  label: "Net Weight",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.unitCost,
                  keyboardType: TextInputType.number,
                  label: "Unit Cost",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),TextFieldTab(
                  controller: widget.actualCost,
                  label: "Actual Cost",
                  hint: "",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  controller: widget.minimumSales,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  label: "min sales order limit",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.maximumSales,
                  label: "Max sales order limit",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  controller: widget.vat,
                  label: "Vat",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.excessTax,
                  label: "Excess Tax",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.minimumGp,
                  label: "Minimum GP",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.maximumGp,
                  label: "maximum GP",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.averageGp,
                  label: "average GP",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: widget.targetGp,
                  label: "targeted GP",
                  hint: "",
                ),
                SizedBox(
                  height: 16,
                ),
                TextFieldTab(
                  keyboardType: TextInputType.text,
                  controller: widget.videoUrl,
                  label: "Video Url",
                  hint: "",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  _showModalBottomSheetSales() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: w,
                          padding: EdgeInsets.only(right: 10, top: 10),
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Siblings",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      stateSetter(() {
                                        widget.onChangeSibling!(
                                            dataList?[index].name ?? "",
                                            dataList?[index].id ?? 0);
                                        siblings = dataList?[index].name ?? "";
                                        isSelect = index;
                                      });
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: isSelect == index
                                        ? Container(
                                            // padding: EdgeInsets.all(10),
                                            child: SvgPicture.string(
                                                OrderSvg().checkBoxActiveIcon))
                                        : SvgPicture.string(
                                            OrderSvg().checkBoxIcon,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: w / 1.2,
                                      child: Text(dataList?[index].name ?? ""))
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: dataList!.length),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
