import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/logistic_app/widget/hub_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'add_new_hub.dart';

class DeliveryHub extends StatelessWidget {
  const DeliveryHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Delivery Hubs",
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
              children: [
                SearchCard(),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "20 Results",
                      style:  GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: w/21,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: AddNewHub(),
                          withNavBar: true,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                          PageTransitionAnimation.fade,
                        );
                      //  AddNewHub
                      },
                      child: Text(
                        "Add New Hub",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: w/22,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                ListView.separated(
                  itemBuilder: (context, index) => DeliveryHubCard(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemCount: 6,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
