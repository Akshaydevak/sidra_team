import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: ColorPalette.primary, // Status bar
        ),
        backgroundColor: ColorPalette.primary,
        elevation: 0,
        title: Text("Categories"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16,right: 16,top: 16),
            child: Text(
              "Categories",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 18,

                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GridView.builder(
              padding: const EdgeInsets.all(16),
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 16,

              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 1.5 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 8),

              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: CategoryScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Column(
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
                  ),
                );
              }),
        ],
      ),
    );
  }
}
