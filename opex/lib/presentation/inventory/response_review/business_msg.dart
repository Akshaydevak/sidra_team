import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/inventory/response_review/recent_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BussinessMessage extends StatelessWidget {
  const BussinessMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Business Messages"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Recent Chat",
                    style: GoogleFonts.roboto(
                      color: Color(0xff151522),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    itemBuilder: (context, index) => RecentCard(),
                    separatorBuilder: (context, index) => Container(color: ColorPalette.divider,height: 1.1,width: w,),
                    itemCount: 15),
                SizedBox(height: 20,),
                Divider(indent: 16,endIndent: 16,thickness: 1.1,color: ColorPalette.divider,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
