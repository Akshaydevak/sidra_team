import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../task_svg.dart';
import 'assigned_me_card.dart';
import 'model/joblist_model.dart';

class AssignedByMe extends StatefulWidget {
  const AssignedByMe({Key? key}) : super(key: key);

  @override
  State<AssignedByMe> createState() => _AssignedByMeState();
}

class _AssignedByMeState extends State<AssignedByMe> {
  List<GetJobList> jobList = [];
  String nextUrl = "";
  String prevUrl = "";
  @override
  void initState() {
    context.read<JobBloc>().add(const GetAssignedMeListEvent('', '', ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: SingleChildScrollView(child:
          // jobList.isEmpty? Container(
          //   padding: EdgeInsets.only(top: 10),
          //   alignment: Alignment.center,
          //   height: h/2,
          //   child: SvgPicture.string(TaskSvg().nolistSvg,height: h/4.5,),
          // ):
          BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is GetAssignedMeListLoading) {
            return Container(
                height: 300,
                width: w,
                alignment: Alignment.center,
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.red,
                  size: 30,
                ));
          }
          if (state is GetAssignedMeListSuccess) {
            jobList = state.assignMeList ?? [];
            nextUrl = state.nextPageUrl ?? "";
            prevUrl = state.prevPageUrl ?? "";
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total ${jobList.length} Jobs",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 22,
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
                  const SizedBox(
                    height: 16,
                  ),
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
                            onTap: () {},
                            child: AssignedMeCard(
                              assignedMe: jobList[i],
                            ),
                          );
                        },
                        itemCount: jobList.length),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        prevUrl != ""
                            ? GestureDetector(
                                onTap: () {
                                  context.read<JobBloc>().add(
                                      GetAssignedMeListEvent('', '', prevUrl));
                                  // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                },
                                child: Text(
                                  "Previous",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPalette.primary,
                                      fontSize: w / 24),
                                ),
                              )
                            : Container(),
                        nextUrl != ""
                            ? GestureDetector(
                                onTap: () {
                                  // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                  setState(() {
                                    context.read<JobBloc>().add(
                                        GetAssignedMeListEvent(
                                            '', nextUrl, ""));
                                  });
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPalette.primary,
                                      fontSize: w / 24),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            height: h / 2,
            child: SvgPicture.string(
              TaskSvg().nolistSvg,
              height: h / 4.5,
            ),
          );
        },
      )),
    );
  }
}
