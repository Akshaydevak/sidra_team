import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/task_operation/create/create_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int select = 0;
  int selectIndex = 0;

  void onSelect(index) {
    setState(() {
      select = index;
    });
  }
  void onSelectIndex(index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Filter",
          isAction: false,
          action: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xfffd5762),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Color(0xfffd5762),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "APPLY",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: Row(
          children: [
            Container(
              width: w / 4,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0x33a9a8a8),
                  width: 1,
                ),
                color: Color(0xfff2f2f2),
              ),
              height: h,
              child: ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        onSelect(index);
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 59,
                              width: w / 4,
                              color: select == index
                                  ? Colors.white
                                  : Color(0xfff2f2f2),
                              padding: const EdgeInsets.all(16),
                              child: Text("Hello")),
                          Positioned(
                              child: select == index
                                  ? Container(
                                      width: 5,
                                      height: 59,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(3),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(3),
                                        ),
                                        color: Color(0xfffd5762),
                                      ),
                                    )
                                  : Container())
                        ],
                      )),
                  separatorBuilder: (context, index) => Container(
                        width: w / 4,
                        height: 1,
                        color: Color(0x33a9a8a8),
                      ),
                  itemCount: 20),
            ),
            Container(
              height: h,
              width: w / 1.34,
              padding: EdgeInsets.all(16),
              // color: Colors.yellow,
              child: ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              onSelectIndex(index);
                            },
                            child: Row(
                              children: [
                              SvgPicture.string(  selectIndex==index?CreateSvg().radioActiveButton:CreateSvg().radioInActiveButton),
                                SizedBox(width: 10,),
                                Text("RM General"),
                              ],
                            ),
                          ),




                        ],
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 16,
                      ),
                  itemCount: 20),
            )
          ],
        ),
      ),
    );
  }
}
