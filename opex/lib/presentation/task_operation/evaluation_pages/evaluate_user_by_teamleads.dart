import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/task_operation/evaluation_pages/evaluation_user_view.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../create/task_bloc/task_bloc.dart';
import '../lottieLoader.dart';
import '../task_svg.dart';
import '../task_title.dart';
import 'evaluation_card.dart';
import 'evaluation_first_page.dart';

class EvaluationUserListByTLs extends StatefulWidget {
  const EvaluationUserListByTLs({super.key});

  @override
  State<EvaluationUserListByTLs> createState() => _EvaluationUserListByTLsState();
}

class _EvaluationUserListByTLsState extends State<EvaluationUserListByTLs> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Evaluation",
            isAction: false,
            onTap: () {},
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [


                Container(
                  // height: h/1.3,
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 16),
                  width: w1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "New Jobs",
                      //   style: GoogleFonts.roboto(
                      //     color: Color(0xff151522),
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: w1/1.35,
                                child: SearchCard(
                                  hint: "Search Users..!",
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Color(0xffE6ECF0))
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                                child:   SvgPicture.string(
                                  TaskSvg().filter,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext cxt, int i) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                                itemBuilder: (BuildContext context, int i) {
                                  return GestureDetector(
                                    onTap: (){
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: EvaluationFirstPage(),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: UserCardEvaluationTLs(
                                      onTap: (){
                                        // _showModalBottomSheetNew(context,false);
                                      },
                                    ),
                                  );
                                },
                                itemCount: 6),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  _showModalBottomSheetNew(BuildContext context, bool edit) {
    List<String> filterList=['Weeks','Day','Months','Years'];
    String? selectedGender='Weeks';
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        height: h / 1.7,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "Evaluation",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormReusable(
                              label: "Evaluation Title",
                              hint: "Enter name",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: w/3.8,
                                  child: TextFormReusable(
                                    label: "Review within",
                                    numField: true,
                                  ),
                                ),
                                Container(
                                  width: w/1.7,
                                  child: Flex(direction: Axis.vertical,
                                      children:[
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 25,),
                                            Container(
                                                width: w/1.7,
                                                padding: EdgeInsets.only(left: 15),
                                                decoration: BoxDecoration(color: Colors.white,
                                                    border: Border.all(color: Color(0xffe6ecf0)),
                                                    borderRadius: BorderRadius.circular(4)),
                                                child: DropdownButton<String>(
                                                  underline:Container(),
                                                  icon:  Padding(
                                                    padding: EdgeInsets.only(left: w/3.7),
                                                    child: Icon(Icons.arrow_drop_down),
                                                  ),
                                                  hint:  Text(""),
                                                  value: selectedGender,
                                                  onTap: (){

                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedGender=value;

                                                    });
                                                  },

                                                  items: filterList.map<DropdownMenuItem<String>>((String value) =>
                                                      DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,)
                                                      )).toList(),
                                                )
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormReusable(
                              label: "Your Notes",
                              hint: "Text anything...",
                              maxLength: 6,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GradientButton(
                                color: ColorPalette.primary,
                                onPressed: (){

                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Start Evaluation",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
                        ),)
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
