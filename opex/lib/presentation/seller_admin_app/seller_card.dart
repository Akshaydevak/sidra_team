import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/seller_admin_app/seller_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_app/order_svg.dart';
import 'model_seller_admin/seller_admin_models.dart';

class SellerCard extends StatelessWidget {
  final SellerListAdmin? listData;
  const SellerCard({Key? key, this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return GestureDetector(
      onTap: (){
        context
            .read<SellerAdminBloc>()
            .add( GetSellerRead(listData?.id??0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: SellerView(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //  SellerView
      },
      child: Container(
        width: w,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(listData?.logo??""),
        ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w1/1.7,
                  child: Text(
                    listData?.name??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // SizedBox(height: 5,),
                // Text(
                //   "Super Market",
                //   style: TextStyle(
                //     color: Color(0xff7d7d7d),
                //     fontSize: 14,
                //   ),
                // ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.string(ProfileSvg().emailIcon),
                    SizedBox(width: 5,),
                    Container(
                      width: w1/1.8,
                      child: Text(
                        listData?.email??"",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ) ,
                SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.string(OrderSvg().callIcon,color: ColorPalette.primary,height: 15,width: 15,),
                    SizedBox(width: 5,),
                    Text(
                      // "+971 986587454",
                      listData?.contact?.primary??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
