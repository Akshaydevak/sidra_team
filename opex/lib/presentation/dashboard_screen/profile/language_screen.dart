import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen/homescreen_widget/appbar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isEng = true;
  bool isArabic = false;
  bool isHindi = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Language",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: w,
            height: 1.50,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xb2e6e6e6),
                width: 0.50,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: h/1.3,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Language",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isArabic=false;
                        isEng=true;
                        isHindi=false;
                      });
                    },
                    child: Container(
                      width: w,
                      padding: const EdgeInsets.all(16),
                      decoration: isEng
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xfffe5762),
                                width: 1,
                              ),
                              color: const Color(0x0cfe5762),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xffe6ecf0),
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                      child: Row(
                        children: [
                          SvgPicture.string(isEng
                              ? HomeSvg().radioButtonActive
                              : HomeSvg().radioInActive),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "English",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "English",
                                style: TextStyle(
                                  color: Color(0xff7d7d7d),
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     setState(() {
                  //       isArabic=true;
                  //       isEng=false;
                  //       isHindi=false;
                  //     });
                  //   },
                  //   child: Container(
                  //     width: w,
                  //     padding: const EdgeInsets.all(16),
                  //     decoration: isArabic
                  //         ? BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(
                  //               color: const Color(0xfffe5762),
                  //               width: 1,
                  //             ),
                  //             color: const Color(0x0cfe5762),
                  //           )
                  //         : BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(
                  //               color: const Color(0xffe6ecf0),
                  //               width: 1,
                  //             ),
                  //             boxShadow: const [
                  //               BoxShadow(
                  //                 color: Color(0x05000000),
                  //                 blurRadius: 8,
                  //                 offset: Offset(1, 1),
                  //               ),
                  //             ],
                  //             color: Colors.white,
                  //           ),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.string(isArabic
                  //             ? HomeSvg().radioButtonActive
                  //             : HomeSvg().radioInActive),
                  //         const SizedBox(width: 10),
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: const [
                  //             Text(
                  //               "عربى",
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 18,
                  //               ),
                  //             ),
                  //             Text(
                  //               "Arabic",
                  //               style: TextStyle(
                  //                 color: Color(0xff7d7d7d),
                  //                 fontSize: 14,
                  //               ),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10,),
                  // GestureDetector(
                  //   onTap: (){
                  //     setState(() {
                  //       isArabic=false;
                  //       isEng=false;
                  //       isHindi=true;
                  //     });
                  //   },
                  //   child: Container(
                  //     width: w,
                  //     padding: const EdgeInsets.all(16),
                  //     decoration: isHindi
                  //         ? BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(
                  //         color: const Color(0xfffe5762),
                  //         width: 1,
                  //       ),
                  //       color: const Color(0x0cfe5762),
                  //     )
                  //         : BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(
                  //         color: const Color(0xffe6ecf0),
                  //         width: 1,
                  //       ),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           color: Color(0x05000000),
                  //           blurRadius: 8,
                  //           offset: Offset(1, 1),
                  //         ),
                  //       ],
                  //       color: Colors.white,
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.string(isHindi
                  //             ? HomeSvg().radioButtonActive
                  //             : HomeSvg().radioInActive),
                  //         const SizedBox(width: 10),
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: const [
                  //             Text(
                  //               "हिन्दी",
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 18,
                  //               ),
                  //             ),
                  //             Text(
                  //               "Hindi",
                  //               style: TextStyle(
                  //                 color: Color(0xff7d7d7d),
                  //                 fontSize: 14,
                  //               ),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
