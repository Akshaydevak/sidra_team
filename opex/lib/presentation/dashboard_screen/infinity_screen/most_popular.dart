import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../common_widgets/view_btn.dart';
import 'category_screen.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Popular",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ViewButton(
                onTap:(){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CategoryScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            // margin: const EdgeInsets.only(left: 12),
            // height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                physics:const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,

                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1.5 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 8),

                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Container(
                          height: 70,
                          padding: EdgeInsets.zero,
                          decoration:  const BoxDecoration(

                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "asset/img_4.png")),
                          )),
                      Text(
                        "qwertyuio",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
