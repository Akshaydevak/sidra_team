
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_group_screen.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/new_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../core/common_snackBar.dart';


class EmployeeCard extends StatelessWidget {
  final GetEmployeeList? employeeList;
  const EmployeeCard({Key? key, this.employeeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {

        if (state is DeleteEmployeeLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is DeleteEmployeeFailed) {
          showSnackBar(
            context,
            message: "Not Deleter",
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is DeleteEmployeeSuccess) {


          Fluttertoast.showToast(
              msg: 'Successfully Deleted',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);

          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: EmployeesGroupScreen(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        }

      },
  child: Container(
      // width: w,
      // height: h/7,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CircleAvatar(
             radius: 30,
             backgroundImage: NetworkImage(employeeList?.profile??"",),
           ),
           // CircleAvatar(
           //   radius: 25, // set the radius of the circular avatar
           //   backgroundColor: Colors.transparent, // set the background color to transparent
           //   backgroundImage: ClipOval(
           //     child: Image.network(employeeList?.profile??"",fit: BoxFit.cover, // replace with your image path// make sure the image covers the entire avatar area
           //     ),
           //   ),
           // ),
           SizedBox(width: 8,),
           SizedBox(
             width: w/1.7,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   "${employeeList?.fname}"" ""${employeeList?.lname}",
                   style: GoogleFonts.roboto(
                     color: Colors.black,
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
                 // SizedBox(height: 5,),
                 // Text(
                 //   "Manager  |  Rawabi Hypermarket",
                 //   style: GoogleFonts.roboto(
                 //     color: Color(0xff9b9b9b),
                 //     fontSize: 14,
                 //     fontWeight: FontWeight.w500,
                 //   ),
                 // ),
                 SizedBox(height: 5,),
                 Text(
                   employeeList?.primaryMobile??"",
                   style: const TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                   ),
                 ),
                 const SizedBox(height: 5,),
                 Text(
                   employeeList?.primaryMail??"",
                   style: const TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                   ),
                 )
               ],
             ),
           ),
           Spacer(),
           // PopupMenuButton(
           //   icon: SvgPicture.string(TaskSvg().moreIcon),
           //   //don't specify icon if you want 3 dot menu
           //   color: Colors.white,
           //   elevation: 1,
           //   padding: EdgeInsets.zero,
           //   shape:
           //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           //   itemBuilder: (context) =>
           //   [
           //     PopupMenuItem(
           //         padding: EdgeInsets.all(0),
           //         value: 'a',
           //         enabled: true,
           //         child: Column(
           //           crossAxisAlignment: CrossAxisAlignment.start,
           //           children: [
           //             InkWell(
           //               onTap: (){
           //                 print("EdIT");
           //
           //                 context.read<EmployeeBloc>().add(
           //                     GetEmployeeReadEvent(employeeList?.id?? 0));
           //                 PersistentNavBarNavigator.pushNewScreen(
           //                   context,
           //                   screen: const NewEmployee(editEmployee: true),
           //                   withNavBar: true, // OPTIONAL VALUE. True by default.
           //                   pageTransitionAnimation: PageTransitionAnimation.fade,
           //                 );
           //               },
           //               child: Container(
           //                 padding: EdgeInsets.all(10),
           //                 child: Row(
           //                   children: [
           //                     // SvgPicture.string(TaskSvg().editorIcon),
           //                     // SizedBox(width: 10,),
           //                     Text(
           //                       'Edit',
           //                       style: GoogleFonts.poppins(
           //                           color: Colors.black54,
           //                           fontSize: 13,
           //                           fontWeight: FontWeight.w500),
           //                     ),
           //                   ],
           //                 ),
           //               ),
           //             ),
           //             Divider(indent: 30,),
           //             InkWell(
           //               onTap: (){
           //                 BlocProvider.of<EmployeeBloc>(context)
           //                     .add(DeleteEmployeeEvent(employeeList?.id?? 0));
           //               },
           //               child: Container(
           //                 padding: EdgeInsets.all(10),
           //                 child: Row(
           //                   children: [
           //
           //                     Text(
           //                       'Remove From List',
           //                       style: GoogleFonts.poppins(
           //                           color: Colors.black54,
           //                           fontSize: 13,
           //                           fontWeight: FontWeight.w500),
           //                     ),
           //                   ],
           //                 ),
           //               ),
           //             ),
           //
           //           ],
           //         ))
           //
           //   ],
           //   onSelected: (value) {
           //
           //   },
           // ),
         ],
      ),
    ),
);
  }
}
