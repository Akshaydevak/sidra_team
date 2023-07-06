import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_model.dart';

class AppList extends StatefulWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  int selected = 0;
  void onSelect(int val) {
    print("......................$val");
    selected = val;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    return SizedBox(
      height: h / 16,
      child: ListView.separated(
        itemCount: appList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 16,left: 16,top: 5,bottom: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return AppCard(
            onTap: () {
              onSelect(index);

            },
            groupList:appList[index],
            isSelect: index == selected,
          );
        }), separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 6,); },),
    );
  }
}
class AppCard extends StatelessWidget {
  final AppModel? groupList;
  final VoidCallback? onTap;
  final bool isSelect;
  const AppCard({Key? key, this.onTap,  this.isSelect=false,this.groupList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: h / 20,
        child: Container(
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration:isSelect?BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xfffe5762),
          ): BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Color(0x114e4e4e),
                blurRadius: 36,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(groupList?.name ?? "", textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color:  isSelect ? Colors.white:Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),),
        ),

      ),
    );
  }
}
