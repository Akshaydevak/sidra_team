import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Notification",
          isAction: false,

        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFieldTab(
                label: "Message Text",
                hint: "Eg. SEM",
              ),
              const SizedBox(height: 10,),
              TextFieldTab(
                label: "Message Label",
                hint: "Eg. SEM",
              ),
              const SizedBox(height: 10,),
              TextFieldTab(
                label: "Topic",
                hint: "Eg. SEM",
              ),
              const SizedBox(height: 10,),
              TextFieldTab(
                label: "Target Group",
                hint: "-  Select Group -",
              ),
              SizedBox(height: 50,),
              GradientButton(
                  onPressed: () {

                  },
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfffe5762),
                      Color(0xfffe5762),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: const Color(0xfffe5762),
                  child: Text(
                    "Send Notification",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
