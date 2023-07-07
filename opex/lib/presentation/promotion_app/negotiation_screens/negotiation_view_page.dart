import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_bloc/negotiation_bloc.dart';
import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_page_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import '../models_promotion/discount_models/model_discount.dart';

class NegotiationViewPage extends StatefulWidget {
  const NegotiationViewPage({super.key});

  @override
  State<NegotiationViewPage> createState() => _NegotiationViewPageState();
}

class _NegotiationViewPageState extends State<NegotiationViewPage> {
  NegotiationList? readNegotiation;
  String lifeStyle="";
  List<String> segment=[];
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<NegotiationBloc, NegotiationState>(
          listener: (context, state) {
            if(state is GetNegotiationReadLoading){
              customCupertinoLoading();
            }
            else if(state is GetNegotiationReadSuccess){
              readNegotiation=state.negotiationList;
              for(var i=0;i<readNegotiation!.segments!.length;i++){
                segment.add(readNegotiation?.segments?[i].segmentName??"");
              }
              for(int i=0;i<segment.length;i++){
                lifeStyle="$lifeStyle${segment[i]},";
              }
              print("lifee$lifeStyle");
              print("lifee${readNegotiation?.segments?.length}");
              setState(() {

              });

            }
          },
        ),
        BlocListener<NegotiationBloc, NegotiationState>(
          listener: (context, state) {
            if (state is DeleteNegotiationLoading) {
              showSnackBar(context,
                  message: "Loading",
                  color: ColorPalette.green);
            } else if (state is DeleteNegotiationSuccess) {
              showSnackBar(context,
                  message: "Negotiation Deleted Successfully",
                  color: ColorPalette.green);
              context.read<NegotiationBloc>().add( PaginatedNegotiationListEvent("",""));
              Navigator.pop(context);

            } else if (state is DeleteNegotiationFailed) {
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
          child: BackAppBar(label: readNegotiation?.name??"",
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
                        child: Image.network(readNegotiation?.image??""),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            readNegotiation?.description??"",
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
                            "From Jan 21, 2022 to Mar 22, 2022",
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
                          readNegotiation?.name??"",
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
                          readNegotiation?.description??"",
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
                          readNegotiation?.basedOn??"",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ListView.separated(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) =>GestureDetector(
                  //       onTap: (){
                  //       },
                  //       child: Container(
                  //         width: w,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           border: Border.all(
                  //             color: Color(0xffe6ecf0),
                  //             width: 1,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Color(0x05000000),
                  //               blurRadius: 8,
                  //               offset: Offset(1, 1),
                  //             ),
                  //           ],
                  //           color: Colors.white,
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             Container(
                  //               padding:
                  //               EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     "Promotion Applying To",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Colors.black,
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   Icon(Icons.keyboard_arrow_down)
                  //                 ],
                  //               ),
                  //             ),
                  //             Divider(
                  //               color: ColorPalette.divider,
                  //             ),
                  //             Container(
                  //               padding:
                  //               EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     "Variant Name",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Colors.black,
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Text(
                  //                     readBuyMore?.lines?[index].variantName.toString()??"",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Color(0x99666161),
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //
                  //                   SizedBox(height: 10,),
                  //                   Text(
                  //                     "Variant Id",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Colors.black,
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Text(
                  //                     readBuyMore?.lines?[index].variantId.toString()??"",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Color(0x99666161),
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(height: 10,),
                  //                   Text(
                  //                     "Bar Code",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Colors.black,
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Text(
                  //                     readBuyMore?.lines?[index].barcode?.barcodeNumber.toString()??"",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Color(0x99666161),
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(height: 10,),
                  //                   Text(
                  //                     "Offer Name",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Colors.black,
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   Text(
                  //                     readBuyMore?.lines?[index].offerName.toString()??"",
                  //                     style: GoogleFonts.roboto(
                  //                       color: Color(0x99666161),
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       ),
                  //     ) ,
                  //     separatorBuilder: (context, index) => SizedBox(height: 10,),
                  //     itemCount: readBuyMore?.lines?.length??0),

                  SizedBox(height: 30,),
                  GradientButton(
                      color: Color(0xffe6ecf0),
                      onPressed: () {
                        context.read<NegotiationBloc>().add(GetNegotiationReadEvent(readNegotiation?.id??0));
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen:  NegotiationPageOne(editDiscount: true,),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
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
                        context.read<NegotiationBloc>().add( DeleteNegotiationEvent(readNegotiation?.id??0));
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
