import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/mpos/payment_method.dart';
import 'package:cluster/presentation/mpos/pick_pack_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';
import 'gift_card.dart';
import 'mpos_svg.dart';

class PickAndPack extends StatefulWidget {
  const PickAndPack({Key? key}) : super(key: key);

  @override
  State<PickAndPack> createState() => _PickAndPackState();
}

class _PickAndPackState extends State<PickAndPack> {
  bool isPick = false;
  bool isQuality = false;
  bool isPack = false;
  int? select;


  void onSelect(int val) {
    select = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Pick and Pack"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: w / 1.35, child: SearchCard()),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 50,
                      height: 50,
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
                      child: SvgPicture.string(MposSvg().filterIcon),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PickAndPackCard();
                      },
                      separatorBuilder: (context, index) => Container(
                            height: 10,
                          ),
                      itemCount: 5),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gift Collection",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // color: Colors.green,
                              height: h / 8,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index == 3) {
                                      return Container(
                                        width: 54,
                                        height: 87,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xfffe5762),
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x05000000),
                                              blurRadius: 8,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                          color: Color(0x19fe5762),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "+7",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xfffe5762),
                                            fontSize: 20,

                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap:() {
                                        onSelect(index);
                                        setState((){

                                        });
                                      },
                                        child: GiftCard(isSelect: select==index,));
                                  },
                                  separatorBuilder: (context, index) => Container(
                                        width: 5,
                                      ),
                                  itemCount: 4),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPick = !isPick;
                                    });
                                  },
                                  child: isPick
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.string(
                                              OrderSvg().checkBoxActiveIcon))
                                      : SvgPicture.string(
                                          OrderSvg().checkBoxIcon,
                                          height: 35,
                                          width: 35,
                                        ),
                                ),
                                Text(
                                  "Picked",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff1b1b1f),
                                    fontSize: w / 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isQuality = !isQuality;
                                    });
                                  },
                                  child: isQuality
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.string(
                                              OrderSvg().checkBoxActiveIcon))
                                      : SvgPicture.string(
                                          OrderSvg().checkBoxIcon,
                                          height: 35,
                                          width: 35,
                                        ),
                                ),
                                Text(
                                  "QuantityChecked",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff1b1b1f),
                                    fontSize: w / 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPack = !isPack;
                                    });
                                  },
                                  child: isPack
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.string(
                                              OrderSvg().checkBoxActiveIcon))
                                      : SvgPicture.string(
                                          OrderSvg().checkBoxIcon,
                                          height: 35,
                                          width: 35,
                                        ),
                                ),
                                Text(
                                  "Packed",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff1b1b1f),
                                    fontSize: w / 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PaymentMethod(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      //  PickAndPack
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          ColorPalette.primary,
                          ColorPalette.primary
                        ]),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
