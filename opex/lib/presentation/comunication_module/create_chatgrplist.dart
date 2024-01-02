
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';


import '../../../../common_widgets/custom_checkbox.dart';



class GroupChatList extends StatefulWidget {
  final bool readUser;
  final List<String> userList;
  final List<GetEmployeeList> userUpdateList;
  final GetEmployeeList? employeeList;
  final Function (List<String>,List<GetEmployeeList>,bool val) listuser;

   const GroupChatList({Key? key, this.employeeList,required this.listuser, required this.readUser, required this.userList, required this.userUpdateList}) : super(key: key);

  @override
  State<GroupChatList> createState() => _GroupChatListState();
}

class _GroupChatListState extends State<GroupChatList> {

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
      child:Container(
        padding: EdgeInsets.all(3),
        child: 
            CustomCheckBoxData(
              role: widget.employeeList?.role??"",
              profile: widget.employeeList?.profile??"",
              lname: widget.employeeList?.lname??"",
              key: UniqueKey(),
              value: widget.readUser,
              onChange: (p0) {
            
                if (p0) {
                  widget.userList.add(widget.employeeList?.userCode ?? "");
                  widget.userUpdateList.add(GetEmployeeList(
                      fname: widget.employeeList?.fname,
                      lname: widget.employeeList?.lname,
                      email: widget.employeeList?.email,
                      profile: widget.employeeList?.profile,
                      code: widget.employeeList?.userCode
                      ));
                }
                else {
                  widget.userList.remove(widget.employeeList?.userCode ?? "");
                  widget.userUpdateList.remove(GetEmployeeList(
                      fname: widget.employeeList?.fname,
                      lname: widget.employeeList?.lname,
                      email: widget.employeeList?.email,
                      profile: widget.employeeList?.profile,
                      code: widget.employeeList?.userCode
                      ));
                  widget.userUpdateList.add(GetEmployeeList(
                          fname: widget.employeeList?.fname,
                      lname: widget.employeeList?.lname,
                      email: widget.employeeList?.email,
                      profile: widget.employeeList?.profile,
                      code: widget.employeeList?.userCode
                      ));
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
