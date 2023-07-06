import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:cluster/presentation/self_checkout/widget/self_checkout_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'bill_screen.dart';
class SelfSuccessScreen extends StatelessWidget {
  const SelfSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child:Stack(
        children: [
      Container(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 50,bottom: 60),
                child: SvgPicture.string(SelfSvg().successScreen)),
         
          ],
        ),
      ),
          Positioned(
            bottom: 0,
            width: w,
            child:    Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SelfCheckoutBtn(label: "View digital bill",onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BillScreen(),
                      withNavBar: true,
                      pageTransitionAnimation:  PageTransitionAnimation.fade,
                    );
                  },),
                  SizedBox(height: 10,),
                  SelfCheckoutInactiveButton(label: "Back to home",textColor: Colors.black,),
                ],
              ),
            ),)
        ],
      )
      )
    );
  }
}
