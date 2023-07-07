import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/inventory/division_list.dart';
import 'package:cluster/presentation/inventory/manage_inventory.dart';
import 'package:cluster/presentation/inventory/response_review_screen.dart';
import 'package:cluster/presentation/inventory/stock_manage.dart';
import 'package:cluster/presentation/order_app/insight_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../product_hub/add_new_list.dart';
import 'bloc/inventory_bloc.dart';
import 'costing.dart';
import 'hierarchy_screen.dart';
import 'inventory_create_new_list.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

import 'model/inventory_model.dart';

class InventoryQuickAccess extends StatefulWidget {
  InventoryQuickAccess({Key? key}) : super(key: key);

  @override
  State<InventoryQuickAccess> createState() => _InventoryQuickAccessState();
}

class _InventoryQuickAccessState extends State<InventoryQuickAccess> {
  List<String> quickData = [
    'New  Variant',
    // 'Insight',
    'Manage Inventory',
    // 'Response & Reviews',
    // 'Virtual Stock',
    'Stock Manage',
    'Costing',
    'Hierarchy'
  ];

  @override
  void initState() {
    BlocProvider.of<InventoryBloc>(context)
        .add(ListVariantEvent(url: '', search: ""));

    //ListVariantEvent

    super.initState();
  }
  List<InventoryModel> allVariants = [];

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery
        .of(context)
        .size
        .width;
    double w = w1 > 700
        ? 400
        : w1;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is ListVariantSuccess) {
          for (var element in state.data!) {
            allVariants.add(element);
          }
        }

      },
      child: Container(
        // margin: const EdgeInsets.only(left: 12),
        // height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: GridView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: quickData.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 1.5 / 1.9,
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
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.string(TaskSvg().quickaccessIcon),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          quickData[i],
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontSize: w / 26,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
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
            screen: ManageInventoryScreen(),
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
            screen: StockManage(),
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
            screen: Costing(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: ResponseAndReviewScreen(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
          //ResponseAndReviewScreen
        };
        break;

      case 4:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: HierarchyScreen(),
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
            screen: StockManage(),
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
            screen: Costing(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
          //Costing
        };
        break;

      case 7:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: HierarchyScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
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