import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/order_app/screens/all_order_tab.dart';
import 'package:cluster/presentation/order_app/bloc/order_bloc/order_list_bloc.dart';
import 'package:cluster/presentation/order_app/bloc/order_status_bloc/order_status_bloc.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:cluster/presentation/order_app/order_tabs/orders_list.dart';
import 'package:cluster/presentation/order_app/utils/custom_check_box.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_svg.dart';
import '../orderapp_card.dart';

class OrderView extends StatefulWidget {
  final bool? isPicking;
  final bool? isPacking;
  final bool? isAssignment;
  final ListOrdersModel? orderData;
  final String? customerName;
  final String? contactNumber;
  final List<OrderLines>? orderLineData;

  const OrderView(
      {Key? key,
      this.orderLineData,
      this.customerName,
      this.contactNumber,
      this.orderData,
      this.isPicking = false,
      this.isPacking = false,
      this.isAssignment})
      : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int select = 0;
  void onselect(Intex) {
    setState(() {
      select = Intex;
    });
  }

  String? legalEntityCode;
  String? employeeCode;
  List<String> paymentStatus = [];
  List<int> orderLineId = [];
  List<int> itemId = [];
  List<String> variantCode = [];
  List<int> totalQuantity = [];
  List<double> amount = [];
  List<String> deliverySlot = [];
  List<String> status = [];
  List<String> deliveryAddressId = [];

