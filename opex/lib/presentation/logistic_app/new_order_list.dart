import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/logistic_app/screens/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../mpos/search_card.dart';
import '../order_app/order_view.dart';
import 'widget/order_card.dart';

class NewOrderList extends StatelessWidget {
  const NewOrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "New Orders",
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
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: LogisticOrderView(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    //OrderView
                    },
                      child: const OrderCard()),
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
