import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/inventory/widget/Inventory_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/headline_text.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/product_card.dart';
import '../mpos/search_card.dart';
import '../order_app/quick_access.dart';
import '../task_operation/home_card.dart';
import 'bloc/inventory_bloc.dart';
import 'inventory_quickaccess.dart';
import 'inventory_search_screen.dart';
import 'model/inventory_model.dart';

class InventoryDashBoard extends StatefulWidget {
  const InventoryDashBoard({Key? key}) : super(key: key);

  @override
  State<InventoryDashBoard> createState() => _InventoryDashBoardState();
}

class _InventoryDashBoardState extends State<InventoryDashBoard> {
  @override
  void initState() {
    BlocProvider.of<InventoryBloc>(context)
        .add(GetInventoryEvent());
    BlocProvider.of<InventoryBloc>(context)
        .add(ListVariantEvent(url: '', search: ""));
    // TODO: implement initState
    super.initState();
  }
  List<InventoryModel> allVariants = [];


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is ListVariantSuccess) {
          for (var element in state.data!) {
            allVariants.add(element);
          }
          setState(() {

          });
        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(label: "Inventory", isAction: false),
        ),
        body: BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is InventorySuccess) {
              Variable.inventoryName = state.inventory?[0].displayName;
              print("Inside Inventory${Variable.inventoryName}");
            }
          },
          child: ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SearchCard(
                    //   onTap: () {
                    //     PersistentNavBarNavigator.pushNewScreen(
                    //       context,
                    //       screen: InventorySearchScreen(),
                    //       withNavBar: true, // OPTIONAL VALUE. True by default.
                    //       pageTransitionAnimation: PageTransitionAnimation.fade,
                    //     );
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     HomeCard(
                    //       head: "120",
                    //       sub: "Newly Added",
                    //     ),
                    //     HomeCard(
                    //       head: '32',
                    //       sub: "Total Products",
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     HomeCard(
                    //       head: "3200",
                    //       sub: "Returned Orders",
                    //     ),
                    //     HomeCard(
                    //       head: '362',
                    //       sub: "Out of stock items",
                    //     )
                    //   ],
                    // ),

                    HeadlineText(headText: "Quick access to :"),

                    InventoryQuickAccess(),
                    HeadlineText(headText: "Newly added products"),

                    Container(
                      child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InventoryProductCard(
                              isSearch: false,
                            data: allVariants[index],);
                          },
                          separatorBuilder: (context, index) =>
                              Container(
                                height: 10,
                              ),
                          itemCount: allVariants.length>=5?5:allVariants.length),
                    ),
                    BottomCard()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
