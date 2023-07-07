import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_bloc/negotiation_bloc.dart';
import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_page_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../buy_more_get_form/buy_more_view.dart';
import '../buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import '../discount_card.dart';
import '../models_promotion/discount_models/model_discount.dart';
import 'negotiation_view_page.dart';

class NegotiationListPage extends StatefulWidget {
  const NegotiationListPage({super.key});

  @override
  State<NegotiationListPage> createState() => _NegotiationListPageState();
}

class _NegotiationListPageState extends State<NegotiationListPage> {
  List<NegotiationList> negotiationList=[];

  @override
  void initState() {
    context.read<NegotiationBloc>().add( PaginatedNegotiationListEvent("",""));
    super.initState();
  }
  String next="";
  String prev="";
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return BlocListener<NegotiationBloc, NegotiationState>(
      listener: (context, state) {
        if(state is GetNegotiationListLoading){

        }
        if(state is GetNegotiationListSuccess){
          negotiationList=state.discountList.data;
          next=state.discountList.nextPageUrl??"";
          prev=state.discountList.count??"";
          print("AAAAA$negotiationList");
          setState(() {

          });
        }
      },
      child: BlocConsumer<NegotiationBloc, NegotiationState>(
        listener: (context, state) {
          if(state is GetSearchedNegotiationLoading){

          }
          if(state is GetSearchedNegotiationSuccess){
            negotiationList=state.productItem.data;
            print("AAAAA$negotiationList");
            setState(() {

            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: BackAppBar(label: "Negotiation",
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
                          Container(
                              width:w/1.1,
                              child: SearchCard(
                                hint: "Search Negotiation...",
                                onchange: (val){
                                  BlocProvider.of<NegotiationBloc>(context)
                                      .add(SearchPaginatedNegotiationListEvent(query: val));
                                },
                              )),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${negotiationList.length} Results",
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
                                screen:  NegotiationPageOne(editDiscount: false,),
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
                                context.read<NegotiationBloc>().add(GetNegotiationReadEvent(negotiationList[index].id??0));
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: NegotiationViewPage(),
                                  withNavBar: true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              },
                              child: NegotiationCard(buyMoreList: negotiationList[index],)) ,
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: negotiationList.length),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            prev==null||prev==""?Text(""):
                            GestureDetector(
                              onTap: (){
                                context.read<BuyMoreBloc>().add( PaginatedBuyMoreListEvent("",prev));
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
                                context.read<BuyMoreBloc>().add( PaginatedBuyMoreListEvent(next,""));
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
