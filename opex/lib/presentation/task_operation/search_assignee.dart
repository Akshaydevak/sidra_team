
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchAssignee extends StatefulWidget {
  const SearchAssignee({Key? key}) : super(key: key);

  @override
  State<SearchAssignee> createState() => _SearchAssigneeState();
}

class _SearchAssigneeState extends State<SearchAssignee> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: w,
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: w / 1.3,
                    child: TextFormField(

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16),
                        hintText: "Search ...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color(0xffE6ECF0)
                          )

                        ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffE6ECF0)
                              )

                          ),
                          
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color(0xffE6ECF0)
                          )

                        ),disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color(0xffE6ECF0)
                          )

                        ),
                        suffixIcon:Container(
                          padding: EdgeInsets.all(15),
                          child: SvgPicture.string(TaskSvg().closeIcon) ,
                        ) 
                       
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          "R",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 26,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        "Rawabi Market",
                        style: TextStyle(
                          color: Color(0xff151522),
                          fontSize: 18,
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          "R",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 26,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        "Rawabi Market",
                        style: TextStyle(
                          color: Color(0xff151522),
                          fontSize: 18,
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          "R",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 26,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Text(
                        "Rawabi Market",
                        style: TextStyle(
                          color: Color(0xff151522),
                          fontSize: 18,
                        ),
                      )

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
