import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../contract_app/widgets/contract_type_card.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class NearingRenewal extends StatelessWidget {
  const NearingRenewal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Nearing to Renuwal",
          isAction: false,
        ),
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
                Text(
                  "Total 14 Contract",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ContractTypeCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: 5)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
