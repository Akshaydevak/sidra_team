import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'evaluation_card.dart';
import 'evaluation_first_page.dart';

class GroupEvaluation extends StatefulWidget {
  const GroupEvaluation({super.key});

  @override
  State<GroupEvaluation> createState() => _GroupEvaluationState();
}

class _GroupEvaluationState extends State<GroupEvaluation> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Evaluation",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w1,
                margin: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0xff2871AF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                    child: Text("Evaluate all (6)")),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    separatorBuilder:
                        (BuildContext cxt, int i) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: EvaluationFirstPage(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        child: UserCardEvaluation(
                          evaluted: true,
                          onTap: (){
                            // _showModalBottomSheetNew(context,false);
                          },
                        ),
                      );
                    },
                    itemCount: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
