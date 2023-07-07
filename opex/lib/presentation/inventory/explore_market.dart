import 'package:cluster/common_widgets/checkbox_widget.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/inventory/widget/explore_card.dart';
import 'package:cluster/presentation/inventory/inventory_svg.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ExploreMarket extends StatefulWidget {
  ExploreMarket({Key? key}) : super(key: key);

  @override
  State<ExploreMarket> createState() => _ExploreMarketState();
}

class _ExploreMarketState extends State<ExploreMarket> {
  String? selGender;
  int? isSelect;
  List<String> gender = ["Item Shortage", "Item Shortage", "Item Shortage"];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Column(
          children: [
            AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white, // Navigation bar
                statusBarColor: Colors.white, // Status bar
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                      color: Color(0xfff2f2f2),
                    ),
                    width: w / 2,
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        underline: Container(),
                        items: gender.map((String items) {
                          return DropdownMenuItem(
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        value: selGender,
                        onChanged: (dynamic value) {},
                        hint: Text(
                          "Item Shortage",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
              titleSpacing: 0,
              leading: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              actions: [
                GestureDetector(
                  onTap: () {
                    _locationshowModalBottomSheet();
                  },
                  child: SvgPicture.string(
                    OrderSvg().locationIcon,
                    color: Colors.black,
                    height: 25,
                    width: 25,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      // _showModalBottomSheet();
                    },
                    child: SvgPicture.string(
                      CartSvg().searchIcon,
                      color: Colors.black,
                      height: 19,
                      width: 19,
                    )),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            Container(
              width: w,
              height: 1.50,
              decoration: BoxDecoration(
                color: Color(0xb2e6e6e6),
              ),
            ),
          ],
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                          // onTap: onTapListTile(i, context),
                          child: Container(
                        width: w / 5,
                        child: Column(
                          children: [
                            Container(
                              width: 54,
                              height: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xfff4f5f7),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mobile and Accessories",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 30,
                              ),
                            )
                          ],
                        ),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  height: 1,
                  color: ColorPalette.divider,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Sub-Category",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: w / 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _categoryshowModalBottomSheet();
                                },
                                child: Container(
                                  width: 29,
                                  height: 29,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xfffdf2f2),
                                  ),
                                  child: SvgPicture.string(
                                      InventorySvg().moreIcon),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Memory cards",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: ColorPalette.primary,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 1,
                      color: ColorPalette.divider,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Category",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: w / 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _groupshowModalBottomSheet();
                                },
                                child: Container(
                                  width: 29,
                                  height: 29,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xfffdf2f2),
                                  ),
                                  child: SvgPicture.string(
                                      InventorySvg().moreIcon),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Memory cards",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: ColorPalette.primary,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: w,
                  height: 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xfff8f8f8), Color(0x00ffffff)],
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total 120 Products",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 39,
                                  height: 38,
                                  padding: EdgeInsets.all(10),
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
                                    color: Color(0xfff2f2f2),
                                  ),
                                  child: SvgPicture.string(
                                      InventorySvg().shareIcon),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 39,
                                  height: 38,
                                  padding: EdgeInsets.all(10),
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
                                    color: Color(0xfff2f2f2),
                                  ),
                                  child: SvgPicture.string(
                                      InventorySvg().downloadIcon),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ExploreCard(),
                          separatorBuilder: (context, index) => Container(
                                width: w,
                                height: 1,
                                color: ColorPalette.divider,
                              ),
                          itemCount: 5)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _locationshowModalBottomSheet() {
   int ?select=0;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: w,
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.close))),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(
                          "Choose a Category",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: w,
                        height: 1,
                        color: ColorPalette.divider,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: h / 5,
                        // color: Colors.yellow,
                        child: ScrollConfiguration(
                          behavior: NoGlow(),
                          child: ListView.separated(
                            padding: EdgeInsets.only(left: 16,right: 16,),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        select=index;
                                      });
                                    },
                                    child: Container(
                                          width: 235,
                                          height: h/6,
                                          decoration:select==index? BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xfffe5762),
                                              width: 1,
                                            ),
                                            color: Color(0x0cfe5762),
                                          ):BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x26000000),
                                                blurRadius: 3,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 235,
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Five Group",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "Lorem ipsum doloramt, consect, adipisci elit,  \ndui nibh dolor  Pharet... \nKerala, 9865874",
                                                  style: TextStyle(
                                                    color: ColorPalette.black,
                                                    fontSize: w/24,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child:select==index? SvgPicture.string( HomeSvg().radioButtonActive):Container(),
                                          )
                                        ],

                                      ),
                                        ),
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 5),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _categoryshowModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: ScrollConfiguration(
                  behavior: NoGlow(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: w,
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.close))),
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16, bottom: 16),
                          child: Text(
                            "Choose a Category",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: w,
                          height: 1,
                          color: ColorPalette.divider,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            padding: EdgeInsets.all(10),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSelect = index;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.string(isSelect == index
                                          ? HomeSvg().radioButtonActive
                                          : HomeSvg().radioButtonInActive),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: Color(0x0c000000),
                                            width: 1,
                                          ),
                                          color: Color(0x4fd9d9d9),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Mobile Accessories",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: 10)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  _groupshowModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose Group",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "APPLY",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        height: 1,
                        color: ColorPalette.divider,
                      ),
                      ListView.separated(
                          padding: EdgeInsets.all(10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              checkBox(label: "Chemicals and Petrochemicals"),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: 10)
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
