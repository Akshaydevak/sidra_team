import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/inventory/inventory_hierarchy_screens/stock_partition_screen.dart';

import 'package:cluster/presentation/product_hub/hierarchy_screens/category_screen.dart';
import 'package:cluster/presentation/product_hub/hierarchy_screens/group_screen.dart';
import 'package:cluster/presentation/product_hub/hierarchy_screens/static_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'bloc/inventory_bloc.dart';
import 'inventory_hierarchy_screens/brand_screen.dart';
import 'inventory_hierarchy_screens/category_screen.dart';
import 'inventory_hierarchy_screens/create_screen.dart';
import 'inventory_hierarchy_screens/division_screen.dart';
import 'inventory_hierarchy_screens/group_screen.dart';
import 'inventory_hierarchy_screens/materials_screen.dart';
import 'inventory_hierarchy_screens/sub_category.dart';
import 'inventory_hierarchy_screens/uom_group_screen.dart';
import 'inventory_new_list.dart';
import 'model/create_variant_model.dart';
import 'model/inventory_model.dart';

class InventoryCreateNewList extends StatefulWidget {
  const InventoryCreateNewList({Key? key}) : super(key: key);

  @override
  State<InventoryCreateNewList> createState() => _CreateNewListState();
}

class _CreateNewListState extends State<InventoryCreateNewList> {
  String selDivision = "";
  String selCategory = "";
  String selSubCategory = "";
  String selGroup = "";
  String selItem = "";
  String selUom = "";
  String stock = "";
  int? stockId;
  int? selDivisionid;
  int? selCategoryid;
  int? selSubCategoryid;
  int? selGroupid;
  int? selItemid;
  int? selVarientId;
  BaseUomData? variantModel;
  int? selUomid;

  void onChangeDivision(String? val) {
    print("selected division $val");
    selDivision = val ?? "";
    setState(() {});
  }

  void onChangeDivisionId(int? val) {
    print("selected divisionid $val");
    selDivisionid = val;

    setState(() {});
  }

  void onChangeCategory(String? val) {
    print("selected category $val");
    selCategory = val ?? "";
    setState(() {});
  }

  void onChangeCategoryId(int? val) {
    print("selected categoryid $val");
    selCategoryid = val;
    setState(() {});
  }

  void onChangeSubCategory(String? val) {
    print("selected Subcategory $val");
    selSubCategory = val ?? "";
    setState(() {});
  }

  void onChangeSubCategoryId(int? val) {
    print("selected Subcategoryid $val");
    selSubCategoryid = val;
    setState(() {});
  }

  void onChangeGroup(String? val) {
    print("selected group $val");
    selGroup = val ?? "";
    setState(() {});
  }

  void onChangeGroupId(int? val) {
    print("selected groupid $val");
    selGroupid = val;
    setState(() {});
  }

  void onChangeItem(String? val) {
    print("selected item $val");
    selItem = val ?? "";
    setState(() {});
  }

  void onChangeItemId(int? val) {
    print("selected item id $val");
    selItemid = val;
    setState(() {});
  }

  void onChangeVarientId(int? val) {
    print("selected variant id $val");
    selVarientId = val;
    setState(() {});
  }

  void onChangeBaseUom(BaseUomData? val) {
    print("selected onChangeBaseUom  ${val?.uomId}");
    variantModel = val;
    setState(() {});
  }

  void onChangeUom(String? val) {
    print("selected uom $val");
    selUom = val ?? "";
    setState(() {});
  }
  void onChangeStock(int ?id,String? val) {
    // print("selected uom $val");
     stock = val ?? "";
     stockId=id??0;
    setState(() {});
  }

  void onChangeUomId(int? val) {
    print("selected uomid $val");
    selUomid = val;
    setState(() {});
  }

  int select = 0;
  bool isCategory = false;
  bool isDivision = true;
  bool isSubCategory = false;

  // bool isStaticGroup = false;
  bool isGroup = false;
  bool isMaterial = false;
  bool isUom = false;
  bool isStockPartion = false;
  bool isSelect = false;

