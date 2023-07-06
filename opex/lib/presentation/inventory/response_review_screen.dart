import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/inventory/response_card.dart';
import 'package:cluster/presentation/inventory/response_review/business_msg.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../seller_app/operations/review_feedback.dart';

class ResponseAndReviewScreen extends StatelessWidget {
  List<String> responseList = [
    'Business Messages',
    'View all Reviews',
    'Top rated Reviews',
    'Underrated Reviews',
    'Returned Products',
    'New Ordered Items'
  ];

  ResponseAndReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Response & Reviews"),
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
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: onTapListTile(index, context),
                    child: ResponseCard(
                      label: responseList[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback onTapListTile(int i, BuildContext context) {
    // String email = Variables.emailfield;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: BussinessMessage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ReviewAndFeedBack(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        //ReviewAndFeedBack
        };
        break;
      case 2:
        onTap = () {

        };
        break;
      case 3:
        onTap = () {

        };
        break;

      case 4:
        onTap = () {

        };
        break;
      case 5:
        onTap = () {

        };
        break;




    }
    return onTap;
  }
}
