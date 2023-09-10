import 'package:cluster/presentation/seller_app/seller_bloc/seller_bloc.dart';
import 'package:cluster/presentation/seller_app/seller_models/seller_model_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common_widgets/no_glow.dart';
import '../../core/color_palatte.dart';
import '../../core/utils/variables.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../task_operation/task_svg.dart';
import 'new_product_list.dart';

class TopReviewProductsList extends StatefulWidget {
  const TopReviewProductsList({super.key});

  @override
  State<TopReviewProductsList> createState() => _TopReviewProductsListState();
}

class _TopReviewProductsListState extends State<TopReviewProductsList> {
  int selected = 0;
  int isItemSelect = 0;
  List<String> sortList = [
    'Stock items',
    'Out of stock items',
  ];
  List<String> productTypeList = [
    'All products',
    'Recently Added',
    'Most Selling',
    'Offer Applied'
  ];
  @override
  void initState() {
    context.read<SellerBloc>().add(const SellersListEvent("", "", ""));
    super.initState();
  }

  void onSelect(int val) {
    selected = val;
    setState(() {});
  }

  String nextUrl = "";
  String prevUrl = "";
  String sellerName = "";
  List<SellerList> sellerList=[];
  @override
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
            label: "Top Reviewed",
            isAction: false),
      ),
      body: BlocListener<SellerBloc, SellerState>(
        listener: (context, state) {
          if (state is SellersListLoading) {}
          if (state is SellersListSuccess) {
            sellerList = state.orders??[];
            sellerName=sellerList[0].name??"";
            context.read<SellerBloc>().add(TopReviewedListEvent("", "", "",sellerList[0].code));

            setState(() {});
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Seller : ",
                          style: GoogleFonts.roboto(
                              fontSize: w / 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                                onTap: () {

                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(Icons.close))
                                          ],
                                        ),
                                        // SizedBox(height: 5,),
                                        Text(
                                          "Seller List",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          physics:
                                          const AlwaysScrollableScrollPhysics(),
                                          child: Container(
                                            width: w,
                                            height: 394.30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(2),
                                              border: Border.all(
                                                color: const Color(0x7fd9d9d9),
                                                width: 1,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: ListView.separated(
                                              itemCount: sellerList.length,
                                              primary: true,
                                              shrinkWrap: true,
                                              physics:
                                              const AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        sellerName = sellerList[index]
                                                            .name ??
                                                            "";
                                                        // Variable.orgCode=sellerList[index]
                                                        //     .code ??
                                                        //     "";
                                                        print("CODE${sellerList[index].code}");
                                                        context.read<SellerBloc>().add(TopReviewedListEvent("", "", "",sellerList?[index].code));

                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: 58.25,
                                                              height: 58.25,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    2),
                                                                color: const Color(
                                                                    0xff1ecac0),
                                                              ),
                                                              alignment:
                                                              Alignment.center,
                                                              child: Image.network(sellerList?[
                                                              index]
                                                                  .logo ??
                                                                  "https://clipart-library.com/images/5TRr75Ggc.png")),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: w/3,
                                                                child: Text(
                                                                  sellerList?[index]
                                                                      .name ??
                                                                      "",
                                                                  style: GoogleFonts
                                                                      .roboto(
                                                                    color:
                                                                    Colors.black,
                                                                    fontSize: w / 22,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                sellerList?[index]
                                                                    .code ??
                                                                    "",
                                                                style: TextStyle(
                                                                  color: const Color(
                                                                      0xff636363),
                                                                  fontSize: w / 26,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              separatorBuilder:
                                                  (context, index) => Container(
                                                color: const Color(0xffD9D9D9)
                                                    .withOpacity(0.5),
                                                width: w,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         SvgPicture.string(
                                        //             SellerSvg().addIcon),
                                        //         Text(
                                        //           "Create New Seller",
                                        //           style: GoogleFonts.roboto(
                                        //             color: Color(0xfffe5762),
                                        //             fontSize: w / 24,
                                        //             fontWeight: FontWeight.w500,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Container(
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 6, vertical: 10),
                                        //       decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(5),
                                        //         color: Color(0xffe7e7e7),
                                        //       ),
                                        //       alignment: Alignment.center,
                                        //       child: Text(
                                        //         "Continue",
                                        //         style: GoogleFonts.roboto(
                                        //           color: Colors.white,
                                        //           fontSize: w / 24,
                                        //           fontWeight: FontWeight.w500,
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            sellerName != "" ? sellerName : "Select Seller",
                            style: GoogleFonts.roboto(
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffF1636C)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: w1 /1.1,
                        child: SearchCard(
                          hint: "Search a Product...!",
                          onchange: (jj) {
                            // context
                            //     .read<SellerBloc>()
                            //     .add(OutOfStockListEvent(jj, '', '',Variable.orgCode));
                            setState(() {});
                          },
                        )),
                    // GestureDetector(
                    //   onTap: () {
                    //     _showModalBottomSheet();
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(15),
                    //     width: 50,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(
                    //         color: Color(0xffe6ecf0),
                    //         width: 1,
                    //       ),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Color(0x05000000),
                    //           blurRadius: 8,
                    //           offset: Offset(1, 1),
                    //         ),
                    //       ],
                    //       color: Colors.white,
                    //     ),
                    //     child: SvgPicture.string(OrderSvg().moreIcon),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                BlocBuilder<SellerBloc, SellerState>(
                  builder: (context, state) {
                    if (state is TopSellingListLoading) {
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
                    if (state is TopSellingListSuccess) {
                      nextUrl = state.nextPageUrl ?? "";
                      prevUrl = state.prevPageUrl ?? "";
                      return Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.orders!.length} Products",
                            style: GoogleFonts.roboto(
                              color: const Color(0xff151522),
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            // height: 500,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              primary: true,
                              shrinkWrap: true,
                              itemCount: state.orders!.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  crossAxisCount: w1 > 700 ? 3 : 2,
                                  childAspectRatio: w1 > 700 ? 0.6 : 0.54,
                                  mainAxisSpacing: 5),
                              itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    // width: 186,
                                    // height: 186,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0xffe6ecf0),
                                        width: 1,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          width: w,
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: w1/4.5,
                                                  child: Image.network(state
                                                      .orders?[index]
                                                      .image1 ??
                                                      "")),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.orders?[index].name ?? "",
                                          style:  TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: w/26,
                                          ),
                                        ),
                                        Text(
                                          "BRAND : ${state.orders?[index].brandName ?? ""}",
                                          style: GoogleFonts.poppins(
                                            color: Color(0xff1b1b1f),
                                            fontSize: w/26,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //     right: 0,
                                  //     top: 10,
                                  //     child: Container(
                                  //       width: 69,
                                  //       height: 20,
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(5),
                                  //           topRight: Radius.circular(0),
                                  //           bottomLeft: Radius.circular(5),
                                  //           bottomRight: Radius.circular(0),
                                  //         ),
                                  //         color: Color(0x33079b15),
                                  //       ),
                                  //       alignment: Alignment.center,
                                  //       child: Text(
                                  //         "In stock",
                                  //         style: GoogleFonts.roboto(
                                  //           color: Color(0xff13a322),
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //       ),
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 25, right: 16, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                prevUrl != ""
                                    ? GestureDetector(
                                  onTap: () {
                                    context.read<SellerBloc>().add(
                                        OutOfStockListEvent(
                                            '', '', prevUrl,""));
                                    // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                  },
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPalette.primary,
                                        fontSize: w / 22),
                                  ),
                                )
                                    : Container(),
                                nextUrl != ""
                                    ? GestureDetector(
                                  onTap: () {
                                    // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                    setState(() {
                                      context.read<SellerBloc>().add(
                                          OutOfStockListEvent(
                                              '', nextUrl, "",''));
                                    });
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPalette.primary,
                                        fontSize: w / 22),
                                  ),
                                )
                                    : const Text("")
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      height: 400,
                      child: Column(
                        children: [
                          SvgPicture.string(TaskSvg().nolistIcon,height: 150,),
                          const SizedBox(height: 20,),
                          Text("Product List Is Empty...!",style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: w/28
                          ),),
                          const SizedBox(height: 15,),
                          Text("Select Seller For More Products.",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: w/30
                            ),)
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
