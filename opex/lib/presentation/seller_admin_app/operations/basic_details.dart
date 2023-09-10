import 'dart:io';

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../purchase_app/table_widget.dart';
import '../new_seller_admin.dart';
import '../profile_pic.dart';
import '../seller_admin_bloc/seller_admin_bloc.dart';

class BasicDetails extends StatefulWidget {
  final SellerListAdmin? readData;
  const BasicDetails({Key? key, this.readData}) : super(key: key);
  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  bool _cropped = false;
  final picker = ImagePicker();
  File? cropImage;
  String? profileImage;
  String? backGroundImage;
  @override
  void initState() {
    profileImage=widget.readData?.logo;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("fffffffffff${widget.readData?.id}");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Basic Details", isAction: false),
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
                      width: w1,
                      height: 80,
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
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // ProfilePic(
                              //   idSeller: widget.readData?.id,
                              //   image: profileImage ??
                              //       "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png",
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: w1/2,
                                    child: Text(
                                      widget.readData?.name??"",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(width: w1/2,
                                    child: Text(
                                      widget.readData?.description??"",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Color(0xff7d7d7d),
                                        fontSize: w/26,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              _openDialer(widget.readData?.contact?.primary??"");
                              setState(() {

                              });
                            },
                              child: SvgPicture.string(SellerSvg().callIcon))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w1,
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
                                HomeSvg().chatGroupIcon,
                                color: ColorPalette.primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Chat with a Seller",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 20,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.string(TaskSvg().arrowIcon)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Business Details",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // context
                            //     .read<SellerAdminBloc>()
                            //     .add( GetSellerRead(widget.readData?.id??0));
                            // PersistentNavBarNavigator.pushNewScreen(
                            //   context,
                            //   screen: NewSellerAdmin(editSeller: true,),
                            //   withNavBar:
                            //   true, // OPTIONAL VALUE. True by default.
                            //   pageTransitionAnimation:
                            //   PageTransitionAnimation.fade,
                            // );
                          },
                          child: Icon(Icons.edit,
                          color: ColorPalette.primary,),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w1,
                      // margin: EdgeInsets.all(20),
                      child: Table(
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
                              label: widget.readData?.name,
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Industry",
                            ),
                            SubTextCard(
                              label: widget.readData?.categoryName??"",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "TRN No.",
                            ),
                            SubTextCard(
                              label: "TR12021NDBXB",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Import/Export Code",
                            ),
                            SubTextCard(
                              label: "TR12021NDBXB",
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Business E-Mail",
                            ),
                            SubTextCard(
                              label: widget.readData?.email,
                            ),
                          ]),
                          TableRow(children: [
                            TableTitle(
                              label: "Business Phone Number",
                            ),
                            SubTextCard(
                              label: widget.readData?.contact?.primary,
                            ),
                          ]),


                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Business Details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "${widget.readData?.addressOne??""} | ${widget.readData?.cityortown??""} | ${widget.readData?.landmark??""} | "
                          "${widget.readData?.state??""} | ${widget.readData?.country??""}",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      height: 3,
                      color: Color(0xfff8f7f5),
                    ),
                    SizedBox(height: 10,),
                    // SizedBox(height: 16,),Text(
                    //   "Delivery Address",
                    //   style: GoogleFonts.roboto(
                    //     color: Colors.black,
                    //     fontSize: w/22,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    // Text(
                    //   "MP Tower, Thondayad bypass, \nKozhikode, 673572",
                    //   style: GoogleFonts.roboto(
                    //     color: Color(0xff6d6d6d),
                    //     fontSize: w/24,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    //
                    // Divider(
                    //   color: Color(0xffE6ECF0).withOpacity(0.5),
                    //   thickness: 1.1,
                    // ),
                    //
                    // SizedBox(height: 20,),
                    Container(
                      width: w1,
                      // height: 100,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffdf2f2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AED 201.50",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffe5762),
                                  fontSize: w / 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Total Points",
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: w/24,
                                ),
                              )
                            ],
                          ),
                          SvgPicture.string(SellerSvg().trophyIcon)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> getCoverImage(source, businessId) async {
    try {
      final pickedFile =
      await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<ProfileBloc>(context)
        //     .add(UpdateBusinessCoverPictureEvent(cropImage!, businessId));
        // Navigator.pop(context);
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void _openDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
