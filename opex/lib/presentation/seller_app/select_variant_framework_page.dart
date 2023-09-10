import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class SelectVariantFrameworkPage extends StatefulWidget {
  const SelectVariantFrameworkPage({super.key});

  @override
  State<SelectVariantFrameworkPage> createState() =>
      _SelectVariantFrameworkPageState();
}

class _SelectVariantFrameworkPageState
    extends State<SelectVariantFrameworkPage> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BackAppBar(
          label: "Variant Frame Work",
          isBack: false,
          isAction: false,
          action: GestureDetector(
            onTap: () {
              // PersistentNavBarNavigator.pushNewScreen(
              //   context,
              //   screen: Outlet(),
              //   withNavBar: true,
              //   // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.fade,
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Done",
                style: GoogleFonts.poppins(
                    color: ColorPalette.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GradientButton(
                color: ColorPalette.primary,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 350,
                                child: Scaffold(
                                    body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    PatternClass(
                                      label: "Letter Pattern",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    PatternClass(
                                      label: "Number Pattern",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    PatternClass(
                                      label: "Diffrent Pattern",
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      width: w1,
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xffD3D3D3).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "A/106/AC",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorPalette.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Create",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorPalette.white, ColorPalette.white]),
                child: Text(
                  "+ New Variant Combinations",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            // Text(
            //   "Existing Combinations",
            //   style: GoogleFonts.roboto(
            //     fontSize: w / 22,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // ListView.separated(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) => GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //             padding: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 border: Border.all(
            //                     width: 0.2,
            //                     color: Colors.grey.withOpacity(0.5)),
            //                 color: Color(0xffD3D3D3).withOpacity(0.5)),
            //             child: Text(
            //               "A/106/AC",
            //               style: GoogleFonts.roboto(
            //                 fontSize: w / 24,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ))),
            //     separatorBuilder: (context, index) => SizedBox(
            //           height: 5,
            //         ),
            //     itemCount: 8),

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    SellerSvg().nodataSvg,
                  ),
                  Text(
                    "No combinations exist!",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, fontSize: w / 22),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatternClass extends StatefulWidget {
  final String? label;
  const PatternClass({super.key, this.label});

  @override
  State<PatternClass> createState() => _PatternClassState();
}

class _PatternClassState extends State<PatternClass> {
  int? selected;
  void onSelect(int val) {
    selected = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "Letter Pattern",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: w / 24,
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    onSelect(index);
                    setState(() {});
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 0.5,
                              color: selected == index
                                  ? ColorPalette.primary
                                  : Colors.grey.withOpacity(0.5)),
                          color: selected == index
                              ? ColorPalette.primary.withOpacity(0.1)
                              : Color(0xfffffff).withOpacity(0.5)),
                      child: Text(
                        "A/106/AC",
                        style: GoogleFonts.roboto(
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ))),
              separatorBuilder: (context, index) => SizedBox(
                    width: 5,
                  ),
              itemCount: 5),
        ),
      ],
    );
  }
}
