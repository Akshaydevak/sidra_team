import 'package:cluster/presentation/mpos/payment_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../order_app/quickaccess_model.dart';
import 'collection_point.dart';
import 'customer_list.dart';
import 'order_view.dart';

class QuickAccessCard extends StatelessWidget {
   QuickAccessCard({Key? key}) : super(key: key);
List<String> quickData=['Order View','Insights','Stock Details','Holding Items','Collection Point','Customer List','Sales Report','Payment History'];
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
             screen: OrderViewScreen(),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;

       case 1:
         onTap = () {

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
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: CollectionPoint(),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 5:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: CostomerList(),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 6:
         onTap = () {

         };
         break;

       case 7:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: PaymentHistory(),
             withNavBar: true, // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
           //PaymentHistory
         };
         break;
     }
     return onTap;
   }
}
