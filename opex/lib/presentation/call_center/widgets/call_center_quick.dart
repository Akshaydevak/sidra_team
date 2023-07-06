import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

import '../call_center_history.dart';
import '../callcenter_register.dart';

class CallCenterQuickAccess extends StatelessWidget {
  CallCenterQuickAccess({Key? key}) : super(key: key);
  List<String> quickData=['Add New Customer','Order History','User Manage','GP Corner','Explore','Offers','Holded Orders','Settings'];

  @override
  Widget build(BuildContext context) {
    return Container(

        width: MediaQuery
            .of(context)
            .size
            .width,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: onTapListTile(i, context),
                child: Container(
                  width: 88,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x0ce30000),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(TaskSvg().quickaccessIcon),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        quickData[i],
                        style: TextStyle(
                          color: Color(0xff121113),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }));
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
            screen: CallCenterRegister(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );

        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CallCenterHistory(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        //CallCenterHistory
        };
        break;
      case 2:
        onTap = () {


          // //  DeliveryHub
        };
        break;
      case 3:
        onTap = () {

          //DriverDetails
        };
        break;


    }
    return onTap;
  }
}
