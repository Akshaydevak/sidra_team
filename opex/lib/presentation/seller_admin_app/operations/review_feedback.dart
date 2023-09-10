import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/seller_admin_app/operations/review_card.dart';
import 'package:cluster/presentation/seller_admin_app/operations/review_screen.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../task_operation/task_svg.dart';

class ReviewAndFeedBack extends StatefulWidget {
  const ReviewAndFeedBack({Key? key}) : super(key: key);

  @override
  State<ReviewAndFeedBack> createState() => _ReviewAndFeedBackState();
}

class _ReviewAndFeedBackState extends State<ReviewAndFeedBack> {
  double? _ratingValue = 4;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Rewards and Feedbacks", isAction: false),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w1 / 2.2,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xfffdf2f2),
                          width: 1.50,
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
                          Text(
                            "LAST REVIEW",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RatingBar(
                              initialRating: 0,
                              itemSize: 20,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      color: ColorPalette.primary),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: ColorPalette.primary,
                                  ),
                                  empty: const Icon(
                                    Icons.star,
                                    color: Color(0xffF8F7F5),
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  _ratingValue = value;
                                });
                              }),
                          Text(
                            "(4.5)",
                            style: TextStyle(
                              color: Color(0xff7d7d7d),
                              fontSize: w / 26,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: w1 / 2.2,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xfffdf2f2),
                          width: 1.50,
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
                          Text(
                            "MONTH OVERVIEW",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RatingBar(
                              initialRating: 0,
                              itemSize: 20,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      color: ColorPalette.primary),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: ColorPalette.primary,
                                  ),
                                  empty: const Icon(
                                    Icons.star,
                                    color: Color(0xffF8F7F5),
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  _ratingValue = value;
                                });
                              }),
                          Text(
                            "(4.5)",
                            style: TextStyle(
                              color: Color(0xff7d7d7d),
                              fontSize: w / 26,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ReviewScreen(isLeast: true,),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  //  ReviewScreen
                  },
                  child: Container(
                    width: w1,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffdf2f2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(
                              SellerSvg().starIcon,
                              color: ColorPalette.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Least Rated Reviews",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 20,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.string(TaskSvg().arrowIcon)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ReviewScreen(isLeast: false,),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    width: w1,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffdf2f2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(
                              SellerSvg().starIcon,
                              color: ColorPalette.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Most Rated Reviews",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 20,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.string(TaskSvg().arrowIcon)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Review History",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ReviewCard(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
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
