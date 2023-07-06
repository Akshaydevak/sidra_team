import 'package:cluster/presentation/contract_app/contract_svg.dart';
import 'package:cluster/presentation/taxes/tax_calculation.dart';
import 'package:cluster/presentation/taxes/tax_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../seller_app/product_list.dart';
import '../task_operation/task_svg.dart';
import 'new_vendor.dart';


class VendorQuick extends StatelessWidget {
  List<String> quickData = [
    'Add a Vendor',
     'Insights',
    'Product List',
    'Vendor Tax',
    'Point Corner',
    'Rebate',
    'Settle Payments',
    'GP Value'
  ];

  VendorQuick({Key? key}) : super(key: key);

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
    int select=0;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {

          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: NewVendor(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        };
        break;

      case 1:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: ContractProfile(),
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
            screen: ProductList(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        //ProductList
        };
        break;
      case 3:
        onTap = () {

        };
        break;
      case 4:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: TaxCalculation(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
        };
        break;
      case 5:
        onTap = () {

        };
        break;
      case 6:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: TaxHistory(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
          //TaxHistory
        };
        break;
    }
    return onTap;
  }
}
