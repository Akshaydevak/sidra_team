import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/stock_details.dart';
import 'package:cluster/presentation/inventory/widget/inventory_outstock_card.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/stock_app/out_stock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'model/inventory_model.dart';
import 'widget/Inventory_product_card.dart';

class StockManage extends StatefulWidget {
  const StockManage({Key? key}) : super(key: key);

  @override
  State<StockManage> createState() => _StockManageState();
}

class _StockManageState extends State<StockManage> {
  @override
  void initState() {
    context.read<InventoryBloc>().add(ProductStockListEvent("",""));
    super.initState();
  }

  List<InventoryModel>? variantList;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: "Stock Manage",
          isAction: false),

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
                  SearchCard(
                    hint: "Search Products...",
                    onchange: (fa){
                      context.read<InventoryBloc>().add(ProductStockListEvent(fa,""));
                      setState(() {

                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      if (state is StockListProductLoading) {}
                      if (state is StockListProductSuccess) {
                        variantList = state.product.data;
                        print("NEXTTTT${state.product.nextPageUrl}");
                        print("NEXTTTT${state.product.previousUrl}");
                        print("NEXTTTT${state.product.count}");
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total ${variantList!.length} Products",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(6),
                                //   width: 35,
                                //   height: 35,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(4),
                                //     border: Border.all(
                                //       color: Color(0xff8ca6b6),
                                //       width: 1,
                                //     ),
                                //     color: Color(0xffeef3f6),
                                //   ),
                                //   child: SvgPicture.string(
                                //     MposSvg().filterIcon,
                                //     color: ColorPalette.subtextGrey,
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        context.read<InventoryBloc>().add(ReadStockProductEvent(variantList?[index].id??0));
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: StockDetails(
                                            variantData: variantList?[index],
                                          ),
                                          withNavBar:
                                              true, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade,
                                        );
                                        //  StockDetails
                                      },
                                      child: InventoryOutStockCard(
                                        isStock: true,
                                        variantList: variantList?[index],
                                      ));
                                },
                                separatorBuilder: (context, index) => Container(
                                      height: 10,
                                    ),
                                itemCount: variantList!.length),
                            Padding(
                              padding:  EdgeInsets.only(top: 15,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  state.product?.count!=null?GestureDetector(
                                    onTap: (){
                                      context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                    },
                                    child: Text(
                                      "Previous",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.primary,
                                          fontSize: w / 24),
                                    ),
                                  ):Container(),
                                  state.product?.nextPageUrl!=null?
                                  GestureDetector(
                                    onTap: (){
                                      context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                      setState(() {

                                      });
                                    },
                                    child: Text("Next",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.primary,
                                          fontSize: w / 24),),
                                  ):Text("")
                                ],
                              ),
                            )
                          ],
                        );
                      }
                      return ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: StockDetails(),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                  //  StockDetails
                                },
                                child: OutStockCard(
                                  isStock: true,
                                ));
                          },
                          separatorBuilder: (context, index) => Container(
                                height: 10,
                              ),
                          itemCount: 5);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
