import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilingScreen extends StatelessWidget {
  const ProfilingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Images",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w / 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(
                text:
                    'We are implementing some guidelines for your product image,  ',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 25,
                  fontWeight: FontWeight.normal,
                ),
                children: [
              TextSpan(
                text: 'View Guideline',
                style: GoogleFonts.roboto(
                  color: ColorPalette.primary,
                  fontSize: w / 25,
                  fontWeight: FontWeight.w500,
                ),
              )
            ])),
        SizedBox(
          height: 5,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1.5 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 8),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                    child: Container(
                        width: 88,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffe6ecf0),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(30),
                        child:   SvgPicture.string(ProductSvg().camIcon),
                    ),
                  );
                })),
        const SizedBox(
          height: 10,
        ),

        DottedBorder(
          color: const Color(0xffcbced0),
          strokeWidth: 1,
          strokeCap: StrokeCap.butt,
          radius: const Radius.circular(5),
          dashPattern: [7],
          child: Container(
            padding: EdgeInsets.all(14),
            width: w,
            // height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IMAGE GUIDELINE",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: w/20,
                      ),
                    ),
                    Container(
                      width: w/1.25,
                      child:  Text(
                        " You should upload up to 8 images for your product",
                        style: TextStyle(
                          color: Color(0xff666161),
                          fontSize: w/26,
                        ),
                      ),
                    )

                  ],
                ) ,
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: w/20,
                      ),
                    ),
                    Container(
                      width: w/1.25,
                      child:  Text(
                        " You can able to add at maximum of 8 images. Image should be clear and dust free.",
                        style: TextStyle(
                          color: Color(0xff666161),
                          fontSize: w/26,
                        ),
                      ),
                    )

                  ],
                ),SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u2022",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: w/20,
                      ),
                    ),

                    Container(
                      width: w/1.3,
                      child:  Row(
                        children: [
                          Text(
                            " Image Resolution: ",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w/29,
                            ),
                          ), Text(
                            "image resolution is 500X500",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: w/29,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Catalogues",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.string(SellerSvg().validationIcon)
              ],
            ),
            Text(
              "Add Maximum 8 catelogues",
              style: TextStyle(
                color: Color(0xff666161),
                fontSize: 14,
              ),
            )
          ],
        ),

        const SizedBox(
          height: 5,
        ),
        DottedBorder(
            color: const Color(0xffcbced0),
            strokeWidth: 1,
            strokeCap: StrokeCap.butt,
            radius: const Radius.circular(5),
            dashPattern: [7],
            child: Container(
              width: w,
              height: 114,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Color(0xfff7f7f7),
              ),
              alignment: Alignment.center,
              child: SvgPicture.string(ProductSvg().camIcon),
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
