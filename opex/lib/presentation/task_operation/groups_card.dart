
import 'package:cluster/presentation/task_operation/update_group.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'create_group.dart';
import 'employee_bloc/employee_bloc.dart';
import 'employee_model/employee_model.dart';

class GroupCard extends StatelessWidget {
  final GetTaskGroupList? groupList;
  const GroupCard({Key? key, this.groupList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        context.read<EmployeeBloc>().add(
            GetGroupTReadEvent(groupList?.id?? 0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const UpdateGroup(edit: true),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        width: w,

        padding: EdgeInsets.all(10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextAvatar(
              shape: Shape.Circular,
              size: 45,
              numberLetters: 2,
              fontSize: w/16,
              textColor: Colors.white,
              fontWeight: FontWeight.w500,
              text: groupList?.gName.toString().toUpperCase(),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupList?.gName??"",
                  style: TextStyle(
                    color: Color(0xff151522),
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${groupList?.menberCount} Members",
                  style: GoogleFonts.roboto(
                    color: Color(0xff9b9b9b),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
