import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/organisation/bloc/organisation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_radio_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/mpos_svg.dart';
import '../../mpos/search_card.dart';
import '../../order_app/order_svg.dart';
import 'organisation_card.dart';


class LegalUnit extends StatefulWidget {
   LegalUnit({Key? key}) : super(key: key);

  @override
  State<LegalUnit> createState() => _LegalUnitState();
}

class _LegalUnitState extends State<LegalUnit> {
  int selected = 0;
bool viewCountry=false;
  int isItemSelect = 0;

  List<String> typeList = [
    'Lorem ipsum ',
    'Lorem ipsum dolar',
    'Lorem ipsum dolar',
    'Lorem ipsum dolar',
  ];  List<String> statusList = [
    'Active Legal Units',
    'Expired Legal Units',
    'Inactive Legal Units',
    'Blocked Units',
  ];

  List<String> productTypeList = [
    'All Countries',
    'Saudi Arabia',
    'INDIA',
    'USA'
  ];
  void onSelect(int val) {
    selected = val;
    setState(() {});
  }



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
        child: BackAppBar(label: "Legal Units"),
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
                    Container(width:w/1.35,child: SearchCard()),
                    GestureDetector(
                      onTap: (){
                        _showModalBottomSheet();

                      },child: Container(
                      padding: EdgeInsets.all(13),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: SvgPicture.string(MposSvg().filterIcon,color: ColorPalette.subtextGrey,),
                    ),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Text(
                  "Organizations",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                        );;
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
                SizedBox(height: 40,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SafeArea(
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Filter",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Apply",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xfffe5762),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 1.5,
                              color: Color(0xffE6ECF0),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Registered Country",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: productTypeList.length<3?productTypeList.length:viewCountry?productTypeList.length:3,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                onSelect(index);
                                                setState(() {});
                                              },
                                              child: selected == index
                                                  ? Container(
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.string(
                                                    OrderSvg()
                                                        .checkBoxActiveIcon),
                                              )
                                                  : SvgPicture.string(
                                                  OrderSvg().checkBoxIcon),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              productTypeList[index],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            height: 10,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            viewCountry?Container(): Container(
                              padding: EdgeInsets.only(left: 50,bottom: 10),
                              child: GestureDetector(
                                onTap: (){
                                  setState((){
                                    viewCountry=true;
                                  });

                                },
                                child: Text(
                                  "View All Countries",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 1.5,
                              color: Color(0xffE6ECF0),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Types",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                onSelect(index);
                                                setState(() {});
                                              },
                                              child: selected == index
                                                  ? Container(
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.string(
                                                    OrderSvg()
                                                        .checkBoxActiveIcon),
                                              )
                                                  : SvgPicture.string(
                                                  OrderSvg().checkBoxIcon),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              typeList[index],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            height: 10,
                                          ),
                                      itemCount: typeList.length),
                                ],
                              ),
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 1.5,
                              color: Color(0xffE6ECF0),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                onSelect(index);
                                                setState(() {});
                                              },
                                              child: selected == index
                                                  ? Container(
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.string(
                                                    OrderSvg()
                                                        .checkBoxActiveIcon),
                                              )
                                                  : SvgPicture.string(
                                                  OrderSvg().checkBoxIcon),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              statusList[index],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            height: 10,
                                          ),
                                      itemCount: statusList.length),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              );
            },
          );
        });
  }
}
