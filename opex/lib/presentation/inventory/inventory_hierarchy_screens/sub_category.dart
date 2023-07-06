import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../mpos/search_card.dart';
import '../inventory_create_new_list.dart';

class InventorySubCategoryScreen extends StatelessWidget {
  InventorySubCategoryScreen({Key? key}) : super(key: key);
  List<String> division=[ "Amet minim mollit non ","Deserunt ullamco ","Est sit aliqua dolor do amet sint. ","Velit officia consequat duis ","Enim velit mollit. ","Exercitation veniam consequat ",];

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;

    return
      Column(
          children: [


            Text(
              "Select Sub Category",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Amet minim mollit non deserunt ult sitaliq ua dol\ndo amet sint. Amet minim.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff666161),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10,),
            SearchCard(),
            SizedBox(height: 5,),
            Container(
              width: w,
              // height: 328,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffe0e3e5), width: 1, ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Color(0xfff7f7f7),
              ),
              child: ListView.separated(
                itemCount: division.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                itemBuilder: (context, index) => InventoryCatProductCard(division: division[index]),
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
            SizedBox(height: 20,),
          ]
      );
  }
}
