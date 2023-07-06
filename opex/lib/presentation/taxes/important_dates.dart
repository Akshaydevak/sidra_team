import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/taxes/widgets/imp_dates_card.dart';
import 'package:flutter/material.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ImportantDates extends StatelessWidget {
  const ImportantDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Important Dates",
          isAction: false,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ImportantDatesCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
