import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:flutter/material.dart';

class InventoryOutStockCard extends StatelessWidget {
  bool isStock;
  InventoryModel? variantList;
  InventoryOutStockCard({Key? key,this.isStock=false,this.variantList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(10), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(10), ),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xfff0f1f2),
            ),
            child: Image.network(variantList?.image1??"https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"),
          ),

          SizedBox(width: 16,),
          Container(
            width: w/1.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variantList?.code??"",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w/24,
                  ),

                ),
                SizedBox(height: 5,),
                Text(
                  variantList?.name??"",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w/24,
                  ),

                ),
                SizedBox(height: 5,),
                variantList?.barcode?.barcodeNumber==null?Container():Container(
                  child: Row(
                    children:  [
                      Text(
                        "Barcode :",
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorPalette.subtextGrey
                        ),
                      ),
                      Text(
                        variantList?.barcode?.barcodeNumber??"",
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorPalette.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
