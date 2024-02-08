import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/color_palatte.dart';
import '../presentation/order_app/order_svg.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final String text;
  final Widget? widget;
  final bool? isWidget;
  final Function(bool)? onChange;

  const CustomCheckBox({Key? key, this.value = false,this.text="",this.isWidget=false, this.onChange,this.widget})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool val;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    if (!onChange) val = widget.value;
    onChange = false;
    return InkWell(
      onTap: () {
        val = !val;
        if (widget.onChange != null) widget.onChange!(val);
        onChange = true;
        setState(() {});
      },
      child:    Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 0),
            child: Center(
              child: val
                  ? Container(
                padding: EdgeInsets.all(7),
                  child: SvgPicture.string(
                      OrderSvg().checkBoxActiveIcon,color: ColorPalette.primary,))
                  : SvgPicture.string(
                  OrderSvg().checkBoxIcon,height: 35,width: 35,),
            ),
          ),
          SizedBox(
            width: w / 40,
          ),
          widget.isWidget==true?Row(
            children: [
              widget.widget??Container(),
              SizedBox(
                width: w / 24,
              ),

            ],
          ):Container(),
          Text(widget.text,
           style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w / 24,
            // fontWeight: FontWeight.w500,
          ),)
        ],
      ),
    );
  }
}

//

class CustomCheckBoxData extends StatefulWidget {
  final bool value;
  final String name;
  final String email;
  final String lname;
  final String profile;
  final String role;
  final List<String>? emailList;
  final Function(bool)? onChange;

  const CustomCheckBoxData({Key? key, this.value = false, this.onChange,  this.name="",  this.email="", required this.lname, required this.profile, required this.role,  this.emailList})
      : super(key: key);

  @override
  _CustomCheckBoxDataState createState() => _CustomCheckBoxDataState();
}

class _CustomCheckBoxDataState extends State<CustomCheckBoxData> {
  bool val=false;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    print("fasss$val");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    if (!onChange) val = widget.value;
    onChange = false;
    return InkWell(
      onTap: () {
        val = !val;
        if (widget.onChange != null) widget.onChange!(val);
        onChange = true;
        print("ggggg$val");
        setState(() {});
      },
      child:    Container(
        padding: EdgeInsets.only(top: 15,bottom: 18,left: 10,right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: val==true||widget.emailList==widget.email?ColorPalette.primary:Color(0xffe6ecf0), width: 1, ),
          boxShadow: [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 8,
              offset: Offset(1, 1),
            ),
          ],
          color: val==true?ColorPalette.cardBackground:ColorPalette.white,
        ),
        child: Row(
          children: [
            widget.profile==""?
            TextAvatar(
              shape: Shape.Circular,
              size: 40,
              numberLetters: 2,
              fontSize: w/22,
              textColor: Colors.white,
              fontWeight: FontWeight.w500,
              text:"${widget.name.toString().toUpperCase()} ${widget.lname.toString().toUpperCase()}",
            ):
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.profile??"",),
            ),
            SizedBox(width: 8,),
            SizedBox(
              width: w1/1.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w1/2.2,
                        // color: Colors.yellow,
                        child: Text(
                          "${widget.name}"" ""${widget.lname}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      widget?.role=="Staff"?Container():
                      widget?.role=="Associative Admin"?Container(
                        decoration: BoxDecoration(
                            color: ColorPalette.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2)
                        ),
                        padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                        child: Text("Ass.admin",
                          style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: w/32
                          ),),
                      ):widget?.role=="Admin"?Container(
                        decoration: BoxDecoration(
                            color: ColorPalette.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2)
                        ),
                        padding: EdgeInsets.only(left: 4,right: 4,top: 2,bottom: 2),
                        child: Text("Admin",
                          style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: w/32
                          ),),
                      ):Container()
                    ],
                  ),
                  // const SizedBox(height: 2,),
                  Container(
                    width: w,
                    // color: Colors.red,

                    child: Text(
                      widget?.email??"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: w/26,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}