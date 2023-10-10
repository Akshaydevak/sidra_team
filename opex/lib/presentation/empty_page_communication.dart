import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/color_palatte.dart';

class EmptyPageCommunication extends StatefulWidget {
  const EmptyPageCommunication({Key? key}) : super(key: key);

  @override
  State<EmptyPageCommunication> createState() => _EmptyPageCommunicationState();
}

class _EmptyPageCommunicationState extends State<EmptyPageCommunication> {
  List<ActivityList> activityList=[];
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                      Text("Coming Soon",
                        style: GoogleFonts.roboto(
                          fontSize: w/10,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 25,),
                        Container(
                          width: w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xffEAF1F7),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                          
                          child: Column(children: [
                            Text("We are currently working on creating something fantastic for sidrateams",
                            textAlign: TextAlign.center),
                            SizedBox(height: 10,),
                            Text("Your suggestions will be appreciated.",style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold
                            ),),
                          ]),

                        ),
                        SizedBox(height: 25,),
                        Text("Contact Us"),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: ()async{
                                  String email = Uri.encodeComponent("care@sidrateams.com");
                                  String subject = Uri.encodeComponent("Suggestions");
                                  String body = Uri.encodeComponent("Hi,");
                                  
                                  Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                                  if (await launchUrl(mail)) {

                                  }else{

                                  }
                              },
                              child: Text("care@sidrateams.com",style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.bold
                              ),),
                            ),

                            SizedBox(height: h/4,),
                            Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(
                      AppsSvg().careIcon,
                      height: 10,width: 10,
                    ),
                    SizedBox(width: 5,),
                    Text("all rights reserved to sidrateams",
                    style: GoogleFonts.roboto(
                      fontSize: w/32,
                      color: Color(0xff555555),
                    ),),
                  ],
                ))

                      ],
                    )))
              ],
            ),
          ),
        ),
      ),
    );

  }
}
