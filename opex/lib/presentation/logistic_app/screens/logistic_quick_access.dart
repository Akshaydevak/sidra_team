import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'delivery_hub.dart';
import 'driver_details.dart';
import 'new_order_list.dart';
class LogisticQuickAccess extends StatelessWidget {
  LogisticQuickAccess({Key? key}) : super(key: key);
  List<String> quickData=['New Orders','Insight','Delivery Hubs','Driver Details','Staff Handling','Type of Delivery','Return & Reports','Response & Reviews'];

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
            screen: NewOrderList(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );

        };
        break;

      case 1:
        onTap = () {

        };
        break;
      case 2:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DeliveryHub(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
          // //  DeliveryHub
        };
        break;
      case 3:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DriverDetails(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        //DriverDetails
        };
        break;


    }
    return onTap;
  }
}

