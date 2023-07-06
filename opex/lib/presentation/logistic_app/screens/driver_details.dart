import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/logistic_app/utils/logistic_svg.dart';
import 'package:cluster/presentation/logistic_app/widget/assign_order_card.dart';
import 'package:cluster/presentation/logistic_app/widget/driver_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'add_delivery.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Driver Details",
          isAction: false,
          action: SvgPicture.string(
            TaskSvg().notificationIcon,
            color: Colors.black,
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                DriverCard(isSelect: true,svg: LogisticSvg().bikeIcon,),
                DriverCard(svg: LogisticSvg().bikeIcon,),
                DriverCard(svg: LogisticSvg().bikeIcon,),
                DriverCard(svg: LogisticSvg().bikeIcon,),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "20 Result",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AddDelivery(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Text(
                    "Add New Driver",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: w / 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AssignOrderCard();
                  },
                  separatorBuilder: (context, index) => Container(
                        height: 10,
                      ),
                  itemCount: 5),
            ],
          ),
        )),
      ),
    );
  }
}
