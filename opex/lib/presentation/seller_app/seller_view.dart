import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_app/product_list.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_svg.dart';
import 'operations/basic_details.dart';
import 'operations/bussiness_outlets.dart';
import 'operations/review_feedback.dart';
import 'operations/taxes_operations.dart';
import 'operations_card.dart';

class SellerView extends StatefulWidget {
  const SellerView({Key? key}) : super(key: key);

  @override
  State<SellerView> createState() => _SellerViewState();
}

class _SellerViewState extends State<SellerView> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Rawabi Market", isAction: false),
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
                Container(
                  width: w,
                  // height: 100,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffdf2f2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AED 201.50",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: w / 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Total Points",
                            style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: w / 24,
                            ),
                          )
                        ],
                      ),
                      SvgPicture.string(SellerSvg().trophyIcon)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  height: 30,
                ),
                Container(
                  height: h/9,
                  child:

                ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics:ScrollPhysics(),
                    itemBuilder: (context, index) =>  Container(
                      width: w/2.5,
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start ,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "120",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                              "Today’s Sale",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w/24,
                              ),

                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemCount: 5)),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Operations",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  // height: 365,
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
                  child: Column(
                    children: [
                      OperationsCard(
                        ontap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: BasicDetails(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //
                        },
                        label: "Basic Details ",
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 20, bottom: 10),
                      ),
                      Divider(
                        indent: 40,
                      ),
                      OperationsCard(
                        label: "Product Details",
                        color: Color(0xfffc3b3d),
                        ontap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ProductList(
                              isProductDetails: true,
                            ),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //  ProductList
                        },
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                      ),
                      Divider(
                        indent: 40,
                      ),
                      OperationsCard(
                        ontap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: BussinessOutlets(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //
                        },
                        label: "Business Outlets",
                        color: Color(0xffad51e0),
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                      ),
                      Divider(
                        indent: 40,
                      ),
                      OperationsCard(
                        label: "Rebate",
                        color: Color(0xff3a9ffc),
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                      ),
                      Divider(
                        indent: 40,
                      ),
                      OperationsCard(
                        ontap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: TaxesAndOperations(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        label: "Tax and Payment Info",
                        color: Color(0xff50bde0),
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                      ),
                      Divider(
                        indent: 40,
                      ),
                      OperationsCard(
                        ontap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ReviewAndFeedBack(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        label: "Reviews and Feedbacks",
                        color: Color(0xffe050a6),
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 20),
                      ),
                    ],
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
