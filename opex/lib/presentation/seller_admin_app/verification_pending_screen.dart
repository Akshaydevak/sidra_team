// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
// import '../dashboard_screen/profile/profile_svg.dart';
//
// class VerificationPendingScreen extends StatefulWidget {
//   final String? label;
//   const VerificationPendingScreen({super.key, this.label});
//
//   @override
//   State<VerificationPendingScreen> createState() => _VerificationPendingScreenState();
// }
//
// class _VerificationPendingScreenState extends State<VerificationPendingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     double w1 = MediaQuery.of(context).size.width ;
//     double w = w1> 700
//         ? 400
//         : w1;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: BackAppBar(
//           label: widget.label??"",
//           isAction: false,
//         ),
//       ),
//       body: ScrollConfiguration(
//         behavior: NoGlow(),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Column(
//                 children: [
//                   SizedBox(height: h/20,),
//                   //
//
//                   SvgPicture.string(HomeSvg().verifyIcon),
//                   SizedBox(height: h/30,),
//                   Text("Request under review!",style:
//                     GoogleFonts.roboto(
//                       fontWeight: FontWeight.w500,
//                       fontSize: w/24
//                     ),),
//                   SizedBox(height: h/40,),
//                   Container(
//                     width: w1/1.2,
//                     child: Center(
//                       child: Text("We're currently reviewing your application to ensure a safe and trustworthy environment for all our users.",
//                         style:
//                       GoogleFonts.roboto(
//                           fontWeight: FontWeight.w400,
//                           fontSize: w/26,
//                         color: Color(0xff666161)
//                       ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: h/40,),
//                   GestureDetector(
//                     onTap: () async{
//
//                       String email = Uri.encodeComponent("info@sidrabusiness.com");
//                       String subject = Uri.encodeComponent("Help & Support");
//                       String body = Uri.encodeComponent("Hi,");
//                       print(subject); //output: Hello%20Flutter
//                       Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
//                       if (await launchUrl(mail)) {
//
//                       }else{
//
//                       }
//                     },
//                     child: Container(
//                       width: w1/2.5,
//                         padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: ColorPalette.white,
//                           border: Border.all(width: 0.5,color: Color(0xffE6ECF0))
//                         ),
//                         child: Center(
//                           child: Text("Contact Us",
//                           style: GoogleFonts.roboto(
//                             fontSize: w/24,
//                             fontWeight: FontWeight.w500
//                           ),),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
