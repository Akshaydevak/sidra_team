import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/seller_app/seller_bloc/seller_bloc.dart';
import 'package:cluster/presentation/seller_app/seller_models/seller_model_class.dart';
import 'package:cluster/presentation/seller_app/slr_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../task_operation/create/create_svg.dart';

class NewOrdersSellerApp extends StatefulWidget {
  const NewOrdersSellerApp({super.key});

  @override
  State<NewOrdersSellerApp> createState() => _NewOrdersSellerAppState();
}

class _NewOrdersSellerAppState extends State<NewOrdersSellerApp> {


  @override
  void initState() {
    context.read<SellerBloc>().add( NewOrderListEvent("","","","",'',''));
    super.initState();
  }
  String nextUrl = "";
  String prevUrl = "";
  bool isOrder = true;
  bool isDelivered = false;
  bool isCancelled = false;
  bool isReturned = false;
  bool isSubscibed = false;
  bool allOrders = true;
  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _range1 = '';
  String _rangeCount = '';

  String startDate2 = "10-12-2020";

  String ebdDate2 = "25-1-2022";
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        _range1 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }

      ebdDate2 = _range.split(" - ")[0];

      startDate2 = _range.split(" - ")[1];


      print("statatat$startDate2");
      print("statatat$ebdDate2");
    });
  }
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BackAppBar(isAction: false,
          label: 'All Orders',
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w1/2.2,
                    child: SearchCard(
                      hint: "Order Id...!",
                      onchange: (fa){
                        // Variable.isOrderId=true;
                        context.read<SellerBloc>().add( NewOrderListEvent(fa,"","","",'',''));
                        setState(() {

                        });
                      },
                    ),
                  ),
                  Container(
                    width: w1/2.2,
                    child: SearchCard(
                      hint: "Order Line Id...!",
                      onchange: (fa){
                        // Variable.isOrderId=false;
                        context.read<SellerBloc>().add( NewOrderListEvent(fa,"","","",'',''));
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 300,
                                    child: Scaffold(
                                      body: SfDateRangePicker(

                                        backgroundColor:
                                        Colors.white,
                                        endRangeSelectionColor:
                                        ColorPalette.primary,
                                        startRangeSelectionColor:
                                        ColorPalette.primary,
                                        rangeSelectionColor:
                                        ColorPalette.primary
                                            .withOpacity(0.1),
                                        selectionColor:
                                        Colors.grey,
                                        todayHighlightColor:
                                        ColorPalette.primary,
                                        onSelectionChanged:
                                        _onSelectionChanged,
                                        selectionMode:
                                        DateRangePickerSelectionMode
                                            .range,
                                        // initialSelectedRange:PickerDateRange(
                                        //     DateTime.parse(startDate),
                                        //     DateTime.parse(ebdDate))

                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<SellerBloc>(
                                          context)
                                          .add(
                                          NewOrderListEvent("","","","",startDate2,ebdDate2));
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Container(width: w/3,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                      alignment: Alignment.center,
                                      color: ColorPalette.primary,
                                      child: Text("Ok",style: GoogleFonts.roboto(color: Colors.white),),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),

                        color: Color(0xfffdf2f2),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],

                      ),
                      padding: EdgeInsets.all(4),
                      child: SvgPicture.string(
                        CreateSvg().calenderIcon,
                        color: ColorPalette.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: w/30,),
                  InkWell(
                    onTap: (){
                      _showModalBottomSheet();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),

                        color: Color(0xfffdf2f2),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],

                      ),
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.string(
                        MposSvg().filterIcon,
                        color: ColorPalette.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<SellerBloc, SellerState>(
              builder: (context, state) {
                if(state is NewOrderListLoading){
                  return Container(
                    height: 200,
                    width: w,
                    alignment: Alignment.center,
                    child: LoadingAnimationWidget.threeRotatingDots(
                      color: Colors.red,
                      size: 30,
                    ),
                  );
                }
                if(state is NewOrderListSuccess){
                  nextUrl = state.nextPageUrl ?? "";
                  prevUrl = state.prevPageUrl ?? "";
                  return Column(
                    children: [



                      Container(
                        padding: EdgeInsets.all(16),
                        child: ListView.separated(
                          primary: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.orders!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: 5,
                              ),
                          itemBuilder: (context, index) => SellerOrderCard(seller: state.orders![index],),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15,bottom: 25,right: 16,left: 16
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            prevUrl != ""
                                ? GestureDetector(
                              onTap: () {
                                context
                                    .read<SellerBloc>()
                                    .add(
                                    NewOrderListEvent(
                                        '',
                                        '',
                                        prevUrl,"",'',''));
                                // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                              },
                              child: Text(
                                "Previous",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w500,
                                    color: ColorPalette
                                        .primary,
                                    fontSize: w / 22),
                              ),
                            )
                                : Container(),
                            nextUrl != ""
                                ? GestureDetector(
                              onTap: () {
                                // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                setState(() {
                                  context
                                      .read<
                                      SellerBloc>()
                                      .add(
                                      NewOrderListEvent(
                                          '',
                                          nextUrl,
                                          "","",'',''));
                                });
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w500,
                                    color: ColorPalette
                                        .primary,
                                    fontSize: w / 22),
                              ),
                            )
                                : Text("")
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Text("NO PRODUCTS HERE");
              },
            ),
          ],
        ),
      ),
    );
  }
  _showModalBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: w1 > 700 ? h / 2.7 : h / 2,
                  width: w1,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.yellow,
                        padding:
                        EdgeInsets.only(right: w1 > 700 ? 30 : 16, top: 10),
                        width: w1,
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close)),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(left: w1 > 700 ? 30 : 16, top: 0),
                        child: Text(
                          "Filters ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: w / 24),
                        ),
                      ),
                      SizedBox(
                        height: h / 80,
                      ),
                      const Divider(
                        height: 1,
                        color: Color(0xffA9A8A8),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: w1 > 700 ? 30 : 16,
                            right: w1 > 700 ? 30 : 16,
                            top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  allOrders = true;
                                  isOrder = true;
                                  isCancelled = false;
                                  isDelivered = false;
                                  isReturned = false;
                                  isSubscibed = false;
                                });
                                // Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: w1 / 2.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: isOrder
                                          ? Colors.white
                                          : const Color(0x26000000),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: isOrder
                                          ? ColorPalette.primary
                                          : Colors.white),
                                  color: isOrder
                                      ? const Color(0x0fff9900)
                                      : Colors.white,
                                ),
                                child: Text("All Orders",
                                    style: GoogleFonts.poppins()),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  allOrders = false;
                                  isOrder = false;
                                  isCancelled = false;
                                  isDelivered = true;
                                  isReturned = false;
                                  isSubscibed = false;
                                });
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: w1 / 2.4,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDelivered
                                          ? Colors.white
                                          : const Color(0x26000000),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: isDelivered
                                          ? ColorPalette.primary
                                          : Colors.white),
                                  color: isDelivered
                                      ? const Color(0x0fff9900)
                                      : Colors.white,
                                ),
                                child: Text("Delivered",
                                    style: GoogleFonts.poppins()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: w1 > 700 ? 30 : 16,
                            right: w1 > 700 ? 30 : 16,
                            top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOrder = false;
                                  isCancelled = true;
                                  isDelivered = false;
                                  isReturned = false;
                                  isSubscibed = false;
                                  allOrders = false;
                                });
                                // Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: w1 / 2.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isCancelled
                                          ? ColorPalette.primary
                                          : Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isCancelled
                                          ? Colors.white
                                          : const Color(0x26000000),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: isCancelled
                                      ? const Color(0x0fff9900)
                                      : Colors.white,
                                ),
                                child: Text("Cancelled",
                                    style: GoogleFonts.poppins()),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOrder = false;
                                  isCancelled = false;
                                  isDelivered = false;
                                  isReturned = true;
                                  isSubscibed = false;
                                  allOrders = false;
                                });
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: w1 / 2.4,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isReturned
                                          ? ColorPalette.primary
                                          : Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isReturned
                                          ? Colors.white
                                          : const Color(0x26000000),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: isReturned
                                      ? const Color(0x0fff9900)
                                      : Colors.white,
                                ),
                                child: Text(
                                  "Returned",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h / 40,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: w1 > 700 ? 30 : 16,
                            right: w1 > 700 ? 30 : 16),
                        child: GradientButton(
                            onPressed: () {
                              print("isSubscibed$isSubscibed");

                             context
                                  .read<SellerBloc>()
                                  .add(NewOrderListEvent("","","",
                                   isOrder
                                      ? ""
                                      : isCancelled
                                      ? "Order Cancelled"
                                      : isDelivered
                                      ? "Order Delivered"
                                      : isReturned
                                      ? "Order Returned"
                                  // Replace
                                      : "","",""));

                              Navigator.pop(context);
                              setState(() {});
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [ColorPalette.primary, ColorPalette.primary]),
                            color: ColorPalette.primary,
                            child: Text(
                              "Apply",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ));
            },
          );
        });
  }
}
