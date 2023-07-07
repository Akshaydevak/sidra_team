import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/costing_view.dart';
import 'package:cluster/presentation/inventory/widget/costing_card.dart';
import 'package:cluster/presentation/inventory/widget/inventory_outstock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/no_glow.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../stock_app/out_stock_card.dart';
import 'model/inventory_model.dart';

class CostingListPage extends StatefulWidget {
  final InventoryModel? variantData;
   CostingListPage({Key? key, this.variantData}) : super(key: key);

  @override
  State<CostingListPage> createState() => _CostingListPageState();
}

class _CostingListPageState extends State<CostingListPage> {
  int select = 0;

  void onselect(int index) {
    setState(() {
      select = index;
    });
  }

  int selectIndex = 0;
  @override
  void initState() {
    context.read<InventoryBloc>().add(  CostingListEvent("", "",widget.variantData?.id??0));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),

          child: BackAppBar(label: "Costing",
          isBack: false,
          onTap: (){
            context.read<InventoryBloc>().add(ProductStockListEvent("", ""));
            Navigator.pop(context);
          },),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InventoryOutStockCard(
                      isStock: true,
                      variantList: widget.variantData,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CostingView(variantData: widget.variantData),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Container(
                        width: w,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xffe6ecf0),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Color(0xfffe5762),
                            ),
                            Text(
                              "Add new",
                              style: TextStyle(
                                color: Color(0xfffe5762),
                                fontSize: 16,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      if(state is CostingListLoading){

                      }
                      else if(state is CostingListSuccess){
                        List<CostingReadData>? cost;
                        print("FFFFFF${state.costData.data}");

                        cost=state.costData.data;

                    return SizedBox(
                      width: w,
                      child: ListView.separated(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: cost!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<InventoryBloc>().add( CostingReadEvent(cost?[index].id??0));
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: CostingView(variantData: widget.variantData,
                                        editCosting: true,),
                                        withNavBar: true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: Container(
                                      width: w,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xffe6ecf0),
                                          width: 1,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x05000000),
                                            blurRadius: 8,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:  [
                                          Text(
                                            "Costing Name",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            cost?[index].costingName??"",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(Icons.keyboard_arrow_right)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          separatorBuilder: (context, index) => Container(
                                color: ColorPalette.white,
                                height: 1,
                                width: w,
                              )),
                    );
                      }
                      return Container();
  },
)
                  ]),
            ),
          ),
        ));
  }
}
