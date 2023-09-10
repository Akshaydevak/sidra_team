import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/textfield_tab.dart';
import 'package:cluster/presentation/seller_app/select_variant_framework_page.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_app/order_svg.dart';
import '../task_operation/task_svg.dart';

class CreateTab extends StatefulWidget {
  final TextEditingController? varientName;
  final TextEditingController? searchName;
  final TextEditingController? displayName;
  final TextEditingController? posName;
  final TextEditingController? description;
  final TextEditingController? arabicDescription;
  final TextEditingController? additionalDescription;
  final TextEditingController? oldSystemCode;
  final TextEditingController? identification;
  final TextEditingController? barCode;
  final TextEditingController? producedCountry;
  final Function(String)? onChangeBaseUom;
  final Function(String,int)? onChangeSalesUom;
  final Function(String,int)? onChangeChannel;
  final int? id;
  final BaseUomData? variantModel;
  final String ?sales;
  final String ?channel;


  CreateTab(
      {Key? key,
        this.sales,
        this.channel,
        this.id,
        this.variantModel,
        this.varientName,
        this.searchName,
        this.posName,
        this.displayName,
        this.description,
        this.arabicDescription,
        this.additionalDescription,
        this.oldSystemCode,
        this.identification,
        this.barCode,
        this.producedCountry,
        this.onChangeBaseUom,
        this.onChangeSalesUom,
        this.onChangeChannel})
      : super(key: key);

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  int? isSelect;
  int? isSelectSales;
  bool isActive = false;
  List<InventoryModel>? uomList = [];
  List<InventoryModel>? channelList = [];
  List<String>? channelIdList = [];
  String? selectChannel;
  String base = "";
  String sales = "";

  // TextEditingController varientNameController=TextEditingController();
  // TextEditingController searchNameController=TextEditingController();
  // TextEditingController displayNameController=TextEditingController();
  // TextEditingController discriptionController=TextEditingController();
  @override
  void initState() {
    print("id ${widget.id}");
    sales=widget.sales??"";
    // selectChannel=widget.channel??"";
    context.read<InventoryBloc>().add(GetSalesUomEvent(id: widget.variantModel?.uomId));
    context.read<InventoryBloc>().add(GetChannelEvent());
    // TODO: implement initState
    super.initState();
  }

