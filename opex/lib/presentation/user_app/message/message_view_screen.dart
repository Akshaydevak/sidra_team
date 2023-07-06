import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/user_app/user_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../task_operation/task_svg.dart';

class MessageViewScreen extends StatelessWidget {
  const MessageViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Message",
          isAction: false,
           action: Row(
             children: [
               SvgPicture.string(UserSvg().attachIcon),
               SizedBox(width: 20,),
               SvgPicture.string(TaskSvg().sendIcon),
               SizedBox(width: 10,),
             ],
           ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                // padding: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefix: Text(
                        "To :",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xffE6ECF0).withOpacity(0.3))),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE6ECF0))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE6ECF0))),
                      hintText: "  Search employee/Group name"),
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Message ...",
                        hintStyle: TextStyle(
                            color: ColorPalette.inactiveGrey,
                            fontSize: w/22,

                        ),
                      ),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
