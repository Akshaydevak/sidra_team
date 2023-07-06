import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common_widgets/loading.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../home/bloc/job_bloc.dart';
import '../home/model/joblist_model.dart';
import '../task_operation_appbar.dart';
import '../task_svg.dart';
import 'job_card.dart';

class NewJobList extends StatefulWidget {
  const NewJobList({Key? key}) : super(key: key);

  @override
  State<NewJobList> createState() => _NewJobListState();
}

class _NewJobListState extends State<NewJobList> {
  List<String> assignTypeList = ["All Jobs", "Pending Jobs","On Progress","Completed"];
  List<GetJobList> joblist=[];
  String? selectedType;
  @override
  void initState() {
    context.read<JobBloc>().add(const GetNewJobListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
  listeners: [
    BlocListener<JobBloc, JobState>(
  listener: (context, state) {
    print("stateeeeee $state");
    if(state is GetFilterJobListLoading){
      customCupertinoLoading();
    }
    if(state is GetFilterJobListSuccess) {
      joblist = state.jobList;
      setState(() {

      });
    }
      if(state is GetFilterJobListFailed){
        print("Failed JOBLIST");

        joblist.clear();
        setState(() {

        });
      }

  },
),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
      if(state is GetNewJobListLoading){

      }
      if(state is GetNewJobListSuccess){
        joblist=state.jobList;
        setState(() {

        });
      }
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Job List",
        isAction: false,
          onTap: () {

          },),
      ),
      body: joblist.isEmpty?
      Container(
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        height: h/3.5,
        child: SvgPicture.string(TaskSvg().nolistSvg),
      ):
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  Spacer(),
                  Container(
                    width: 120,
                    height: 37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xffe6ecf0), width: 1,),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        underline: Container(),
                        items: assignTypeList.map((String items) {
                          return DropdownMenuItem(
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: TextStyle(
                                    color: Colors.black)),
                          );
                        }).toList(),
                        value: selectedType,
                        onChanged: (dynamic value) {


                          setState(() {
                            selectedType = value;
                            selectedType=="Pending Jobs"?context.read<JobBloc>().add( GetFilterJobListEvent("PENDING")):
                                selectedType=="On Progress"?context.read<JobBloc>().add( GetFilterJobListEvent("ON PROGRESS")):
                                selectedType=="Completed"?context.read<JobBloc>().add( GetFilterJobListEvent("COMPLETED")):
                                context.read<JobBloc>().add(const GetNewJobListEvent());
                          });

                        },
                        hint: Text(
                          "All Jobs",
                          style: GoogleFonts.poppins(
                              color:Colors.grey,fontSize: 14),
                        )),
                  ), SizedBox(width: 10,),
                  Container(
                      width: 37,
                      height: 37,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xffe6ecf0), width: 1,),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,

                      ),
                      child: SvgPicture.string(
                          TaskSvg().moreTaskIcon)),
                  SizedBox(width: 15,),
                ],
              ),
              Container(
                // height: h/1.3,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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

                           Container(
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
                                    child: JobCard(
                                        joblist: joblist[i]
                                    ),
                                  );
                                },
                                itemCount: joblist.length),
                          )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
);
  }
}
