import 'package:cluster/presentation/comunication_module/chat_screen/media_list.dart';
import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:cluster/presentation/purchase_app/request_info.dart';
import 'package:cluster/presentation/purchase_app/varient_card.dart';
import 'package:cluster/presentation/purchase_app/view_sub_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'attachment_screen.dart';
import 'basic_details_screen.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "P.O : 1342548754"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: w,
                    // height: 46,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Color(0xfffd5762),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w / 1.7,
                          child: Text(
                            "Variants",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Qty",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Price",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          VarientCard(index: index, finalIndex: 3 - 1),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2,
                          ),
                      itemCount: 3),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: w,
                    height: 46,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                      border: Border.all(
                        color: Color(0xffe6ecf0),
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grand Total",
                          style: GoogleFonts.roboto(
                            color: Color(0xff1b1b1f),
                            fontSize: w / 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "41,020.50",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ViewSubCard(
                    label: "Basic Details",
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: BasicDetailsScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    //  BasicDetailsScreen
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ViewSubCard(
                    label: "Request Information",
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: RequestInformation(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    //  RequestInformation
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ViewSubCard(
                    label: "Attachments",
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PurchaseAttachmentScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    //  AttachmentScreen
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: "Comments ...",
                        hintStyle:  TextStyle(
                          color: Color(0x66151522),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffe6ecf0),width: 1)
                        ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE6ECF0),width: 1)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h / 5,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
                width: w,
                // height: 60,
                color: Color(0xfff9f9f9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Reject the Order",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: w/20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Text(
                                          "Accept the order request submitted by",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: w/27,
                                          ),
                                        ),Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Rawabi Market ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),  Text(
                                              "on",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                // fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),  Text(
                                              " jan 12, 2022",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        TextFormField(
                                          maxLines: 5,
                                          decoration: const InputDecoration(hintText: "Add Notes ...",
                                            hintStyle:  TextStyle(
                                              color: Color(0x66151522),
                                              fontSize: 16,
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffe6ecf0),width: 1)
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffE6ECF0),width: 1)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: w / 4,
                                                  padding:
                                                  EdgeInsets.symmetric(vertical: 10),

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xffc5c5c5),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.string(PurchaseSvg().closeIcon),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: w/22,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Container(
                                                    width: w / 4,
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Color(0xffed4e4e),
                                                    ),

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.string(PurchaseSvg().approveIcon),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                         Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: w/22,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ), 
                                            ])
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            // width: w/4,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffec4d4d),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.string(PurchaseSvg().closeIcon),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Accept the Order",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: w/20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Text(
                                          "Accept the order request submitted by",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: w/27,
                                          ),
                                        ),Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Rawabi Market ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),  Text(
                                              "on",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                // fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),  Text(
                                              " jan 12, 2022",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: w/27,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        TextFormField(
                                          maxLines: 5,
                                          decoration: const InputDecoration(hintText: "Add Notes ...",
                                            hintStyle:  TextStyle(
                                              color: Color(0x66151522),
                                              fontSize: 16,
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffe6ecf0),width: 1)
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffE6ECF0),width: 1)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: w / 4,
                                                  padding:
                                                  EdgeInsets.symmetric(vertical: 10),

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xffc5c5c5),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.string(PurchaseSvg().closeIcon),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: w/22,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Container(
                                                    width: w / 4,
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Color(0xff199c3e),
                                                    ),

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.string(PurchaseSvg().approveIcon),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "OK",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ])
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // width: w/4,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff199c3e),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.string(PurchaseSvg().approveIcon),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Approve",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      // width: w/4,
                      height: 42,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0x0f000000),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0f000000),
                            blurRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.string(PurchaseSvg().forwardIcon),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Forward",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
