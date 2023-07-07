import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_widgets/custom_checkbox.dart';
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

class CreateSegmentScreen extends StatefulWidget {
  final bool? edit;
  const CreateSegmentScreen({Key? key, this.edit}) : super(key: key);

  @override
  State<CreateSegmentScreen> createState() => _CreateSegmentScreenState();
}

class _CreateSegmentScreenState extends State<CreateSegmentScreen> {
  refresh(){
    setState(() {

    });
  }
  bool isActive = true;
  bool isMixed = false;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;
  TextEditingController nameController=TextEditingController();
  TextEditingController altNameController=TextEditingController();
  TextEditingController searchNameController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController priorityController=TextEditingController();
  DivisionConfigRead? modelData;
  String? uomSelect;
  String? catSelect;
  String? groupSelect;
  List<String> uomCodeList=[];
  List<String> groupCodeList=[];
  List<String> categoryCodeList=[];
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
            if (state is CreateDivisionConfigurationLoading) {
              showSnackBar(context,
                  message: "Division Configuration Creation Loading",
                  color: ColorPalette.green);
            } else if (state is CreateDivisionConfigurationSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetDivisionConfigurationListEvent('','',''));
              Navigator.pop(context);
            } else if (state is CreateDivisionConfigurationFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is DivisionConfigurationReadLoading) {

            } else if (state is DivisionConfigurationReadSuccess) {

              modelData=state.divisionModel;
              print("mod$modelData");
              nameController.text=modelData?.name??"";
              discriptionController.text=modelData?.description??"";
              priorityController.text=modelData?.priority?.toString()??"";
              groupCodeList=modelData?.configurationMete?.includeData?.group??[];
              uomCodeList=modelData?.configurationMete?.includeData?.uomData??[];
              categoryCodeList=modelData?.configurationMete?.includeData?.category??[];
              imageId=modelData?.image??"";
              isActive=modelData?.isActive??false;
              isMixed=modelData?.isMixed??false;

              if(uomCodeList.isNotEmpty){
                uomSelect="Uom Selected";
              }
              if(groupCodeList.isNotEmpty){
                groupSelect="Group Selected";
              }
              if(categoryCodeList.isNotEmpty){
                catSelect="Category Selected";
              }
              setState(() {

              });

            } else if (state is DivisionConfigurationReadFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is DivisionConfigurationUpdateLoading) {
              showSnackBar(context,
                  message: "Division Configuration Updation Loading",
                  color: ColorPalette.green);
            } else if (state is DivisionConfigurationUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetDivisionConfigurationListEvent('','',''));
              Navigator.pop(context);
            } else if (state is DivisionConfigurationUpdateFailed) {
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
            label: widget.edit==true?"Update Segment":"Create Segment", isAction: false,
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
                  TextFormReusable(
                    label: "Description",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: discriptionController,
                  ),
                  SizedBox(height: 5,),
                  FileUploadCard(
                    label: imageId == null
                        ? "No file chosen"
                        : imageFileName??imageId,
                    onTap: () {
                      getCoverImage(
                          ImageSource.gallery);
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Priority",
                    hint: "Eg. 10",
                    numField: true,
                    controller: priorityController,
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: uomSelect,

                    label: "Uom Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetUomListSegmentEvent("",'',''));
                      _showModalBottomSheetUom();
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: catSelect,

                    label: "Category Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetCategoryListSegmentEvent("",'',''));
                      _showModalBottomSheetCategory();
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: groupSelect,

                    label: "Group Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetGroupListSegmentEvent("",'',''));
                      _showModalBottomSheetGroup();
                    },
                  ),
                  SizedBox(height: 5,),

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
                          "Is Mixed",
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
                              isMixed=!isMixed;
                            });
                          },
                          child: isMixed
                              ? SvgPicture.string(HomeSvg().toggleActive)
                              : SvgPicture.string(HomeSvg().toggleInActive),
                        ),
                      ],
                    ),
                  ),
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
                          "Is Active",
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

                        context.read<InventoryBloc>().add(UpdateDivisionConfigurationEvent(
                            id: modelData?.id??0,
                            isActive: isActive,
                            image: imageId,
                            name: nameController.text,
                            description: discriptionController.text,
                            uomGroup: uomCodeList,
                            isMixed: isMixed,
                            grroup: groupCodeList,
                            categoey: categoryCodeList,
                            priority: int.tryParse(priorityController.text)??0,


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

                        context.read<InventoryBloc>().add(DivisionConfigurationCreateEvent(
                            image: imageId,
                            name: nameController.text,
                            description: discriptionController.text,
                            uomGroup: uomCodeList,
                          isMixed: isMixed,
                          grroup: groupCodeList,
                          categoey: categoryCodeList,
                          priority: int.tryParse(priorityController.text)??0,
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
  _showModalBottomSheetGroup() {

    String nextUrl="";
    String prevUrl="";
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

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
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Group",
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
                          hint: "Search Group...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetGroupListSegmentEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          if (state is GroupListSegmentLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GroupListSegmentSuccess) {
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        CustomCheckBox(
                                          key: UniqueKey(),
                                          value:
                                          // false,
                                          groupCodeList
                                              .contains(state.inventory?[index].code),
                                          onChange: (p0) {
                                            if (p0) {
                                              groupCodeList.add(
                                                  state.inventory?[index].code ?? "");
                                            } else {

                                              groupCodeList.remove(
                                                  state.inventory?[index].code ?? "");
                                            }

                                            if(groupCodeList.isNotEmpty){
                                              groupSelect="Group Selected";
                                            }
                                            print("list is group$groupCodeList");
                                          },

                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                           state.inventory?[index].code??"",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    separatorBuilder: (context, index) => Container(
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
                                            context.read<InventoryBloc>().add( GetGroupListSegmentEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetGroupListSegmentEvent('',nextUrl,''));
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
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        // groupSelect="Group Selected";
                                        refresh();
                                        Navigator.pop(context);
                                      },
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            ColorPalette.primary,
                                            ColorPalette.primary
                                          ]),
                                      child: Text(
                                        "Select and Continue",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            );}
                          return Container();
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

  _showModalBottomSheetUom() {

    String nextUrl="";
    String prevUrl="";
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

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
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Uom",
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
                          hint: "Search Uom...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetUomListSegmentEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          if (state is UomListSegmentLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is UomListSegmentSuccess) {

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
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        CustomCheckBox(
                                          key: UniqueKey(),
                                          value:
                                          // false,
                                          uomCodeList
                                              .contains(state.inventory?[index].uomCode),
                                          onChange: (p0) {
                                            if (p0) {
                                              uomCodeList.add(
                                                  state.inventory?[index].uomCode ?? "");
                                            } else {

                                              uomCodeList.remove(
                                                  state.inventory?[index].uomCode ?? "");
                                            }
                                            print("List uom $uomCodeList");
                                            if(uomCodeList.isNotEmpty){
                                              uomSelect="Uom Selected";
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          state.inventory?[index].uomCode??"",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    separatorBuilder: (context, index) => Container(
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
                                            context.read<InventoryBloc>().add( GetUomListSegmentEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetUomListSegmentEvent('',nextUrl,''));
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
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {

                                        refresh();
                                        Navigator.pop(context);
                                      },
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            ColorPalette.primary,
                                            ColorPalette.primary
                                          ]),
                                      child: Text(
                                        "Select and Continue",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            );}
                          return Container();
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

  _showModalBottomSheetCategory() {

    String nextUrl="";
    String prevUrl="";
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

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
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Category",
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
                          hint: "Search Category...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetCategoryListSegmentEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          if (state is CategoryListSegmentLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is CategoryListSegmentSuccess) {

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
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        CustomCheckBox(
                                          key: UniqueKey(),
                                          value:
                                          // false,
                                          categoryCodeList
                                              .contains(state.inventory?[index].code),
                                          onChange: (p0) {
                                            if (p0) {
                                              categoryCodeList.add(
                                                  state.inventory?[index].code ?? "");
                                            } else {
                                              categoryCodeList.remove(
                                                  state.inventory?[index].code ?? "");
                                            }
                                            if(categoryCodeList.isNotEmpty){
                                              catSelect="Category Selected";
                                            }
                                            print("list Cate$categoryCodeList");
                                          },

                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          state.inventory?[index].code??"",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    separatorBuilder: (context, index) => Container(
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
                                            context.read<InventoryBloc>().add( GetCategoryListSegmentEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetCategoryListSegmentEvent('',nextUrl,''));
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
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        // catSelect="Category Selected";

                                        refresh();
                                        Navigator.pop(context);
                                      },
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            ColorPalette.primary,
                                            ColorPalette.primary
                                          ]),
                                      child: Text(
                                        "Select and Continue",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            );}
                          return Container();
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
