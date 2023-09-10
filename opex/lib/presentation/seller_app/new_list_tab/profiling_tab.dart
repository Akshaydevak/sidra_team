import 'dart:io';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../seller_svg.dart';

class ProfilingTab extends StatefulWidget {

   ProfilingTab({Key? key}) : super(key: key);

  @override
  State<ProfilingTab> createState() => _ProfilingTabState();
}

class _ProfilingTabState extends State<ProfilingTab> {
  final picker = ImagePicker();

  File? cropImage;
int indexImage=0;
int catindexImage=0;
  bool _cropped = false;
  bool isCatalogue=false;
List<PicModel> picModel=[];
List<PicModel> catalogueList=[];
@override
  void initState() {
   for(int i=0;i<5;i++) {
     picModel.add(PicModel(data: null,url: ""));
   }
   for(int j=0;j<8;j++) {
     catalogueList.add(PicModel(data: null,url: ""));
   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<InventoryBloc,InventoryState>(
      listener: (context, state) {
        if(state is PicLoading){
          print("Inside Loading");
        }
        if(state is PicSuccess){
          print("Inside Success${state.data}\t${state.url}");
          setState(() {
            isCatalogue? catalogueList.replaceRange(indexImage, indexImage+1, [PicModel(data: state.data,url: state.url)]):picModel.replaceRange(indexImage, indexImage+1, [PicModel(data: state.data,url: state.url)]);
          });
          print("pic model length${picModel[0].data}");

        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Images",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 24,
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

          SizedBox(height: 5,),
          Container(

              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1.5 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, i) {
                    print("eeeeeeeeeeeee  ${picModel[i].url}");
                    return GestureDetector(
                      onTap: (){
                        isCatalogue=false;
                        indexImage=i;
                        setState(() {

                        });
                        getImage(ImageSource.gallery);
                      },
                        // getImage(ImageSource.gallery);
                      // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                      child:picModel[i].url!=""&&picModel[i].url!.isNotEmpty?Container(
                        width: 88,
                        height: 100,
                        decoration:BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(picModel[i].url.toString()),fit: BoxFit.fill
                            )
                        )
                      ):Container(
                        width: 88,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.add,color:Color(0x7f666161))
                      ),
                    );
                  })),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Catalogues",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.string(SellerSvg().validationIcon,height: 15,)
            ],
          ),
          const SizedBox(
            height: 8,
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
                    print("eeeeeeeeeeeee${catalogueList[i].url}");
                    return GestureDetector(
                      onTap: (){
                        isCatalogue=true;
                        indexImage=i;
                        setState((){});
                        getImage(ImageSource.gallery);
                      },
                      // getImage(ImageSource.gallery);
                      // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                      child:catalogueList[i].url!=""&&catalogueList[i].url!.isNotEmpty?Container(
                          width: 88,
                          height: 100,
                          decoration:BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(catalogueList[i].url.toString()),fit: BoxFit.fill
                              )
                          ),
                      ):Container(
                          width: 88,
                          height: 100,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.add,color:Color(0x7f666161))
                      ),
                    );
                  })),
          // GestureDetector(
          //   onTap: (){
          //     // getImage(ImageSource.gallery);
          //   },
          //   child: DottedBorder(
          //     color: const Color(0xffcbced0),
          //
          //     strokeWidth: 1,
          //     strokeCap: StrokeCap.butt,
          //     radius:const Radius.circular(5),
          //
          //     dashPattern: [7],
          //
          //     child:
          //
          //   Container(
          //     width: w,
          //     height: 114,
          //     decoration: const BoxDecoration(
          //       boxShadow: [
          //         BoxShadow(
          //           color: Color(0x05000000),
          //           blurRadius: 8,
          //           offset: Offset(1, 1),
          //         ),
          //       ],
          //       color: Color(0xfff7f7f7),
          //     ),
          //   )),
          // ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Future<void> getImage(source) async {
    try {
      final pickedFile =
      await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        BlocProvider.of<InventoryBloc>(context).add(PicEvent(image: cropImage!));
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
class PicModel{
  final int? data;
  final String? url;
  PicModel({
    this.data,this.url});
}
