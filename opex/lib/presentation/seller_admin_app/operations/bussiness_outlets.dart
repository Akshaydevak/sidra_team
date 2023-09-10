import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_admin_app/operations/outlet_card.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/change_category.dart';
import 'outlet.dart';

class BussinessOutlets extends StatefulWidget {
  final String? legalCode;
   BussinessOutlets({Key? key, this.legalCode}) : super(key: key);

  @override
  State<BussinessOutlets> createState() => _BussinessOutletsState();
}

class _BussinessOutletsState extends State<BussinessOutlets> {
int ?select;

void onselect(index){
  setState(() {
    select=index;
  });

}

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return WillPopScope(
      onWillPop: ()async{
        context.read<SellerAdminBloc>().add(
            BusinessOutletListEvent(
                widget.legalCode, "", "", ""));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Business Outlets",
            isAction: false,
          action: GestureDetector(
            onTap: () {
              // PersistentNavBarNavigator.pushNewScreen(
              //   context,
              //   screen: Outlet(legalCode: widget.legalCode,
              //   ),
              //   withNavBar: true,
              //   // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.fade,
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Create",
                style: GoogleFonts.poppins(
                    color: ColorPalette.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: BlocBuilder<SellerAdminBloc, SellerAdminState>(
  builder: (context, state) {
      if(state is BusinessOutletListLoading){

      }
      if(state is BusinessOutletListSuccess){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total ${state.category!.length} Outlets",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w/20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10,),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: state.category!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    onselect(index);
                    setState(() {

                    });
                  },
                  child: Container()),)
          ],
        );
      }
      return Container();
  },

),
            ),
          ),
        ),
      ),
    );
  }
}
