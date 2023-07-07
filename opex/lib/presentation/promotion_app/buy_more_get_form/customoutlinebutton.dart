import 'package:flutter/material.dart';

class CustomOutLinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? iconData;
  final Widget? child;
  CustomOutLinedButton({
    Key? key,
    required this.text,
    this.onTap,
    this.iconData,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:Colors.white,
            width: 1,
          ),
        ),
        onPressed: onTap == null
            ? () {
          showDialog(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: AlertDialog(
                  content: child ?? SizedBox(),
                ),
              ));
        }
            : onTap,
        child: iconData == null
            ? Text(text)
            : Row(
          children: [Icon(iconData), SizedBox(height: 4,), Text(text)],
        ));
  }
}
