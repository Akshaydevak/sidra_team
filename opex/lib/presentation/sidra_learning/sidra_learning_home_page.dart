import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:cluster/presentation/sidra_learning/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/application_model.dart';
import 'button_seek.dart';
import 'learning_cards.dart';

class SidraLearningHomePage extends StatefulWidget {
  const SidraLearningHomePage({super.key});

  @override
  State<SidraLearningHomePage> createState() => _SidraLearningHomePageState();
}

class _SidraLearningHomePageState extends State<SidraLearningHomePage> {

  List<String> bannerList=[
    "https://www.dochipo.com/wp-content/uploads/2021/10/YouTube-Thumbnail-_-Education-8.png",
    "https://www.dochipo.com/wp-content/uploads/2022/08/YouTube-Thumbnail-_-Education-scaled.jpg",
    "https://www.adobe.com/express/create/thumbnail/media_17d5e64dbfdcfa68951114825e4c1a99f31cc9996.jpeg?width=750&format=jpeg&optimize=medium",
    "https://www.dochipo.com/wp-content/uploads/2022/08/YouTube-Thumbnail-_-Education-4-scaled.jpg"
  ];
  List<String> listVideo=[
    "https://sidra-bazar-uat-products.s3.ap-south-1.amazonaws.com/w_banners/Sidra+Meta+Ad2.mp4",
    "https://sidra-bazar-uat-products.s3.ap-south-1.amazonaws.com/w_banners/Sidra+GO%26+Business.mp4",
    // "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    // "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
  ];


  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: StickyHeader(
          header: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 5,bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 8,top: 4),
                              child: SvgPicture.string(AppsSvg().learningSvg),height: 35,width: 35,),
                          SizedBox(width: 5,),
                          Text("Sidra Learning",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: w/22
                            ),),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10,top: 10),
                              child: Icon(Icons.close,color: Colors.black,),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Fuel your knowledge with our dynamic learning app",
                          style: GoogleFonts.roboto(
                              color: Color(0xff555555),
                              fontSize: w/32
                          ),),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,color: ColorPalette.borderGrey.withOpacity(0.5),),
              ],
            ),
          ),

          content: Column(
            children: [

              // Container(
              //   height: 185,
              //   width: w1/1.15,
              //   color: Colors.white,
              //   child: CarouselSlider.builder(
              //       slideTransform: DefaultTransform(),
              //        enableAutoSlider: true,unlimitedMode: true,
              //       slideIndicator: CircularSlideIndicator(
              //           padding: EdgeInsets.only(bottom: 0, left: 0),
              //           alignment: Alignment.bottomCenter,
              //           indicatorBorderWidth: 0.2,
              //           indicatorRadius: 3.5,
              //           itemSpacing: 10,
              //           currentIndicatorColor: Color(0xff086DB5),
              //           indicatorBackgroundColor: ColorPalette.cardBackground),
              //       itemCount: bannerList.length,
              //       slideBuilder: (int i) {
              //         return Column(
              //           children: [
              //             Container(
              //               margin: EdgeInsets.symmetric(horizontal: 5),
              //               width: w1,
              //               height: 170,
              //               decoration: BoxDecoration(
              //                 image: DecorationImage(image: NetworkImage(bannerList[i]),fit: BoxFit.cover),
              //                 borderRadius: BorderRadius.circular(4),
              //                 color: Colors.white
              //               ),
              //             ),
              //           ],
              //         );
              //       }),
              // ),
              // Divider(),
              SizedBox(height: 15,),
              Container(
                // color: Colors.blue,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (){
                            // _launchUrl(applicationList[index].url);
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: VideoPlayerWidget(videoUrls: listVideo,initialIndex: index,
                              model: applicationList[index]),
                              withNavBar:
                              false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.slideUp,
                            );

                          },
                          child: ThumbnailCard(thumbNail: applicationList[index],
                          share: (){
                            _share(applicationList[index].url);
                          },));
                    },
                    separatorBuilder: (context, index) => Column(
                      children: [
                        Divider(height: 1,color: ColorPalette.borderGrey.withOpacity(0.5),),
                        SizedBox(height: 15,),
                      ],
                    ),
                    itemCount: applicationList.length),
              ),
              Divider(height: 1,color: ColorPalette.borderGrey.withOpacity(0.5),),
              SizedBox(height: 50,),
              Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.string(
                        AppsSvg().careIcon,
                        height: 10,width: 10,
                      ),
                      SizedBox(width: 5,),
                      Text("all rights reserved to sidralearning",
                        style: GoogleFonts.roboto(
                          fontSize: w/32,
                          color: Color(0xff555555),
                        ),),
                    ],
                  )),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
   _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }

  }
  _share(String url){
    Share.share(url);
    print(url);
  }
}
