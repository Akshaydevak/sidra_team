import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/card_design_organisation.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/models_org/org_model.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/organisation_bloc_task/organisation_task_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'heirarchy_page_2.dart';

class CreateHeirarchyPageOne extends StatefulWidget {
  const CreateHeirarchyPageOne({super.key});

  @override
  State<CreateHeirarchyPageOne> createState() => _CreateHeirarchyPageOneState();
}

class _CreateHeirarchyPageOneState extends State<CreateHeirarchyPageOne> {
  int? select;
  void onselect(index) {
    setState(() {
      select = index;
    });
  }

  int? currentlyExpandedIndex;

  @override
  void initState() {
    super.initState();
    context
        .read<OrganisationTaskBloc>()
        .add(const GetDepartmentTaskListEvent('', "", ""));
    currentlyExpandedIndex =
        -1; // Initialize to -1, indicating no card is expanded initially.
  }

  void toggleExpansion(int index) {
    setState(() {
      if (currentlyExpandedIndex == index) {
        // Clicking on the same card that is already expanded should collapse it.
        currentlyExpandedIndex = -1;
      } else {
        currentlyExpandedIndex = index;
      }
    });
  }
  List<DepartmentTaskModel> model=[];

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<OrganisationTaskBloc, OrganisationTaskState>(
  listener: (context, state) {
    if(state is DepartmentTaskListSuccess){
      model=state.inventory??[];
      setState(() {

      });
    }
    // TODO: implement listener
  },
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Level 1",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              // BlocBuilder<OrganisationTaskBloc, OrganisationTaskState>(
              //   builder: (context, state) {
              //     if (state is DepartmentTaskListLoading) {
              //       return Container(
              //           height: h / 1.2, child: customCupertinoLoading());
              //     }
              //     if (state is DepartmentTaskListSuccess) {
              //       return
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "${model.length} Department",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: h / 1.2,
                          child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ToggleExpandCard(
                                      onTap: () {
                                        toggleExpansion(index);
                                        context
                                            .read<OrganisationTaskBloc>()
                                            .add( RoleUnderDepartmentListEvent('', "", "",model[index].id));
                                        setState(() {});
                                      },
                                      label: model[index].name,
                                      // id: state.inventory?[index].id,
                                      isExpaned:
                                          currentlyExpandedIndex == index,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => Container(
                                    height: 0,
                                  ),
                              itemCount: model.length),
                        ),
                      ],
                    // );
                //   }
                //   return Container();
                // },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: HeirarchyPageTwo(),
                          withNavBar: true,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      gradient: const LinearGradient(
                        colors: [ColorPalette.primary, ColorPalette.primary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: Colors.transparent,
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    ),
);
  }
}
