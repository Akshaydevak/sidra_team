import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';
import '../../User_Model/user_models.dart';
import '../../task_operation/employee_model/employee_model.dart';
import '../../task_operation/task_svg.dart';
import '../home_screen/homescreen_widget/appbar.dart';

class MyProfileDetailsScreen extends StatefulWidget {
  const MyProfileDetailsScreen({super.key});

  @override
  State<MyProfileDetailsScreen> createState() => _MyProfileDetailsScreenState();
}

class _MyProfileDetailsScreenState extends State<MyProfileDetailsScreen> {
  GetEmployeeList? userData;
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }
  bool? isLoading=true;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return  BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if(state is ProfileLoading){

        }
        if (state is ProfileSuccess) {
          userData=state.user;
          isLoading=false;

          setState(() {

          });
        }
      },
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                if(isLoading==true)...[
                  LottieLoader()
                ]
          else...[
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      userData?.userMete?.profile??""),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              userData?.fname??"",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500, fontSize: w / 24),
            ),
            Text(
              userData?.email??"",
              style: GoogleFonts.roboto(fontSize: w / 26),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   width: w1,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SvgPicture.string(
            //         TaskSvg().chatmsgIcon,
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Text(
            //         "Chat Now",
            //         style: GoogleFonts.roboto(
            //             fontWeight: FontWeight.w500,
            //             fontSize: w / 28,
            //             color: ColorPalette.primary),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   width: w1,
            //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   decoration: BoxDecoration(
            //       color: Color(0xff2871AF).withOpacity(0.2),
            //       borderRadius: BorderRadius.circular(4)),
            //   child: Column(
            //     children: [
            //       Text(
            //         "YOUR SCORE",
            //         style: GoogleFonts.roboto(
            //             fontSize: w / 22, fontWeight: FontWeight.w400),
            //       ),
            //       Text(
            //         "90/100",
            //         style: GoogleFonts.roboto(
            //             fontSize: w / 16, fontWeight: FontWeight.bold),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         "Last evaluated on 21-Jan-2023",
            //         style: GoogleFonts.roboto(
            //             fontSize: w / 28,
            //             fontWeight: FontWeight.w500,
            //             color: Color(0xff6D6D6D)),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 16, right: 16),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           width: w1 / 3.5,
            //           height: h / 7,
            //           decoration: BoxDecoration(
            //               color: Color(0xff3284CA).withOpacity(0.5),
            //               borderRadius: BorderRadius.circular(4)),
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 10),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Code Wise\nEvaluation",
            //                 style: GoogleFonts.roboto(
            //                     fontSize: w / 24,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //               Spacer(),
            //               Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: Text(
            //                   "30/40",
            //                   style: GoogleFonts.roboto(
            //                       fontSize: w / 20,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           width: w1 / 3.5,
            //           height: h / 7,
            //           decoration: BoxDecoration(
            //               color: Color(0xffE599C6).withOpacity(0.5),
            //               borderRadius: BorderRadius.circular(4)),
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 10),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Communication",
            //                 style: GoogleFonts.roboto(
            //                     fontSize: w / 24,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //               Spacer(),
            //               Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: Text(
            //                   "20/30",
            //                   style: GoogleFonts.roboto(
            //                       fontSize: w / 20,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           width: w1 / 3.5,
            //           height: h / 7,
            //           decoration: BoxDecoration(
            //               color: Color(0xff99E5C0).withOpacity(0.5),
            //               borderRadius: BorderRadius.circular(4)),
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 10),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Behavioural\Pattern",
            //                 style: GoogleFonts.roboto(
            //                     fontSize: w / 24,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //               Spacer(),
            //               Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: Text(
            //                   "20/30",
            //                   style: GoogleFonts.roboto(
            //                       fontSize: w / 20,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )

          ],
        ),
          ]
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
