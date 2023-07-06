import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/autohide_appbar.dart';
import '../../common_widgets/view_btn.dart';

import 'cart_screen/cart_svg.dart';
import 'infinity_screen/category_card.dart';
import 'infinity_screen/deals_card.dart';
import 'infinity_screen/fashion_card.dart';
import 'infinity_screen/list_product.dart';
import 'infinity_screen/most_popular.dart';
import 'infinity_screen/two_banner.dart';

class Infinity extends StatefulWidget {
  const Infinity({Key? key}) : super(key: key);

  @override
  State<Infinity> createState() => _InfinityState();
}

class _InfinityState extends State<Infinity> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: ColorPalette.primary, // Status bar
          ),
          elevation: 0,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: CustomAutoHideAppBarDelegate(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: ColorPalette.primary,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search and explore ...",
                    hintStyle: TextStyle(
                      color: Color(0xff666161),
                      fontSize: w / 23,
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                    suffixIcon: Container(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.string(
                          CartSvg().searchIcon,
                          color: Colors.black,
                        )),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            )),
            pinned: true,
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(left: 12, right: 12),
            width: w,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffeef3f6),
            ),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  SvgPicture.string(HomeSvg().locationIcon),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Thondayad, Kozhikode City",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                "Change",
                style: GoogleFonts.roboto(
                  color: ColorPalette.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          )),
          SliverToBoxAdapter(child: MostPopular()),
          SliverToBoxAdapter(
            child: Container(
                width: w,
                height: h / 5,
                margin: EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  // color: Colors.yellow,
                  // shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage("asset/banner.png")),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 415,
              height: 6,
              color: Color(0xfff8f7f5),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recently Viewed Products",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "View All",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w / 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w / 2.3,
                      height: 184,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0x4ca9a8a8),
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: Image.asset("asset/img_11.png"),
                    ),
                    Container(
                      width: w / 2.25,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w / 4.7,
                                height: 88,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0x4ca9a8a8),
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Image.asset("asset/img_11.png"),
                              ),
                              Container(
                                width: w / 4.7,
                                padding: EdgeInsets.all(16),
                                height: 88,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0x4ca9a8a8),
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Image.asset("asset/img_11.png"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                width: w / 4.7,
                                height: 88,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0x4ca9a8a8),
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Image.asset("asset/img_11.png"),
                              ),
                              Container(
                                width: w / 4.7,
                                height: 88,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0x4ca9a8a8),
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Image.asset("asset/img_11.png"),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: Container(
                width: 415,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xfff8f7f5),
              child: Column(
                children: [
                  Container(
                    color: Color(0xfff8f7f5),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Exclusive deals of the Month",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Latest product on tropical season",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List<Widget>.generate(3, (index) {
                        return Container(
                            margin: const EdgeInsets.only(left: 10,bottom: 10),
                            child: const ListProductCard(
                                // product: state.categoryList.product![index],
                                ));
                      })))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: 415,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deal of this week",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TwoBanner(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: 415,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fashion Sale",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            color: Color(0xfffe5762),
                            fontSize: w / 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  FashionCard(),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: w,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exclusive deals of the Month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 20,
                            ),
                          ),
                          Text(
                            "Latest product on tropical season",
                            style: TextStyle(
                              color: Color(0xff6d6d6d),
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 80,
                        height: 33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xfffd5762),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "View All",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: w / 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DealsCard(), DealsCard(), DealsCard()],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DealsCard(), DealsCard(), DealsCard()],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DealsCard(), DealsCard(), DealsCard()],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: w,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                    child: Text(
                      "Indstries",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.only(left: 12),
                    // height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                childAspectRatio: 1.5 / 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 70,
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("asset/img_4.png")),
                                  )),
                              Text(
                                "qwertyuio",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                width: w,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                  child: Text(
                    "Choose Category",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CategoryCard()
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              color: Color(0xffA9A8A8).withOpacity(0.2),
            ),
          )
        ]),
      ),
    );
  }
}
