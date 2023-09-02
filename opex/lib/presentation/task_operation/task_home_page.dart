import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'home/assigned_me.dart';
import 'home/my_jobs.dart';

class TaskAndOperationHomePage extends StatefulWidget {
  final int? newIndex;
  const TaskAndOperationHomePage({Key? key, this.newIndex}) : super(key: key);

  @override
  State<TaskAndOperationHomePage> createState() =>
      _TaskAndOperationHomePageState();
}

class _TaskAndOperationHomePageState extends State<TaskAndOperationHomePage> {

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Job List",
          isAction: false,),

        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                alignment: Alignment.center,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: w / 1,
                    child:  TabBar(
                        labelColor: Colors.black,
                        indicatorColor: ColorPalette.primary,
                        unselectedLabelColor: Colors.black,
                        labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500,color: Colors.black,fontSize: w/24),
                        unselectedLabelStyle:GoogleFonts.roboto(fontWeight: FontWeight.normal,color: Colors.black,fontSize: w/24) ,
                        tabs: const [
                          Tab(text: "My Task"),
                          Tab(text: "Job Assigned by Me"),
                        ]),
                  )),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child:
                     const TabBarView(
                        children: [
                          // MyTasks(),
                          MyJobs(),
                          AssignedByMe()
                        ]),
                ),
              )
            ],
          ),
        ),
      );
  }
}
