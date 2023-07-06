import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/user_app/basic_details.dart';
import 'package:cluster/presentation/user_app/review_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';

class EmployeeView extends StatefulWidget {

   EmployeeView({Key? key}) : super(key: key);

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Afthabu Rahman",
          isAction: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Employee ID   #7654564655",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ClusterCard(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sbin Sreenivas",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: w / 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.string(OrderSvg().callIcon),
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.string(OrderSvg().msgIcon),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      width: w,
                      height: 1,
                      color: const Color(0xffE6ECF0),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.cardBackground,
                            ),
                            child: SvgPicture.string(OrderSvg().phoneIcon),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "+91 8606200441",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50),
                      width: w,
                      height: 1,
                      color: const Color(0xffE6ECF0),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            padding: EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.cardBackground,
                            ),
                            child: SvgPicture.string(OrderSvg().phoneIcon),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "+91 8606200441",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Basic Details",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClusterCard(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicDetails(),
                  SizedBox(
                    height: 16,
                  ),
                  BasicDetails(
                    head: "Last Login",
                    label: "12 Jan 2022, 12:25 AM",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BasicDetails(
                    head: "Gender",
                    label: "Male",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BasicDetails(
                    head: "Nationality",
                    label: "Australian",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BasicDetails(
                    head: "Organization",
                    label: "RM General Trading",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BasicDetails(
                    head: "Department",
                    label: "Digital and Media Wing",
                  ),

                ],
              )),
              SizedBox(height: 16,),
              Container(
                width: w,
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
                    Text(
                      "Is_Active",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isActive=!isActive;
                        });
                      },
                      child: isActive
                          ? SvgPicture.string(HomeSvg().toggleActive)
                          : SvgPicture.string(HomeSvg().toggleInActive),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              UserReviewCard(label: "Send a Message ",color: ColorPalette.blue,),
              const SizedBox(height: 10,),
              UserReviewCard(label: "Assign a Task ",color: ColorPalette.yellow,),
              SizedBox(height: 50,),
              GradientButton(
                  onPressed: () {},
                  gradient: const LinearGradient(
                    colors: [
                      ColorPalette.white,
                      ColorPalette.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: ColorPalette.cardBackground,
                  child: Text(
                    "Edit Details",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              SizedBox(height: 10,),
              GradientButton(
                  onPressed: () {},
                  gradient: const LinearGradient(
                    colors: [
                      ColorPalette.white,
                      ColorPalette.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: ColorPalette.cardBackground,
                  child: Text(
                    "Delete this Employee",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: ColorPalette.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
