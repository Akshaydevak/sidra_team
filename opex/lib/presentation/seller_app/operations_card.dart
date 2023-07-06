import 'package:cluster/presentation/task_operation/create/create_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class OperationsCard extends StatelessWidget {
  String ?label,svg;
  VoidCallback? ontap;
  EdgeInsets? padding;
  Color? color;
   OperationsCard({Key? key,this.label,this.padding=const EdgeInsets.all(16),this.color,this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap:ontap,
        child:
      Container(
      padding:padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:color?? Color(0xff33c658),
                ),
                child: SvgPicture.string(svg?? CreateSvg().calenderIcon),
              ),
              SizedBox(width: 10,),
              Text(
               label?? "Basic Details ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: w/22,
                ),
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    ));
  }
}
