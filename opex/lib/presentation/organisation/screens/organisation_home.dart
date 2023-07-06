import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/mpos_svg.dart';
import '../../mpos/search_card.dart';
import '../../task_operation/home_card.dart';
import '../../task_operation/task_svg.dart';
import '../bloc/organisation_bloc.dart';
import 'org_quick.dart';
import 'organisation_card.dart';

class OrganisationHome extends StatefulWidget {
  const OrganisationHome({Key? key}) : super(key: key);

  @override
  State<OrganisationHome> createState() => _OrganisationHomeState();
}

class _OrganisationHomeState extends State<OrganisationHome> {

  @override
  void initState() {
    context.read<OrganisationBloc>().add(const GetOrganisationListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(label: "Organization"),
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
                        SearchCard(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeCard(
                              head: "120",
                              sub: "Total Legal Units",
                            ),
                            HomeCard(
                              head: '32',
                              sub: "Total Business Units",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeCard(
                              head: "3200",
                              sub: "Opeational Units",
                            ),
                            HomeCard(
                              head: '362',
                              sub: "Total Channels",
                            )
                          ],
                        ),
                        SizedBox(height: 25,),
                        Container(
                          width: w,
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
                                    HomeSvg().chatGroupIcon,
                                    color: ColorPalette.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Chat with a Seller",
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
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            width: w,
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
                                      MposSvg().handIcon  ,
                                      color: ColorPalette.primary,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Sellers List",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SvgPicture.string(TaskSvg().arrowIcon)
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30,),
                        Text(
                          "Quick access to :",
                          style: GoogleFonts.roboto(
                            color: Color(0xff151522),
                            fontSize: w/20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        OrgQuick(),
                        SizedBox(
                          height: 26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             "New Legal Units",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "View All",
                              style: GoogleFonts.roboto(
                                color: Color(0xfffe5762),
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ) ,
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<OrganisationBloc, OrganisationState>(
                            builder: (context, state) {
                              if(state is GetOrganisationListLoading){
                                return Text("Loadinggg................");
                              } if(state is GetOrganisationListSuccess){
                                return  ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                   itemCount: state.ordersList.length,
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: 5,
                                  ),
                                  itemBuilder: (context, index) => OrganisationCard(
                                    // orgName: state.ordersList[index].name.toString(),
                                    orgModel: state.ordersList[index],

                                  ),
                                );
                              }if(state is GetOrganisationListFailed){
                                return Text("Failed................");
                              }
                              return ListView.separated(
                                primary: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 20,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                                itemBuilder: (context, index) => OrganisationCard(),
                              );
                            }
                        ),
                        BottomCard()
                      ])
              )
          ),
        ));
  }
}
