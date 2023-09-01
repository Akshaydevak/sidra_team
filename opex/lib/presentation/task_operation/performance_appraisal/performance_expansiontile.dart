import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common_snackBar.dart';

class PerformanceExpansionTile extends StatefulWidget {
  String label;
  final bool isExpand;
  final VoidCallback? onTap;
  final List<PointsList>? pointlist;
  final GetTaskList? tasklist;
  final Function(bool val) load;
   PerformanceExpansionTile({Key? key,this.label="", this.pointlist, this.tasklist,  this.isExpand=false, this.onTap, required this.load}) : super(key: key);

  @override
  State<PerformanceExpansionTile> createState() =>
      _PerformanceExpansionTileState();
}

class _PerformanceExpansionTileState extends State<PerformanceExpansionTile> {

  int? select;
  void onSelect(int val) {
    select = val;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
    print('StateCreate$state');
    if (state is CreatePerformanceLoading) {
      // showSnackBar(context,
      //     message: "Loading...",
      //     color: Colors.white,
      //     // icon: HomeSvg().SnackbarIcon,
      //     autoDismiss: true);
    }

    if (state is CreatePerformanceFailed) {
      showSnackBar(
        context,
        message: state.error,
        color: Colors.red,
        // icon: Icons.admin_panel_settings_outlined
      );
    }
    if (state is CreatePerformanceSuccess) {
      // Fluttertoast.showToast(
      //     msg: 'Performance Created',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.white,
      //     textColor: Colors.black);
      context.read<TaskBloc>().add(
          GetTotalPerformanceEvent(employeeCode: widget.tasklist?.assigningCode??"",widget.tasklist?.id));

    }
  },
  child: GestureDetector(
    onTap:widget.onTap ,
    child: Container(
        width: w,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: widget.isExpand
                        ? Icon(Icons.keyboard_arrow_up_sharp)
                        : Icon(Icons.keyboard_arrow_down))
              ],
            ),
            widget.isExpand
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  onSelect(index);
                                  widget.load(true);
                                  setState((){

                                    BlocProvider.of<TaskBloc>(context)
                                        .add(CreatePerfomanceAppraisalTaskEvent(
                                      name: Variable.perfomanceName,
                                      discription: "",
                                      taskId:widget.tasklist?.id??0,
                                      pointId: widget.pointlist?[index].id??0,
                                      userId: widget.tasklist?.assigningCode??""

                                    ));
                                    context.read<TaskBloc>().add(
                                        GetTotalPerformanceEvent(employeeCode: widget.tasklist?.assigningCode??"",widget.tasklist?.id));
                                  });
                                },
                                child: Container(
                                  width: w,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: select==index?Border.all(
                                      color: Color(0xfffe5762),
                                      width: 1,
                                    ):Border.all(
                                      color: Colors.black,
                                      width: 0.2,
                                    ),
                                    color: select==index?Color(0x0cfe5762):Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: w/1.8,
                                        child: Text(

                                          "${index+1}-${widget.pointlist?[index].name}",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "${widget.pointlist?[index].points} Point",
                                        style: const TextStyle(
                                          color: Color(0xff939393),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              height: 15,
                            ),
                            itemCount: widget.pointlist!.length),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
  ),
);
  }
}
