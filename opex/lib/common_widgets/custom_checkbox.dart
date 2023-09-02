import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../presentation/order_app/order_svg.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool)? onChange;

  const CustomCheckBox({Key? key, this.value = false, this.onChange})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool val;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    if (!onChange) val = widget.value;
    onChange = false;
    return InkWell(
      onTap: () {
        val = !val;
        if (widget.onChange != null) widget.onChange!(val);
        onChange = true;
        setState(() {});
      },
      child:    Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 0),
        child: Center(
          child: val
              ? Container(
              child: SvgPicture.string(
                  OrderSvg().checkBoxActiveIcon))
              : SvgPicture.string(
              OrderSvg().checkBoxIcon),
        ),
      ),
    );
  }
}

//

class CustomCheckBoxData extends StatefulWidget {
  final bool value;
  final String name;
  final String email;
  final Function(bool)? onChange;

  const CustomCheckBoxData({Key? key, this.value = false, this.onChange,  this.name="",  this.email=""})
      : super(key: key);

  @override
  _CustomCheckBoxDataState createState() => _CustomCheckBoxDataState();
}

class _CustomCheckBoxDataState extends State<CustomCheckBoxData> {
  late bool val;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    if (!onChange) val = widget.value;
    onChange = false;
    return InkWell(
      onTap: () {
        val = !val;
        if (widget.onChange != null) widget.onChange!(val);
        onChange = true;
        setState(() {});
      },
      child:    Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: val
                    ? Container(
                    child: SvgPicture.string(
                        OrderSvg().checkBoxActiveIcon))
                    : SvgPicture.string(
                    OrderSvg().checkBoxIcon),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextAvatar(
              shape: Shape.Circular,
              size: 40,
              numberLetters: 1,
              fontSize: w / 16,
              textColor: Colors.white,
              fontWeight: FontWeight.w500,
              text: widget.name ??
                  "".toUpperCase(),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: w/1.8,
              child: Text(
                widget.email??"",
                style:  TextStyle(overflow: TextOverflow.ellipsis,

                  color: Color(0xff151522),
                  fontSize: w/24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}