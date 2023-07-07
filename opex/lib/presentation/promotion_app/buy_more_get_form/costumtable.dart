import 'package:flutter/material.dart';

import 'colors.dart';
import 'custominputdecoration.dart';
import 'customoutlinebutton.dart';


Widget customTableTwo({
  required List<TableRow> childrens,
  Map<int, TableColumnWidth>? widths,
  double tableWidth = 1,
  TableBorder? border,
}) =>
    Table(
      columnWidths: widths,
      border: border ??
          TableBorder.all(
              color: Colors.grey, style: BorderStyle.solid, width: tableWidth),
      children: childrens,
    );

Widget tableHeadtextTwo(
    String label, {
      double height = 10,
      double? size,
      Color? textColor = Colors.white,
      Color? color =  Pellet.tableHeaderTwo,
      EdgeInsets? padding,
    }) =>
    Container(
      alignment: Alignment.center,
      height: height,
      padding: padding ?? EdgeInsets.fromLTRB(3, 3, 0, 4),
      color: color,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: size, color: textColor,fontWeight: FontWeight.w700),
      ),
    );
Widget textPaddingTwo(String label,VoidCallback onTap,
    {double fontSize = 14,
      EdgeInsets? padding,
      FontWeight fontWeight = FontWeight.w100}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,

        height: 60,
        alignment: Alignment.center,
        // padding: padding ?? EdgeInsets.fromLTRB(3, 3, 0, 0),
        child:label=="0"?Text(''):Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
Widget childPadding(Widget child, {EdgeInsets? padding}) => Padding(
  padding: padding ?? EdgeInsets.fromLTRB(3, 3, 0, 4),
  child: child,
);

Widget dataTableHead(BuildContext context, String label) => Row(
  children: [
    boldText(label),
    SizedBox(height: 5,),
    TextButton.icon(
      onPressed: () {},
      label: Text("add new"),
      icon: Icon(Icons.add),
    ),
    // DropDownLabel(),
    SizedBox(height: 5,),
    SizedBox(
        width: 100,
        child: underlinedSearchField())
  ],
);

underlinedSearchField() {}
Widget tableAddNewTitle(String label, VoidCallback onTap) => Row(
  children: [
    boldText(label),
    SizedBox(height: 5,),
    Transform.scale(
      scale: 0.8,
      child: CustomOutLinedButton(
        text: 'Add new',
        iconData: Icons.add,
        onTap: onTap,
      ),
    ),
  ],
);
Widget childCustomPadding(Widget child, {EdgeInsetsGeometry? padding}) =>
    Padding(
      padding: padding ?? EdgeInsets.all(2),
      child: child,
    );
