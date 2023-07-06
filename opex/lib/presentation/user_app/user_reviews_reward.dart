import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/user_app/review_card.dart';
import 'package:flutter/material.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class UserReviewsAndRewards extends StatelessWidget {
  const UserReviewsAndRewards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Reviews and Rewards",
          isAction: false,

        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              UserReviewCard(label: "Employee Performance",

              ),
              SizedBox(height: 10,),
              UserReviewCard(label: "Employee Benchmark",color: Color(0xff007BFF),),
              SizedBox(height: 10,),
              UserReviewCard(label: "Most Improved Employee",color: Color(0xff33C658),),
              SizedBox(height: 10,),
              UserReviewCard(label: "Best of the Month",color: Color(0xffFC3B3D),),
              SizedBox(height: 10,),
              UserReviewCard(label: "Low Performance",color: ColorPalette.yellow,),
            ],
          ),
        ),
      ),
    );
  }
}
