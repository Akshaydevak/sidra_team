
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
    var w=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: CustomCheckBoxData(
          key: UniqueKey(),
          value: widget.readUser,
          onChange: (p0) {

            if (p0) {
              widget.userList.add(widget.employeeList?.code ?? "");
              widget.userUpdateList.add(GetUserList(
                  userCode: widget.employeeList?.code,
                  isActive: true));
            }
            else {
              widget.userList.remove(widget.employeeList?.code ?? "");
              widget.userUpdateList.remove(GetUserList(
                  userCode: widget.employeeList?.code,
                  isActive: false));
              widget.userUpdateList.add(GetUserList(
                  userCode: widget.employeeList?.code,
                  isActive: false));
            }
            widget.listuser(widget.userList,widget.userUpdateList,true);
            print("usr-list${widget.userList}");
            print("usr-list${widget.userUpdateList}");

          },
          email: widget.employeeList?.primaryMail??"",
          name: widget.employeeList?.fname ??
              "",
        ),
      ),
    );
  }
}