  FocusNode currentFocus = FocusNode();
  FocusNode searchFocus = FocusNode();
  FocusNode displayFocus = FocusNode();
  FocusNode posFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode arabicDescriptionFocus = FocusNode();
  FocusNode additionalDescriptionFocus = FocusNode();
  FocusNode oldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Container(
      // padding: EdgeInsets.all(16),
      child: BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is GetUomSuccess) {
              uomList = state.inventory;
            }
            if (state is ChannelSuccess) {
              // for (int i = 0; i < state.inventory!.length; i++){
              channelList=state.inventory;

              // }
              setState(() {});
              // channelList=state.inventory;
              print(".......channel list${channelList?[0].id}");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 140,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF7F7F7),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Color(0xFFCBCED0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      // child:  Container(color: Colors.red,),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(Icons.error_outline,size: 20,color: Color(0xff6D6D6D),)
                    ),
                    Positioned(
                      top: 50,
                      child: SizedBox(
                        width: w1/3,
                        height: 46,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 19,
                              child: Container(
                                width: 86,
                                height: 27,
                                decoration: ShapeDecoration(
                                  color: Color(0x4CD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 0.50, color: Color(0xFFE1E4E6)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              top: 20,
                              child: SizedBox(
                                width: w1/3,
                                height: 19,
                                child: const Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        height: 18.46,
                                        child: Row(
                                          children: [
                                            Text(
                                              '+ add image',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                focusNode: currentFocus,
                controller: widget.varientName,
                label: "Variant Name",
                hint: "",
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                controller: widget.barCode,
                label: "Barcode",
                hint: "",
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                focusNode: displayFocus,
                controller: widget.displayName,
                label: "Display Name",
                hint: "",
              ),

              SizedBox(
                height: 16,
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Base UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
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
                  // currentFocus.unfocus();
                  // searchFocus.unfocus();
                  // displayFocus.unfocus();
                  // descriptionFocus.unfocus();
                  // oldFocus.unfocus();
                  // _showModalBottomSheet();
                },
                child: Container(
                  width: w1,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                        "${widget.variantModel?.uomName}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w / 24,
                        ),
                      ),
                      // Icon(Icons.keyboard_arrow_down_outlined,
                      //     color: Color(0x7f666161))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
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
                  currentFocus.unfocus();
                  searchFocus.unfocus();
                  displayFocus.unfocus();
                  descriptionFocus.unfocus();
                  oldFocus.unfocus();
                  _showModalBottomSheetSales();
                },
                child: Container(
                  width: w1,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                        sales ?? "-  Select  -",
                        style: TextStyle(
                          color: Color(0xbf666161),
                          fontSize: w / 24,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,
                          color: Color(0x7f666161))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Please choose any UOM",
                style: TextStyle(
                  color: Color(0xff666161),
                  fontSize: w / 26,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                controller: widget.producedCountry,
                label: "Produced Country",
                hint: "",
              ),
              SizedBox(
                height: 15,
              ),
              GradientButton(
                  color: ColorPalette.primary,
                  onPressed: () {

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SelectVariantFrameworkPage(),
                      withNavBar: true,
                      // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                      PageTransitionAnimation.fade,
                    );
                  },
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ColorPalette.white, ColorPalette.white]),
                  child: Text(
                    "+ Variant Combinations",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: ColorPalette.primary,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          )),
    );
  }

  // _showModalBottomSheet() {
  //   final TextEditingController groupName = TextEditingController();
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
  //       ),
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         var h = MediaQuery.of(context).size.height;
  //         var w = MediaQuery.of(context).size.width;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               height: 550,
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               // alignment: Alignment.center,
  //               child: ScrollConfiguration(
  //                 behavior: NoGlow(),
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: w,
  //                         padding: EdgeInsets.only(right: 10, top: 10),
  //                         alignment: Alignment.topRight,
  //                         child: GestureDetector(
  //                             onTap: () {
  //                               Navigator.pop(context);
  //                             },
  //                             child: Icon(Icons.close)),
  //                       ),
  //
  //                       Container(
  //                         padding: EdgeInsets.only(left: 16),
  //                         child: Text(
  //                           "Base Uom",
  //                           style: GoogleFonts.roboto(
  //                             color: Colors.black,
  //                             fontSize: w / 20,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       Divider(
  //                         color: ColorPalette.divider,
  //                         thickness: 1.1,
  //                       ),
  //                       ListView.separated(
  //                           padding: EdgeInsets.symmetric(horizontal: 10),
  //                           physics: NeverScrollableScrollPhysics(),
  //                            shrinkWrap: true,
  //                           itemBuilder: (context, index) => Row(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setState(() {
  //                                         widget.onChangeBaseUom!(
  //                                             uomList?[index].name ?? "");
  //                                         base = uomList?[index].name ?? "";
  //
  //                                         isSelect = index;
  //                                       });
  //                                       Navigator.pop(context);
  //                                     },
  //                                     child: isSelect == index
  //                                         ? Container(
  //                                             // padding: EdgeInsets.all(10),
  //                                             child: SvgPicture.string(
  //                                                 OrderSvg()
  //                                                     .checkBoxActiveIcon))
  //                                         : SvgPicture.string(
  //                                             OrderSvg().checkBoxIcon,
  //                                           ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 10,
  //                                   ),
  //                                   Text(uomList?[index].name ?? "")
  //                                 ],
  //                               ),
  //                           separatorBuilder: (context, index) => SizedBox(
  //                                 height: 10,
  //                               ),
  //                           itemCount: uomList!.length),
  //                       // SizedBox(height: 40,),
  //                       // Container(
  //                       //   padding: EdgeInsets.all(16),
  //                       //   child: GradientButton(
  //                       //       color: ColorPalette.primary,
  //                       //       onPressed: () {
  //                       //         Navigator.pop(context);
  //                       //       },
  //                       //       gradient: const LinearGradient(
  //                       //           begin: Alignment.topCenter,
  //                       //           end: Alignment.bottomCenter,
  //                       //           colors: [
  //                       //             ColorPalette.primary,
  //                       //             ColorPalette.primary
  //                       //           ]),
  //                       //       child: Text(
  //                       //         "Continue",
  //                       //         textAlign: TextAlign.center,
  //                       //         style: GoogleFonts.roboto(
  //                       //           color: Colors.white,
  //                       //           fontSize: w/22,
  //                       //           fontWeight: FontWeight.w600,
  //                       //         ),
  //                       //       )),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

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
            builder: (BuildContext context, StateSetter setState) {
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
                        onTap: (){
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
                          "Sales Uom",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.onChangeSalesUom!(
                                        uomList?[index].name ?? "", uomList?[index].id??0 );
                                    sales = uomList?[index].name ?? "";
                                    isSelectSales = index;
                                  });
                                  Navigator.pop(context);
                                },
                                child: isSelectSales == index
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
                              Text(uomList?[index].name ?? "")
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: uomList!.length),

                      // SizedBox(height: 40,),
                      // Container(
                      //   padding: EdgeInsets.all(16),
                      //   child: GradientButton(
                      //       color: ColorPalette.primary,
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       gradient: const LinearGradient(
                      //           begin: Alignment.topCenter,
                      //           end: Alignment.bottomCenter,
                      //           colors: [
                      //             ColorPalette.primary,
                      //             ColorPalette.primary
                      //           ]),
                      //       child: Text(
                      //         "Continue",
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.roboto(
                      //           color: Colors.white,
                      //           fontSize: w/22,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       )),
                      // )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
