import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/mpos/pick_and_pack.dart';
import 'package:cluster/presentation/mpos/product_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/order_app/orderapp_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';
import '../task_operation/create/add_text.dart';
import 'gift_card.dart';
import 'mpos_svg.dart';

class CollectionPointView extends StatefulWidget {
  const CollectionPointView({Key? key}) : super(key: key);

  @override
  State<CollectionPointView> createState() => _CollectionPointViewState();
}

class _CollectionPointViewState extends State<CollectionPointView> {
  bool isWrapping = false;
  int? select=0;

   TextEditingController controller=TextEditingController();
  void onSelect(int val) {
    select = val;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Sahya Market"),
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
                      child: SvgPicture.string(MposSvg().scannerIcon),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          isCollect: true,
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                            height: 10,
                          ),
                      itemCount: 3),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Available Offers",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ClusterCard(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.string(OrderSvg().checkBoxIcon),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w / 1.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Extra AED.10 Off on UPI",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Min.Order 200",
                                    style: TextStyle(
                                      color: Color(0xff666161),
                                      fontSize: w / 27,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: w / 1.35,
                              child: Text(
                                "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                ClusterCard(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.string(OrderSvg().checkBoxIcon),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w / 1.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Instant Discount",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Upto 65% Off",
                                    style: TextStyle(
                                      color: Color(0xff666161),
                                      fontSize: w / 27,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: w / 1.35,
                              child: Text(
                                "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    _showModalBottomSheet();
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.all(0),
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
                    child: AddText(label: "Apply Gift Option",hint: "", controller: controller, isActive: true, ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   width: w,
                //   padding: EdgeInsets.all(0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       color: Color(0xffe6ecf0),
                //       width: 1,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Color(0x05000000),
                //         blurRadius: 8,
                //         offset: Offset(1, 1),
                //       ),
                //     ],
                //     color: Colors.white,
                //   ),
                //   child: AddText(label: "Apply Wrapping Option"),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.all(0),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AddText(label: "Apply Wrapping Option", controller: controller,isActive: true),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isWrapping = !isWrapping;
                              });
                            },
                            child: isWrapping
                                ? Icon(Icons.keyboard_arrow_up)
                                : Icon(Icons.keyboard_arrow_down_sharp),
                          )
                        ],
                      ),
                      isWrapping
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 16),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color(0xffA9A8A8)
                                                .withOpacity(0.3))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color(0xffA9A8A8)
                                                .withOpacity(0.3))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Color(0xffA9A8A8)
                                                .withOpacity(0.3))),
                                  ),
                                )
                              ],
                            )
                          : Container()
                    ],

                  ),
                ),

                SizedBox(height: 16,),
                Text(
                  "Payment Details",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 20,
                    fontWeight: FontWeight.w500,

                  ),
                ),
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddText(label: "Apply Wrapping Option",controller: controller,isActive: true),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isWrapping = !isWrapping;
                            });
                          },
                          child: isWrapping
                              ? Icon(Icons.keyboard_arrow_up)
                              : Icon(Icons.keyboard_arrow_down_sharp),
                        )
                      ],

                    ),
                    Text(
                      "1925.25",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w/20,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: w/20,
                      ),
                    ),
                    Text(
                      "-125.0",
                      style: TextStyle(
                        color: Color(0xff079b15),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping & Packing",
                      style: TextStyle(
                        fontSize: w/20,
                      ),
                    ),
                    Text(
                      "14.25",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w/20,
                      ),
                    ),
                  ],
                ), SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping Discount",
                      style: TextStyle(
                        fontSize: w/20,
                      ),
                    ),
                    Text(
                      "-15.25",
                      style: TextStyle(
                        color: Color(0xff079b15),
                        fontSize: w/20,
                      ),
                    ),
                  ],
                ), SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax",
                      style: TextStyle(
                        fontSize: w/20,
                      ),
                    ),
                    Text(
                      "125.25",
                      style: TextStyle(
                        color: Color(0xff1b1b1f),
                        fontSize: w/20,
                      ),
                    )
                  ],
                ),SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Promotion",
                      style: TextStyle(
                        fontSize: w/20,
                      ),
                    ),
                    Text(
                      "5.25",
                      style: TextStyle(
                        color: Color(0xff1b1b1f),
                        fontSize: w/20,
                      ),
                    )
                  ],
                ),SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: w/20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "-25.25",
                      style: GoogleFonts.roboto(
                        color: Color(0xff1b1b1f),
                        fontSize: w/20,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PickAndPack(),
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
                SizedBox(height: 10,),
                Container(
                  width: w,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Hold this Collection",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: 18,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showModalBottomSheet() {
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
              return Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 20,left: 16,right: 16,bottom: 10
                  ),
                  
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
                        Text(
                          "Gift Option 1",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,

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
                        SizedBox(height: 16,),
                        ProductCard(),

                        SizedBox(height: 16,),
                        Text(
                          "To",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xffE6ECF0)
                              )
                            ),
                            enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xffE6ECF0)
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "From",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xffE6ECF0)
                              )
                            ),
                            enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xffE6ECF0)
                                )
                            ),
                          ),

                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Your Message",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: w/25,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xffe6ecf0)
                                  )
                              ),
                            enabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xffE6ECF0)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        
                      ],
                    ),
                  ),

                ),
              );
            },
          );
        });
  }
}