  @override
  void initState() {
    context.read<OrderStatusBloc>().add(const GetEmployeeListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<OrderStatusBloc, OrderStatusState>(
        listener: (context, state) {
          if (state is MoveOrderToPickingSuccess) {
         widget.isPicking==true?PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const AllOrderTab(index: 2),

              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            )  :widget.isPacking==true?PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const AllOrderTab(index: 3),

              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            ): PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const AllOrderTab(index: 0),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            showSnackBar(context,
                message: state.message ?? "",
                color: Colors.white,
                
                // icon: HomeSvg().SnackbarIcon,
                autoDismiss: true);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: w / 1.1,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0x4ca9a8a8),
                              width: 1,
                            ),
                            color: const Color(0xfff8f7f5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Order ID",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff1b1b1f),
                                      fontSize: w / 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  widget.isPacking == true ||
                                          widget.isPicking == true ||
                                          widget.isAssignment == true
                                      ? Text(
                                          widget.orderData?.orderId
                                                  .toString() ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xff1b1b1f),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          widget.orderData?.id.toString() ?? "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xff1b1b1f),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500),
                                        )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Order Date",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xff1b1b1f),
                                      fontSize: w / 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  widget.isPacking == true ||
                                          widget.isPicking == true ||
                                          widget.isAssignment == true
                                      ? Text(
                                          " ${widget.orderData?.orderCreated?.split('T')[0]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xff1b1b1f),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          " ${widget.orderData?.created?.split('T')[0]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xff1b1b1f),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(10),
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
                          child: SvgPicture.string(OrderSvg().qrIcon),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.customerName ?? "",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xfffe5762),
                                      fontSize: w / 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.string(OrderSvg().callIcon),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.string(OrderSvg().msgIcon),
                                ],
                              ),
                            ],
                          )),
                      Container(
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffffeff0),
                              ),
                              child: SvgPicture.string(OrderSvg().phoneIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.contactNumber ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(left: 50),
                      //   width: w,
                      //   height: 1,
                      //   color: const Color(0xffE6ECF0),
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 30,
                      //         height: 30,
                      //         padding: const EdgeInsets.all(8),
                      //         decoration: const BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: Color(0xffffeff0),
                      //         ),
                      //         child: SvgPicture.string(OrderSvg().phoneIcon),
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         "+91 8606200441",
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: w / 22,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Delivery Details",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Text(
                                "Delivery on ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                         widget.orderLineData!=null && widget.orderLineData!.isNotEmpty?     Text(
                                "${widget.orderLineData?[0].orderLinesMeta?.deliveryData?.deliveryData.toString()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ):Container(),
                            ],
                          )),
                      Container(
                        width: w,
                        margin: const EdgeInsets.only(left: 50),
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        width: w,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.orderLineData != null &&
                                    widget.orderLineData!.isNotEmpty
                                ? Text(
                                    "Note :",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Container(),
                            widget.orderLineData != null &&
                                    widget.orderLineData!.isNotEmpty
                                ? Text(
                                    widget.orderLineData?[0].orderLinesMeta
                                            ?.deliveryData?.notes
                                            .toString() ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Text(
                //   "Payment Method",
                //   style: GoogleFonts.roboto(
                //     color: Colors.black,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // ClusterCard(
                //     child: Row(
                //   children: [
                //     Container(
                //       width: 48,
                //       height: 48,
                //       padding: const EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         border: Border.all(
                //           color: const Color(0x7fe6ecf0),
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
                //       child: Image.asset("asset/cardicon.png"),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Afthabu Rahman PP",
                //           style: GoogleFonts.roboto(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: const [
                //             Text(
                //               "****  ****  **** ",
                //               style: TextStyle(
                //                 color: Color(0xff1b1b1f),
                //                 fontSize: 18,
                //                 fontFamily: "Poppins",
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             Text(
                //               "5326",
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontSize: 16,
                //               ),
                //             )
                //           ],
                //         )
                //       ],
                //     )
                //   ],
                // )),
                // const SizedBox(
                //   height: 16,
                // ),
                Text(
                  "Order Lines",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderLineCard(
                        onChange: (val) {
                          if (val) {
                            orderLineId
                                .add(widget.orderLineData?[index].id ?? 0);
                            itemId.add(widget.orderLineData?[index].id ?? 0);
                            paymentStatus.add(
                                widget.orderLineData?[index].paymentStatus ??
                                    "");
                            variantCode.add(widget.orderLineData?[index]
                                    .orderLinesMeta?.varianCode ??
                                "");
                            totalQuantity.add(
                                widget.orderLineData?[index].totalQty ?? 0);
                            amount.add(
                                widget.orderLineData?[index].amount ?? 0.0);
                            deliverySlot.add(widget.orderLineData?[index]
                                    .orderLinesMeta?.deliveryData?.name ??
                                "");
                            // deliverySlot.add(widget.orderLineData?[index].orderLinesMeta?.deliveryData?.)
                            status
                                .add(widget.orderLineData?[index].status ?? "");
                            deliveryAddressId.add(widget
                                    .orderData?.deliveryAddressId
                                    .toString() ??
                                "");
                          } else {
                            orderLineId
                                .remove(widget.orderLineData?[index].id ?? 0);
                            paymentStatus.remove(
                                widget.orderLineData?[index].paymentStatus ??
                                    "");
                            variantCode.remove(
                                widget.orderLineData?[index].variantId ?? "");
                            totalQuantity.remove(
                                widget.orderLineData?[index].totalQty ?? 0);
                            amount.remove(
                                widget.orderLineData?[index].amount ?? 0.0);
                            deliverySlot.remove(widget.orderLineData?[index]
                                    .orderLinesMeta?.deliveryData?.name ??
                                "");
                            status.remove(
                                widget.orderLineData?[index].status ?? "");
                            deliveryAddressId.remove(widget
                                    .orderData?.deliveryAddressId
                                    .toString() ??
                                "");
                          }
                        },
                        orderLineId: widget.orderLineData?[index].id.toString(),
                        price: widget.orderLineData?[index].amount.toString(),
                        quantity:
                            widget.orderLineData?[index].totalQty.toString(),
                        variantName: widget
                            .orderLineData?[index].orderLinesMeta?.variantName,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container();
                    },
                    itemCount: widget.orderLineData?.length ?? 0),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                widget.isAssignment == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select a Partner",
                            style: GoogleFonts.roboto(fontSize: 14),
                          ),
                          Container(
                            width: 382,
                            // height: 301,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(10),
                              ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   padding: EdgeInsets.symmetric(horizontal: 10),
                                //   child: Row(
                                //     children: [
                                //       SvgPicture.string(
                                //           HomeSvg().radioButtonActive),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text(
                                //         "Own organization",
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: w / 24,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const Divider(
                                //   thickness: 1.1,
                                // ),
                                BlocBuilder<OrderStatusBloc, OrderStatusState>(
                                  builder: (context, state) {
                                    if (state is GetEmployeeListSuccess) {
                                      return ListView.separated(
                                        itemCount: state.ordersList.length,
                                        primary: true,
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        itemBuilder: (context, index) =>
                                            Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  onselect(index);
                                                  legalEntityCode = state
                                                      .ordersList[index]
                                                      .legalEntityCode;
                                                  employeeCode = state
                                                      .ordersList[index]
                                                      .employeeCode;
                                                },
                                                child: SvgPicture.string(
                                                    select == index
                                                        ? HomeSvg()
                                                            .radioButtonActive
                                                        : HomeSvg()
                                                            .radioInActive),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.ordersList[index].fname ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: w / 24,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    List<LineItems> lineItems = [];
                    for (var i = 0; i < orderLineId.length; i++) {
                      lineItems.add(LineItems(
                          id: orderLineId[i],
                          variantCode: variantCode[i],
                          deliveryAddress:
                              widget.orderData?.deliveryAddressId.toString() ??
                                  "",
                          amount: amount[i],
                          deliverySlot: widget.orderLineData?[0].orderLinesMeta
                                  ?.deliveryData?.name ??
                              "",
                          status: widget.orderData?.status,
                          paymentStatus: paymentStatus[i],
                          totalQuantity: totalQuantity[i]));
                    }
                    CreatePickingModel moveToPicking = CreatePickingModel(
                        createdBy: widget.orderData?.created,
                        inventory: widget.orderData?.orderLines?[0].inventoryId,
                        orderCode: widget.orderData?.orderCode,
                        orderStatus: widget.orderData?.status,
                        lineItems: lineItems);

                    widget.isPicking == true
                        ? context
                            .read<OrderStatusBloc>()
                            .add(MoveOrderToPacking(
                              isPacking: false,
                              isAssignment: false,
                              orderCode: widget.orderData?.orderCode ?? "",
                              orderLineIds: orderLineId,
                            ))
                        : widget.isPacking == true
                            ? context.read<OrderStatusBloc>().add(
                                MoveOrderToPacking(
                                    isAssignment: false,
                                    isPacking: true,
                                    orderCode: widget.orderData?.orderCode,
                                    orderLineIds: orderLineId))
                            : widget.isAssignment == true
                                ? context.read<OrderStatusBloc>().add(
                                    MoveOrderToPacking(

                                        isAssignment: true,
                                        employeeCode: employeeCode,
                                        organizationCode: legalEntityCode,
                                        isPacking: false,
                                        orderCode: widget.orderData?.orderCode,
                                        orderLineIds: orderLineId))
                                : context.read<OrderStatusBloc>().add(
                                    MoveOrderToPicking(
                                        updateOrder: moveToPicking));
                  },
                  child: ClusterCard(
                    child: Center(
                      child: Text(
                        widget.isPicking == true
                            ? "Add to packing"
                            : widget.isPacking == true
                                ? "Add to Assignment"
                                : widget.isAssignment == true
                                    ? "Assign to Partner"
                                    : "Add to Picking",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: const Color(0xfffe5762),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderLineCard extends StatefulWidget {
  final bool selected;
  final String? orderLineId;
  final String? variantName;
  final String? quantity;
  final Function(bool)? onChange;
  final String? price;
  const OrderLineCard(
      {super.key,
      this.orderLineId,
      this.variantName,
      this.quantity,
      this.price,
      this.onChange,
      this.selected = false});

  @override
  State<OrderLineCard> createState() => _OrderLineCardState();
}

class _OrderLineCardState extends State<OrderLineCard> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return ClusterCard(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
                height: 65,
                width: 65,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset("asset/img_9.png"),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: CustomCheckBox(
                        value: widget.selected,
                        onChange: widget.onChange,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.orderLineId ?? "",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                    width: w / 1.8,
                    child: Text(
                      widget.variantName ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )),
                Row(
                  children: [
                    const Text(
                      "Quantity\nPrice ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.quantity}\nAED ${widget.price}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ));
  }
}
