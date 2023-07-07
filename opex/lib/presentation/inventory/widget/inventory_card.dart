import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
class InventoryCatProductCard extends StatefulWidget {
  final VoidCallback? onTap;
  bool isSelect;
  final String? division;

  InventoryCatProductCard({
    Key? key,
    this.division,
    this.isSelect=false,this.onTap
  }) : super(key: key);

  @override
  State<InventoryCatProductCard> createState() => _InventoryCatProductCardState();
}

class _InventoryCatProductCardState extends State<InventoryCatProductCard> {


  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: w/1.45,
                  child: Text(
                    widget.division ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/24,
                    ),
                  ),
                ),
                widget.isSelect
                    ? Container(
                    // padding: EdgeInsets.all(10),
                    child: SvgPicture.string(OrderSvg().checkBoxActiveIcon))
                    : SvgPicture.string(
                  OrderSvg().checkBoxIcon,

                ),
              ],
            )));
  }
}
class InventoryDivisionCard extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapAll;
  final VoidCallback? onTapDelete;
  bool isSelect;
  bool frameWork;
  final String? division;

  InventoryDivisionCard({
    Key? key,
    this.division,
    this.isSelect=false,
    this.frameWork=false,
    this.onTap,
    this.onTapAll,
    this.onTapDelete
  }) : super(key: key);

  @override
  State<InventoryDivisionCard> createState() => _InventoryDivisionCardState();
}

class _InventoryDivisionCardState extends State<InventoryDivisionCard> {


  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
            onTap: widget.onTapAll,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: w/1.8,
                  child: Text(
                    widget.division ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/24,
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: SvgPicture.string(MposSvg().moreIcon),
                  //don't specify icon if you want 3 dot menu
                  color: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            widget.frameWork==true?Container():InkWell(
                              onTap: widget.onTap,
                              child: Container(
                                padding: const EdgeInsets.only(right: 50,top: 10,bottom: 10,left: 10),
                                child: Text(
                                  'Edit',
                                  style: GoogleFonts.poppins(
                                      color: ColorPalette.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            widget.frameWork==true?Container(): Divider(indent: 30,),
                            InkWell(
                              onTap: widget.onTapDelete,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Remove from list',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ))

                  ],
                  onSelected: (value) {

                  },
                ),
              ],
            )));
  }
}
