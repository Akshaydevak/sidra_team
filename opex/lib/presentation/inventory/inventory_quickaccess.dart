import 'package:cluster/presentation/inventory/response_review_screen.dart';
import 'package:cluster/presentation/order_app/insight_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../product_hub/add_new_list.dart';
import 'inventory_create_new_list.dart';
import 'manage_delivery.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

class InventoryQuickAccess extends StatelessWidget {
   InventoryQuickAccess({Key? key}) : super(key: key);
  List<String> quickData=['New Item','Insight','Manage Inventory','Response & Reviews'];

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 12),
      // height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
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
             screen: InventoryCreateNewList(),
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
             screen: InsightScreen(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         //InsightScreen
         };
         break;
       case 2:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: ManageDeliveryScreen(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         //ManageDeliveryScreen
         };
         break;
       case 3:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: ResponseAndReviewScreen(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         //ResponseAndReviewScreen
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
         onTap = () {};
         break;
     }
     return onTap;
   }
}
