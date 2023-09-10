import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon(
      {super.key, required this.icon,
        this.badgeCount = 0,
        this.showIfZero = false,
        this.badgeColor = Colors.red,
      });


  final Widget icon;
  final int badgeCount;
  final bool showIfZero;
  final Color badgeColor;


  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      icon,
      if (badgeCount > 0 || showIfZero) badge(badgeCount),
    ]);
  }

  Widget badge(int count) => Positioned(
    right: 0,
    // left: 10,
    top: 0,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: ColorPalette.primary,
        borderRadius: BorderRadius.circular(8.5),

        border: Border.all(color: Colors.black,width: 0.1)
      ),

      constraints: const BoxConstraints(
        minWidth: 13,
        minHeight: 13,
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}