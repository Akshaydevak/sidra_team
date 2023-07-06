import 'package:cluster/presentation/order_app/insight_screen.dart';
import 'package:cluster/presentation/seller_app/outlet.dart';
import 'package:cluster/presentation/seller_app/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../task_operation/task_svg.dart';
import 'new_outlet.dart';
import 'new_product.dart';
import 'new_seller.dart';

class SellerQuick extends StatelessWidget {
  bool isAdmin;
   SellerQuick({Key? key,this.isAdmin=false}) : super(key: key);
  List<String> quickData=['Add New Outlet','Add New Product','Order Summary','Seller Tax','Purchase','Sales Report','Settings','Help'];
  List<String> adminQuickData=['Add a Seller','Insights','Product List','Seller Tax','Point Corner','Rebate','Settle Payments','GP Value'];
  @override
  Widget build(BuildContext context) {
    return Container(

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
                 onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
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
                        isAdmin?adminQuickData[i] :quickData[i],
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
             screen: Outlet(),
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
             screen: AddNewProduct(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation:
             PageTransitionAnimation.fade,
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


     }
     return onTap;
   }
   VoidCallback onTapListTileAdmin(int i, BuildContext context) {
     // String email = Variables.emailfield;
     VoidCallback onTap;
     onTap = () {};
     switch (i) {
       case 0:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: NewSeller(),
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
             screen:  InsightScreen(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation:
             PageTransitionAnimation.fade,
           );
         };
         break;
       case 2:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen:  ProductList(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation:
             PageTransitionAnimation.fade,
           );
         //  ProductList
         };
         break;
       case 3:
         onTap = () {

         };
         break;


     }
     return onTap;
   }
}
