import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/product_hub/add_new_list.dart';
import 'package:cluster/presentation/product_hub/hierarchy_screens/category_screen.dart';
import 'package:cluster/presentation/product_hub/hierarchy_screens/group_screen.dart';
import 'package:cluster/presentation/product_hub/hierarchy_screens/static_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';
import 'hierarchy_screens/brand_screen.dart';
import 'hierarchy_screens/create_screen.dart';
import 'hierarchy_screens/division_screen.dart';
import 'hierarchy_screens/materials_screen.dart';
import 'hierarchy_screens/sub_category.dart';

class CreateNewList extends StatefulWidget {
  const CreateNewList({Key? key}) : super(key: key);

  @override
  State<CreateNewList> createState() => _CreateNewListState();
}

class _CreateNewListState extends State<CreateNewList> {
  int select = 0;
  bool isCategory = false;
  bool isDivision = true;
  bool isSubCategory = false;
  bool isStaticGroup = false;
  bool isGroup = false;
  bool isMaterial = false;
  bool isBrand = false;
  bool isSelect = false;

  void onSelect(index) {
    setState(() {
      select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Add new list", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
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
                    GestureDetector(
                      onTap: () {
                        isDivision == true
                            ? Navigator.pop(context)
                            : print("hello");
                        isCategory == true
                            ? setState(() {
                                isCategory = false;
                                isDivision = true;
                                isSubCategory = false;
                                isStaticGroup = false;
                                isGroup = false;
                                isMaterial = false;
                              })
                            : print("hello");
                        isSubCategory == true
                            ? setState(() {
                                isCategory = false;
                                isDivision = false;
                                isSubCategory = false;
                                isStaticGroup = true;
                                isGroup = false;
                                isMaterial = false;
                              })
                            : print("hello");
                        isStaticGroup == true
                            ? setState(() {
                                isCategory = true;
                                isDivision = false;
                                isSubCategory = false;
                                isStaticGroup = false;
                                isGroup = false;
                                isMaterial = false;
                              })
                            : print("hello");
                        isGroup == true
                            ? setState(() {
                                isCategory = false;
                                isDivision = false;
                                isSubCategory = false;
                                isStaticGroup = true;
                                isGroup = false;
                                isMaterial = false;
                              })
                            : print("hello");
                        isMaterial == true
                            ? setState(() {
                                isCategory = false;
                                isDivision = false;
                                isSubCategory = false;
                                isStaticGroup = false;
                                isGroup = true;
                                isMaterial = false;
                              })
                            : print("hello");
                        // Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Text(
                        "Add New",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                isDivision
                    ? DivisionScreen()
                    : isCategory
                        ? CategoryScreen()
                        : isSubCategory
                            ? SubCategoryScreen()
                            : isStaticGroup
                                ? StaticGroupScreen()
                                : isGroup
                                    ? GroupScreen()
                                    : isMaterial
                                        ? MaterialScreen()
                                        :isBrand
                                        ? BrandScreen()
                                        : Container(),
                isDivision
                    ? GradientButton(
                        onPressed: () {
                          isDivision == true
                              ? setState(() {
                                  isCategory = true;
                                  isDivision = false;
                                  isSubCategory = false;
                                  isStaticGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");
                        },
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isCategory
                    ? GradientButton(
                        onPressed: () {
                          isCategory == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = true;
                                  isStaticGroup = false;
                                  isGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");
                        },
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isSubCategory
                    ? GradientButton(
                        onPressed: () {
                          isSubCategory == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  isStaticGroup = true;
                                  isGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isStaticGroup
                    ? GradientButton(
                        onPressed: () {
                          isStaticGroup == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  isStaticGroup = false;
                                  isGroup = true;
                                  isMaterial = false;
                                })
                              : print("hello");
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isGroup
                    ? GradientButton(
                        onPressed: () {
                          isGroup == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  isStaticGroup = false;
                                  isGroup = false;
                                  isMaterial = true;
                                })
                              : print("hello");
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isMaterial
                    ? GradientButton(
                        onPressed: () {
                          isMaterial == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  isStaticGroup = false;
                                  isGroup = false;
                                  isMaterial = false;
                                  isBrand = true;
                                })
                              : print("hello");
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
                isBrand
                    ? GradientButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const AddNewList(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //AddNewList
                          // isBrand == true
                          //     ? setState(() {
                          //         isCategory = false;
                          //         isDivision = false;
                          //         isSubCategory = false;
                          //         isStaticGroup = false;
                          //         isGroup = false;
                          //         isBrand = false;
                          //       })
                          //     : print("hello");

                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CatProductCard extends StatefulWidget {
  // final bool isSelect;
  final String? division;

  const CatProductCard({
    Key? key,
    this.division,
  }) : super(key: key);

  @override
  State<CatProductCard> createState() => _CatProductCardState();
}

class _CatProductCardState extends State<CatProductCard> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            onTap: () {
              setState(() {
                isSelect = !isSelect;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.division ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                isSelect
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.string(OrderSvg().checkBoxActiveIcon))
                    : SvgPicture.string(
                        OrderSvg().checkBoxIcon,
                        height: 35,
                        width: 35,
                      ),
              ],
            )));
  }
}
