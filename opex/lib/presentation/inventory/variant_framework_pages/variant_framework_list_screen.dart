import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../../core/utils/variables.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../bloc/inventory_bloc.dart';
import '../model/inventory_model.dart';
import '../widget/inventory_card.dart';
import 'create_variant_framework_sceen.dart';

class VariantFrameworkListScreen extends StatefulWidget {
  const VariantFrameworkListScreen({Key? key}) : super(key: key);

  @override
  State<VariantFrameworkListScreen> createState() =>
      _VariantFrameworkListScreenState();
}

class _VariantFrameworkListScreenState
    extends State<VariantFrameworkListScreen> {
  @override
  void initState() {
    context
        .read<InventoryBloc>()
        .add(const GetVarientFrameworkListEvent('', '', ''));
    // TODO: implement initState
    super.initState();
  }

  String nextUrl = "";
  String prevUrl = "";
  List<InventoryModel> division = [];
  int? select = Variable.division;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is DeleteCategoryLoading) {
          showSnackBar(context,
              message: "Category Deletion Loading", color: ColorPalette.green);
        } else if (state is DeleteCategorySuccess) {
          showSnackBar(context,
              message: "Category Deleted Successfully",
              color: ColorPalette.green);
          Navigator.pop(context);
        } else if (state is DeleteCategoryFailed) {
          showSnackBar(context, message: "failed", color: ColorPalette.black);
        }
        // TODO: implement listener
      },
      child: Scaffold(
          backgroundColor: Color(0xffF7F7F7),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(
              label: "Variant Framework",
              action: GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CreateVariantFrameworkScreen(
                      edit: false,
                    ),
                    withNavBar: true,
                    // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "ADD NEW",
                    style: GoogleFonts.poppins(
                        color: ColorPalette.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              isAction: false,
            ),
          ),
          body: ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchCard(
                      hint: "Search Variant Frame Work...!",
                      onchange: (jj) {
                        context.read<InventoryBloc>().add(
                            GetVarientFrameworkListEvent(jj, '', ''));
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                        if (state is GetVarientFrameWorkListLoading) {
                          return Container(
                              height: 200,
                              width: w,
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.red,
                                size: 30,
                              ));
                        }
                        if (state is GetVarientFrameWorkListSuccess) {
                          // group.clear();
                          division = state.inventory ?? [];
                          nextUrl = state.nextPageUrl ?? "";
                          prevUrl = state.prevPageUrl ?? "";

                          return Container(
                            width: w1,
                            // height: 328,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffe0e3e5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Color(0xfff7f7f7),
                            ),
                            child: division.isNotEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.separated(
                                        itemCount: division.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: false,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                                child: InventoryDivisionCard(
                                          frameWork: true,
                                          onTapAll: () {
                                            context.read<InventoryBloc>().add(
                                                VarientFrameworkReadEvent(
                                                    division[index].id ?? 0));
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen:
                                                  CreateVariantFrameworkScreen(
                                                      edit: true),
                                              withNavBar: true,
                                              // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation.fade,
                                            );
                                          },
                                          onTap: () {
                                            select = index;
                                            context.read<InventoryBloc>().add(
                                                VarientFrameworkReadEvent(
                                                    division[index].id ?? 0));
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen:
                                                  CreateVariantFrameworkScreen(
                                                      edit: true),
                                              withNavBar: true,
                                              // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation.fade,
                                            );
                                          },
                                          onTapDelete: () {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Container(
                                                            width: w,
                                                            height: 53,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                              ),
                                                              color: Color(
                                                                  0xff4c4c4c),
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 16,
                                                                    right: 16,
                                                                    top: 16,
                                                                    bottom: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Conformation",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        w / 24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            )),
                                                        Container(
                                                          width: w,
                                                          // height: 227,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Are You Sure To Delete The Varient Framework..?",
                                                                style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        w / 24,
                                                                    color: ColorPalette
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              GradientButton(
                                                                  color: ColorPalette
                                                                      .primary,
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            InventoryBloc>()
                                                                        .add(DeleteVarientFrameworkEvent(division[index].id ??
                                                                            0));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment.bottomCenter,
                                                                      colors: const [
                                                                        ColorPalette
                                                                            .primary,
                                                                        ColorPalette
                                                                            .primary
                                                                      ]),
                                                                  child: Text(
                                                                    "Delete",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          w / 22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          division: division[index].name,
                                          isSelect: select == index,
                                        )),
                                        separatorBuilder: (context, index) =>
                                            Divider(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            prevUrl != ""
                                                ? GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<InventoryBloc>()
                                                          .add(
                                                              GetVarientFrameworkListEvent(
                                                                  "",
                                                                  '',
                                                                  prevUrl));
                                                      // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                                    },
                                                    child: Text(
                                                      "Previous",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorPalette
                                                              .primary,
                                                          fontSize: w / 24),
                                                    ),
                                                  )
                                                : Container(),
                                            nextUrl != ""
                                                ? GestureDetector(
                                                    onTap: () {
                                                      // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                                      setState(() {
                                                        context
                                                            .read<
                                                                InventoryBloc>()
                                                            .add(
                                                                GetVarientFrameworkListEvent(
                                                                    '',
                                                                    nextUrl,
                                                                    ''));
                                                      });
                                                    },
                                                    child: Text(
                                                      "Next",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorPalette
                                                              .primary,
                                                          fontSize: w / 24),
                                                    ),
                                                  )
                                                : Text("")
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Text("No Data Here"),
                          );
                        }
                        if (state is GetVarientFrameWorkListFailed) {
                          // group.clear();
                          division.clear();
                          // setState(() {});

                          // print("state${division[0].name}");
                        }
                        return Text("NO DATA FOUND");
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
