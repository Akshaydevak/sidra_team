import 'package:cluster/presentation/contract_app/contract_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../mpos/search_card.dart';
import '../../organisation/screens/comments_screen.dart';
import '../../organisation/screens/nearing_renewal.dart';
import '../../seller_app/new_product.dart';
import '../../task_operation/task_svg.dart';
import '../contract_profile.dart';
import '../contract_type.dart';
import '../counter_parties.dart';
import '../new_contract.dart';

class ContractQuick extends StatelessWidget {
  List<String> quickData = [
    'Add New Contract',
    'Profile',
    'Counter Parties',
    'Contract Types',
    'New Contracts',
    'Nearing Renewal',
    'Comments',
    'Settings'
  ];

  ContractQuick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onTap: onTapListTile(i, context),
                child: Container(
                  width: 88,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x0ce30000),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(TaskSvg().quickaccessIcon),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        quickData[i],
                        style: TextStyle(
                          color: Color(0xff121113),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  VoidCallback onTapListTile(int i, BuildContext context) {
    // String email = Variables.emailfield;
    int select=0;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                var w=MediaQuery.of(context).size.width;
                return AlertDialog(
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.close))],
                      ),
                      // SizedBox(height: 5,),
                      Text(
                        "Select Contract Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      SearchCard(),
                      SizedBox(
                        height: 16,
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              // setState((){
                              //
                              // });
                            },
                            child: Container(
                              width: w,
                               padding: EdgeInsets.all(16),
                                decoration: select==index?BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xfffdf2f2),
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x05000000),
                                      blurRadius: 8,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                  color: Colors.white  ,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Service Delivery Agreement",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w/26,
                                      ),
                                    ),
                                    select==index?SvgPicture.string(ContractSvg().tickIcon):Container()
                                  ],
                                )),
                          ), separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: 3),
                      SizedBox(height: 5,),
                      GradientButton(
                          color:Color(0xfffe5762) ,
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen:  NewContract(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );

                          },
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  ),
                );
              });
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: LegalUnit(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation:
          //   PageTransitionAnimation.fade,
          // );
        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ContractProfile(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        };
        break;
      case 2:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CounterParties(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 3:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ContractType(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 4:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: ContractType(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
        };
        break;
      case 5:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: NearingRenewal(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        //NearingRenewal
        };
        break;
      case 6:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CommentScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
    }
    return onTap;
  }
}
