import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/checkbox_widget.dart';
import '../../common_widgets/custom_radio_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'manufacture_contract_card.dart';
import 'manufacture_svg.dart';

class AllContracts extends StatefulWidget {
  const AllContracts({Key? key}) : super(key: key);

  @override
  State<AllContracts> createState() => _AllContractsState();
}

class _AllContractsState extends State<AllContracts> {
  int ?selected;
  List<String> productTypeList = [
    'All Contracts',
    'Pending Contracts',
    'Confirmed Contracts',
    'Recently Added'
  ];

  void onSelect(int val) {
    selected = val;
    setState(() {});
  }
  var _listGenderText = ["Send", "Recieved"];

  var _tabTextIconIndexSelected = 0;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Contracts",
          isAction: true,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                FlutterToggleTab(
                  width: w/4,
                  borderRadius: 10,
                  isShadowEnable: false,
                  marginSelected: EdgeInsets.all(3),
                  selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  selectedBackgroundColors: [Colors.white],
                  unSelectedBackgroundColors: [Color(0xffFDF2F2)],
                  unSelectedTextStyle:  TextStyle(
                color: Color(0xff7d7d7d),
            fontSize: 18,
          ),
                  labels: _listGenderText,
                  // icons: _listIconTabToggle,
                  selectedIndex: _tabTextIconIndexSelected,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIconIndexSelected = index;
                    });
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contract List",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showModalBottomSheet();
                      },
                      child: Container(
                        width: 37,
                        height: 37,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffe6ecf0),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: SvgPicture.string(ManufactureSvg().filterIcon),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 16,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ManufactureContractCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: 6)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filter",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Apply",
                              style: GoogleFonts.roboto(
                                color: Color(0xfffe5762),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 1.5,
                        color: Color(0xffE6ECF0),
                      ),
                      ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return checkBox(
                              label: productTypeList[index],
                            );
                            // return Row(
                            //   children: [
                            //     CustomRadioButton(
                            //       onTap: () {
                            //         onSelect(index);
                            //         setState(() {});
                            //       },
                            //       isActive: selected == index,
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(
                            //       productTypeList[index],
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: 18,
                            //       ),
                            //     )
                            //   ],
                            // );
                          },
                          separatorBuilder: (context, index) =>
                              Container(
                                height: 10,
                              ),
                          itemCount: productTypeList.length),

                    ],
                  ));


            },
          );
        });
  }

}
