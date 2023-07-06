import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/base/bottom_card.dart';

import 'package:cluster/presentation/logistic_app/screens/logistic_quick_access.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../../task_operation/home_card.dart';

class LogisticHome extends StatefulWidget {
  String ?label;
   LogisticHome({Key? key,this.label}) : super(key: key);

  @override
  State<LogisticHome> createState() => _LogisticHomeState();
}

class _LogisticHomeState extends State<LogisticHome> {



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: widget.label??"Logistic App",
          isAction: false,
          action :SvgPicture.string(
            TaskSvg().notificationIcon,
            color: Colors.black,
          ),),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchCard(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "120",
                      sub: "New Orders",
                    ),
                    HomeCard(
                      head: '32',
                      sub: "Total Delivery",
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "3200",
                      sub: "Returned Orders",
                    ),
                    HomeCard(
                      head: '362',
                      sub: "Delivery on progress",
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "Quick access to :",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                LogisticQuickAccess(),
                BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
