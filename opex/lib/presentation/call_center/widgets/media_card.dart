import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/call_center/call_center_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class MediaCard extends StatefulWidget {
  String? label;
   MediaCard({Key? key,this.label}) : super(key: key);

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
  bool isActive=false;
  bool isSubmit=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
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
      ),padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FlutterLogo(size: 40),
              ),
              SizedBox(width: 5,),
              isActive?isSubmit?Container():  Container(
                  width: w/2.2,
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Color(0xffe6ecf0),
                        ),
                        
                      ),    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Color(0xffe6ecf0),
                        ),
                      ),  focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Color(0xffe6ecf0),
                        ),
                      ),
                      suffix: SvgPicture.string(CallCenterSvg().closeIcon,color: Color(0xff1C1B1F).withOpacity(0.3),)
                    ),
                  )) :Text(
                widget.label??"Whatsapp",
                style: GoogleFonts.roboto(
                  color: ColorPalette.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),

        isActive?isSubmit?
          Row(
            children: [
              Text(
                "afthab_pp",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isActive=false;isSubmit=false;
                  });
                },
                  child: SvgPicture.string(CallCenterSvg().closeIcon))
            ],
          ):GestureDetector(
          onTap: (){
            setState(() {
              isSubmit=true;
            });
          },
          child: Container(
            width: 86,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Color(0xfffe5762),
            ),
            alignment: Alignment.center,
            child: Text(
              "Submit",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
            :
          GestureDetector(
            onTap: (){
            setState(() {
              isActive=true;
            });
            },
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Color(0xfffe5762),
              ),
              alignment: Alignment.center,
              child: Text(
                "Link",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: w/23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
