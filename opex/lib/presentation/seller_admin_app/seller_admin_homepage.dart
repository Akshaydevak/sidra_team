import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_quick_access.dart';
import 'package:cluster/presentation/seller_admin_app/seller_card.dart';
import 'package:cluster/presentation/seller_admin_app/seller_request_list.dart';
import 'package:cluster/presentation/seller_app/product_list.dart';
import 'package:cluster/presentation/seller_app/seller_bloc/seller_bloc.dart';
import 'package:cluster/presentation/seller_app/seller_models/seller_model_class.dart';
import 'package:cluster/presentation/seller_app/seller_quick.dart';
import 'package:cluster/presentation/seller_admin_app/sellers_screen.dart';
import 'package:cluster/presentation/seller_app/slr_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/loading.dart';
import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../inventory/inventory_dashboard.dart';
import '../promotion_app/promotion_dashboard.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import 'model_seller_admin/seller_admin_models.dart';

class SellerAdminHomePage extends StatefulWidget {
  bool isAdmin;
  SellerAdminHomePage({Key? key,this.isAdmin=false}) : super(key: key);

  @override
  State<SellerAdminHomePage> createState() => _SellerAdminHomePageState();
}

class _SellerAdminHomePageState extends State<SellerAdminHomePage> {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;
  List<GetNewOrderSellerList>? list;
  @override
  void initState() {


    context
        .read<SellerAdminBloc>().add( GetAdminDashboardRead());
    context
        .read<SellerAdminBloc>()
        .add(const SellerListSellerEvent("", "",'',''));
    super.initState();
  }
  SellerAdminDashboard? dataDasboard;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return BlocListener<SellerAdminBloc, SellerAdminState>(
  listener: (context, state) {
    if(state is GetAdminDashboardReadLoading){

    }
    if(state is GetAdminDashboardReadSuccess){
      dataDasboard=state.seller;
      setState(() {

      });
    }
  },
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Seller Admin",
          isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
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
                //             " Today’s Report",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: dataDasboard?.totalSellers.toString(),
                      sub: "Total Sellers",
                    ),
                    HomeCard(
                      head: dataDasboard?.activeSellers.toString(),
                      sub: "Active Sellers",
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: dataDasboard?.totalOrders.toString(),
                      sub: "Total Orders",
                    ),
                    HomeCard(
                      head: dataDasboard?.totalCustomers.toString(),
                      sub: "Total Customers",
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: SellerRequestListScreen(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
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
                                  "Seller Requests",
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
                          screen: SellersScreen(),
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
                                  "Sellers List",
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
                SellerAdminQuick(),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seller List",
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
                          screen: SellersScreen(),
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
                BlocBuilder<SellerAdminBloc, SellerAdminState>(
                  builder: (context, state) {
                    if(state is SellerListSellerLoading){
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
                    if(state is SellerListSellerSuccess){
                      return Container(
                        child: ListView.separated(
                          primary: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.category!.length>=5?5:state.category!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: 5,
                              ),
                          itemBuilder: (context, index) => SellerCard(listData: state.category?[index],)

                        ),
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
