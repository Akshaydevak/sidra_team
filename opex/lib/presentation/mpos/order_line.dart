import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/mpos/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'collection_card.dart';
import 'orderline_card.dart';

class OrderLineScreen extends StatelessWidget {
  const OrderLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrderLineCard();
                    },
                    separatorBuilder: (context, index) => Container(
                          height: 10,
                        ),
                    itemCount: 5),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffe6ecf0),
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add to Collection Point",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Color(0xfffe5762),
                    fontSize: w / 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
