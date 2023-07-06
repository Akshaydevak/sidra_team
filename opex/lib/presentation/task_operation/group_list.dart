
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:flutter/material.dart';


import '../../../../common_widgets/custom_checkbox.dart';



class GroupList extends StatefulWidget {
  final bool readUser;
  final List<String> userList;
  final GetEmployeeList? employeeList;
  final Function (List<String>) listuser;

   const GroupList({Key? key, this.employeeList,required this.listuser, required this.readUser, required this.userList}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    // print("code${widget.userlistCode}");
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          CustomCheckBox(
            key: UniqueKey(),
            value: widget.readUser,
            // userList.contains(widget.userlistCode),
            onChange: (p0) {

              if (p0) {
                widget.userList.add(widget.employeeList?.code ?? "");
              }
              else {
                widget.userList.remove(widget.employeeList?.code ?? "");
              }
              widget.listuser(widget.userList);
              print("usr-list${widget.userList}");

            },
          ),
          const SizedBox(
            width: 5,
          ),
          const CircleAvatar(
            radius: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.employeeList?.primaryMail??"",
            style:  TextStyle(overflow: TextOverflow.clip,

              color: Color(0xff151522),
              fontSize: w/24,
            ),
          )
        ],
      ),
    );
  }
}
