import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/mandatory_textfield.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/widget/inventory_outstock_card.dart';
import 'package:cluster/presentation/inventory/widget/quantity_card.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:cluster/presentation/stock_app/out_stock_card.dart';
import 'package:cluster/presentation/stock_app/virtual_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class StockDetails extends StatefulWidget {
  final InventoryModel? variantData;
  StockDetails({Key? key, this.variantData}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  List<String> stockName = [
    'STOCK CODE',
    'TOTAL QUANTITY',
    'SALES UOM',
    'BASE UOM',
    'VIRTUAL STOCK'
  ];
  bool isActive = true;
  bool isDailyStockAvailable = false;
  bool stockWarning = false;
  String? selectedGender;
  TextEditingController meadiumController = TextEditingController();
  TextEditingController crucialController = TextEditingController();
  TextEditingController dailyStockQtyController = TextEditingController();
  TextEditingController addVirtualStockController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];
  StockDataModel? stockData;
  ReadStockData? readStockData;
  List<String> virtualType = [];
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is GetStockReadLoading) {}
            if (state is GetStockReadSuccess) {
              print("stock Data${state.stockData}");
              stockData = state.stockData.dataModel;
              virtualType = state.stockData.virtualType ?? [];
              // selectedGender=state.stockData.dataModel?.stockData?.stockTypeUsing??"";

              meadiumController.text =
                  stockData?.stockData?.websiteStatusMediumPoint?.toString() ??
                      "";
              crucialController.text =
                  stockData?.stockData?.websiteStatusCrucialPoint?.toString() ??
                      "";

              setState(() {});
            }
            // TODO: implement listener
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            print("Sucsess Msg$state");
            if (state is CreateVirtualStockLoading) {
              showSnackBar(context,
                  message: "Creation Loading", color: ColorPalette.green);
            } else if (state is CreateVirtualStockSuccess) {
              showSnackBar(context,
                  message: state.successMessage ?? "",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(ProductStockListEvent("",""));
              Navigator.pop(context);
            } else if (state is CreateVirtualStockFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Stock",
            isAction: false,
            onTap: (){
              context.read<InventoryBloc>().add(ProductStockListEvent("",""));
              Navigator.pop(context);
            },
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
                  InventoryOutStockCard(
                    isStock: true,
                    variantList: widget.variantData,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityCard(
                        label: "Cancelled Qty:",
                        count: stockData?.stockData?.cancelledQty?.toString() ??
                            "0",
                      ),
                      QuantityCard(
                        label: "Reserved Qty:",
                        count: stockData?.stockData?.reservedQty?.toString() ??
                            "0",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityCard(
                        label: "Damaged Qty:",
                        count:
                            stockData?.stockData?.damagedQty?.toString() ?? "0",
                      ),
                      QuantityCard(
                        label: "Returned Qty:",
                        count: stockData?.stockData?.returnedQty?.toString() ??
                            "0",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityCard(
                        label: "Total Qty:",
                        count:
                            stockData?.stockData?.availableQty?.toString() ??
                                "0",
                      ),
                      QuantityCard(
                        label: "Replaced Qty:",
                        count:
                            stockData?.stockData?.replacementQty?.toString() ??
                                "0",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stock Details",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Text(
                          "+ Virtual Stock",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: w,
                      padding: EdgeInsets.all(15),
                      // height: 251,
                      decoration: BoxDecoration(
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
                                width: w / 3,
                                child: Text(
                                  "STOCK CODE",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.stockCode ?? "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: w / 3,
                                child: Text(
                                  "TOTAL QUANTITY",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.availableQty
                                        ?.toString() ??
                                    "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: w / 3,
                                child: Text(
                                  "SALES UOM",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.salesUomName ?? "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: w / 3,
                                child: Text(
                                  "BASE UOM",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.baseUomName ?? "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: w / 3,
                                child: Text(
                                  "VIRTUAL STOCK",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.virtualStock
                                        ?.toString() ??
                                    "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: w / 3,
                                child: Text(
                                  "STOCK TYPE",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                ":",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                stockData?.stockData?.stockTypeUsing ?? "",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          stockData?.stockData?.dailyStockQty.toString() ==
                                      "0" ||
                                  stockData?.stockData?.dailyStockQty == null
                              ? Container()
                              : Row(
                                  children: [
                                    Container(
                                      width: w / 3,
                                      child: Text(
                                        "DAILY STOCK QUANTITY",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 27,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      stockData?.stockData?.dailyStockQty
                                              .toString() ??
                                          "",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Profile related info placed here.  Whishlist is used to save your favourite items for later.",
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFormReusable(
                          label: "Medium Status",
                          hint: "1109",
                          numField: true,
                          controller: meadiumController,
                        ),
                      ),
                      Container(
                        width: w / 2.3,
                        child: TextFormReusable(
                          label: "Crucial Status",
                          hint: "1109",
                          numField: true,
                          controller: crucialController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ClusterCard(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is Active",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // isActive = !isActive;
                          });
                        },
                        child: isActive
                            ? SvgPicture.string(HomeSvg().toggleActive)
                            : SvgPicture.string(HomeSvg().toggleInActive),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  ClusterCard(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stock Warning",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            stockWarning = !stockWarning;
                          });
                        },
                        child: stockWarning
                            ? SvgPicture.string(HomeSvg().toggleActive)
                            : SvgPicture.string(HomeSvg().toggleInActive),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {
                        BlocProvider.of<InventoryBloc>(context).add(
                            CreateVirtualStockPostEvent(
                                channelCode: null,
                              channelId: null,
                              virtualType: selectedGender??"",
                              variantCode: widget.variantData?.code??"",
                              stockWarning: stockWarning,
                              mediumPoint: int.tryParse(meadiumController.text)??null,
                              isDailyStockAvailable: isDailyStockAvailable,
                              crucialPoint: int.tryParse(crucialController.text)??null,
                              variantId: widget.variantData?.id??0,
                              inventoryId: stockData?.inventoryId??"",
                              dailyStockQty: int.tryParse(dailyStockQtyController.text)??0,
                              addVirtualStock: int.tryParse(addVirtualStockController.text)??0

                            ));
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: VirtualStock(),
                        //   withNavBar: true,
                        //   // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                        //VirtualStock
                        // Navigator.pop(context);
                      },
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorPalette.primary,
                            ColorPalette.primary,
                          ]),
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
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
                height: 450,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: w,
                        padding: EdgeInsets.only(right: 16, top: 16),
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, bottom: 5),
                        child: Text(
                          "Add Virtual Stock",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.1,
                        color: ColorPalette.divider,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flex(direction: Axis.vertical, children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Virtual Type",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      width: w,
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        icon: const Padding(
                                          padding: EdgeInsets.only(left: 180),
                                          child: Icon(
                                              Icons.arrow_drop_down_circle),
                                        ),
                                        hint: const Text("Select Type"),
                                        value: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                            isDailyStockAvailable=false;
                                          });
                                        },
                                        items: virtualType
                                            .map<DropdownMenuItem<String>>(
                                                (String _value) =>
                                                    DropdownMenuItem<String>(
                                                        value: _value,
                                                        child: Text(
                                                          _value ?? "",
                                                        )))
                                            .toList(),
                                      )),
                                ],
                              ),
                            ]),


                            TextFormReusable(
                              label: "",
                              hint: "Enter Stock Quantity",
                              controller: addVirtualStockController,
                            ),
                            isDailyStockAvailable == true
                                ? SizedBox(
                              height: 15,
                            )
                                : Container(),
                            isDailyStockAvailable == true
                                ? TextFormReusable(
                              label: "Daily Stock Quantity",
                              hint: "100",
                              controller: dailyStockQtyController,
                            )
                                : Container(),
                            SizedBox(
                              height: 16,
                            ),
                            selectedGender=="daily stock"?ClusterCard(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Is Daily Stock Available",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isDailyStockAvailable =
                                          !isDailyStockAvailable;
                                    });
                                  },
                                  child: isDailyStockAvailable
                                      ? SvgPicture.string(
                                          HomeSvg().toggleActive)
                                      : SvgPicture.string(
                                          HomeSvg().toggleInActive),
                                )
                              ],
                            )):Container(),

                            SizedBox(
                              height: 30,
                            ),
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.primary,
                                      ColorPalette.primary,
                                    ]),
                                child: Text(
                                  "Add Virtual Stock",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
