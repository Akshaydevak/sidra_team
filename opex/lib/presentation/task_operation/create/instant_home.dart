
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import 'create_svg.dart';

class InstantHome extends StatefulWidget {
  final List<GetJobList>? joblist;
  const InstantHome({Key? key, this.joblist}) : super(key: key);

  @override
  State<InstantHome> createState() => _InstantHomeState();
}

class _InstantHomeState extends State<InstantHome> {
  bool isTime = false;
  int select = 0;
  void onSelect(int val) {
    select = val;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
        height: h / 8,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 16, left: 12, bottom: 10),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.joblist!.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: (){
                onSelect(i);

              },
                child:Container(
                  width: 120,
                  height: 73,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: select==i?Border.all(color: Colors.red, width: 1, ):
                    Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.joblist?[i].name??"",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 10,
            );
          },
        )),
        Container(
          width: w,

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
          child: Column(
            children: [
              Container(
                margin:
          isTime? EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 16):EdgeInsets.all(16),
                child: SingleRow(
                    color: Color(0xfffc3a97),
                    label: "Date & Time",
                    svg: CreateSvg().clockIcon,
                    onTap: () {
                      setState(() {
                        isTime = !isTime;
                      });
                    },
                    endIcon: isTime
                        ? SvgPicture.string(HomeSvg().toggleActive)
                        : SvgPicture.string(HomeSvg().toggleInActive)),
              ),
              Column(
                children: [
                  Divider(
                    indent: 50,
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Start Date :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          "12 Jun 2022",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "12:20 AM",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 50,
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "End Date :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          "12 Jun 2022",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "12:20 AM",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
