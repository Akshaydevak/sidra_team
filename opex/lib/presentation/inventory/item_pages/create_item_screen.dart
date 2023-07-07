import 'dart:io';

import 'package:cluster/core/utils/variables.dart';
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
import '../inventory_new_list.dart';
import '../model/division_model.dart';
import '../new_list_tab/profiling_tab.dart';

class CreateItemScreen extends StatefulWidget {
  final bool? edit;
  const CreateItemScreen({Key? key, this.edit}) : super(key: key);

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  bool isActive = true;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;
  TextEditingController nameController=TextEditingController();
  TextEditingController displayNameController=TextEditingController();
  TextEditingController barcodeController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController oldSystemCodeController=TextEditingController();
  TextEditingController searchNameController=TextEditingController();
  ItemReadModel? modelData;
  String? materialCode;
  String? uomGroupCode;
  String? uomCode;
  String? groupCode;
  String? brandCode;
  String? staticGriupCode;
  String? variantFrameworkCode;

  int indexImage=0;
  int catindexImage=0;
  bool isCatalogue=false;
  @override
  void initState() {
    catalogueList.clear();
    picModel.clear();
    for(int i=0;i<3;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    for(int j=0;j<5;j++) {
      catalogueList.add(PicModel(data: null,url: ""));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if(state is PicLoading){
              print("Inside Loading");
            }
            if(state is PicSuccess){
              print("Inside Success${state.data}\t${state.url}");
              setState(() {
                isCatalogue? catalogueList.replaceRange(indexImage, indexImage+1,
                    [PicModel(data: state.data,url: state.url)]):picModel.replaceRange(indexImage, indexImage+1,
                    [PicModel(data: state.data,url: state.url)]);
              });
              print("pic model length${picModel.length}");

            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is CreateItemLoading) {
              showSnackBar(context,
                  message: "Item Creation Loading",
                  color: ColorPalette.green);
            } else if (state is CreateItemSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetItemListEvent('','',''));
              Navigator.pop(context);
            } else if (state is CreateItemFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is ItemReadLoading) {

            } else if (state is ItemReadSuccess) {

              modelData=state.divisionModel;
              print("mod$modelData");
              nameController.text=modelData?.name??"";
              searchNameController.text=modelData?.searchName??"";
              materialCode=modelData?.materialDataModel?.materialCode??"";
              uomGroupCode=modelData?.uomGroupDataModel?.uomGroupCode??"";
              uomCode=modelData?.uomDataModel?.uomCode??"";
              groupCode=modelData?.groupDataModel?.groupCode??"";
              brandCode=modelData?.brandDataModel?.brandCode??"";
              staticGriupCode=modelData?.staticGroupDataModel?.staticGroupCode??'';
              variantFrameworkCode=modelData?.varientFrameworkDataModel?.variantFrameCode??"";
              displayNameController.text=modelData?.displayName??"";
              barcodeController.text=modelData?.barcodeDataModel?.barcodeNumber??"";
              discriptionController.text=modelData?.itemMeteDataModel?.description??"";
              oldSystemCodeController.text=modelData?.itemMeteDataModel?.oldSystemCode??"";
              isActive=modelData?.isActive??false;

              catalogueList.setAll(0, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.cat1 ??
                        "")
              ]);
              catalogueList.setAll(1, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.cat2 ??
                        "")
              ]);
              catalogueList.setAll(2, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.cat3 ??
                        "")
              ]);
              catalogueList.setAll(3, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.cat4 ??
                        "")
              ]);
              catalogueList.setAll(4, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.cat5 ??
                        "")
              ]);
              picModel.setAll(0, [
                PicModel(
                    url: modelData?.img1 ??
                        "")
              ]);
              picModel.setAll(1, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.img2 ??
                        "")
              ]);
              picModel.setAll(2, [
                PicModel(
                    url: modelData?.itemMeteDataModel?.img3 ??
                        "")
              ]);
              print("iiiiiii${modelData?.itemMeteDataModel?.cat1}");
              print("iiiiiii${modelData?.itemMeteDataModel?.img2}");
              print("pic model length${picModel.length}");
              setState(() {

              });

            } else if (state is ItemReadFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is ItemUpdateLoading) {
              showSnackBar(context,
                  message: "Item Updation Loading",
                  color: ColorPalette.green);
            } else if (state is ItemUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetItemListEvent('','',''));
              Navigator.pop(context);
            } else if (state is ItemUpdateFailed) {
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
            label: widget.edit==true?"Update Item":"Create Item",
            isAction: false,
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
                    selValue: materialCode,

                    label: "Material Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetMaterialListEvent("",'',''));
                      _showModalBottomSheetMaterialCode(materialCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: uomGroupCode,

                    label: "Uom Group Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetUomGroupListEvent("",'',''));
                      _showModalBottomUomGroupCode(uomGroupCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: uomCode,

                    label: "Uom Code",
                    onTap: () {
                      print("GROUP ID${Variable.uomGroupId}");
                      context.read<InventoryBloc>().add( GetUomByUomGroupEvent("",Variable.uomGroupId,'',''));
                      _showModalBottomSheetUomCode(uomCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: groupCode,

                    label: "Group Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetGroupListEvent("",'',''));
                      _showModalBottomSheetGroupCode(groupCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: brandCode,

                    label: "Brand Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetBrandListEvent("",'',''));
                      _showModalBottomSheetBrandCode(brandCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: staticGriupCode,

                    label: "Static Group Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetStaticGroupListEvent("",'',''));
                      _showModalBottomSheetStaticGroupCode(staticGriupCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  DropDownCard(
                    selValue: variantFrameworkCode,

                    label: "Variant Framework Code",
                    onTap: () {
                      context.read<InventoryBloc>().add( GetVarientFrameworkListEvent("",'',''));
                      _showModalBottomSheetVariantFrameworkCode(variantFrameworkCode);
                    },
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Display Name",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: displayNameController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Barcode",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: barcodeController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Description",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: discriptionController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Old System Code",
                    hint: "Eg. 10",
                    controller: oldSystemCodeController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Search Name",
                    hint: "Eg. 10",
                    controller: searchNameController,
                  ),
                  SizedBox(height: 5,),

                  Text(
                    "Item Catalog",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                            // print("eeeeeeeeeeeee${catalogueList[i].url}");
                            return GestureDetector(
                              onTap: (){
                                isCatalogue=true;
                                indexImage=i;
                                setState((){});
                                getCoverImage(ImageSource.gallery);
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Images",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(

                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              childAspectRatio: 1.5 / 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 8),
                          itemBuilder: (context, i) {
                            // print("eeeeeeeeeeeee  ${picModel[i].url}");
                            return GestureDetector(
                              onTap: (){
                                isCatalogue=false;
                                indexImage=i;
                                setState(() {

                                });
                                getCoverImage(ImageSource.gallery);
                              },
                              // getImage(ImageSource.gallery);
                              // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                              child:
                              picModel[i].url!=""&&picModel[i].url!.isNotEmpty?
                              Container(
                                  width: 88,
                                  height: 100,
                                  decoration:BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(picModel[i].url.toString()),fit: BoxFit.fill
                                      )
                                  )
                              )
                                    :
                                Container(
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

                        context.read<InventoryBloc>().add(UpdateItemEvent(
                            id: modelData?.id??0,
                            isActive: isActive,
                            name: nameController.text,
                            description: discriptionController.text,
                            variantFrameworkCode: variantFrameworkCode??"",
                            uomgroupCode: uomGroupCode??"",
                            uomCode: uomCode??"",
                            staticGroupCode: staticGriupCode??"",
                            oldSystemCode: oldSystemCodeController.text,
                            materialCode: materialCode??"",
                            itemCatalog5: catalogueList[4].data??catalogueList[4].url,
                            itemCatalog4: catalogueList[3].data??catalogueList[3].url,
                            itemCatalog3: catalogueList[2].data??catalogueList[2].url,
                            itemCatalog2: catalogueList[1].data??catalogueList[1].url,
                            itemCatalog1: catalogueList[0].data??catalogueList[0].url,
                            img3: picModel[2].data??picModel[2].url,
                            img2: picModel[1].data??picModel[1].url,
                            img1: picModel[0].data??picModel[0].url,
                            groupCode: groupCode??"",
                            brandCode: brandCode??"",
                            barcode: barcodeController.text,
                            displayName: displayNameController.text,
                            searchName: searchNameController.text


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

                        context.read<InventoryBloc>().add(ItemCreateEvent(

                            name: nameController.text,
                            description: discriptionController.text,
                            variantFrameworkCode: variantFrameworkCode??"",
                          uomgroupCode: uomGroupCode??"",
                          uomCode: uomCode??"",
                          staticGroupCode: staticGriupCode??"",
                          oldSystemCode: oldSystemCodeController.text,
                          materialCode: materialCode??"",
                          itemCatalog5: catalogueList[4].data??null,
                          itemCatalog4: catalogueList[3].data??null,
                          itemCatalog3: catalogueList[2].data??null,
                          itemCatalog2: catalogueList[1].data??null,
                          itemCatalog1: catalogueList[0].data??null,
                          img3: picModel[2].data??null,
                          img2: picModel[1].data??null,
                          img1: picModel[0].data??null,
                          groupCode: groupCode??"",
                          brandCode: brandCode??"",
                          barcode: barcodeController.text,
                          displayName: displayNameController.text,
                          searchName: searchNameController.text


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
  _showModalBottomSheetMaterialCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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
                        "Select Material",
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
                          hint: "Search Material...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetMaterialListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetMaterialListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetMaterialListSuccess) {
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
                                            materialCode = state.inventory?[index].code ??
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
                                            context.read<InventoryBloc>().add( GetMaterialListEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetMaterialListEvent('',nextUrl,''));
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
                          }
                         return Container(
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

  _showModalBottomUomGroupCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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
                          hint: "Search Material...",
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
                                            Variable.uomGroupId=state.inventory?[index].id??0;
                                            uomGroupCode = state.inventory?[index].code ??
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
                          }
                          return Container(
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

  _showModalBottomSheetUomCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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


                              context.read<InventoryBloc>().add( GetUomByUomGroupEvent(ff,Variable.uomGroupId,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetUomByUomGroupListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetUomByUomGroupListSuccess) {
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
                                            uomCode = state.inventory?[index].uomCode ??
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
                                                      .uomCode ==
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
                                            context.read<InventoryBloc>().add( GetUomByUomGroupEvent("",Variable.uomGroupId,'',prevUrl));
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
                                             setState(() {
                                              context.read<InventoryBloc>().add( GetUomByUomGroupEvent('',Variable.uomGroupId,nextUrl,''));
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
                          }
                          return Container(
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

  _showModalBottomSheetGroupCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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


                              context.read<InventoryBloc>().add( GetGroupListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetGroupListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetGroupListSuccess) {
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
                                            groupCode = state.inventory?[index].code ??
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
                                            context.read<InventoryBloc>().add( GetGroupListEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetGroupListEvent('',nextUrl,''));
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
                          }
                          return Container(
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

  _showModalBottomSheetBrandCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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
                        "Select Brand",
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
                          hint: "Search Brand...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetBrandListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetBrandListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetBrandListSuccess) {
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
                                            brandCode = state.inventory?[index].code ??
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
                                            context.read<InventoryBloc>().add( GetBrandListEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetBrandListEvent('',nextUrl,''));
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
                          }
                          return Container(
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

  _showModalBottomSheetStaticGroupCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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
                        "Select Static Group",
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
                          hint: "Search Static Group...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetStaticGroupListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetStaticGroupListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetStaticGroupListSuccess) {
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
                                            staticGriupCode = state.inventory?[index].code ??
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
                                            context.read<InventoryBloc>().add( GetStaticGroupListEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetStaticGroupListEvent('',nextUrl,''));
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
                          }
                          return Container(
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

  _showModalBottomSheetVariantFrameworkCode(String? offerPeriodNameNew) {
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
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
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
                        "Select Variant Framework",
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
                          hint: "Search Variant Framework...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetVarientFrameworkListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetVarientFrameWorkListLoading) {
                            return Container(
                                height: 200,
                                width: w,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: Colors.red,
                                  size: 30,
                                ));
                          }
                          if (state is GetVarientFrameWorkListSuccess) {
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
                                            variantFrameworkCode = state.inventory?[index].code ??
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
                                            context.read<InventoryBloc>().add( GetVarientFrameworkListEvent("",'',prevUrl));
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
                                              context.read<InventoryBloc>().add( GetVarientFrameworkListEvent('',nextUrl,''));
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
                          }
                          return Container(
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
