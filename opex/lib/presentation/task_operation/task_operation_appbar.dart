import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskAndOperationAppBar extends StatefulWidget {
  final VoidCallback? onTap;
  Widget? EndIcon;

  String? label;
   TaskAndOperationAppBar({Key? key,this.EndIcon,this.label, this.onTap}) : super(key: key);

  @override
  State<TaskAndOperationAppBar> createState() => _TaskAndOperationAppBarState();
}

class _TaskAndOperationAppBarState extends State<TaskAndOperationAppBar> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(color: Colors.white,
          width: w,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onTap??
                        (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back)),
                  const SizedBox(width: 20,),
                  SizedBox(
                    width: w/2,
                    child: Text(
                     widget.label??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 24,

                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                ],
              ),
              widget.EndIcon??Container()
            ],
          ),
        ),
        Container(
          width: w,
          height: 1.50,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xb2e6e6e6), width: 0.50, ),
          ),
        ),
      ],
    );
  }
}
