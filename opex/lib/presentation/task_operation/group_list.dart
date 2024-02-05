
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';


import '../../../../common_widgets/custom_checkbox.dart';



class GroupList extends StatefulWidget {
  final bool readUser;
  final List<String> userList;
  final List<GetUserList> userUpdateList;
  final GetEmployeeList? employeeList;
  final Function (List<String>,List<GetUserList>,bool val) listuser;

   const GroupList({Key? key, this.employeeList,required this.listuser, required this.readUser, required this.userList, required this.userUpdateList}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.all(3),
        child: CustomCheckBoxData(
          role: widget.employeeList?.role??"",

          profile: widget.employeeList?.profile??"",
          lname: widget.employeeList?.lname??"",
          key: UniqueKey(),
          value: widget.readUser,
          onChange: (p0) {

            if (p0) {
              widget.userList.add(widget.employeeList?.userCode ?? "");
              widget.userUpdateList.add(GetUserList(
                  userCode: widget.employeeList?.userCode,
                  isActive: true));
            }
            else {
              widget.userList.remove(widget.employeeList?.userCode ?? "");
              widget.userUpdateList.remove(GetUserList(
                  userCode: widget.employeeList?.userCode,
                  isActive: false));
              widget.userUpdateList.add(GetUserList(
                  userCode: widget.employeeList?.userCode,
                  isActive: false));
            }
            widget.listuser(widget.userList,widget.userUpdateList,true);
            print("usr-list${widget.userList}");
            print("usr-list${widget.userUpdateList}");

          },
          email: widget.employeeList?.email??"",
          name: widget.employeeList?.fname ??
              "",
        ),
      ),
    );
  }
}
