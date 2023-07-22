import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../task_operation_appbar.dart';
import 'critirea_performance.dart';

class CreatePerformance extends StatefulWidget {
  final GetTaskList? taskList;
  const CreatePerformance({Key? key, this.taskList}) : super(key: key);

  @override
  State<CreatePerformance> createState() => _CreatePerformanceState();
}

class _CreatePerformanceState extends State<CreatePerformance> {
  bool isIndividual= false;
  bool isCritiria= true;
  List<PointsList> pointList=[];
  int totalMark=0;
  @override
  void initState() {
    context.read<TaskBloc>().add(GetPointsListEvent());
    context.read<TaskBloc>().add(GetTotalPerformanceEvent(employeeCode: widget.taskList?.assigningCode??"",widget.taskList?.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
    if(state is GetPointListLoading){

    }
    if(state is GetPointListSuccess){
      pointList=state.pointList;
      print("FAS$pointList");
      setState(() {

      });
    }
  },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if(state is GetTotalPerformanceLoading){

        }
        if(state is GetTotalPerformanceSuccess){
          totalMark=state.totalMark;
          setState(() {
            print(("TOTA$totalMark"));
          });
        }
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),

          elevation: 0,

        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            TaskAndOperationAppBar(
              label: "Criteria",
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  // isIndividual? IndividualPerformance(pointList: pointList,taskList: widget.taskList,totalMark: totalMark,):Container(),
                  isCritiria? CritireaPerformance():Container(),
              ],),
            )

          ]),
        ),
      ),
    ),
);
  }

}
