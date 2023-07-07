import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/discount_bloc.dart';
import 'package:cluster/presentation/promotion_app/buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_bloc/coupon_bloc.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_form_one.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_view.dart';
import 'package:cluster/presentation/promotion_app/discount_view.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../discount_card.dart';

class CouponListScreen extends StatefulWidget {
  CouponListScreen({Key? key}) : super(key: key);

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  List<CouponList> couponList=[];
  String next="";
  String prev="";
  @override
  void initState() {
    context.read<CouponBloc>().add( PaginatedCouponListEvent("",""));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return BlocListener<CouponBloc, CouponState>(
      listener: (context, state) {
        print("state coupon $state");
        if(state is GetCouponListLoading){

        }
        if(state is GetCouponListSuccess){
          couponList=state.couponList.data;
          next=state.couponList.nextPageUrl??"";
          prev=state.couponList.count??"";
          print("AAAAA$couponList");
          setState(() {

          });
        }
      },
      child: BlocConsumer<CouponBloc, CouponState>(
        listener: (context, state) {
          if(state is GetSearchedCouponLoading){

          }
          if(state is GetSearchedCouponSuccess){
            couponList=state.productItem.data;
            print("AAAAA$couponList");
            setState(() {

            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: BackAppBar(
                  label: "Coupons",
                  isBack: true,
                  isAction: false,
                  onTap: (){
                    Navigator.pop(context);
                  }),
            ),
            body: ScrollConfiguration(behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width:w/1.1,child: SearchCard(
                            hint: "Search Coupon...",
                            onchange: (val){
                              BlocProvider.of<CouponBloc>(context)
                                  .add(SearchPaginatedCouponListEvent(query: val));
                            },
                          )),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${couponList.length} Results",
                            style: TextStyle(
                              color: Color(0xff151522),
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen:  CouponFormOne(),
                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.fade,
                              );
                            },
                            child: const Text(
                              "+ Add New",
                              style: TextStyle(
                                color: Color(0xfffe5762),
                                fontSize: 16,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                              ),

                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>GestureDetector(
                              onTap: (){
                                context.read<CouponBloc>().add(GetCouponReadEvent(couponList[index].id??0));
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: CouponView(),
                                  withNavBar: true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              },
                              child: CouponCard(couponList: couponList[index])) ,
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: couponList.length),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            prev==null||prev==""?Text(""):
                            GestureDetector(
                              onTap: (){
                                context.read<CouponBloc>().add( PaginatedCouponListEvent("",prev));
                              },
                              child: Text(
                                "Previous",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.primary,
                                    fontSize: w / 24),
                              ),
                            ),
                            next==null||next==""?Text(""):
                            GestureDetector(
                              onTap: (){
                                context.read<CouponBloc>().add( PaginatedCouponListEvent(next,""));
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.primary,
                                    fontSize: w / 24),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),),
          );
        },
      ),
    );
  }
}
