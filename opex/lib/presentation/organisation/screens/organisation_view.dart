import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/organisation/screens/contract_details.dart';
import 'package:cluster/presentation/organisation/screens/operational_unit.dart';
import 'package:cluster/presentation/organisation/screens/organisation_svg.dart';
import 'package:cluster/presentation/purchase_app/table_widget.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../order_app/order_svg.dart';
import '../../task_operation/create/single_row.dart';
import 'bussiness_unit.dart';

class OrganisationView extends StatefulWidget {
  const OrganisationView({Key? key}) : super(key: key);

  @override
  State<OrganisationView> createState() => _OrganisationViewState();
}

class _OrganisationViewState extends State<OrganisationView> {
  bool isActive=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "RM General Trading",isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w,
                      // height: 80,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(radius: 35,
                                backgroundColor: ColorPalette.inactiveGrey,
                              ),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RM General Trading",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "Super Market",
                                    style: TextStyle(
                                      color: Color(0xff7d7d7d),
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SvgPicture.string(OrderSvg().callIcon,color: ColorPalette.primary ,),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: BussinessUnit(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      //BussinessUnit
                      },
                      child: Container(
                        width: w,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        // height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfffdf2f2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(
                                  OrderSvg().msgIcon,
                                  color: ColorPalette.primary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Business Units",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            SvgPicture.string(TaskSvg().arrowIcon)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Business Details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                Table(
                  defaultColumnWidth: FixedColumnWidth(160.0),
                  border: TableBorder.all(
                      color: Color(0xffE6ECF0),
                      borderRadius: BorderRadius.circular(10),
                      style: BorderStyle.solid,
                      width: 2),
                  children: [
                    TableRow(children: [
                      TableTitle(
                        label: "Business Name",
                      ),
                      SubTextCard(
                        label: "Rawabi Market",
                      ),
                    ]),
                    TableRow(children: [
                      TableTitle(
                        label: "Industry",
                      ),
                      SubTextCard(
                        label: "Hypermarket",
                      ),
                    ]),
                    TableRow(children: [
                      TableTitle(
                        label: "TRN No.",
                      ),
                      SubTextCard(
                        label: "TR12021NDBXB",
                      ),
                    ]), TableRow(children: [
                      TableTitle(
                        label: "Import/Export Code",
                      ),
                      SubTextCard(
                        label: "TR12021NDBXB",
                      ),
                    ]), TableRow(children: [
                      TableTitle(
                        label: "Business E-Mail",
                      ),
                      SubTextCard(
                        label: "rawabimarket@gmail.com",
                      ),
                    ]),
                    TableRow(children: [
                      TableTitle(
                        label: "Working Hours",
                      ),
                      SubTextCard(
                        label: "24 Hours",
                      ),
                    ]),
                    TableRow(children: [
                      TableTitle(
                        label: "Business Phone Number",
                      ),
                      SubTextCard(
                        label: "125454441",
                      ),
                    ]),
                  ],
                ),
                    SizedBox(height: 16,),

              ]),
        ),
              Container(
                width: w,
                height: 6,
                color: Color(0xfff8f7f5),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Business Address",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Rawabi Market  |  Hypefrmarket \nTRN : 65328HG5IY4 ",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(thickness: 1.1,
                    color: ColorPalette.divider,),
                    SizedBox(height: 5,),
                    Text(
                      "Delivery Address",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "MP Tower, Thondayad bypass,\nKozhikode, 673572",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                width: w,
                height: 6,
                color: Color(0xfff8f7f5),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: w,
                      // height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SingleRow(
                              label: "Operational Units",
                              color: Color(0xff33c658),
                              svg: OrganisationSvg().globIcon,
                              endIcon: Icon(Icons.arrow_forward_ios_sharp),
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: OperationalUnit(),
                                  withNavBar: true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              },
                            ),
                          ),
                          Divider(indent: 50,),
                          Container(

                            padding: EdgeInsets.all(10),
                            child: SingleRow(
                              label: "Contract Details",
                              color:Color(0xffad51e0),
                              svg:  OrganisationSvg().contractIcon,
                              endIcon: Icon(Icons.arrow_forward_ios_sharp),
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ContractDetails(),
                                  withNavBar: true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              //  ContractDetails
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      padding: EdgeInsets.all(16),
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
                        color: ColorPalette.white,
                      ),
                      child: SingleRow(
                        label: "Status : Active",
                        color: Color(0xffffc800),
                        svg:  TaskSvg().notificationIcon,
                        endIcon: isActive
                            ? SvgPicture.string(HomeSvg().toggleActive)
                            : SvgPicture.string(HomeSvg().toggleInActive),
                        onTap: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        "Block this Unit",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    ));
  }
}
