import 'package:cluster/presentation/seller_app/seller_models/seller_model_class.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerOrderCard extends StatefulWidget {
  final GetNewOrderSellerList? seller;
  const SellerOrderCard({Key? key,  this.seller}) : super(key: key);

  @override
  State<SellerOrderCard> createState() => _SellerOrderCardState();
}

class _SellerOrderCardState extends State<SellerOrderCard> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Stack(
      children: [
        Container(
          width: w1,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.string(SellerSvg().clockIcon),
                  SizedBox(width: 8,),
                  Text(
                    "${widget.seller?.orderDate?.split("T")[0]}" " " "${ widget.seller?.orderDate?.split("T")[1].split(":")[0]}" ":" "${ widget.seller?.orderDate?.split("T")[1].split(":")[1]}" ??"",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              // Row(
              //   children: [
              //     SvgPicture.string(SellerSvg().docIcon),
              //     SizedBox(width: 8,),
              //     Row(
              //       children: [
              //         Text(
              //           "61843643545",
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontSize: w / 22,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         SizedBox(width: 8,),
              //         Text(
              //           "Sidra App",
              //           style: GoogleFonts.roboto(
              //             color: Color(0xff676767),
              //             fontSize: 16,
              //
              //             fontWeight: FontWeight.w500,
              //           ),
              //         )
              //       ],
              //     )
              //   ],
              // ),
              // SizedBox(height: 10,),
              Row(
                children: [
                  SvgPicture.string(SellerSvg().personIcon),
                  SizedBox(width: 8,),
                  Text(
                    widget.seller?.orderMetaSeller?.customerDataSeller?.fname??"",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.string(SellerSvg().mapIcon),
                  SizedBox(width: 8,),
                  Text(
                    "${widget.seller?.orderMetaSeller?.customerDataSeller?.streetName}, ${widget.seller?.orderMetaSeller?.customerDataSeller?.city},"
                        "\n${widget.seller?.orderMetaSeller?.customerDataSeller?.country}",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: w/3,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(0),
                ),
                color: Color(0xff3fb44b),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.string(SellerSvg().deliveryIcon),
                  const SizedBox(width: 5,),
                  Text(
                    widget.seller?.status??"",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: w/26,

                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
