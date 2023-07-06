import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/wallet_app/wallet_history_detail.dart';
import 'package:cluster/presentation/wallet_app/wallet_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
class WalletHistory extends StatelessWidget {
  List<Color>colorList=[Color(0xfffd5762),Color(0xff33700e),Color(0xff0e6470), Color(0xff70540e),Color(0xff700e0e),Color(0xff0e1770),Color(0xff33700e), Color(0xff6e0e70)];
   List<String>appsList=["Inventry App","Callcenter","Ahlan Cart","Wallet","Promotion App","Callcenter","Logistic App","Sidra App"];
  WalletHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Wallet History",isAction: false),
      ),
      body: ScrollConfiguration(behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose App",
                style: GoogleFonts.roboto(
                  color: Color(0xff151522),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            primary: true,
            shrinkWrap: true,
            itemCount: colorList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 1.2,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: WalletHistoryDetails(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:colorList[index].withOpacity(0.08),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorList[index].withOpacity(0.8),
                        ),
                        child: SvgPicture.string(WalletSvg().appIcon),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        appsList[index]??"Inventry App",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              );

            }),
            ],
          ),
        ),
      ),),
    );
  }
}
