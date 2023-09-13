import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/create/create_svg.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';


class CustomRadioButton extends StatefulWidget {
  final bool? isActive;
  final VoidCallback? onTap;
   CustomRadioButton({Key? key,  this.onTap, this.isActive}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  // bool isActive=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
        child: SvgPicture.string(widget.isActive==true?HomeSvg().radioButtonActive:CreateSvg().radioInActiveButton));
  }
}
