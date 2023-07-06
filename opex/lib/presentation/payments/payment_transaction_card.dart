import 'package:cluster/presentation/payments/transaction_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PaymentTransactionCard extends StatelessWidget {
  const PaymentTransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TransactionView(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        width: w,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffe6ecf0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 8,
              offset: Offset(1, 1),
            ),
          ],
          color: Color(0xfffcfbfb),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ICIC Bank -  XX 3652",
                        style: GoogleFonts.roboto(
                          color: Color(0xff6d6d6d),
                          fontSize: w/23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Call center app",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff121113),
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "AED 500.25",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "01 OCT  |  05:22 PM",
                        style: GoogleFonts.roboto(
                          color: Color(0xff7d7d7d),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
                top: 0,
                child:Container(
                  width: 69,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(8), bottomLeft: Radius.circular(2), bottomRight: Radius.circular(0), ),
                    color: Color(0xff3ab746),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Completed",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ) )
          ],
        ),
      ),
    );
  }
}
