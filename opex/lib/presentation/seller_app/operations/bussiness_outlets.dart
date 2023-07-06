import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_app/operations/outlet_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class BussinessOutlets extends StatefulWidget {
   BussinessOutlets({Key? key}) : super(key: key);

  @override
  State<BussinessOutlets> createState() => _BussinessOutletsState();
}

class _BussinessOutletsState extends State<BussinessOutlets> {
int ?select;

void onselect(index){
  setState(() {
    select=index;
  });

}

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Business Outlets", isAction: false),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total 4 Outlets",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      onselect(index);
                      setState(() {

                      });
                    },
                      child: OutletCard(
                        isSelect: select==index,
                      )),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
