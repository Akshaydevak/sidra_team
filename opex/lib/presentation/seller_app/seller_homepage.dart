import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/seller_app/product_list.dart';
import 'package:cluster/presentation/seller_app/seller_bloc/seller_bloc.dart';
import 'package:cluster/presentation/seller_app/seller_models/seller_model_class.dart';
import 'package:cluster/presentation/seller_app/seller_quick.dart';
import 'package:cluster/presentation/seller_app/slr_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../inventory/inventory_dashboard.dart';
import '../order_app/model/order_model.dart';
import '../promotion_app/promotion_dashboard.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import 'applications_card.dart';
import 'new_orders_list_seller.dart';

class PartnerHomePage extends StatefulWidget {
  bool isAdmin;
  PartnerHomePage({Key? key,this.isAdmin=false}) : super(key: key);

  @override
  State<PartnerHomePage> createState() => _PartnerHomePageState();
}

class _PartnerHomePageState extends State<PartnerHomePage> {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;
  List<GetNewOrderSellerList>? list;
  @override
  void initState() {
    context.read<SellerBloc>().add( DashBoardDataEvent());
    context.read<SellerBloc>().add( TotalProductCountEvent());
    context.read<SellerBloc>().add( NewOrderListEvent("","","","",'',''));

    super.initState();
  }
  // OrderAnalyticsModel? dasboadData;
  int totalProduct=0;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return MultiBlocListener(
  listeners: [
//     BlocListener<SellerBloc, SellerState>(
//       listener: (context, state) {
//         if(state is GetDashboardDataLoading){
//
//         }
//         if(state is GetDashboardDataSuccess){
//           // dasboadData=state.ordersList;
//           setState(() {
//
//           });
//         }
//         // TODO: implement listener
//       },
// ),
    BlocListener<SellerBloc, SellerState>(
      listener: (context, state) {
       if(state is GetTotalProductLoading){

       }
       if(state is GetTotalProductSuccess){
         totalProduct=state.totalMark;
         setState(() {

         });
       }
      },
    ),
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Seller App",
            isAction: false,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       width: w / 2.3,
                  //       // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //       //height: 20.0,
                  //       padding: EdgeInsets.symmetric(horizontal: 6.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Color(0x05000000),
                  //             blurRadius: 8,
                  //             offset: Offset(1, 1),
                  //           ),
                  //         ],
                  //         color: Colors.white,
                  //       ),
                  //       child: DropdownButton(
                  //           isExpanded: true,
                  //           icon: Icon(Icons.keyboard_arrow_down_outlined),
                  //           underline: Container(),
                  //           items: gender.map((String items) {
                  //             return DropdownMenuItem(
                  //               enabled: true,
                  //               value: items,
                  //               child: Text(items,
                  //                   style: TextStyle(color: Colors.black)),
                  //             );
                  //           }).toList(),
                  //           value: selectedGender,
                  //           onChanged: (dynamic value) {},
                  //           hint: Text(
                  //            " Today’s Report",
                  //             style:TextStyle(
                  //               color: Colors.black,
                  //               fontSize: w/22,
                  //             ),
                  //           )),
                  //     ),
                  //
                  //     Text(
                  //       "View Insight",
                  //       style: GoogleFonts.roboto(
                  //         color: Color(0xfffe5762),
                  //         fontSize: w/22,
                  //
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     HomeCard(
                  //       head: dasboadData?.newOrders?.toString()??"0",
                  //       sub: "Awaiting Orders",
                  //     ),
                  //     HomeCard(
                  //       head: dasboadData?.totalItems?.toString()??"0",
                  //       sub: "Total Orders",
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     HomeCard(
                  //       head: dasboadData?.completedOrders?.toString()??"0",
                  //       sub: "Competed Orders",
                  //     ),
                  //     HomeCard(
                  //       head: totalProduct.toString(),
                  //       sub: "Total Products",
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.isAdmin?
                  Column(
                    children: [
                      Container(
                        width: w,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        // height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfffdf2f2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(
                                  HomeSvg().chatGroupIcon,
                                  color: ColorPalette.primary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Chat with a Seller",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: w / 20,
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.string(TaskSvg().arrowIcon)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: SellersScreen(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );

                        },
                        child: Container(
                          width: w,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfffdf2f2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.string(
                                    MposSvg().handIcon  ,
                                    color: ColorPalette.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sellers List",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.string(TaskSvg().arrowIcon)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ):
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: NewOrdersSellerApp(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        child: Container(
                          width: w1,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfffdf2f2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.string(
                                    HomeSvg().chatGroupIcon,
                                    color: ColorPalette.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "All Orders",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.string(TaskSvg().arrowIcon)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ProductList(
                              isProductDetails: true,
                            ),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );

                        },
                        child: Container(
                          width: w1,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfffdf2f2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.string(
                                    MposSvg().handIcon  ,
                                    color: ColorPalette.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Out Of Stock Items",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w/22,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.string(TaskSvg().arrowIcon)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.isAdmin==false?Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Applications :",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                // PersistentNavBarNavigator.pushNewScreen(
                                //   context,
                                //   screen: InventoryDashBoard(),
                                //   withNavBar: true,
                                //   // OPTIONAL VALUE. True by default.
                                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                // );
                              },

                              child: ApplicationsCard(label: "Inventory\nApp")),
                          GestureDetector(
                            onTap: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: PromotionDashBoard(),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.fade,
                              );
                            },
                            child: ApplicationsCard(
                              label: "Promotion\nApp",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: (){
                      //         // PersistentNavBarNavigator.pushNewScreen(
                      //         //   context,
                      //         //   screen: OrderAppDashBoard(),
                      //         //   withNavBar: true,
                      //         //   // OPTIONAL VALUE. True by default.
                      //         //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      //         // );
                      //       },
                      //         child: ApplicationsCard(label: "Order\nApp")),
                      //     // ApplicationsCard(label: "Logistic\nApp"),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ):Container(),


                  Text(
                    "Quick access to :",
                    style: GoogleFonts.roboto(
                      color: const Color(0xff151522),
                      fontSize: w / 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  SellerQuick(isAdmin: widget.isAdmin,),
                  SizedBox(
                    height: 26,
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
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Orders",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: NewOrdersSellerApp(),
                                      withNavBar: true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Text(
                                    "View All",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xfffe5762),
                                      fontSize: w/22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ) ,
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: ListView.separated(
                                primary: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.orders!.length>=5?5:state.orders!.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(
                                      height: 5,
                                    ),
                                itemBuilder: (context, index) => SellerOrderCard(seller: state.orders![index],),

                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  BottomCard()
                ],
              ),
            ),
          ),
        ),
      ),
);
  }
}
