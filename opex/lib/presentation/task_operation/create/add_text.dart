import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddText extends StatefulWidget {
  String? label;
  String? hint;
   bool isActive;
  void Function(String)? onchange;
   TextEditingController controller=TextEditingController();

  AddText({Key? key, this.label,required this.controller,this.hint,required this.isActive,this.onchange}) : super(key: key);

  @override
  State<AddText> createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {

  final TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isActive = !widget.isActive;
            });
          },
          child: Container(
            width: w,
            color: Colors.white,
            padding: widget.isActive
                ? EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 5)
                : EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.add,
                  color: ColorPalette.primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.label ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalette.primary,
                    fontSize: w/22,
                  ),
                )
              ],
            ),
          ),
        ),
        widget.isActive
            ? Column(
          children: [
            Divider(
              indent: 16,
              color:  Color(0xffe6ecf0),
            ),
            TextFormField(
              controller: widget.controller,
              maxLines: 4,
              minLines: 1,
              onChanged: widget.onchange,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,


                    contentPadding: EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 16),

                    hintStyle: TextStyle(
                      color: Color(0x66151522),
                      fontSize: w/26,
                    ),

              ),
            )
          ],
        )
            : Container()
      ],
    );
  }
}