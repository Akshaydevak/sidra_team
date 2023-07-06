import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/call_center/widgets/search_callcenter_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/color_palatte.dart';
import 'call_center_svg.dart';
import 'callcenter_cart.dart';

class CallCenterSearch extends StatelessWidget {
  String? selGender;
  List<String> gender = ["Wholesale", "Retails"];
  String? selectedGender;

  CallCenterSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: ColorPalette.white, // Status bar
          ),
          elevation: 0,
          title: Column(
            children: [
              SearchCard(),
            ],
          ),
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                    child: SvgPicture.string(CallCenterSvg().moreIcon)),
              ],
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: w / 2.5,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffe6ecf0),
                              width: 0.50,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 7,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              underline: Container(),
                              items: gender.map((String items) {
                                return DropdownMenuItem(
                                  enabled: true,
                                  value: items,
                                  child: Text(items,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              value: selectedGender,
                              onChanged: (dynamic value) {},
                              hint: Text(
                                "Wholesale",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: w / 2.5,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffe6ecf0),
                              width: 0.50,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 7,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              underline: Container(),
                              items: gender.map((String items) {
                                return DropdownMenuItem(
                                  enabled: true,
                                  value: items,
                                  child: Text(items,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              value: selectedGender,
                              onChanged: (dynamic value) {},
                              hint: Text(
                                "Branch",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => SearchCallCenterCard(),
                      separatorBuilder: (context, index) => Container(
                            width: 415.50,
                            height: 2.50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xfff1f1f1),
                                width: 1.50,
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
                          ),
                      itemCount: 5)
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    width: w / 1.1,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xfffe5762),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "2 Items :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "1925.25",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: CallCenterCart(),
                              withNavBar: true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                          },
                          child: Text(
                            "View Cart",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
