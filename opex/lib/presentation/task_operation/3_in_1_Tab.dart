import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import 'attachment_screen.dart';

class MyTabScreen extends StatefulWidget {
  @override
  State<MyTabScreen> createState() => _MyTabScreenState();
}

class _MyTabScreenState extends State<MyTabScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("${_getTabText(_selectedIndex)}",
          style: GoogleFonts.roboto(
            fontSize: w/22
          ),),
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            onTap: (val){
              setState(() {
                _selectedIndex = val;
                print('Tapped Tab: Index $_selectedIndex, Text: ${_getTabText(val)}');
              });
            },
            tabs: [
              Tab(text: 'Notes',),
              Tab(text: 'Payment'),
              Tab(text: 'Rewards'),
            ],
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          actions: [
          Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
            margin: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorPalette.primary,
                      ),
                      alignment: Alignment.center,
                      child:
                      // buttonLoad==true?
                      // SpinKitThreeBounce(
                      //   color: Colors.white,
                      //   size: 15.0,
                      // ):
                      Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),)
          ],
        ),
        body: TabBarView(
          children: [
            // Content for "Notes" Tab
            Center(
              child: AttachmentScreen(),
            ),

            // Content for "Payment" Tab
            Center(
              child: PaymentOption(
                // assignCode: getTaskRead?.assignToDict?.userCode,
                // assignType: getTaskRead?.assigningType,
                // currencyCode:
                // getTaskRead?.currency,
                // isJob: false,
                // isTask: true,
                // update: getTaskRead
                //     ?.paymentId ==
                //     null
                //     ? false
                //     : getTaskRead
                //     ?.paymentId ==
                //     null
                //     ? false
                //     : true,
                paymentId:
                // getTaskRead
                //     ?.paymentId ??
                    0,
                // taskId:
                // getTaskRead?.id ?? 0,
                // jobId: null,
              ),
            ),

            // Content for "Rewards" Tab
            Center(
              child: RewardsScreen(
                type: "Task",
                typeId:
                // getTaskRead?.id ??
                    0,
                update:
                // getTaskRead
                //     ?.rewardid ==
                //     null
                //     ? false
                //     : getTaskRead
                //     ?.rewardid ==
                //     null
                //     ? false
                //     :
                true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _getTabText(int index) {
    // Function to get the text of the tab at the given index
    final tabTexts = ['Notes', 'Payment', 'Rewards'];
    return tabTexts[index];
  }
}