import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';

class ReportedListUser extends StatefulWidget {
  const ReportedListUser({super.key});

  @override
  State<ReportedListUser> createState() => _ReportedListUserState();
}

class _ReportedListUserState extends State<ReportedListUser> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    context.read<TaskBloc>().add(ReportListUserEvent("",""));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{
        // context.read<JobBloc>().add(GetNewJobListEvent('','',''));
        // context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      key: _refreshIndicatorKey,
      color: ColorPalette.primary,
      // backgroundColor: Colors.transparent,

      strokeWidth: 2.0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Reported List",
            isAction: false,
            onTap: () {},
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Total ${10} Jobs",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: w / 26,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                // joblist.isEmpty?
                // Container(
                //   padding: EdgeInsets.only(top: 10),
                //   alignment: Alignment.center,
                //   height: h / 3.5,
                //   child: SvgPicture.string(TaskSvg().nolistSvg),
                // ):
                Container(
                  // height: h/1.3,
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 16),
                  width: w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "New Jobs",
                      //   style: GoogleFonts.roboto(
                      //     color: Color(0xff151522),
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      BlocBuilder<TaskBloc, TaskState>(
  builder: (context, state) {
    if(state is ReportListUserListLoading){

    }
    if(state is ReportListUserListSuccess){
      return Container(
        padding: const EdgeInsets.only(bottom: 20),
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
                onTap: () {},
                child: Container(
                  // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.3,color: Color(0xffD3D3D3),),
                        borderRadius: BorderRadius.circular(5)


                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Text(state.orders?[i].topicName??"",
                                style: GoogleFonts.roboto(
                                    fontSize: w/26,
                                    fontWeight: FontWeight.w500

                                ),),
                              SizedBox(height: 10,),
                              Text(state.orders?[i].notes??"",
                                style: GoogleFonts.roboto(
                                  color: Color(0xff6D6D6D),
                                ),),
                            ],
                          ),
                        ),

                        Container(width: w,
                          height: 0.3,color: Colors.grey,),

                        Container(
                          width: w,
                          color: Color(0xffA9A8A8).withOpacity(0.2),
                          padding: EdgeInsets.all(10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.orders?[i].taskName??""),
                              Text(state.orders?[i].taskDescription??""),
                            ],
                          ),
                        ),

                        Container(width: w,
                          height: 0.3,color: Colors.grey,),

                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 10),
                                  SizedBox(width: 10,),
                                  Text("Report Approved",
                                    style: GoogleFonts.roboto(
                                        fontSize: w/26,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500

                                    ),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Description",
                                style: GoogleFonts.roboto(
                                    color: Color(0xff6D6D6D),
                                    fontSize: w/26
                                ),),
                            ],
                          ),
                        ),

                      ],
                    )),
              );
            },
            itemCount: state.orders!.length),
      );
    }
    return Container();
  },
)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}


