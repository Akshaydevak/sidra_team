import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'insight_card.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({Key? key}) : super(key: key);

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  String? selGender;
  String? selectedGender;
  List<String> gender = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Insight",isAction: false),
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
                InsightCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: w / 3,
                            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            //height: 20.0,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0x4ca9a8a8),
                                width: 1,
                              ),
                              color: Color(0xfff8f7f5),
                            ),
                            child: DropdownButton(
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                underline: Container(),
                                items: gender.map((String items) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: items,
                                    child: Text(items,
                                        style: TextStyle(color: Colors.black)),
                                  );
                                }).toList(),
                                value: selectedGender,
                                onChanged: (dynamic value) {},
                                hint: Text(
                                  "Unit Sold",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: w / 3,
                            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            //height: 20.0,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0x4ca9a8a8),
                                width: 1,
                              ),
                              color: Color(0xfff8f7f5),
                            ),
                            child: DropdownButton(
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                underline: Container(),
                                items: gender.map((String items) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: items,
                                    child: Text(items,
                                        style: TextStyle(color: Colors.black)),
                                  );
                                }).toList(),
                                value: selectedGender,
                                onChanged: (dynamic value) {},
                                hint: Text(
                                  "This Week",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset("asset/img_17.png")
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset("asset/img_18.png"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: h/5,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) => Image.asset("asset/img_20.png",width: w/2,),
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemCount: 3),
                ),
                Text(
                  "New Order",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Image.asset("asset/img_19.png"),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriberSeries {
  final String year;
  final int subscribers;

  SubscriberSeries({
    required this.year,
    required this.subscribers,
  });
}
