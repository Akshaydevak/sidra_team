import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../task_svg.dart';
import 'assigned_me_card.dart';
import 'model/joblist_model.dart';

class AssignedByMe extends StatefulWidget {
  const AssignedByMe({Key? key}) : super(key: key);

  @override
  State<AssignedByMe> createState() => _AssignedByMeState();
}

class _AssignedByMeState extends State<AssignedByMe> {
  List<GetJobList> jobList=[];
  @override
  void initState() {
    context.read<JobBloc>().add(const GetAssignedMeListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return BlocListener<JobBloc, JobState>(
  listener: (context, state) {
    if(state is GetAssignedMeListLoading){

    }
    if(state is GetAssignedMeListSuccess){
      jobList=state.assignMeList;
      setState(() {

      });
    }
  },
  child:
      ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
        child: jobList.isEmpty? Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          height: h/2,
          child: SvgPicture.string(TaskSvg().nolistSvg,height: h/4.5,),
        ):Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total ${jobList.length} Jobs",
                        style: GoogleFonts.roboto(
                          color:  ColorPalette.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //
                      //     Container(
                      //         width: 37,
                      //         height: 37,
                      //         padding: EdgeInsets.all(8),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5),
                      //           border: Border.all(
                      //             color: Color(0xffe6ecf0), width: 1,),
                      //           boxShadow: const [
                      //             BoxShadow(
                      //               color: Color(0x05000000),
                      //               blurRadius: 8,
                      //               offset: Offset(1, 1),
                      //             ),
                      //           ],
                      //           color: Colors.white,
                      //         ),
                      //         child: SvgPicture.string(TaskSvg().moreTaskIcon))
                      //   ],
                      // ),

                    ]),
                const SizedBox(height: 16,),
                Container(
                  //color: Colors.yellow,
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      separatorBuilder: (BuildContext cxt, int i) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {

                          },
                          child: AssignedMeCard(assignedMe: jobList[i],),
                        );
                      },
                      itemCount: jobList.length),
                ),
              ],
            ),
          )
    ),
      ),
);
  }
}
