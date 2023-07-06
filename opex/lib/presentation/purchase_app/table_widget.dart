import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TableTitle extends StatelessWidget {
  String ?label;
   TableTitle({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Container(
        padding: const EdgeInsets.all(10),
        child:  Text(
          label??"Payment ID",
          style: GoogleFonts.roboto(
            color: Color(0xff1b1b1f),
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
class SubTextCard extends StatelessWidget {
  String ?label;
   SubTextCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Container(
        padding: EdgeInsets.all(10),child: Text(
          label??"5156435132114",
          style: TextStyle(
            color: Color(0x66151522),
            fontSize: w/24,
          ),
        ));
  }
}

