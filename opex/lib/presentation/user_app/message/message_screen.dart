import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/user_app/message/select_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'message_view_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

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
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefix: Text(
                      "To :",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffE6ECF0).withOpacity(0.3))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE6ECF0))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE6ECF0))),
                    hintText: "  Search employee/Group name"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Group",
                style: GoogleFonts.roboto(
                  color: ColorPalette.black,
                  fontSize: w / 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5,),
              SelectGroupCard(),
              SizedBox(height: 16,),
              Text(
                "Select Employee",
                style: GoogleFonts.roboto(
                  color: ColorPalette.black,
                  fontSize: w / 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MessageViewScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      //MessageViewScreen
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Afthimal1254@gmail.com",
                            style: TextStyle(
                              color: Color(0xff151522),
                              fontSize: w/22,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Color(0xffE6ECF0),
                    indent: 50,
                  ),

                  itemCount: 5),
            ],
          ),
        ),
      ),
    );
  }
}
