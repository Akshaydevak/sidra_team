import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_svg.dart';
import '../task_title.dart';

class ReportedListAdmin extends StatefulWidget {
  const ReportedListAdmin({super.key});

  @override
  State<ReportedListAdmin> createState() => _ReportedListAdminState();
}

class _ReportedListAdminState extends State<ReportedListAdmin> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    context.read<TaskBloc>().add(ReportListAdminEvent("", ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
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


                  Container(
                    // height: h/1.3,
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: w1,
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
                            if (state is ReportListAdminListLoading) {
                              return LottieLoader();
                            }

                            if (state is ReportListAdminListSuccess) {
                              return state.orders!.isNotEmpty?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total ${state.orders!.length} Jobs",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: w / 26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        separatorBuilder:
                                            (BuildContext cxt, int i) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        itemBuilder: (BuildContext context, int i) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      width: 0.3,
                                                      color: Color(0xffD3D3D3),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 25,
                                                          child: TextAvatar(
                                                            shape: Shape.Circular,
                                                            size: 5,
                                                            numberLetters: 1,
                                                            fontSize: w / 22,
                                                            textColor: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            text: state.orders?[i].userName ??
                                                                "".toUpperCase(),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          state.orders?[i].topicName??"",
                                                          style: GoogleFonts.roboto(
                                                              fontSize: w / 26,
                                                              fontWeight:
                                                                  FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      state.orders?[i].notes??"",
                                                      style: GoogleFonts.roboto(
                                                        color: Color(0xff6D6D6D),
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Text(state.orders?[i].taskName??""),
                                                    Text(state.orders?[i].taskDescription??""),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        context.read<TaskBloc>().add(GetTaskReadListEvent(state.orders?[i].taskId ?? 0));
                                                        PersistentNavBarNavigator.pushNewScreen(
                                                          context,
                                                          screen: TaskTitle(
                                                            isMyJob: true,
                                                            isReporter: false,
                                                            isReported: true,
                                                            // reportId: state.orders?[i].id,
                                                          ),
                                                          withNavBar: false, // OPTIONAL VALUE. True by default.
                                                          pageTransitionAnimation: PageTransitionAnimation.fade,
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "View Details",
                                                            style: GoogleFonts.roboto(
                                                              color: ColorPalette
                                                                  .primary,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.arrow_forward,
                                                            size: 20,
                                                            color:
                                                                ColorPalette.primary,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        },
                                        itemCount: state.orders!.length),
                                  ),
                                ],
                              ):

                              Container(
                                padding: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                height: h / 3.5,
                                child: SvgPicture.string(TaskSvg().nolistSvg),
                              );
                            }
                            if(state is ReportListAdminListFailed){
                              return Container(
                                padding: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                height: h / 3.5,
                                child: SvgPicture.string(TaskSvg().nolistSvg),
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
          )),
    );
  }
}
