import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/seller_admin_app/seller_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/custom_radio_button.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';
import '../seller_app/change_category.dart';

class SellersScreen extends StatefulWidget {
  const SellersScreen({Key? key}) : super(key: key);

  @override
  State<SellersScreen> createState() => _SellersScreenState();
}

class _SellersScreenState extends State<SellersScreen> {
  int selected = 0;
  int isItemSelect = 0;
  List<String> sortList = [
    'Stock items',
    'Out of stock items',
  ];
  List<String> productTypeList = [
    'All products',
    'Recently Added',
    'Most Selling',
    'Offer Applied'
  ];

  void onSelect(int val) {
    selected = val;
    setState(() {});
  }
  @override
  void initState() {
    context
        .read<SellerAdminBloc>()
        .add(const SellerListSellerEvent("", "",'',''));
    super.initState();
  }
  List<String> assignTypeList = [
    "Ascending",
    "Descending",
  ];

  String? selectedType;
  String nextUrl = "";
  String prevUrl = "";

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Sellers", isAction: false),
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
                    SizedBox(width: w1 / 1.1,
                        child: SearchCard(
                          hint: "Search by name,mobile,location...!",
                          onchange: (aa){
                            context
                                .read<SellerAdminBloc>()
                                .add( SellerListSellerEvent(aa, "",'',''));
                          },
                        )
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     _showModalBottomSheet();
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(15),
                    //     width: 50,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(
                    //         color: Color(0xffe6ecf0),
                    //         width: 1,
                    //       ),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Color(0x05000000),
                    //           blurRadius: 8,
                    //           offset: Offset(1, 1),
                    //         ),
                    //       ],
                    //       color: Colors.white,
                    //     ),
                    //     child: SvgPicture.string(OrderSvg().moreIcon),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                BlocBuilder<SellerAdminBloc, SellerAdminState>(
                  builder: (context, state) {
                    if (state is SellerListSellerLoading) {
                      return Container(
                          height: 200,
                          width: w,
                          alignment: Alignment.center,
                          child: LoadingAnimationWidget.threeRotatingDots(
                            color: Colors.red,
                            size: 30,
                          ));
                    }
                    if (state is SellerListSellerSuccess) {
                      nextUrl=state.nextPageUrl??"";
                      prevUrl=state.prevPageUrl??"";
                      return Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total ${state.category!.length} Sellers",
                                  style: GoogleFonts.roboto(
                                    color:  ColorPalette.black,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xffe6ecf0), width: 1,),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x05000000),
                                        blurRadius: 8,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                                      underline: Container(),
                                      items: assignTypeList.map((String items) {
                                        return DropdownMenuItem(
                                          enabled: true,
                                          value: items,
                                          child: Text(items,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        );
                                      }).toList(),
                                      value: selectedType,
                                      onChanged: (dynamic value) {


                                        setState(() {
                                          selectedType = value;
                                          print("DDDD${selectedType}");
                                          selectedType =="Descending"?
                                          context.read<SellerAdminBloc>().add( SellerListSellerEvent('','','','desc')):
                                          selectedType=="Ascending"?context.read<SellerAdminBloc>().add( SellerListSellerEvent('','','','ace')):
                                          context.read<SellerAdminBloc>().add( SellerListSellerEvent('','','',''));
                                        });

                                      },
                                      hint: Text(
                                        "All Sellers",
                                        style: GoogleFonts.poppins(
                                            color:Colors.grey,fontSize: 14),
                                      )),
                                ),
                              ]),
                          SizedBox(height: 15,),
                          ListView.separated(
                            itemBuilder: (context, index) => SellerCard(
                              listData: state.category?[index],
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                            itemCount: state.category!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 25, right: 16, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                prevUrl != ""
                                    ? GestureDetector(
                                  onTap: () {
                                    context.read<SellerAdminBloc>().add(
                                        SellerListSellerEvent(
                                            '', '', prevUrl,""));
                                    },
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPalette.primary,
                                        fontSize: w / 22),
                                  ),
                                )
                                    : Container(),
                                nextUrl != ""
                                    ? GestureDetector(
                                  onTap: () {
                                   setState(() {
                                      context.read<SellerAdminBloc>().add(
                                          SellerListSellerEvent(
                                              '', nextUrl, "",''));
                                    });
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPalette.primary,
                                        fontSize: w / 22),
                                  ),
                                )
                                    : const Text("")
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SafeArea(
                  child: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Filter",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Apply",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Type",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          CustomRadioButton(
                                            onTap: () {
                                              onSelect(index);
                                              setState(() {});
                                            },
                                            isActive: selected == index,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            productTypeList[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 10,
                                        ),
                                    itemCount: productTypeList.length),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Item Stock ",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              onSelect(index);
                                              setState(() {});
                                            },
                                            child: selected == index
                                                ? Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: SvgPicture.string(
                                                        OrderSvg()
                                                            .checkBoxActiveIcon),
                                                  )
                                                : SvgPicture.string(
                                                    OrderSvg().checkBoxIcon),
                                          ),
                                          // CustomRadioButton(
                                          //   onTap: () {
                                          //     onSelect(index);
                                          //     setState(() {});
                                          //   },
                                          //   isActive: selected == index,
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            sortList[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 10,
                                        ),
                                    itemCount: sortList.length),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1.5,
                            color: Color(0xffE6ECF0),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Category",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.string(
                                            OrderSvg().checkBoxIcon),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "All Products",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ChangeCategory(),
                                          withNavBar: true,
                                          // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade,
                                        );
                                        //ChangeCategory
                                      },
                                      child: Text(
                                        "Change",
                                        style: GoogleFonts.roboto(
                                          color: Color(0xfffe5762),
                                          fontSize: w / 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
          );
        });
  }
}
