import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class FileUploadCard extends StatelessWidget {
  VoidCallback? onTap;
  final String? label;
  final String? head;
   FileUploadCard({Key? key, this.onTap, this.label, this.head}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head??"Upload Image",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w / 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: w,
          padding: const EdgeInsets.all(8),
          //height: 20.0,

          decoration: BoxDecoration(
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
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: const Color(0xfffe5762),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Choose File",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: w/1.8,
                // color: Colors.teal,
                child: Text(
                 label??"",
                  maxLines: 2,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                    color: Color(0xfffe5762),
                    fontSize: w / 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
