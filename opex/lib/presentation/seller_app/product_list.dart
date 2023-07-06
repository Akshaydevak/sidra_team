import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/custom_radio_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/mpos_svg.dart';
import '../mpos/search_card.dart';
import '../order_app/no_of_item_model.dart';
import '../order_app/order_svg.dart';
import '../promotion_app/slider_card.dart';
import 'change_category.dart';

class ProductList extends StatefulWidget {
  bool isProductDetails;
   ProductList({Key? key,this.isProductDetails=false}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label:widget.isProductDetails?"Product Details": "Product List", isAction: false),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: w / 1.35, child:  SearchCard()),
                  GestureDetector(
                    onTap: () {
                      _showModalBottomSheet();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
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
                      child: SvgPicture.string(OrderSvg().moreIcon),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Seller : ",
                        style: GoogleFonts.roboto(
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [Icon(Icons.close)],
                                      ),
                                      // SizedBox(height: 5,),
                                      Text(
                                        "Seller List",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: w,
                                        // height: 394.30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                            color: Color(0x7fd9d9d9),
                                            width: 1,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: ListView.separated(
                                          itemCount: 5,
                                          primary: true,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 58.25,
                                                  height: 58.25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Color(0xff1ecac0),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "S",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Souq Rawabi",
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: w / 22,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "13,025 Products",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff636363),
                                                        fontSize: w / 26,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context, index) =>
                                              Container(
                                            color: Color(0xffD9D9D9)
                                                .withOpacity(0.5),
                                            width: w,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.string(
                                                  SellerSvg().addIcon),
                                              Text(
                                                "Create New Seller",
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xfffe5762),
                                                  fontSize: w / 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xffe7e7e7),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Continue",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Rawabi Market",
                          style: GoogleFonts.roboto(
                              fontSize: w / 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF1636C)),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "1035 Products",
                    style: GoogleFonts.roboto(
                      color: Color(0xff151522),
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                // height: 500,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: true,
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        // width: 186,
                        // height: 186,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xffe6ecf0),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: w,
                              child: Column(
                                children: [
                                  Container(
                                      height: 80,
                                      width: 80,
                                      child: Image.network("https://th.bing.com/th/id/OIP.bFszH6D8gyrJDzo_574w0AHaHa?pid=ImgDet&rs=1")),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Musafir Pure Low Sodiu..",
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "AED 1899.00",
                              style: GoogleFonts.poppins(
                                color: Color(0xff1b1b1f),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 0,
                          top: 10,
                          child: Container(
                            width: 69,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(0),
                              ),
                              color: Color(0x33079b15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "In stock",
                              style: GoogleFonts.roboto(
                                color: Color(0xff13a322),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.string(OrderSvg().checkBoxIcon),
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
                                      onTap: (){
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ChangeCategory(),
                                          withNavBar: true, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation: PageTransitionAnimation.fade,
                                        );
                                      //ChangeCategory
                                      },
                                      child: Text(
                                        "Change",
                                        style: GoogleFonts.roboto(
                                          color: Color(0xfffe5762),
                                          fontSize: w/20,
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
