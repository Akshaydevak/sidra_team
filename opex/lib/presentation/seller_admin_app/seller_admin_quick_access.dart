
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../task_operation/task_svg.dart';
import 'new_seller_admin.dart';

class SellerAdminQuick extends StatelessWidget {

  SellerAdminQuick({Key? key}) : super(key: key);

  List<String> adminQuickData=[
    'Add New Seller',
    'Seller Tax',
    'Point Corner',
    'Rebate',
    'Settle Payment',
    'GP Value'
  ];
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(

        width: w1,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.6 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: onTapListTileAdmin(i, context),
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
                        adminQuickData[i],
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
  // VoidCallback onTapListTile(int i, BuildContext context) {
  //   // String email = Variables.emailfield;
  //   VoidCallback onTap;
  //   onTap = () {};
  //   switch (i) {
  //     case 0:
  //       onTap = () {
  //         Variable.division = null;
  //         Variable.category = null;
  //         Variable.subcategory = null;
  //         Variable.group = null;
  //         Variable.item = null;
  //         Variable.uom = null;
  //         Variable.stock = null;
  //
  //         PersistentNavBarNavigator.pushNewScreen(
  //           context,
  //           screen: InventoryCreateNewList(),
  //           withNavBar: true,
  //           // OPTIONAL VALUE. True by default.
  //           pageTransitionAnimation: PageTransitionAnimation.fade,
  //         );
  //         // PersistentNavBarNavigator.pushNewScreen(
  //         //   context,
  //         //   screen: Outlet(),
  //         //   withNavBar: true,
  //         //   // OPTIONAL VALUE. True by default.
  //         //   pageTransitionAnimation:
  //         //   PageTransitionAnimation.fade,
  //         // );
  //       };
  //       break;
  //
  //     case 1:
  //       onTap = () {
  //         PersistentNavBarNavigator.pushNewScreen(
  //           context,
  //           screen: ManageInventoryScreen(),
  //           withNavBar: true,
  //           // OPTIONAL VALUE. True by default.
  //           pageTransitionAnimation: PageTransitionAnimation.fade,
  //         );
  //         // PersistentNavBarNavigator.pushNewScreen(
  //         //   context,
  //         //   screen: AddNewProduct(),
  //         //   withNavBar: true,
  //         //   // OPTIONAL VALUE. True by default.
  //         //   pageTransitionAnimation:
  //         //   PageTransitionAnimation.fade,
  //         // );
  //       };
  //       break;
  //     case 2:
  //       onTap = () {
  //         PersistentNavBarNavigator.pushNewScreen(
  //           context,
  //           screen: StockManage(),
  //           withNavBar: true,
  //           // OPTIONAL VALUE. True by default.
  //           pageTransitionAnimation: PageTransitionAnimation.fade,
  //         );
  //       };
  //       break;
  //     case 3:
  //       onTap = () {
  //         PersistentNavBarNavigator.pushNewScreen(
  //           context,
  //           screen: Costing(),
  //           withNavBar: true,
  //           // OPTIONAL VALUE. True by default.
  //           pageTransitionAnimation: PageTransitionAnimation.fade,
  //         );
  //       };
  //       break;
  //
  //
  //   }
  //   return onTap;
  // }
  VoidCallback onTapListTileAdmin(int i, BuildContext context) {
    // String email = Variables.emailfield;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: NewSellerAdmin(),
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
          //   screen:  InsightScreen(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation:
          //   PageTransitionAnimation.fade,
          // );
        };
        break;
      case 2:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen:  ProductList(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation:
          //   PageTransitionAnimation.fade,
          // );
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
