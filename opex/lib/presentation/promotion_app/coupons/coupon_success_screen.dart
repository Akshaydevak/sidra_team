import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/discount_bloc.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_bloc/coupon_bloc.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_list.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../core/color_palatte.dart';
import '../../seller_app/seller_svg.dart';


class SuccessScreenCoupon extends StatefulWidget {
  final bool? update;
  SuccessScreenCoupon({Key? key, this.update}) : super(key: key);

  @override
  State<SuccessScreenCoupon> createState() => _SuccessScreenCouponState();
}

class _SuccessScreenCouponState extends State<SuccessScreenCoupon> {
  bool isActive = false;
  CouponList? readCoupon;
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
    return BlocListener<CouponBloc, CouponState>(
      listener: (context, state) {
        print("BUY MORE $state");
        if (state is GetCouponReadLoading) {
          customCupertinoLoading();
        }
        else if (state is GetCouponReadSuccess) {
          readCoupon = state.couponList;
          for(var i=0;i<readCoupon!.segments!.length;i++){
            segment.add(readCoupon?.segments?[i].segmentName??"");

          }
          for(int i=0;i<segment.length;i++){
            lifeStyle="$lifeStyle${segment[i]},";
          }
          print("lifee$lifeStyle");
          print("lifee${readCoupon?.line?.length}");
          setState(() {

          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
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
                    decoration: BoxDecoration(
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.update==true?"Coupon Updated Successfully !":"Coupon Created Successfully !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w / 22,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
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
                                color: Color(0xfff0f1f2),
                              ),
                              child: Image.network(readCoupon?.image??"",fit: BoxFit.cover,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  readCoupon?.name??"",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "From Jan 21, 2022 to Mar 22, 2022",
                                  style: GoogleFonts.roboto(
                                    color: Color(0x99666161),
                                    fontSize: w/25,
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
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Promotion Title",
                                style: TextStyle(
                                  color: Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readCoupon?.name??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
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
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readCoupon?.description??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
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
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readCoupon?.basedOn??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Offer Period Name",
                                style: TextStyle(
                                  color: Color(0x99666161),
                                  fontSize: w/25,
                                ),
                              ),
                              Text(
                                readCoupon?.offerPerodName??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   child: ListView.separated(
                        //       shrinkWrap: true,
                        //       primary: false,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemBuilder: (context, index) {
                        //         return  GestureDetector(
                        //           onTap: () {
                        //             onSelect(index);
                        //             setState(() {
                        //               // isActive = !isActive;
                        //             });
                        //           },
                        //           child: ClusterCard(
                        //             padding: EdgeInsets.zero,
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   padding: select==index
                        //                       ? EdgeInsets.fromLTRB(16, 16, 16, 10)
                        //                       : EdgeInsets.all(16),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Text(
                        //                         "Promotion Applying To",
                        //                         style: GoogleFonts.roboto(
                        //                           color: Colors.black,
                        //                           fontSize: 18,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                       Icon(Icons.keyboard_arrow_down_outlined)
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 select==index
                        //                     ? Container(
                        //
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                     MainAxisAlignment.start,
                        //                     crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                     children: [
                        //                       Divider(
                        //                         color: ColorPalette.divider,
                        //                       ),
                        //                       Container(
                        //                         padding:
                        //                         EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        //                             SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readCoupon?.line?[index].variantName.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //
                        //                             SizedBox(height: 10,),
                        //                             Text(
                        //                               "Variant Code",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readCoupon?.line?[index].variantCode.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             SizedBox(height: 10,),
                        //                             Text(
                        //                               "Bar Code",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readCoupon?.line?[index].barcode?.barcodeNumber.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             SizedBox(height: 10,),
                        //                             Text(
                        //                               "Coupon Line Code",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Colors.black,
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 5,
                        //                             ),
                        //                             Text(
                        //                               readCoupon?.line?[index].couponLineCode.toString()??"",
                        //                               style: GoogleFonts.roboto(
                        //                                 color: Color(0x99666161),
                        //                                 fontSize: 15,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //
                        //                           ],
                        //                         ),
                        //                       ),
                        //
                        //
                        //                     ],
                        //                   ),
                        //                 )
                        //                     : Container()
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //       separatorBuilder: (context, index) => Container(
                        //         height: 10,
                        //       ),
                        //       itemCount: readCoupon?.line?.length??0),
                        // ),

                        SizedBox(
                          height: 30,
                        ),
                        GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<CouponBloc>().add( PaginatedCouponListEvent("",""));
                            },
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: const [
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
