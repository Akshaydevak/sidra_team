import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'attachment_screen.dart';
import 'create/model/task_models.dart';

class MyTabScreen extends StatefulWidget {
  final GetTaskList? getTaskRead;
  const MyTabScreen({
    Key? key,
    this.getTaskRead,
  }) : super(key: key);

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
        backgroundColor: ColorPalette.white,

        // appBar: PreferredSize(
        //     preferredSize: const Size.fromHeight(60),
        //     child: BackAppBar(
        //         label: "${_getTabText(_selectedIndex)}" ?? "",
        //         isAction: false,
        //         isBack: false,
        //         onTap: (){
        //
        //           Navigator.pop(context);
        //         },
        //         action: Container(
        //           padding: EdgeInsets.symmetric(
        //               horizontal: 16, vertical: 8),
        // margin: EdgeInsets.symmetric(
        //               horizontal: 16, vertical: 10),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             color: ColorPalette.primary,
        //           ),
        //           alignment: Alignment.center,
        //           child:
        //           // buttonLoad==true?
        //           // SpinKitThreeBounce(
        //           //   color: Colors.white,
        //           //   size: 15.0,
        //           // ):
        //           Text(
        //             "Add",
        //             textAlign: TextAlign.center,
        //             style: GoogleFonts.roboto(
        //               color: Colors.white,
        //               fontSize: w/22,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),)
        //     ),),
        appBar: AppBar(
          title: Text(
            "${_getTabText(_selectedIndex)}",
            style: GoogleFonts.roboto(fontSize: w / 22),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            onTap: (val) {
              setState(() {
                _selectedIndex = val;
                print(
                    'Tapped Tab: Index $_selectedIndex, Text: ${_getTabText(val)}');
              });
            },
            tabs: [
              Tab(text: 'Notes'),
              Tab(text: 'Payment'),
              Tab(text: 'Rewards'),
            ],
          ),
          surfaceTintColor: Colors.white,
          titleSpacing: 0,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                "Save",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Content for "Notes" Tab
            Center(
              child: AttachmentScreen(
                readData: widget.getTaskRead,
              ),
            ),

            // Content for "Payment" Tab
            Center(
              child: PaymentOption(
                assignCode: widget.getTaskRead?.assignToDict?.userCode,
                assignType: widget.getTaskRead?.assigningType,
                currencyCode: widget.getTaskRead?.currency,
                isJob: false,
                isTask: true,
                update: widget.getTaskRead?.paymentId == null
                    ? false
                    : widget.getTaskRead?.paymentId == null
                        ? false
                        : true,
                paymentId: widget.getTaskRead?.paymentId ?? 0,
                taskId: widget.getTaskRead?.id ?? 0,
                jobId: null,
              ),
            ),

            // Content for "Rewards" Tab
            Center(
              child: RewardsScreen(
                type: "Task",
                typeId: widget.getTaskRead?.id ?? 0,
                update: widget.getTaskRead?.rewardid == null
                    ? false
                    : widget.getTaskRead?.rewardid == null
                        ? false
                        : true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTabText(int index) {
    // Function to get the text of the tab at the given index
    final tabTexts = ['Notes & Attachments', 'Payment Option', 'Rewards'];
    return tabTexts[index];
  }
}
