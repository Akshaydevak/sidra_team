import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'evaluation_card.dart';
import 'evaluation_read_ceo_page.dart';

class EvaluationUserListToCEO extends StatefulWidget {
  const EvaluationUserListToCEO({super.key});

  @override
  State<EvaluationUserListToCEO> createState() => _EvaluationUserListToCEOState();
}

class _EvaluationUserListToCEOState extends State<EvaluationUserListToCEO> {
  List<String> filterList=[
    "Default",
    "Points: Low to High",
    "Points: High to Low",
  ];
  String? selectedFilter;
  List<CoolDropdownItem<String>> pokemonDropdownItems = [];
  List<CoolDropdownItem<String>> fruitDropdownItems = [];

  final fruitDropdownController = DropdownController();
  final pokemonDropdownController = DropdownController();
  final listDropdownController = DropdownController();

  @override
  void initState() {
    for (var i = 0; i < filterList.length; i++) {
      pokemonDropdownItems.add(
        CoolDropdownItem<String>(
            label: filterList[i],
            icon: Container(
              height: 25,
              width: 25,
              color: Colors.green,
            ),
            value: '${filterList[i]}'),
      );
    }
    super.initState();
  }
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
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: w1/1.35,
                            child: SearchCard(
                              hint: "Search Users..!",
                            ),
                          ),
                          // SizedBox(width: w1/10,),
                          Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Color(0xffe6ecf0),
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: DropdownButton(
                                isExpanded: true,
                                icon: SvgPicture.string(TaskSvg().filter),
                                underline: Container(),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                items: filterList.map((String items) {
                                  return DropdownMenuItem(

                                    enabled: true,
                                    value: items,
                                    child: Container(
                                      child: Text(items,
                                          style: TextStyle(color: Colors.black,fontSize: w/24)),
                                    ),
                                  );
                                }).toList(),
                                // value: slectedFilter,
                                onChanged: (dynamic value) {

                                    selectedFilter = value;

                                }),
                          ),
                          // CoolDropdown<String>(
                          //   controller: pokemonDropdownController,
                          //   dropdownList: pokemonDropdownItems,
                          //   defaultItem: pokemonDropdownItems.last,
                          //   onChange: (a) {
                          //     pokemonDropdownController.close();
                          //   },
                          //   resultOptions: ResultOptions(
                          //       width: 50,
                          //       render: ResultRender.none,
                          //       icon: SvgPicture.string(TaskSvg().filter)
                          //   ),
                          //   dropdownOptions: DropdownOptions(
                          //     width: 180,
                          //
                          //   ),
                          //   dropdownItemOptions: DropdownItemOptions(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     selectedBoxDecoration: BoxDecoration(
                          //       color: Color(0XFFEFFAF0),
                          //     ),
                          //   ),
                          // ),
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
                                    screen: EvaluatioReadPageCeo(),
                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.fade,
                                  );

                                },
                                child: UserReviewCard(
                                  onTap: (){
                                    // _showModalBottomSheetNew(context,false);
                                  },
                                ),
                              );
                            },
                            itemCount: 4),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
