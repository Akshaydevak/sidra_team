import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_admin_app/operations/review_card.dart';
import 'package:flutter/material.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ReviewScreen extends StatefulWidget {
 bool  isLeast;
   ReviewScreen({Key? key,this.isLeast=false}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label:widget.isLeast?"Least Rated Reviews": "Most Rated Reviews", isAction: false),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ReviewCard(),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
