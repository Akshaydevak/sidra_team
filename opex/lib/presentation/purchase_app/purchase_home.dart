import 'package:cluster/presentation/inventory/inventory_quickaccess.dart';
import 'package:cluster/presentation/purchase_app/purchase_order_screen.dart';
import 'package:cluster/presentation/purchase_app/purchase_ordercard.dart';
import 'package:cluster/presentation/purchase_app/purchase_quickaccess.dart';
import 'package:cluster/presentation/purchase_app/purchase_recieving_screen.dart';
import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:cluster/presentation/purchase_app/row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

import '../task_operation/home_card.dart';

class PurchaseHome extends StatefulWidget {
  const PurchaseHome({Key? key}) : super(key: key);

  @override
  State<PurchaseHome> createState() => _PurchaseHomeState();
}

class _PurchaseHomeState extends State<PurchaseHome> {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Purchase App"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w / 2.3,
                    // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //height: 20.0,
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xfffdf2f2),
                        width: 1.50,
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
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        underline: Container(),
                        items: gender.map((String items) {
                          return DropdownMenuItem(
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        value: selectedGender,
                        onChanged: (dynamic value) {},
                        hint: Text(
                          " Today’s Report",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 22,
                          ),
                        )),
                  ),
                  Text(
                    "View Insight",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
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
                    head: "120",
                    sub: "Order Recieved",
                  ),
                  HomeCard(
                    head: '32',
                    sub: "Order Confirmed",
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
                    head: "3200",
                    sub: "Success Order",
                  ),
                  HomeCard(
                    head: '362',
                    sub: "Purchase Returned",
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              OrderCard(
                icon: PurchaseSvg().orderIcon,
                label: "Purchase Orders",
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: PurchaseOrderScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              OrderCard(
                icon: PurchaseSvg().orderReceivingIcon,
                label: "Purchase Receiving",
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: PurchaseRecievingScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Quick access to :",
                style: GoogleFonts.roboto(
                  color: Color(0xff151522),
                  fontSize: w / 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PurchaseQuickAccess(),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Sellers",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "View All",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => PurchaseOrdercard(),separatorBuilder: (context, index) => SizedBox(height: 5,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
