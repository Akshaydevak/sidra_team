import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create_card.dart';
import 'create_screen/alert_screen.dart';
import 'create_screen/notification_screen.dart';
import 'create_screen/warning_screen.dart';
import 'message/message_screen.dart';

class CreateNewScreen extends StatelessWidget {
  const CreateNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Create New",
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
                 "Select Type :",
                 style: GoogleFonts.roboto(
                   color: Color(0xff151522),
                   fontSize: w/22,
                   fontWeight: FontWeight.w500,
                 ),
               ),
               SizedBox(height: 16,),
               GestureDetector(
                 onTap: (){
                   PersistentNavBarNavigator.pushNewScreen(
                     context,
                     screen: MessageScreen(),
                     withNavBar: true, // OPTIONAL VALUE. True by default.
                     pageTransitionAnimation: PageTransitionAnimation.fade,
                   );
                 //
                 },
                 child: CreateCard(
                   color: Color(0xff33c658),
                   label:  "Message",
                 ),
               ),
               SizedBox(height: 5,),
               GestureDetector(
                 onTap: (){
                   PersistentNavBarNavigator.pushNewScreen(
                   context,
                   screen: AlertScreen(),
                   withNavBar: true, // OPTIONAL VALUE. True by default.
                   pageTransitionAnimation: PageTransitionAnimation.fade,
                 );
                 //  AlertScreen
                 },
                 child: CreateCard(color: Color(0xffEE9500),
                 label: "Alert",),
               ),
               SizedBox(height: 5,),
               GestureDetector(
                 onTap: (){
                   PersistentNavBarNavigator.pushNewScreen(
                     context,
                     screen: NotificationScreen(),
                     withNavBar: true, // OPTIONAL VALUE. True by default.
                     pageTransitionAnimation: PageTransitionAnimation.fade,
                   );
                 //  NotificationScreen
                 },
                 child: CreateCard(
                   color: Color(0xffFFD840),
                   label: "Notification",
                 ),
               ),  SizedBox(height: 5,),
               GestureDetector(
                 onTap: (){
                   PersistentNavBarNavigator.pushNewScreen(
                     context,
                     screen: WarningScreen(),
                     withNavBar: true, // OPTIONAL VALUE. True by default.
                     pageTransitionAnimation: PageTransitionAnimation.fade,
                   );
                 //  WarningScreen
                 },
                 child: CreateCard(
                   color: Color(0xffE94E2D),
                   label: "Warning",
                 ),
               ),
             ],
           ),
        ),
      ),
    );
  }
}
