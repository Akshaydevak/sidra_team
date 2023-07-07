import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_bloc/negotiation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/cluster_card.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../seller_app/seller_svg.dart';
import '../buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import '../models_promotion/discount_models/model_discount.dart';

class NegotiationSuccessScreen extends StatefulWidget {
  final bool? update;
  const NegotiationSuccessScreen({super.key, this.update});

  @override
  State<NegotiationSuccessScreen> createState() => _NegotiationSuccessScreenState();
}

class _NegotiationSuccessScreenState extends State<NegotiationSuccessScreen> {
  bool isActive = false;
  NegotiationList? readByMore;
  List<String> segment=[];
  String lifeStyle="";
  int select=0;
  void onSelect(int val) {
    select = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<NegotiationBloc, NegotiationState>(
      listener: (context, state) {
        debugPrint("BUY MORE $state");
        if (state is GetNegotiationReadLoading) {
          customCupertinoLoading();
        }
        else if (state is GetNegotiationReadSuccess) {
          readByMore = state.negotiationList;
          for(var i=0;i<readByMore!.segments!.length;i++){
            segment.add(readByMore?.segments?[i].segmentName??"");

          }
          for(int i=0;i<segment.length;i++){
            lifeStyle="$lifeStyle${segment[i]},";
          }
          print("life$lifeStyle");
          print("life${readByMore?.segments?.length}");
          setState(() {

          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white, // Navigation bar
                statusBarColor: Color(0xff3aba6f), // Status bar
              ),
            )),
        body: ScrollConfiguration(behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              // height: h,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    width: w,
                    height: h / 4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff3aba6f), Color(0xff1e9a51)],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.string(SellerSvg().tickIcon),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.update==true?"Negotiation updated successfully !":"Negotiation created successfully !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w / 22,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xfff0f1f2),
                              ),
                              child: Image.network(readByMore?.image??"",fit: BoxFit.cover,),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  readByMore?.name??"",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "From Jan 21, 2022 to Mar 22, 2022",
                                  style: GoogleFonts.roboto(
                                    color: const Color(0x99666161),
                                    fontSize: w/25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClusterCard(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Segment",
                                style: TextStyle(
                                  color: Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                lifeStyle,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Promotion Title",
                                style: TextStyle(
                                  color: const Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readByMore?.name??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: const Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readByMore?.description??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Offer Based on",
                                style: TextStyle(
                                  color: const Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readByMore?.basedOn??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // ListView.separated(
                        //     shrinkWrap: true,
                        //     primary: false,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return  GestureDetector(
                        //         onTap: () {
                        //           onSelect(index);
                        //           setState(() {
                        //             isActive = !isActive;
                        //           });
                        //         },
                        //         child: ClusterCard(
                        //           padding: EdgeInsets.zero,
                        //           child: Column(
                        //             children: [
                        //               Container(
                        //                 padding: select==index
                        //                     ? const EdgeInsets.fromLTRB(16, 16, 16, 10)
                        //                     : const EdgeInsets.all(16),
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       "Promotion Applying To",
                        //                       style: GoogleFonts.roboto(
                        //                         color: Colors.black,
                        //                         fontSize: 18,
                        //                         fontWeight: FontWeight.w500,
                        //                       ),
                        //                     ),
                        //                     const Icon(Icons.keyboard_arrow_down_outlined)
                        //                   ],
                        //                 ),
                        //               ),
                        //               select==index
                        //                   ? Column(
                        //                     mainAxisAlignment:
                        //                     MainAxisAlignment.start,
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       const Divider(
                        //                         color: ColorPalette.divider,
                        //                       ),
                        //                       Container(
                        //                         padding:
                        //                         const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        //                         child: Column(
                        //                           mainAxisAlignment: MainAxisAlignment.start,
                        //                           crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               "Variant Name",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readByMore?.lines?[index].variantName.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: const Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //
                        //                             const SizedBox(height: 10,),
                        //                             Text(
                        //                               "Variant Id",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readByMore?.lines?[index].variantId.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: const Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(height: 10,),
                        //                             Text(
                        //                               "Bar Code",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readByMore?.lines?[index].barcode?.barcodeNumber.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: const Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(height: 10,),
                        //                             Text(
                        //                               "Offer Name",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readByMore?.lines?[index].offerName.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: const Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //
                        //                           ],
                        //                         ),
                        //                       ),
                        //
                        //                     ],
                        //                   )
                        //                   : Container()
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) => Container(
                        //       height: 10,
                        //     ),
                        //     itemCount: readByMore?.lines?.length??0),

                        const SizedBox(
                          height: 30,
                        ),
                        GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<BuyMoreBloc>().add( PaginatedBuyMoreListEvent("",""));
                            },
                            gradient:  LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "View all Promotions",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
