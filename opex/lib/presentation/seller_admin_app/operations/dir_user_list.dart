import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_widgets/no_glow.dart';
import '../model_seller_admin/seller_admin_models.dart';

class DirectorUserList extends StatefulWidget {
  final String? entityCode;
  const DirectorUserList({super.key, this.entityCode});

  @override
  State<DirectorUserList> createState() => _DirectorUserListState();
}

class _DirectorUserListState extends State<DirectorUserList> {
  @override
  void initState() {
    context
        .read<SellerAdminBloc>()
        .add(const DirectorUserListEvent("", "",''));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: BlocBuilder<SellerAdminBloc, SellerAdminState>(
  builder: (context, state) {
    if(state is DirectorUserListLoading){
      return Container(
        height: 200,
        width: w,
        alignment: Alignment.center,
        child: LoadingAnimationWidget.threeRotatingDots(
          color: Colors.red,
          size: 30,
        ),
      );
    }
    if(state is DirectorUserListSuccess){
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total ${state.director!.length} Users",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: state.director!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      _showModalBottomSheetOfferGroup(state.director?[index]);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.2,color: Colors.grey),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Color(0xffffffff),
                      ),child: Container(
                      padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            TextAvatar(
                              shape: Shape.Circular,
                              size: 45,
                              numberLetters: 1,
                              fontSize: w / 16,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w500,
                              text: state.director?[index].dirCode?.toUpperCase() ??
                                  "".toUpperCase(),
                            ),
                            SizedBox(width: 10,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.director?[index].dirCode??"",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7D7D7D),
                                  fontSize: w/26,

                                ),),
                                Text(state.director?[index].fname??"",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: w/24,

                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),

                    )))
          ],
        ),
      );
    }
    return Container();
  },
),
        ),
      ),
    );
  }
  _showModalBottomSheetOfferGroup(SellerUserModel? employee) {
    final TextEditingController groupName = TextEditingController();
    int select = 0;
    void onselect(int index) {
      setState(() {
        select = index;
      });
    }


    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Director Details",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        SizedBox(
                          height: h / 6.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 0.2, color: Colors.grey),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x05000000),
                                              blurRadius: 8,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                          color: Color(0xffffffff),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          child: Row(
                                            children: [
                                              TextAvatar(
                                                shape: Shape.Circular,
                                                size: 45,
                                                numberLetters: 1,
                                                fontSize: w / 16,
                                                textColor: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                text: employee?.fname
                                                    .toString()
                                                    .toUpperCase(),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    employee?.dirCode ?? "",
                                                    style: TextStyle(
                                                        fontSize: w / 26,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        color:
                                                        Color(0xff7D7D7D)),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    employee?.fname ?? "",
                                                    style: TextStyle(
                                                        fontSize: w / 22,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.email_sharp,
                                                        size: 16,
                                                        color:
                                                        Color(0xffD3D3D3),
                                                      ),
                                                      SizedBox(
                                                        width: w / 30,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                            // width: w/1.5,
                                                            child: Text(
                                                              employee?.email ??
                                                                  "",
                                                              maxLines: 2,
                                                              style: GoogleFonts.roboto(
                                                                  color: const Color(
                                                                      0xff777777),
                                                                  fontSize:
                                                                  w / 26),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .phone_android_sharp,
                                                        size: 16,
                                                        color:
                                                        Color(0xffD3D3D3),
                                                      ),
                                                      SizedBox(
                                                        width: w / 30,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              employee?.mobile ??
                                                                  "",
                                                              maxLines: 2,
                                                              style: GoogleFonts.roboto(
                                                                  color: const Color(0xff777777),
                                                                  fontSize:
                                                                  w / 26),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
