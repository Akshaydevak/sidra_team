import 'dart:math';

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/data_loading.dart';

import 'package:cluster/presentation/order_app/bloc/order_bloc/order_list_bloc.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:cluster/presentation/order_app/screens/order_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/custom_radio_button.dart';
import '../../../common_widgets/gradient_button.dart';
import '../new_ordercard.dart';
import '../no_of_item_model.dart';

class TabPage extends StatefulWidget {
  bool isPicking, isPacking;

  TabPage({Key? key, this.isPicking = false, this.isPacking = false})
      : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  bool isSelect = false;
  bool isProduct = false;
  bool isQuantity = false;
  bool isPicking = false;
  int isItemSelect = 0;
  int selected = 0;

  void onSelect(int val) {
    selected = val;
    setState(() {});
  }

  int selectedCheckBox = 0;

  void onSelectCheckBox(int val) {
    selectedCheckBox = val;
    setState(() {});
  }

  List<String> sortList = [
    'New Order',
    'Order Lines : High to Low ',
    'Order Lines : Low to High '
  ];
  List<String> deliveryList = [
    'Instant Delivery',
    'Same - day Delivery',
    'Express Delivery'
  ];

  @override
  void initState() {
    context.read<OrderListBloc>().add(const GetOrderListEvent());
    super.initState();
  }

  List<int> orderIds = [];

