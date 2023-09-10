import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/product_hub/widget/table_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../seller_svg.dart';

class VariationsTab extends StatefulWidget {
  final int? itemId;

  VariationsTab({Key? key, this.itemId}) : super(key: key);

  @override
  State<VariationsTab> createState() => _VariationsTabState();
}

class _VariationsTabState extends State<VariationsTab> {
  List<InventoryModel>? inventory;
  List<InventoryModel> combination = [];
  String? selItem = "- select -";

  void onselectVariant(String val) {
    setState(() {
      selItem = val;
    });
  }

  @override
  void initState() {
    print("inside variant${widget.itemId}");
    BlocProvider.of<InventoryBloc>(context)
        .add(GetvariantEvent(itemId: widget.itemId));
    BlocProvider.of<InventoryBloc>(context).add(GetCombinationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        print("state$state");
        if (state is VariantLoading) {
          print("Loading");
        }
        if (state is VariantSuccess) {
          inventory = state.inventory;
          print("Success${inventory}");
          setState(() {});
        }
        if (state is CombinationSuccess) {
          combination = state.inventory ?? [];
          print("Success${combination}");
          setState(() {});
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Variation Item",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.string(
                SellerSvg().validationIcon,
                height: 15,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              _showModalBottomSheet();
            },
            child: Container(
              width: w,
              // padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //height: 20.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selItem ?? "",
                      style: TextStyle(
                        color: Color(0xbf666161),
                        fontSize: w / 22,
                      )),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Color(0xbf666161),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please choose variation items",
            style: TextStyle(
              color: Color(0xff666161),
              fontSize: w / 24,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        combination[index].attributeData?.attributeName ?? "",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          for (int i = 0;
                              i < combination[index].values!.length;
                              i++)
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xffe6ecf0),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(combination[index].values![i]),
                            )
                        ],
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
              itemCount: combination.length),
          TableCard(
            // head: "Additional Information",
            title1: "Additional Info",
            title2: "Value",
            content1: "Enter Additional info",
            content2: "Enter details",
            keyController: [],
            valueController: [],
            headController: null,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet() {
    int select = 0;
    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
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
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Variation Items",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(
                            color: ColorPalette.divider,
                            thickness: 1.1,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: inventory!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            onselectVariant(
                                                inventory?[index].name ?? "");
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(select ==
                                                    index
                                                ? HomeSvg().radioButtonActive
                                                : HomeSvg().radioInActive),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: w / 1.3,
                                        child: Text(
                                          inventory?[index].name ?? "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    color: ColorPalette.divider,
                                    height: 1,
                                    width: w,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: Text(
                                      "Create New",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ])),
                  ));
            },
          );
        });
  }
}
