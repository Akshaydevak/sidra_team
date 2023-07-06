import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class PinnedJob extends StatelessWidget {
  const PinnedJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Job List", isAction: false,
            action: PopupMenuButton(
              icon: SvgPicture.string(TaskSvg().moreIcon),
              //don't specify icon if you want 3 dot menu
              color: Colors.white,
              elevation: 2,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              itemBuilder: (context) => [
                PopupMenuItem(
                    padding: EdgeInsets.all(0),
                    value: 'a',
                    enabled: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Edit this Job',
                            style: GoogleFonts.poppins(
                                color: Colors.black54,

                                fontSize: 13,
                                fontWeight: FontWeight.w500),),),
                        const Divider(indent: 30,)
                      ],
                    ))
              ],
              onSelected: (value) {
              },
            ),
            // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
          ),
        ),
       body: ScrollConfiguration(behavior: NoGlow(),
       child: SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.all(16),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 "New Jobs",
                 style: GoogleFonts.roboto(
                   color: ColorPalette.black,
                   fontSize: 18,
                   fontWeight: FontWeight.w500,
                 ),
               ),
           // ListView.separated(
           //     padding: const EdgeInsets.only(bottom: 20),
           //     shrinkWrap: true,
           //     physics: const ScrollPhysics(),
           //     separatorBuilder: (BuildContext cxt, int i) {
           //       return const SizedBox(
           //         height: 10,
           //       );
           //     },
           //     itemBuilder: (BuildContext context, int i) {
           //       return InkWell(
           //         onTap: () {},
           //         child: JobCard(
           //             joblist: state.jobList[i]
           //         ),
           //       );
           //     },
           //     itemCount: 5),
             ],
           ),
         ),
       ),
       ),


      ),
    );
  }
}