  List<int> deliveryAddressId = [];
  List<int> totalQuantity = [];
  List<double> amount = [];
  List<String> paymentStatus = [];
  List<String> deliverySlot = [];
  List<String> variantCode = [];
  List<String> status = [];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Stack(children: [
      ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       width: w / 1.35,
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(
                      //           color: const Color(0xffe6ecf0),
                      //           width: 1,
                      //         ),
                      //         boxShadow: const [
                      //           BoxShadow(
                      //             color: Color(0x05000000),
                      //             blurRadius: 8,
                      //             offset: Offset(1, 1),
                      //           ),
                      //         ],
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         _showModalBottomSheet();
                      //       },
                      //       child: Container(
                      //         width: 50,
                      //         height: 50,
                      //         padding: const EdgeInsets.all(14),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(
                      //             color: const Color(0xffe6ecf0),
                      //             width: 1,
                      //           ),
                      //           boxShadow: const [
                      //             BoxShadow(
                      //               color: Color(0x05000000),
                      //               blurRadius: 8,
                      //               offset: Offset(1, 1),
                      //             ),
                      //           ],
                      //           color: Colors.white,
                      //         ),
                      //         child: SvgPicture.string(OrderSvg().moreIcon),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             isSelect = !isSelect;
                      //           });
                      //         },
                      //         child: isSelect
                      //             ? Container(
                      //                 padding: const EdgeInsets.all(10),
                      //                 child: SvgPicture.string(
                      //                     OrderSvg().checkBoxActiveIcon))
                      //             : SvgPicture.string(OrderSvg().checkBoxIcon)),
                      //     Text(
                      //       "Select All",
                      //       style: GoogleFonts.roboto(
                      //         color: Colors.black,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      BlocBuilder<OrderListBloc, OrderListState>(
                        builder: (context, state) {
                          if (state is GetOrderListSuccess) {
                            if(state.ordersList.isNotEmpty){
                              return Container(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return NewOrderCard(
                                        status: state.ordersList[index].status,
                                        paymentType: state.ordersList[index].paymentMethod?.toUpperCase(),
                                        price: state.ordersList[index].totalAmount?.toStringAsFixed(2),
                                        lineCount: state.ordersList[index].orderLines?.length,
                                        onTap: () {
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: OrderView(
                                                isAssignment: false,
                                                isPicking: false,
                                                isPacking: false,
                                                orderData: state.ordersList[index],
                                                orderLineData: state
                                                    .ordersList[index].orderLines,
                                                customerName:
                                                "${state.ordersList[index].orderMeta?.customerData?.fname} ${state.ordersList[index].orderMeta?.customerData?.lname}",
                                                contactNumber: state.ordersList[index]
                                                    .orderMeta?.customerData?.mobile),

                                            withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                          );
                                        },
                                        // status: state.ordersList[index].c
                                        orderId:
                                        state.ordersList[index].orderId.toString(),

                                        created: state.ordersList[index].created,
                                        selected: orderIds
                                            .contains(state.ordersList[index].id),
                                        //  selectedCheckBox == index,
                                        onTapCheckBox: () {
                                          orderIds
                                              .add(state.ordersList[index].id ?? 0);
                                          // onSelectCheckBox(index);
                                        },
                                        isSelect: isSelect,
                                      );
                                    },
                                    separatorBuilder: (context, index) => Container(
                                      height: 10,
                                    ),
                                    itemCount: state.ordersList.length),
                              );
                            }
                            else{
                              return Container(child: Text("No new Orders"),);
                            }
                          }
                          if(state is GetOrderListLoading){      return customStackedLoader(
                              context, 0.1, Colors.white.withOpacity(0.1),
                              padding: 140);}
                          return Container(child: Text("No new Orders"),);

                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      isSelect
          ? Positioned(
          bottom: 0,
          child: widget.isPicking
              ? Container(
            padding: const EdgeInsets.only(
                left: 16, right: 16, bottom: 16, top: 16),
            width: w,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isProduct = !isProduct;
                            });
                          },
                          child: isProduct
                              ? Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.string(
                                  OrderSvg().checkBoxActiveIcon))
                              : SvgPicture.string(
                              OrderSvg().checkBoxIcon),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Product",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isQuantity = !isQuantity;
                            });
                          },
                          child: isQuantity
                              ? Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.string(
                                  OrderSvg().checkBoxActiveIcon))
                              : SvgPicture.string(
                              OrderSvg().checkBoxIcon),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Quantity",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPicking = !isPicking;
                            });
                          },
                          child: isPicking
                              ? Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.string(
                                  OrderSvg().checkBoxActiveIcon))
                              : SvgPicture.string(
                              OrderSvg().checkBoxIcon),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Picking",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GradientButton(
                    color: isProduct && isPicking && isQuantity
                        ? const Color(0xfffe5762)
                        : const Color(0xffd3d3d3),
                    onPressed: () {},
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isProduct && isPicking && isQuantity
                            ? [
                          const Color(0xfffe5762),
                          const Color(0xfffe5762)
                        ]
                            : [
                          const Color(0xffd3d3d3),
                          const Color(0xffd3d3d3)
                        ]),
                    child: Text(
                      widget.isPacking
                          ? "Order move to Assignment"
                          : "Order move to Packing",
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
              : Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16),
              width: w,
              child: GradientButton(
                  color: const Color(0xfffe5762),
                  onPressed: () {},
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xfffe5762), Color(0xfffe5762)]),
                  child: Text(
                    "Order move to Picking",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ))))
          : Container()
    ]);
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SafeArea(
                  child: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Filter",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Apply",
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery Options",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          CustomRadioButton(
                                            onTap: () {
                                              onSelect(index);
                                              setState(() {});
                                            },
                                            isActive: selected == index,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            deliveryList[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 10,
                                        ),
                                    itemCount: 3),
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "No. of Items",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                              height: 45,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                    right: 16, left: 12, bottom: 10),
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: noOfItemList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isItemSelect = i;
                                        });
                                      },
                                      child: Container(
                                        width: 95,
                                        height: 44,
                                        decoration: isItemSelect == i
                                            ? BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color:
                                            const Color(0xfffe5762),
                                            width: 1,
                                          ),
                                          color: const Color(0x0cfe5762),
                                        )
                                            : BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(10),
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                            color:
                                            const Color(0xffe6ecf0),
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
                                        alignment: Alignment.center,
                                        child: Text(
                                          noOfItemList[i].item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                              )),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sort By",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          CustomRadioButton(
                                            onTap: () {
                                              onSelect(index);
                                              setState(() {});
                                            },
                                            isActive: selected == index,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            sortList[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 10,
                                        ),
                                    itemCount: 3),
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    CustomRadioButton(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "All",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomRadioButton(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Cash on Delivery",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomRadioButton(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Credit",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomRadioButton(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Card / UPI Payment  ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
          );
        });
  }
}