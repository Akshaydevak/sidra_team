import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/discount_bloc.dart';
import 'package:cluster/presentation/promotion_app/discount_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../common_widgets/loading.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import 'discount_card.dart';
import 'models_promotion/discount_models/model_discount.dart';
import 'new_promotion.dart';

class DiscountScreen extends StatefulWidget {
   DiscountScreen({Key? key}) : super(key: key);

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  List<DiscountList> discountList=[];

  @override
  void initState() {
    context.read<DiscountBloc>().add( PaginatedDiscountListEvent("",""));
    super.initState();
  }
  String next="";
  String prev="";
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if(state is GetDiscountListLoading){
          Container(
              height: 500,
              color: Colors.red,
              child: customCupertinoLoading());
        }
        if(state is GetDiscountListSuccess){
          discountList=state.discountList.data;
          next=state.discountList.nextPageUrl??"";
          prev=state.discountList.count??"";
          print("AAAAA$discountList");
          print("AAAAA$next");
          print("AAAAA$prev");
          setState(() {

          });
        }
      },
  child: BlocConsumer<DiscountBloc, DiscountState>(
      listener: (context, state) {
        print("DASASAS$state");
        if(state is GetSearchedDiscountLoading){

          Container(
            height: 500,
              color: Colors.red,
              child: customCupertinoLoading());
        }
        if(state is GetSearchedDiscountSuccess){
          discountList=state.productItem.data;
          print("AAAAA$discountList");
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
              label: "Discount",
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
                    Container(width:w/1.1,
                        child: SearchCard(
                          hint: "Search Discount.......",
                      onchange: (val){
                        BlocProvider.of<DiscountBloc>(context)
                            .add(SearchPaginatedDiscountListEvent(query: val));
                      },
                    )),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${discountList.length} Results",
                      style: const TextStyle(
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
                          screen:  NewPromotion(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Text(
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
                SizedBox(height: 10,),
                ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>GestureDetector(
                      onTap: (){
                        context.read<DiscountBloc>().add(GetDiscountReadEvent(discountList[index].id??0));
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: DiscountView(),
                          withNavBar: true, // OPTIONAL VAL UE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                        child: DiscountCard(listDiscount: discountList[index],)) ,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10,),
                    itemCount: discountList.length),
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      prev==null||prev==""?Text(""):
                      GestureDetector(
                        onTap: (){
                          context.read<DiscountBloc>().add( PaginatedDiscountListEvent("",prev));
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
                          context.read<DiscountBloc>().add( PaginatedDiscountListEvent(next,""));
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
