import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'help_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Help",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: w,
              height: 1.50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xb2e6e6e6),
                  width: 0.50,
                ),
              ),
            ),
            Container(
              child:
            SingleChildScrollView(
              child: Column(
                  children: List.generate(8, (index) {
                return Column(
                  children: [
                    HelpCard(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      width: w,
                      height: 1,
                      color: Color(0xffE6ECF0),
                    )
                  ],
                );
              })),
            ),
            )],
        ),
      ),
    );
  }
}
