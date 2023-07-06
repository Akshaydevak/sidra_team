import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/order_app/quickaccess_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'screens/all_order_tab.dart';
import 'insight_screen.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
        height: h / 8,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 16, left: 0, bottom: 5),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: quickList.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: onTapListTile(i,context),
              child: Container(
                width: 88,
                height: 100,
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0x0ce30000),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.string(TaskSvg().quickaccessIcon),
                    SizedBox(height: 5,),
                    Text(
                      quickList[i].name,
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontSize: w/25,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 8,
            );
          },
        ));
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
            screen: InsightScreen(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: AllOrderTab(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
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
      case 6:
        onTap = () {

        };
        break;

      case 7:
        onTap = () {

        };
        break;

      case 8:
        onTap = () {

        };
        break;
      case 9:
        onTap = () {

        };
        break;
    }
    return onTap;
  }
}
