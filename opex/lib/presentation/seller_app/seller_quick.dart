import 'package:cluster/presentation/order_app/insight_screen.dart';
import 'package:cluster/presentation/seller_admin_app/operations/outlet.dart';
import 'package:cluster/presentation/seller_app/product_list.dart';
import 'package:cluster/presentation/seller_app/product_review_list.dart';
import 'package:cluster/presentation/seller_app/top_review_product_list.dart';
import 'package:cluster/presentation/seller_app/top_selling_product_List.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/utils/variables.dart';
import '../inventory/costing.dart';
import '../inventory/inventory_create_new_list.dart';
import '../inventory/manage_inventory.dart';
import '../inventory/stock_manage.dart';
import '../task_operation/task_svg.dart';
import 'create_product_short.dart';
import 'new_product_list.dart';
import 'new_seller.dart';

class SellerQuick extends StatelessWidget {
  bool isAdmin;
   SellerQuick({Key? key,this.isAdmin=false}) : super(key: key);
  List<String> quickData=[
    // 'Add New Outlet',
    // 'Add New Product',
    'Order Summary',
    'Seller Tax',
    'Purchase',
    'Sales Report',
    'Settings',
    'Help'
  ];
  List<String> adminQuickData=[
    'Add New Product',
    'Product List',
    'Stock',
    'Costing',
    'New Products',
    'Top Selling Products',
    'Top Review Products',
    'Product Review List',
    'Add Product'
  ];
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return SizedBox(

        width: w1,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.6 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                 onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                child: Container(
                  width: 88,
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
                        isAdmin?quickData[i] :adminQuickData[i],
                        style: TextStyle(
                          color: Color(0xff121113),
                          fontSize: w/28,
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
           Variable.division = null;
           Variable.category = null;
           Variable.subcategory = null;
           Variable.group = null;
           Variable.item = null;
           Variable.uom = null;
           Variable.stock = null;
           //
           // PersistentNavBarNavigator.pushNewScreen(
           //   context,
           //   screen: InventoryCreateNewList(),
           //   withNavBar: true,
           //   // OPTIONAL VALUE. True by default.
           //   pageTransitionAnimation: PageTransitionAnimation.fade,
           // );
           // PersistentNavBarNavigator.pushNewScreen(
           //   context,
           //   screen: Outlet(),
           //   withNavBar: true,
           //   // OPTIONAL VALUE. True by default.
           //   pageTransitionAnimation:
           //   PageTransitionAnimation.fade,
           // );
         };
         break;

       case 1:
         onTap = () {
           // PersistentNavBarNavigator.pushNewScreen(
           //   context,
           //   screen: ManageInventoryScreen(),
           //   withNavBar: true,
           //   // OPTIONAL VALUE. True by default.
           //   pageTransitionAnimation: PageTransitionAnimation.fade,
           // );
           // PersistentNavBarNavigator.pushNewScreen(
           //   context,
           //   screen: AddNewProduct(),
           //   withNavBar: true,
           //   // OPTIONAL VALUE. True by default.
           //   pageTransitionAnimation:
           //   PageTransitionAnimation.fade,
           // );
         };
         break;
       case 2:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: StockManage(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 3:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: Costing(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 4:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: NewProductSellerList(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 5:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: TopSellingProductList(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
       case 6:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: TopReviewProductsList(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
         case 7:
         onTap = () {
           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: ProductReviewList(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
         };
         break;
         case 8:
         onTap = () {
           Variable.division = null;
           Variable.category = null;
           Variable.subcategory = null;
           Variable.group = null;
           Variable.item = null;
           Variable.uom = null;
           Variable.stock = null;

           PersistentNavBarNavigator.pushNewScreen(
             context,
             screen: CreateNewProductShort(),
             withNavBar: true,
             // OPTIONAL VALUE. True by default.
             pageTransitionAnimation: PageTransitionAnimation.fade,
           );
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
