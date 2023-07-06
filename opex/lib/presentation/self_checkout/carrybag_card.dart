import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/no_glow.dart';

class CarryBagCard extends StatefulWidget {
  const CarryBagCard({Key? key}) : super(key: key);

  @override
  State<CarryBagCard> createState() => _CarryBagCardState();
}

class _CarryBagCardState extends State<CarryBagCard> {
  int selected=0;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return
        Container(
          width: w,
          //
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
            boxShadow: [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(1, 1),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                   children: [
                     Text(
                       "Add a carry bag",
                       style: GoogleFonts.inter(
                         color: Color(0xff1b1b1f),
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                       ),
                     ),

                   ],
                ),
              ),
              Divider(
                thickness: 1.1,
                color: ColorPalette.divider,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Color(0x19ff487c),
                      ),
                    ),
                    SizedBox(width: 6,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Small Carry Bag",
                          style: GoogleFonts.inter(
                            color: Color(0xff0a0a0a),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          // color: Colors.yellow,
                          width: w/1.45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Can carry upto 2 big products",
                                style: GoogleFonts.inter(
                                  color: Color(0x99151522),
                                  fontSize: w/28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _showModalBottomSheet();
                                },
                                child: Text(
                                  "Change",
                                  style:  GoogleFonts.inter(
                                    color: Color(0xffff477b),
                                    fontSize: w/26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
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
                padding: EdgeInsets.all(16),
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: ScrollConfiguration(
                  behavior: NoGlow(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Choose a carry bag",
                          style: GoogleFonts.inter(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // onselect(index);

                                selected = index;
                                setState(() {});
                              },
                              child: Container(
                                width: w,
                                padding: EdgeInsets.all(10),
                                decoration: selected == index
                                    ? BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0x7feb3a6c),
                                    width: 1.50,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x05000000),
                                      blurRadius: 8,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                  color: Color(0x19ff487c),
                                )
                                    : BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x05000000),
                                            blurRadius: 8,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                        color: Color(0x19ff487c),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: w/1.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Small Carry Bag",
                                                style: GoogleFonts.inter(
                                                  color: ColorPalette.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SvgPicture.string(selected==index?SelfSvg().radioIcon:SelfSvg().greyRadioIcon)
                                            ],
                                          ),
                                          SizedBox(height: 10,
                                          ),
                                          Text(
                                            "Can carry upto 2 big products",
                                            style: GoogleFonts.inter(
                                              color: ColorPalette.subtextGrey,
                                              fontSize: w/27,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemCount: 5)
                      ],
                    ),
                  ),
                ));
          },
        );
      });
}
}

