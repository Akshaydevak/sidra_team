import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/payment_history.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SelectGroupCard extends StatelessWidget {
  SelectGroupCard({Key? key}) : super(key: key);
  List<String> quickData = [
    'Order View',
    'Insights',
    'Stock Details',
    'Holding Items',
    'Collection Point',
    'Customer List',
    'Sales Report',
    'Payment History'
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
        // margin: const EdgeInsets.only(left: 12),
        // height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextAvatar(
                      shape: Shape.Circular,
                      size: 55,
                      numberLetters: 2,
                      fontSize: 32,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      text: "A",
                    ),
                    Text(
                      quickData[i],
                      style: TextStyle(
                        color: ColorPalette.black,
                        fontSize: w / 25,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }));
  }
}
