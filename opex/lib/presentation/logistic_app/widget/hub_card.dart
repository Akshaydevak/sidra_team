import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/logistic_app/utils/logistic_svg.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class DeliveryHubCard extends StatelessWidget {
  const DeliveryHubCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      // height: 169,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorPalette.inactiveGrey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Hilite Business Park",
                      style: GoogleFonts.poppins(
                        color: ColorPalette.black,
                        fontSize: w / 21,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                PopupMenuButton(
                  icon: SvgPicture.string(MposSvg().moreIcon),
                  //don't specify icon if you want 3 dot menu
                  color: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(

                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ), const Divider(indent: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Remove from list',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ))

                  ],
                  onSelected: (value) {

                  },
                ),

                // SvgPicture.string(MposSvg().moreIcon)
              ],
            ),
          ),
          Divider(
            indent: 30,
            thickness: 1.1,
            color: ColorPalette.divider,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.string(
                LogisticSvg().clockIcon,
                color: ColorPalette.inactiveGrey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "9:30 AM to 6:30 PM",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.string(
                LogisticSvg().locationIcon,
                color: ColorPalette.inactiveGrey,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: w / 1.3,
                child: Text(
                  "Pookattu Purayil House, Avilora P.O, Koduvally VIA, Pin: 673572",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
