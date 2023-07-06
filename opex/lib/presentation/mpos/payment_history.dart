import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/mpos/payment_history_card.dart';
import 'package:flutter/material.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Payment History",isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>    const PaymentHostoryCard(),
                primary: true,
                shrinkWrap: true,
                  itemCount: 10,
                  separatorBuilder: (context, index) => const SizedBox(height: 5,),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
