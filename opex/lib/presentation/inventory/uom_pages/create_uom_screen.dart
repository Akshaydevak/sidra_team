import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../../promotion_app/dropdown_card.dart';
import '../../promotion_app/widget/file_upload_card.dart';
import '../bloc/inventory_bloc.dart';
import '../model/division_model.dart';

class CreateUomScreen extends StatefulWidget {
  final bool? edit;
  const CreateUomScreen({Key? key, this.edit}) : super(key: key);

  @override
  State<CreateUomScreen> createState() => _CreateUomScreenState();
}

class _CreateUomScreenState extends State<CreateUomScreen> {
  bool isActive = true;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;
  TextEditingController nameController=TextEditingController();
  TextEditingController conversionFactorController=TextEditingController();
  TextEditingController standerdCodeController=TextEditingController();
  TextEditingController shortNameController=TextEditingController();
  TextEditingController baseEquvalantController=TextEditingController();
  DivisionModels? modelData;
  String? divisionCode;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is PicLoading) {

            }
            if (state is PicSuccess) {
              print("pIC IS ID${state.data}");

              imageId = state.data;
              imgUrl=state.url;

              print("pIC IS ID$imageId");
              setState(() {

              });
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is CreateUomLoading) {
              showSnackBar(context,
                  message: "Uom Creation Loading",
                  color: ColorPalette.green);
            } else if (state is CreateUomSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              Navigator.pop(context);
            } else if (state is CreateUomFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is UomReadLoading) {

            } else if (state is UomReadSuccess) {

              modelData=state.divisionModel;
              print("mod$modelData");
              nameController.text=modelData?.name??"";
              divisionCode=modelData?.uomGroupCode??"";
              conversionFactorController.text=modelData?.conversionFactor.toString()??"";
              standerdCodeController.text=modelData?.statnderdCode??"";
              shortNameController.text=modelData?.shortName??"";
              baseEquvalantController.text=modelData?.baseEquvalat??"";
              isActive=modelData?.isActive??false;

              setState(() {

              });
            } else if (state is UomReadFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is UomUpdateLoading) {
              showSnackBar(context,
                  message: "Uom Updation Loading",
                  color: ColorPalette.green);
            } else if (state is UomUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              Navigator.pop(context);
            } else if (state is UomUpdateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: widget.edit==true?"Update Uom":"Create Uom", isAction: false,
            // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
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
                  TextFormReusable(
                    label: "Name",
                    hint: "Eg. SEM",
                    controller: nameController,
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: divisionCode,

                    label: "Uom Group Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetUomGroupListEvent("",'',''));
                      _showModalBottomSheetOfferPeriod(divisionCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Conversion Factor",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: conversionFactorController,
                    floatVal: true,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Standard Code",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: standerdCodeController,
                  ),   SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Short Name",
                    hint: "Eg. sdasfsa",
                    controller: shortNameController,
                  ),

                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Base Equivalent",
                    hint: "Eg. sdasfsa",
                    controller: baseEquvalantController,
                  ),

                  // Text(
                  //   "Image",
                  //   style: GoogleFonts.roboto(
                  //     color: Colors.black,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: 88,
                  //   height: 103,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Color(0x05000000),
                  //         blurRadius: 8,
                  //         offset: Offset(1, 1),
                  //       ),
                  //     ],
                  //     color: Color(0xfff7f7f7),
                  //   ),
                  //   child: imgUrl==""?GestureDetector(
                  //     onTap: (){
                  //       getCoverImage(
                  //           ImageSource.gallery);
                  //     },
                  //       child: Icon(Icons.add)):
                  //   Image.network(imgUrl),
                  // ),
                  SizedBox(height: 16,),
                  Container(
                    width: w,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Is_Active",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              // isActive=!isActive;
                            });
                          },
                          child: isActive
                              ? SvgPicture.string(HomeSvg().toggleActive)
                              : SvgPicture.string(HomeSvg().toggleInActive),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  widget.edit==true?GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );

                        context.read<InventoryBloc>().add(UpdateUomEvent(
                            id: modelData?.id??0,
                            isActive: isActive,
                            name: nameController.text,
                            shortName: shortNameController.text,
                            baseEquvalant: baseEquvalantController.text,
                            convertionFactor: double.tryParse(conversionFactorController.text)??0,
                            statnderdCode: standerdCodeController.text,
                            uomGroupCode: divisionCode??"",


                        ));
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )):GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );

                        context.read<InventoryBloc>().add(UomCreateEvent(
                            name: nameController.text,
                            shortName: shortNameController.text,
                          baseEquvalant: baseEquvalantController.text,
                          convertionFactor: double.tryParse(conversionFactorController.text)??0,
                          statnderdCode: standerdCodeController.text,
                          uomGroupCode: divisionCode??""

                        ));
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Create",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> getCoverImage(source) async {
    try {
      final pickedFile = await picker.pickImage(
          source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<DiscountBloc>(context)
        //     .add(PostImageDiscountEvent(cropImage!));
        BlocProvider.of<InventoryBloc>(context).add(PicEvent(image: cropImage!));
        imageFileName=cropImage?.path.split("_")[1];
        print("cropppp$imageFileName");
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
    int selectIndex = 0;
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }
    String nextUrl="";
    String prevUrl="";

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Select Uom Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: SearchCard(
                          hint: "Search Uom Group...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetUomGroupListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetUomGroupListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetUomGroupListSuccess) {

                            nextUrl=state.nextPageUrl??"";
                            prevUrl=state.prevPageUrl??"";
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: state.inventory!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            setState(() {});
                                            // offerperiodId = state.offerPeriod
                                            //     .data[index].id ??
                                            //     0;
                                            divisionCode = state.inventory?[index].code ??
                                                "";
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              GestureDetector(

                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 8,
                                                      bottom: 10,
                                                      top: 5,
                                                      right: 8),
                                                  child: SvgPicture.string(state
                                                      .inventory?[index]
                                                      .code ==
                                                      offerPeriodNameNew
                                                  // selectIndex == index
                                                      ? HomeSvg().radioButtonActive
                                                      : HomeSvg().radioInActive),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.inventory?[index].name ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          color: ColorPalette.divider,
                                          height: 1,
                                          width: w,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 15,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        prevUrl!=""?GestureDetector(
                                          onTap: (){
                                            context.read<InventoryBloc>().add( GetUomGroupListEvent("",'',prevUrl));
                                            // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                          },
                                          child: Text(
                                            "Previous",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        ):Container(),
                                        nextUrl!=""?
                                        GestureDetector(
                                          onTap: (){
                                            // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                            setState(() {
                                              context.read<InventoryBloc>().add( GetUomGroupListEvent('',nextUrl,''));
                                            });
                                          },
                                          child: Text("Next",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),),
                                        ):Text("")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }  return Container(
                              height: 200,
                              width: w,
                              alignment: Alignment.center,
                              child: LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.red,
                                size: 30,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