  void onSelect(index) {
    setState(() {
      select = index;
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Add new list", isAction: false,

          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.black,
        // backgroundColor: Colors.transparent,

        strokeWidth: 1.0,
        onRefresh: () async {
          isDivision
              ? context.read<InventoryBloc>().add(const GetDivisionEvent(search: '',url: ''))
              : print("");
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ScrollConfiguration(
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
                                  // isStaticGroup = false;
                                  isGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");
                          isSubCategory == true
                              ? setState(() {
                                  isCategory = true;
                                  isDivision = false;
                                  isSubCategory = false;
                                  // isStaticGroup = true;
                                  isGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");

                          isGroup == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = true;
                                  // isStaticGroup = true;
                                  isGroup = false;
                                  isMaterial = false;
                                })
                              : print("hello");
                          isMaterial == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  // isStaticGroup = false;
                                  isUom = false;
                                  isMaterial = false;
                                  isGroup = true;
                                })
                              : print("hello");
                          isUom == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  // isStaticGroup = false;
                                  isUom = false;
                                  isMaterial = true;

                                })
                              : print("hello");  isStockPartion == true
                              ? setState(() {
                                  isCategory = false;
                                  isDivision = false;
                                  isSubCategory = false;
                                  // isStaticGroup = false;
                                  isUom = true;
                                  isMaterial = false;
                                  isStockPartion=false;

                                })
                              : print("hello");
                          // Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     PersistentNavBarNavigator.pushNewScreen(
                      //       context,
                      //       screen: InventoryCreateScreen(),
                      //       withNavBar: true, // OPTIONAL VALUE. True by default.
                      //       pageTransitionAnimation: PageTransitionAnimation.fade,
                      //     );
                      //   },
                      //   child: Text(
                      //     "Add New",
                      //     style: GoogleFonts.roboto(
                      //       color: ColorPalette.primary,
                      //       fontSize: w / 24,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isDivision
                      ? InventoryDivisionScreen(
                          onChangeDivision: onChangeDivision,
                          onChangeDivisionId: onChangeDivisionId,
                        )
                      : isCategory
                          ? InventoryCategoryScreen(
                              onChangeCategory: onChangeCategory,
                              onChangeCategoryId: onChangeCategoryId,
                              divisionId: selDivisionid,
                            )
                          : isSubCategory
                              ? InventorySubCategoryScreen(
                                  onChangeSubCategory: onChangeSubCategory,
                                  onChangeSubCategoryId: onChangeSubCategoryId,
                                  categoryId: selCategoryid,
                                )
                              : isGroup
                                  ? InventoryGroupScreen(
                                      onChangeGroup: onChangeGroup,
                                      onChangeGroupId: onChangeGroupId,
                                      subCategoryId: selSubCategoryid,
                                    )
                                  : isMaterial
                                      ? InventoryMaterialScreen(
                                          onChangeItem: onChangeItem,
                                          onChangeItemId: onChangeItemId,
                                          onChangeVariantId: onChangeVarientId,
                                          groupId: selGroupid,
                                          onChangeBaseUom: onChangeBaseUom,
                                        )
                                      : isUom
                                          ? InventoryUOMScreen(
                                              onChangeUOM: onChangeUom,
                                              onChangeUOMId: onChangeUomId,
                                              itemId: selItemid,
                                            )
                                          : isStockPartion?InventoryStockPartitionScreen(
                    onChangeStock: onChangeStock,

                  ):Container(),
                  isDivision
                      ? GradientButton(
                          onPressed: () {
                            selDivisionid == null
                                ? Fluttertoast.showToast(
                                    msg: "Please Choose a division",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.black,
                                    textColor: Colors.white)
                                : isDivision == true
                                    ? setState(() {
                                        isCategory = true;
                                        isDivision = false;
                                        isSubCategory = false;
                                        isGroup = false;
                                        isMaterial = false;
                                      })
                                    : print("hello");
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
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
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),
                  isCategory
                      ? GradientButton(
                          onPressed: () {
                            selCategoryid == null
                                ? Fluttertoast.showToast(
                                    msg: "Please Choose a category",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.black,
                                    textColor: Colors.white)
                                : isCategory == true
                                    ? setState(() {
                                        isCategory = false;
                                        isDivision = false;
                                        isSubCategory = true;
                                        isGroup = false;
                                        isMaterial = false;
                                      })
                                    : print("hello");
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),
                  isSubCategory
                      ? GradientButton(
                          onPressed: () {
                            selSubCategoryid == null
                                ? Fluttertoast.showToast(
                                    msg: "Please Choose a sub category",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.black,
                                    textColor: Colors.white)
                                : isSubCategory == true
                                    ? setState(() {
                                        isCategory = false;
                                        isDivision = false;
                                        isSubCategory = false;
                                        // isStaticGroup = true;
                                        isGroup = true;
                                        isMaterial = false;
                                      })
                                    : print("hello");
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),

                  isGroup
                      ? GradientButton(
                          onPressed: () {
                            selGroupid == null
                                ? Fluttertoast.showToast(
                                    msg: "Please Choose a Group",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.black,
                                    textColor: Colors.white)
                                : isGroup == true
                                    ? setState(() {
                                        isCategory = false;
                                        isDivision = false;
                                        isSubCategory = false;
                                        isGroup = false;
                                        isMaterial = true;
                                      })
                                    : print("hello");
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),
                  isMaterial
                      ? GradientButton(
                          onPressed: () {
                            selItemid == null
                                ? Fluttertoast.showToast(
                                    msg: "Please Choose an   Item",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.black,
                                    textColor: Colors.white)
                                : isMaterial == true
                                    ? setState(() {
                                        isCategory = false;
                                        isDivision = false;
                                        isSubCategory = false;
                                        isGroup = false;
                                        isMaterial = false;
                                        isUom = true;
                                      })
                                    : print("hello");
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),
                  isUom
                      ? GradientButton(
                          onPressed: () {
                            print("inside button click$selDivision");
                            selUomid == null
                                ? Fluttertoast.showToast(
                                msg: "Please Choose an   uom",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ColorPalette.black,
                                textColor: Colors.white)
                                : isUom == true
                                ? setState(() {
                              isCategory = false;
                              isDivision = false;
                              isSubCategory = false;
                              isGroup = false;
                              isMaterial = false;
                              isUom = false;
                              isStockPartion=true;
                            })
                                : print("hello");
                            // selUomid != null
                            //     ? PersistentNavBarNavigator.pushNewScreen(
                            //         context,
                            //         screen: InventoryAddNewList(
                            //           category: selCategory,
                            //           division: selDivision,
                            //           subCategory: selSubCategory,
                            //           group: selGroup,
                            //           item: selItem,
                            //           uom: selUom,
                            //           uomId: selUomid,
                            //           itemId: selItemid,
                            //           varientId: selVarientId,
                            //           variantModel: variantModel,
                            //         ),
                            //         withNavBar:
                            //             true, // OPTIONAL VALUE. True by default.
                            //         pageTransitionAnimation:
                            //             PageTransitionAnimation.fade,
                            //       )
                            //     : Fluttertoast.showToast(
                            //         msg: "Please Choose a uom",
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.BOTTOM,
                            //         backgroundColor: ColorPalette.black,
                            //         textColor: Colors.white);
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      :isStockPartion
                      ? GradientButton(
                          onPressed: () {
                            print("inside button click$selDivision");
                            // stockId != null
                            //     ?
                            PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: InventoryAddNewList(
                                      category: selCategory,
                                      division: selDivision,
                                      subCategory: selSubCategory,
                                      group: selGroup,
                                      item: selItem,
                                      uom: selUom,
                                      uomId: selUomid,
                                      itemId: selItemid,
                                      varientId: selVarientId,
                                      variantModel: variantModel,
                                    ),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                // : Fluttertoast.showToast(
                                //     msg: "Please Choose a Stock partition",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     backgroundColor: ColorPalette.black,
                                //     textColor: Colors.white);
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      : Container(),
                  // isBrand
                  //     ? GradientButton(
                  //         onPressed: () {
                  //           PersistentNavBarNavigator.pushNewScreen(
                  //             context,
                  //             screen: const AddNewList(),
                  //             withNavBar: true, // OPTIONAL VALUE. True by default.
                  //             pageTransitionAnimation: PageTransitionAnimation.fade,
                  //           );
                  //           //AddNewList
                  //           // isBrand == true
                  //           //     ? setState(() {
                  //           //         isCategory = false;
                  //           //         isDivision = false;
                  //           //         isSubCategory = false;
                  //           //         isStaticGroup = false;
                  //           //         isGroup = false;
                  //           //         isBrand = false;
                  //           //       })
                  //           //     : print("hello");
                  //
                  //         },
                  //         gradient: const LinearGradient(
                  //           colors: [
                  //             ColorPalette.primary,
                  //             ColorPalette.primary,
                  //           ],
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomCenter,
                  //         ),
                  //         color: ColorPalette.primary,
                  //         child: Text(
                  //           "Continue",
                  //           textAlign: TextAlign.center,
                  //           style: GoogleFonts.roboto(
                  //             color: Colors.white,
                  //             fontSize: w/22,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ))
                  //     : Container(),
                  SizedBox(
                    height: 20,
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
