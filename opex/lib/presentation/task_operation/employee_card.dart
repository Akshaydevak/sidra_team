
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_group_screen.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/new_employee.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../core/common_snackBar.dart';
import '../../core/utils/variables.dart';


class EmployeeCard extends StatelessWidget {
  final GetEmployeeList? employeeList;
  final bool isSelect;
  final bool? isCommunicate;

  const EmployeeCard({Key? key, this.employeeList,this.isSelect=false, this.isCommunicate=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Container(
        // width: w,
        // height: h/7,
        padding: EdgeInsets.only(top: 15,bottom: 18,left: 10,right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isSelect ? ColorPalette.primary:Color(0xffe6ecf0), width: 1, ),
          boxShadow: [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 8,
              offset: Offset(1, 1),
            ),
          ],
          // color:  Variable.assignName == employeeList?.fname ?ColorPalette.cardBackground:Colors.white,
          color:  isSelect ?ColorPalette.cardBackground:Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             employeeList?.userMete?.profile==null?
             TextAvatar(
               shape: Shape.Circular,
               size: 40,
               numberLetters: 2,
               fontSize: w/22,
               textColor: Colors.white,
               fontWeight: FontWeight.w500,
              text:"${employeeList?.fname.toString().toUpperCase()} ${employeeList?.lname.toString().toUpperCase()}" ,
             )
                 :
             CircleAvatar(
               radius: 20,
               backgroundImage: NetworkImage(employeeList?.userMete?.profile??"",),
             ),
             SizedBox(width: 8,),
             SizedBox(
               width: w1>700?w/1.15:w/1.4,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         width: w/2.2,
                         // color: Colors.yellow,
                         child: Text(
                           "${employeeList?.fname}"" ""${employeeList?.lname}",
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                           style: GoogleFonts.roboto(
                             color: Colors.black,
                             fontSize: w/24,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                    isCommunicate==false?employeeList?.role=="Staff"?Container():
                       employeeList?.role=="Associative Admin"?Container(
                         decoration: BoxDecoration(
                           color: ColorPalette.primary.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(2)
                         ),
                         padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                         child: Text("Ass.admin",
                         style: GoogleFonts.roboto(
                           color: ColorPalette.primary,
                           fontWeight: FontWeight.w500,
                           fontSize: w/32
                         ),),
                       ):employeeList?.role=="Admin"?Container(
                         decoration: BoxDecoration(
                             color: ColorPalette.primary.withOpacity(0.2),
                             borderRadius: BorderRadius.circular(2)
                         ),
                         padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                         child: Text("Admin",
                           style: GoogleFonts.roboto(
                               color: ColorPalette.primary,
                               fontWeight: FontWeight.w500,
                               fontSize: w/32
                           ),),
                       ):Container():Container()
                     ],
                   ),
                   const SizedBox(height: 2,),
                   Container(
                     width: w,
                     // color: Colors.red,

                     child: Text(
                       employeeList?.email??"",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style:  TextStyle(
                         color: Colors.black,
                         fontSize: w/26,
                       ),
                     ),
                   )
                 ],
               ),
             ),
           ],
        ),
      );
  }
}


class EmployeeCardUnderGroup extends StatelessWidget {
  final GetUserList? userList;
  final String? value;
  const EmployeeCardUnderGroup({Key? key, this.userList,this.value=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Container(
      // width: w,
      // height: h/7,
      padding: EdgeInsets.only(bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color:  Variable.assignCode == userList?.code ?ColorPalette.cardBackground:Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      userList?.profile==""?
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextAvatar(
              shape: Shape.Circular,
              size: 40,
              numberLetters: 2,
              fontSize: w/22,
              textColor: Colors.white,
              fontWeight: FontWeight.w500,
              text:"${userList?.email.toString().toUpperCase()} " ,
            ),
          )
              :
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CircleAvatar(

              radius: 20,
              backgroundImage: NetworkImage(userList?.profile??"",),
            ),
          ),
          SizedBox(width: 8,),
          SizedBox(
            width: w/1.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/1.4,
                      // color: Colors.yellow,
                      child: Text(
                        "${userList?.fName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ],
                ),
                Container(
                  width: w/1.4,
                  // color: Colors.yellow,
                  child: Text(
                    "${userList?.email}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/26,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // const SizedBox(height: 2,),
                // Container(
                //   width: w,
                //   // color: Colors.red,
                //
                //   child: Text(
                //     userList?.email??"",
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //     style:  TextStyle(
                //       color: Colors.black,
                //       fontSize: w/26,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}