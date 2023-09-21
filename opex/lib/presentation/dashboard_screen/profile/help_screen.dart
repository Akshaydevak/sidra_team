import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/no_glow.dart';
import '../../base/icon_constants.dart';
import '../../seller_admin_app/model_seller_admin/seller_admin_models.dart';
import '../../task_operation/lottieLoader.dart';
import '../home_screen/homescreen_widget/appbar.dart';
import 'help_card.dart';

class HelpScreen extends StatefulWidget {
  final bool? autoFocus;
  const HelpScreen({Key? key, this.autoFocus = false}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<FaqList> faqList = [];
  List<FaqList> fullFaqList = [];
  TextEditingController searchWord = TextEditingController();
  bool isSelect = false;
  FocusNode myfocus = FocusNode();
  @override
  void initState() {
    context.read<SellerAdminBloc>().add(GetFaqListEvent(""));
    Future.delayed(Duration(seconds: 0), () {
      myfocus.requestFocus(); //auto focus on second text field.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Help & Support",
            isAction: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                height: h / 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1,
                      color: Color(0xff7C7C7C).withOpacity(0.2)),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(
                  // top: 5,
                    right: w1 > 700 ? 30 : 16,
                    left: w1 > 700 ? 30 : 16),
                padding: EdgeInsets.only(left: 0, right: 0),
                child: TextFormField(
                  enabled: true,
                  autofocus: widget.autoFocus == false ? false : true,
                  controller: searchWord,
                  onFieldSubmitted: (value) {},
                  onChanged: (val) {
                    searchWord.text.length >= 2
                        ? context
                        .read<SellerAdminBloc>()
                        .add(GetFaqListEvent(val))
                        : null;
                    searchWord.text.isEmpty
                        ? context
                        .read<SellerAdminBloc>()
                        .add(GetFaqListEvent(""))
                        : null;
                  },
                  cursorColor: ColorPalette.primary,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    // prefixIcon: Icon(Icons.search),
                    // suffixIcon: InkWell(
                    //   onTap: () {
                    //     // BlocProvider.of<AddressBloc>(context).add(
                    //     //     SearchForPickUpLocation(
                    //     //         searchWord: searchController.text));
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(top: 15, bottom: 15),
                    //     child: SvgPicture.string(
                    //         IconConstants().cartIcon),
                    //   ),
                    // ),

                    focusColor: Colors.white,
                    enabled: true,
                    hintText: "Search “FAQs”",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: w / 26, color: ColorPalette.black),
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    disabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              BlocBuilder<SellerAdminBloc, SellerAdminState>(
                builder: (context, state) {
                  if (state is GetFaqListLoading) {
                    return LottieLoader();
                  }
                  if (state is GetFaqListSuccess) {
                    faqList = state.faqList;
                    fullFaqList = state.faqList;
                    return ScrollConfiguration(
                      behavior: NoGlow(),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // height: MediaQuery.of(context).size.height * .05,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10,
                                                top: 10),
                                            child: Text(
                                              faqList[index].tittle ?? "Title",
                                              style: GoogleFonts.poppins(
                                                color: ColorPalette.black,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, i) {
                                                String fruit =
                                                    faqList[index].values?[i].title ??
                                                        "";
                                                int indexOfMatch = fruit.indexOf(
                                                    searchWord.text.toString());
                                                if (indexOfMatch >= 0) {
                                                  return Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 0.1,
                                                            color: Colors.grey,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  4),
                                                          color: isSelect
                                                              ? Color(0xffFFFFFF)
                                                              : Color(0xffFFFFFF)),
                                                      margin: EdgeInsets.only(
                                                          left: 15, right: 15),
                                                      padding: EdgeInsets.all(0.5),
                                                      child: Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                dividerColor: Colors
                                                                    .transparent),
                                                        child: ExpansionTile(
                                                          tilePadding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 10),
                                                          childrenPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5,
                                                                  left: 15,
                                                                  right: 10),

                                                          onExpansionChanged:
                                                              (bool isExpand) {
                                                            setState(() {
                                                              isSelect = isExpand;
                                                            });
                                                            print(
                                                                ".............$isExpand");
                                                          },
                                                          // collapsedIconColor: ColorPalette.primary,
                                                          iconColor:
                                                              ColorPalette.primary,
                                                          collapsedIconColor:
                                                              Color(0xff000000),
                                                          collapsedBackgroundColor:
                                                              Color(0xffECECEC)
                                                                  .withOpacity(0.5),
                                                          expandedAlignment:
                                                              Alignment.topLeft,
                                                          title: Text(
                                                            faqList[index]
                                                                    .values?[i]
                                                                    .title ??
                                                                "",
                                                            style: isSelect
                                                                ? GoogleFonts.roboto(
                                                                    color:
                                                                        ColorPalette
                                                                            .black,
                                                                    fontSize: w / 24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )
                                                                : TextStyle(
                                                                    color:
                                                                        Colors.black,
                                                                    fontSize: w / 24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                          children: [
                                                            Text(
                                                              faqList[index]
                                                                      .values?[i]
                                                                      .description ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  height: 1.5),
                                                              textAlign:
                                                                  TextAlign.justify,
                                                            ),

                                                            // SizedBox()
                                                          ],
                                                        ),
                                                      ));
                                                }
                                                return Container();
                                              },
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(
                                                  height: 5,
                                                );
                                              },
                                              itemCount:
                                                  faqList[index].values!.length),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 5,
                                      );
                                    },
                                    itemCount: faqList.length),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    print("faq list is here$faqList");
                    setState(() {});
                  }
                  return Container();
                },
              ),
            ],
          ),
        ));
  }
}
