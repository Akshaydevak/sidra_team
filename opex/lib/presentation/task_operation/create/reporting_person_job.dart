import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../employee_model/employee_model.dart';
import '../home/bloc/job_bloc.dart';
import '../home/model/joblist_model.dart';
import '../lottieLoader.dart';
import '../task_svg.dart';

class ReportingPersonJob extends StatefulWidget {
  const ReportingPersonJob({Key? key}) : super(key: key);

  @override
  State<ReportingPersonJob> createState() => _ReportingPersonJobState();
}

class _ReportingPersonJobState extends State<ReportingPersonJob> {
  GetJobList? JobRead;
  bool isSelect = false;
  List<GetEmployeeList> employee = [];

  @override
  void initState() {
    context.read<JobBloc>().add(GetReportingPersonListEvent());
    setState(() {});
    super.initState();
  }

  void read() {
    setState(() {
      context.read<JobBloc>().add(GetJobReadListEvent(JobRead?.id??0));
    });
  }
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is GetJobReadLoading) {}
            if (state is GetJobReadSuccess) {
              JobRead = state.getjobRead;

              setState(() {});
            }
          },
        ),
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is UpdateJobLoading) {
              // showSnackBar(context,
              //     message: "Loading...",
              //     color: Colors.white,
              //     // icon: HomeSvg().SnackbarIcon,
              //     autoDismiss: true);
            }

            if (state is UpdateJobFailed) {
              showSnackBar(
                context,
                message: state.error,
                color: Colors.red,
                // icon: Icons.admin_panel_settings_outlined
              );
            }
            if (state is UpdateJobSuccess) {
              Fluttertoast.showToast(
                  msg: state.successMessage??"",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is GetReportingPersonListLoading) {
              customCupertinoLoading();
            }
            if (state is GetReportingPersonListSuccess) {
              employee = state.employeeList;
              _isLoading=false;
              print("sucsess${state.employeeList}");
              setState(() {});
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(
              label: "Reporting Person",
              isAction: false,
              // action: GestureDetector(
              //   onTap: () {
              //     context.read<JobBloc>().add(GetJobReadListEvent(
              //         int.tryParse(Variable.jobReadId.toString()) ?? 0));
              //   },
              //   child: SvgPicture.string(
              //     CartSvg().searchIcon,
              //     color: Colors.black,
              //   ),
              // ),
            )),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(_isLoading)...[
                    LottieLoader()
                  ]
                  else...[

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Color(0xffe6ecf0),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10, top: 10),
                                child: SingleRow(
                                  label: "Reporting Person",
                                  color: Color(0xffAD51E0),
                                  svg: TaskSvg().personIcon,
                                  endIcon: Container(),
                                  onTap: () {
                                    setState(() {
                                      // isReporting = !isReporting;
                                    });
                                  },
                                ),
                              ),
                              Divider(
                                indent: 10,
                                height: 2,
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16, top: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(TaskSvg().profileReporting),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          JobRead?.reportingMail ?? "",
                                          style: TextStyle(
                                            color: ColorPalette.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Total ${employee.length} Assignee",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      height: 5,
                                    );
                                  },
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () {
                                        BlocProvider.of<JobBloc>(context)
                                            .add(UpdateJobEvent(
                                          id: JobRead?.id,
                                          startDate:
                                          "${JobRead?.startDate?.split("T")[0]}"
                                              " "
                                              "${JobRead?.startDate?.split("T")[1].split("+")[0]}" ??
                                              "",
                                          endDate:
                                          "${JobRead?.endDate?.split("T")[0]}"
                                              " "
                                              "${JobRead?.endDate?.split("T")[1].split("+")[0]}" ??
                                              "",
                                          originFrom: JobRead?.orginFrom ?? "",
                                          reportingPerson: employee[i].userCode ?? "",
                                          priority: JobRead?.priority ?? "",
                                          name: JobRead?.name ?? "",
                                          jobType: JobRead?.jobType,
                                          isActive: JobRead?.isActive ?? true,
                                          assignedBy: JobRead?.assignCode ?? "",
                                          createdBy: JobRead?.createdCode ?? "",
                                          discription: JobRead?.description ?? "",
                                        ));
                                        read();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: JobRead?.reportingMail==employee[i].email?
                                            ColorPalette.primary:
                                            Color(0xffe6ecf0),
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x05000000),
                                              blurRadius: 8,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                          color: JobRead?.reportingMail==employee[i].email?Color(0xffEAF1F7):Colors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        width: w,
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  employee[i]?.userMete?.profile==null?TextAvatar(
                                                    shape: Shape.Circular,
                                                    size: 40,
                                                    numberLetters: 2,
                                                    fontSize: w/22,
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    text:employee[i].email.toString().toUpperCase() ,
                                                  ):  CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(employee[i]?.userMete?.profile??"",),
                                      ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      width: w / 1.5,
                                                      child: Text(
                                                        employee[i].email ??
                                                            "",
                                                        style: TextStyle(
                                                          color:
                                                          Color(0xff151522),
                                                          fontSize: w / 22,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                  itemCount: employee.length),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]
                ]),
          )),
        ),
      ),
    );
  }
}
