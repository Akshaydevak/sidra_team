import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'attachment_screen.dart';
import 'create/model/task_models.dart';
import 'home/bloc/job_bloc.dart';
import 'home/model/joblist_model.dart';

class MyTabScreenTwoInOne extends StatefulWidget {
  final int? index;
  final GetJobList? getJobRead;
  const MyTabScreenTwoInOne({
    Key? key,
    this.getJobRead, this.index,
  }) : super(key: key);

  @override
  State<MyTabScreenTwoInOne> createState() => _MyTabScreenTwoInOneState();
}

class _MyTabScreenTwoInOneState extends State<MyTabScreenTwoInOne> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;
  late TabController _tabController;
  @override
  void initState() {
    print("index$_selectedIndex");

    print("index${widget.index}");
    _selectedIndex=widget.index??0;

    print("index$_selectedIndex");
    _getTabText(widget.index??0);
    print(
        'init Tab: Index ${widget.index}, Text: ${_getTabText(widget.index??0)}');
    // Create TabController
    _tabController = TabController(length: 2, vsync: this);

    // Set the initial index
    // Set the initial index
    _tabController.index = widget.index ?? 0;

    // Add listener for tab changes
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    setState(() {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        context.read<JobBloc>().add(
            GetJobReadListEvent(widget.getJobRead?.id??0));
        return true;

      },
      child: DefaultTabController(
        length: 2, // Number of tabs
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
              controller: _tabController,

              onTap: (val) {
                setState(() {
                  _selectedIndex = val;
                  print(
                      'Tapped Tab: Index $_selectedIndex, Text: ${_getTabText(val)}');
                });
              },
              indicatorColor: ColorPalette.primary,
              labelColor: ColorPalette.primary,

              tabs: [
                Tab(text: 'Payment'),
                Tab(text: 'Rewards'),
              ],
            ),
            surfaceTintColor: Colors.white,
            titleSpacing: 0,

          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Content for "Payment" Tab
              Center(
                child: PaymentOption(
                  currencyCode: widget.getJobRead?.currency,
                  isJob: true,
                  isTask: false,
                  update: widget.getJobRead?.paymentId == null ? false : true,
                  jobId: widget.getJobRead?.id,
                  paymentId: widget.getJobRead?.paymentId ?? 0,
                  joblist: widget.getJobRead,
                ),
              ),

              // Content for "Rewards" Tab
              Center(
                child: RewardsScreen(
                  type: "Job",
                  typeId: widget.getJobRead?.id ?? 0,
                  // update: JobRead?.rewardId == null
                  //     ? false
                  //     : JobRead?.rewardId == null
                  //         ? false
                  //         : true
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  String _getTabText(int index) {
    // Function to get the text of the tab at the given index
    final tabTexts = ['Payment Option', 'Rewards'];
    return tabTexts[index];
  }
}
