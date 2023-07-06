import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/self_checkout/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SelfProfileScreen extends StatelessWidget {
  List<String>profileList=["My Reciept","Manage Saved Cards","Coupons","Help & Support","Settings"];
  SelfProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.checkoutBackground,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: ColorPalette.checkoutBackground,
        ),
        backgroundColor: ColorPalette.checkoutBackground,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
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
                        ),
                        child: Image.network(
                          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit",
                        style: GoogleFonts.inter(
                          color: Color(0xffff477b),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Afthabu Rahman P P",
                  style: GoogleFonts.inter(
                    color: ColorPalette.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "afthaburahman313@gmail.com",
                  style: TextStyle(
                    color: Color(0x99151522),
                    fontSize: 16,
                  ),
                ),
                Text(
                  "860620044254121",
                  style: TextStyle(
                    color: Color(0x99151522),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  // height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0x190a0a0a),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) => ProfileCard(label: profileList[index]),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Color(0x19ff487c),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  // color: Colors.green,
                  width: w,
                  child: Text(
                    "Send any feedback to feedback@quickcheck.com ",
                    style: GoogleFonts.inter(
                      color: Color(0x99151522),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
