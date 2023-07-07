import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/discount_bloc.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'new_promotion.dart';

class DiscountView extends StatefulWidget {
  const DiscountView({Key? key}) : super(key: key);

  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  DiscountList? readDiscount;
  String lifeStyle="";
  List<String> segment=[];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if(state is GetDiscountReadLoading){
          customCupertinoLoading();
        }
        else if(state is GetDiscountReadSuccess){
          readDiscount=state.discountList;

          
          for(var i=0;i<readDiscount!.segments!.length;i++){
            segment.add(readDiscount?.segments?[i].segmentName??"");

          }
          for(int i=0;i<segment.length;i++){
            lifeStyle="$lifeStyle${segment[i]},";
          }
print("lifee$lifeStyle");
print("lifee${readDiscount?.segments?.length}");
          setState(() {

          });
        }
      },
),
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if (state is DeleteDiscountLoading) {
          showSnackBar(context,
              message: "Loading",
              color: ColorPalette.green);
        } else if (state is DeleteDiscountSuccess) {
          showSnackBar(context,
              message: "Discount Deleted Successfully",
              color: ColorPalette.green);
          context.read<DiscountBloc>().add( const PaginatedDiscountListEvent("",""));
          Navigator.pop(context);

        } else if (state is DeleteDiscountFailed) {
          showSnackBar(context,
              message: "Not Deleted", color: ColorPalette.black);
        }
      },
    ),
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: readDiscount?.title??"",
              isBack: true,
              isAction: false,
              onTap: (){
                Navigator.pop(context);
              }),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xfff0f1f2),
                        ),
                        child: Image.network(readDiscount?.image??""),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            readDiscount?.description??"",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          readDiscount?.offerPeriodDetails?.fromDate==""||readDiscount?.offerPeriodDetails?.toDate==""
                              ||readDiscount?.offerPeriodDetails?.fromDate==null||readDiscount?.offerPeriodDetails?.toDate==null?Text(""):
                          Text(
                            "From ${readDiscount?.offerPeriodDetails?.fromDate??""} to ${readDiscount?.offerPeriodDetails?.toDate??""}",
                            style: GoogleFonts.roboto(
                              color: Color(0x99666161),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Color(0xffe6ecf0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Segment",
                          style: TextStyle(
                            color: Color(0x99666161),
                            fontSize: 15,
                          ),
                        ),

                        Text(
                          lifeStyle,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Promotion Title",
                          style: TextStyle(
                            color: Color(0x99666161),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          readDiscount?.title??"",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            color: Color(0x99666161),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          readDiscount?.description??"",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Offer Based on",
                          style: TextStyle(
                            color: Color(0x99666161),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          readDiscount?.basedOn??"",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // const Text(
                        //   "Offer Period Name",
                        //   style: TextStyle(
                        //     color: Color(0x99666161),
                        //     fontSize: 15,
                        //   ),
                        // ),
                        // Text(
                        //   readDiscount?.offerPeriodDetails?.title??"",
                        //   style: GoogleFonts.roboto(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffe6ecf0),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Promotion Applying To",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: ColorPalette.divider,
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 76,
                                            height: 76,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Color(0xfff0f1f2),
                                            ),
                                            child: Image.network(readDiscount?.offerLines?[index].image??""),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                "Type Name",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                readDiscount?.offerLines?[index].typeApplying.toString()??"",
                                                style: GoogleFonts.roboto(
                                                  color: Color(0x99666161),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        readDiscount?.offerLines?[index].title??"",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      const Text(
                                        "Discount Price / Percentage",
                                        style: TextStyle(
                                          color: Color(0x99666161),
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        readDiscount?.discountPercentageorPrice.toString()??"",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // SizedBox(height: 16,),
                                      // Text(
                                      //   "Offer Period",
                                      //   style: TextStyle(
                                      //     color: Color(0x99666161),
                                      //     fontSize: 15,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                                      //   style: GoogleFonts.roboto(
                                      //     color: Colors.black,
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                      ) ,
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: readDiscount?.offerLines?.length??0),

                  SizedBox(height: 30,),
                  GradientButton(
                      color: Color(0xffe6ecf0),
                      onPressed: () {
                        context.read<DiscountBloc>().add(GetDiscountReadEvent(readDiscount?.id??0));
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen:  NewPromotion(editDiscount: true,),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [
                            ColorPalette.white,
                            ColorPalette.white
                          ]),
                      child: Text(
                        "Edit Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )), SizedBox(height: 10,),
                  GradientButton(
                      color: Color(0xffe6ecf0),
                      onPressed: () {
                        context.read<DiscountBloc>().add( DeleteDiscountEvent(readDiscount?.id??0));
                      },
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [
                            ColorPalette.white,
                            ColorPalette.white
                          ]),
                      child: Text(
                        "Delete this Promotion",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
);
  }
}
