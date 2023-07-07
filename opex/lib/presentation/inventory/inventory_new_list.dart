import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/title_app_bar.dart';
import '../../core/color_palatte.dart';

import '../seller_app/continue_btn.dart';
import '../seller_app/item_submit_screen.dart';
import 'model/inventory_model.dart';
import 'new_list_tab/general_tab.dart';
import 'new_list_tab/other_tab.dart';
import 'new_list_tab/profiling_tab.dart';
import 'new_list_tab/segmant_flow_card.dart';
import 'new_list_tab/variations_tab.dart';

List<PicModel> picModel = [];
List<PicModel> catalogueList = [];
List<VarintValue> variantValues = [];
List<NameCreate> value = [];

class InventoryAddNewList extends StatefulWidget {
  final BaseUomData? variantModel;
  final String? division, category, subCategory, group, item, uom;
  final int? uomId, itemId, varientId;

  const InventoryAddNewList(
      {Key? key,
      this.variantModel,
      this.division,
      this.category,
      this.subCategory,
      this.group,
      this.item,
      this.uom,
      this.uomId,
      this.itemId,
      this.varientId})
      : super(key: key);

  @override
  State<InventoryAddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<InventoryAddNewList>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int i = 0;
  bool isOther = false;
  TextEditingController varientNameController = TextEditingController();
  TextEditingController searchNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController arabicDescription = TextEditingController();
  TextEditingController additionalDescription = TextEditingController();
  TextEditingController posName = TextEditingController();
  TextEditingController oldSystemController = TextEditingController();
  TextEditingController identificationController = TextEditingController();
  TextEditingController producedCountry = TextEditingController();
  TextEditingController barCode = TextEditingController();
  TextEditingController returnTime = TextEditingController();
  TextEditingController rePlacementTime = TextEditingController();
  TextEditingController shelfTime = TextEditingController();
  TextEditingController variantHeight = TextEditingController();
  TextEditingController variantWeight = TextEditingController();
  TextEditingController variantWidth = TextEditingController();
  TextEditingController variantLength = TextEditingController();
  TextEditingController grossWeight = TextEditingController();
  TextEditingController netWeight = TextEditingController();
  TextEditingController unitCost = TextEditingController();
  TextEditingController actualCost = TextEditingController();
  TextEditingController minimumSales = TextEditingController();
  TextEditingController maximumSales = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController excessTax = TextEditingController();
  TextEditingController minimumGp = TextEditingController();
  TextEditingController maximumGp = TextEditingController();
  TextEditingController averageGp = TextEditingController();
  TextEditingController targetGp = TextEditingController();
  TextEditingController videoUrl = TextEditingController();
  TextEditingController ethnicController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController headController = TextEditingController();
  TextEditingController storageController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController usageDirectionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController additionalHeadController = TextEditingController();
  List<TextEditingController> additionalKeyController = [];
  List<TextEditingController> additionalValueController = [];
  TextEditingController impHeadController = TextEditingController();
  List<TextEditingController> impKeyController = [];
  List<TextEditingController> impValueController = [];
  TextEditingController nutriHeadController = TextEditingController();
  List<TextEditingController> nutriKeyController = [];
  List<TextEditingController> nutriValueController = [];
  TextEditingController productDetailsHeadController = TextEditingController();
  List<TextEditingController> productDetailsKeyController = [];
  List<TextEditingController> productDetailsValueController = [];
  TextEditingController specificationHeadController = TextEditingController();
  List<TextEditingController> specificationKeyController = [];
  List<TextEditingController> specificationValueController = [];
  TextEditingController productFeatureHeadController = TextEditingController();
  List<TextEditingController> productFeatureKeyController = [];
  List<TextEditingController> productFeatureValueController = [];
  List<TextEditingController> storageNameController = [];

  List<TextEditingController> ingredientsNameController = [];

  List<TextEditingController> usageDirectionNameController = [];

  List<TextEditingController> aboutNameController = [];

  List<SubClassBehaviour>? productBehaviour;
  ProductDetails? storageData;
  List<NameCreate>? storageNameData = [];
  ProductDetails? ingredientsData;
  List<NameCreate>? ingredientsNameData = [];
  ProductDetails? usageDirectionData;
  List<NameCreate>? usageDirectionNameData = [];
  ProductDetails? aboutData;
  List<NameCreate>? aboutNameData = [];

  Abouttheproducts? additionalInfoDataName;
  List<KeyValues>? additionalInfoData = [];
  Abouttheproducts? productDetailsDataName;
  List<KeyValues>? productDetailsData = [];
  Abouttheproducts? nutriDataName;
  List<KeyValues>? nutriData = [];
  Abouttheproducts? impInfoDataName;
  List<KeyValues>? impInfoData = [];
  Abouttheproducts? specificationDataName;
  List<KeyValues>? specificationData = [];
  Abouttheproducts? productFeatureDataName;
  List<KeyValues>? productFeatureData=[];
  bool? isGift;
  bool? isSales;
  bool? isWrap;

  // void onChangeBaseUom(String? val) {
  //   print("selected base $val");
  //   base = val ?? "";
  //   setState(() {});
  // }

  void onChangeSalesUom(String? val, int? id) {
    print("selected sales $val \n selected id $id");
    sales = val ?? "";
    salesId = id ?? 0;
    setState(() {});
  }

  void onChangeSibling(String? val, int? id) {
    print("selected sibling $val \n selected id $id");
    sibling = val ?? "";
    siblingId = id ?? 0;
    setState(() {});
  }

  void onChangeRefund(String? val) {
    print("selected refund $val ");
    replacementType = val ?? "";
    setState(() {});
  }

  void onChangeReturn(String? val) {
    print("selected return $val ");
    returnType = val ?? "";
    setState(() {});
  }

  void onChangeShelf(String? val) {
    print("selected return $val ");
    shelfType = val ?? "";
    setState(() {});
  }

  void onChangeGift(bool? val) {
    print("selected sibling $val");
    isGift = val ?? false;
    print("selected gift $isGift");
    setState(() {});
  }
void onChangeSales(bool? val) {
    print("selected sibling $val");
    isSales = val ?? false;
    print("selected sales $isSales");
    setState(() {});
  }

  void onChangeWrap(bool? val) {
    print("selected Wrap $val");
    isWrap = val ?? false;
    setState(() {});
  }

  void onChangeManufacture(String? val, int? id) {
    print("selected manufacture $val \n selected id $id");
    manufacture = val ?? "";
    manufactureId = id ?? 0;
    setState(() {});
  }

  void onChangeChannel(String? val, int? id) {
    print("selected Channel $val\n$id");
    channel = val ?? "";
    channelId = id ?? 0;
    setState(() {});
  }

  String? base;
  String? sales;
  int? salesId;
  String? sibling;
  int? siblingId;
  String? replacementType;
  String? returnType;
  String? shelfType;
  String? manufacture;
  int? manufactureId;
  String? channel;
  int? channelId;
  FocusNode currentFocus = FocusNode();

  @override
  void initState() {
    print("inside tab screen${widget.variantModel?.uomId}");
    headController = TextEditingController(text: "behaviour");
    storageController = TextEditingController(text: "storage");
    ingredientsController = TextEditingController(text: "Ingredients");
    usageDirectionController = TextEditingController(text: "Usage Direction");
    aboutController = TextEditingController(text: "About Products");
    additionalHeadController = TextEditingController(text: "Additional Information");
    impHeadController = TextEditingController(text: "Important Info");
    productDetailsHeadController =
        TextEditingController(text: "Product Details");
    nutriHeadController = TextEditingController(text: "Nutrial Facts");
    specificationHeadController = TextEditingController(text: "Specifications");
    productFeatureHeadController =
        TextEditingController(text: "Product Features");
    _controller = TabController(length: 4, vsync: this);
    for (int i = 0; i < 5; i++) {
      picModel.add(PicModel(data: null, url: ""));
    }
    for (int j = 0; j < 8; j++) {
      catalogueList.add(PicModel(data: null, url: ""));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("inside Varient${widget.variantModel?.uomCode}");
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BackAppBar(
          label: "Add new list",
          isBack: false,
          onTap: () {
            picModel.clear();
            catalogueList.clear();

            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is CreateVariantSuccess) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ItemSubmitScreen(),
              withNavBar: false,
              // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            showSnackBar(context,
                message: "${state.msg}", color: ColorPalette.green);
          }
          if (state is CreateVariantFailed) {
            showSnackBar(context,
                message: "${state.msg}", color: ColorPalette.green);
            // PersistentNavBarNavigator
            //     .pushNewScreen(
            //   context,
            //   screen: ItemSubmitScreen(),
            //   withNavBar: false,
            //   // OPTIONAL VALUE. True by default.
            //   pageTransitionAnimation:
            //   PageTransitionAnimation.fade,
            // );
          }
        },
        child: DefaultTabController(
          length: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                // padding: EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: w,
                        height: 5,
                        color: Color(0xfff8f7f5),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: TabBar(
                          isScrollable: false,
                          controller: _controller,
                          labelColor: Colors.black,
                          indicatorColor: ColorPalette.primary,
                          indicatorWeight: 5,
                          unselectedLabelColor: Colors.black,
                          labelPadding: EdgeInsets.only(left: 0),
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.green,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: GoogleFonts.roboto(
                            color: Colors.green,
                            fontSize: w / 26,
                          ),
                          tabs: [
                            Tab(
                              // text: "",

                              child: Text(
                                "General",
                                style: GoogleFonts.roboto(
                                  color: _controller.index.toInt() > 0
                                      ? ColorPalette.primary
                                      : Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Profiling",
                                style: GoogleFonts.roboto(
                                  color: _controller.index.toInt() > 1
                                      ? ColorPalette.primary
                                      : Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: _controller.index.toInt() < 1
                                      ? FontWeight.normal
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                            Tab(
                                child: Text(
                              "Variants",
                              style: GoogleFonts.roboto(
                                color: _controller.index.toInt() > 2
                                    ? ColorPalette.primary
                                    : Colors.black,
                                fontSize: w / 24,
                                fontWeight: _controller.index.toInt() < 2
                                    ? FontWeight.normal
                                    : FontWeight.w600,
                              ),
                            )),
                            Tab(
                                child: Text(
                              "Others",
                              style: GoogleFonts.roboto(
                                color: isOther
                                    ? ColorPalette.primary
                                    : Colors.black,
                                fontSize: w / 24,
                                fontWeight: _controller.index.toInt() < 2
                                    ? FontWeight.normal
                                    : FontWeight.w600,
                              ),
                            )),
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TabBarView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ScrollConfiguration(
                          behavior: NoGlow(),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SegmantFlowCard(
                                    division: widget.division,
                                    category: widget.category,
                                    subCategory: widget.subCategory,
                                    group: widget.group,
                                    item: widget.item,
                                    uom: widget.uom,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GeneralTab(
                                    id: widget.uomId,
                                    varientName: varientNameController,
                                    displayName: displayNameController,
                                    searchName: searchNameController,
                                    description: descriptionController,
                                    oldSystemCode: oldSystemController,
                                    arabicDescription: arabicDescription,
                                    additionalDescription:
                                        additionalDescription,
                                    identification: identificationController,
                                    barCode: barCode,
                                    producedCountry: producedCountry,
                                    posName: posName,
                                    // onChangeBaseUom: onChangeBaseUom,
                                    onChangeSalesUom: onChangeSalesUom,
                                    onChangeChannel: onChangeChannel,
                                    variantModel: widget.variantModel,

                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ContinueButton(
                                    onTap: () {
                                      currentFocus.unfocus();

                                      varientNameController.text != '' &&
                                              displayNameController.text !=
                                                  '' &&
                                              searchNameController.text != '' &&
                                              descriptionController.text !=
                                                  '' &&
                                              arabicDescription.text != '' &&
                                              additionalDescription.text !=
                                                  '' &&
                                              oldSystemController.text != '' &&
                                              barCode.text != '' &&
                                              producedCountry.text != '' &&
                                              // identificationController.text != '' &&
                                              sales != '' &&
                                              sales != null &&
                                              channel != '' &&
                                              channel != null
                                          ? setState(() {
                                              _controller.index = 1;
                                            })
                                          : Fluttertoast.showToast(
                                              msg: 'Please fill all fields',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);

                                      print("inside continue button"
                                          "${varientNameController.text}\n"
                                          "${displayNameController.text}\n"
                                          "${searchNameController.text}\n"
                                          "${descriptionController.text}\n"
                                          "${oldSystemController.text}");

                                      print("salesUom$sales");
                                    },
                                  ),
                                  SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ScrollConfiguration(
                          behavior: NoGlow(),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SegmantFlowCard(
                                    division: widget.division,
                                    category: widget.category,
                                    subCategory: widget.subCategory,
                                    group: widget.group,
                                    item: widget.item,
                                    uom: widget.uom,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ProfilingTab(),
                                  ContinueButton(
                                    onTap: () {
                                      int picTotal = 0;
                                      int catTotal = 0;
                                      print("image 1 ${picModel[0].data}");
                                      print("image 2 ${picModel[1].data}");
                                      print("image 3 ${picModel[2].data}");
                                      print("image 4 ${picModel[3].data}");
                                      print("catal 1 ${catalogueList[0].data}");
                                      print("catal 1 ${catalogueList[1].data}");
                                      print("catal 2 ${catalogueList[2].data}");
                                      print("catal 1 ${catalogueList[3].data}");
                                      print("catal 1 ${catalogueList[4].data}");
                                      for (int i = 0;
                                          i < picModel.length;
                                          i++) {
                                        if (picModel[i].data != null) {
                                          picTotal++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < catalogueList.length;
                                          i++) {
                                        if (catalogueList[i].data != null) {
                                          catTotal++;
                                        }
                                      }
                                      picTotal >= 3 && catTotal >= 2
                                          ? setState(() {
                                              _controller.index = 2;
                                            })
                                          : Fluttertoast.showToast(
                                              msg:
                                                  'Please upload minimum images',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                    },
                                  ),
                                  SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ScrollConfiguration(
                          behavior: NoGlow(),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SegmantFlowCard(
                                    division: widget.division,
                                    category: widget.category,
                                    subCategory: widget.subCategory,
                                    group: widget.group,
                                    item: widget.item,
                                    uom: widget.uom,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  VariationsTab(
                                    itemId: widget.itemId,
                                    varientFrameId: widget.varientId,
                                    onChangeManufacture: onChangeManufacture,
                                    purposeController: purposeController,
                                    genderController: genderController,
                                    ethnicController: ethnicController,
                                    countryController: countryController,
                                    ageGroupController: ageGroupController,
                                    headController: headController,
                                    storageNameController:
                                        storageNameController,
                                    storageController: storageController,
                                    aboutNameController: aboutNameController,
                                    ingredientsNameController:
                                        ingredientsNameController,
                                    usageDirectionNameController:
                                        usageDirectionNameController,
                                    aboutController: aboutController,
                                    ingredientsController:
                                        ingredientsController,
                                    usageDirectionController:
                                        usageDirectionController,
                                    additionalKeyController:
                                        additionalKeyController,
                                    additionalValueController:
                                        additionalValueController,
                                    additionalHeadController:
                                        additionalHeadController,
                                    impKeyController: impKeyController,
                                    impValueController: impValueController,
                                    impHeadController: impHeadController,
                                    nutriKeyController: nutriKeyController,
                                    nutriValueController: nutriValueController,
                                    nutriHeadController: nutriHeadController,
                                    productDetailsKeyController:
                                        productDetailsKeyController,
                                    productDetailsValueController:
                                        productDetailsValueController,
                                    productDetailsHeadController:
                                        productDetailsHeadController,
                                    specificationKeyController:
                                        specificationKeyController,
                                    specificationValueController:
                                        specificationValueController,
                                    specificationHeadController:
                                        specificationHeadController,
                                    productFeatureKeyController:
                                        productFeatureKeyController,
                                    productFeatureValueController:
                                        productFeatureValueController,
                                    productFeatureHeadController:
                                        productFeatureHeadController,
                                  ),
                                  ContinueButton(
                                    onTap: () {
                                      for (int i = 0;
                                          i <
                                              productDetailsKeyController
                                                  .length;
                                          i++) {
                                        print(
                                            "product details Index$i\t ${additionalValueController[i].text}");
                                        print(
                                            "product details Index$i\t ${additionalKeyController[i].text}");
                                        productDetailsData?.add(KeyValues(
                                            value:
                                                productDetailsValueController[i]
                                                    .text,
                                            key: productDetailsKeyController[i]
                                                .text));
                                      }
                                      for (int i = 0;
                                          i < nutriValueController.length;
                                          i++) {
                                        print(
                                            "nutri Index$i\t ${nutriValueController[i].text}");
                                        print(
                                            "nutri Index$i\t ${nutriKeyController[i].text}");
                                        nutriData?.add(KeyValues(
                                            value: nutriValueController[i].text,
                                            key: nutriKeyController[i].text));
                                      }
                                      for (int i = 0;
                                          i < impKeyController.length;
                                          i++) {
                                        print(
                                            "imp Index$i\t ${impValueController[i].text}");
                                        print(
                                            "imp Index$i\t ${impKeyController[i].text}");
                                        impInfoData?.add(KeyValues(
                                            value: impValueController[i].text,
                                            key: impKeyController[i].text));
                                      }
                                      for (int i = 0;
                                          i < additionalKeyController.length;
                                          i++) {
                                        print(
                                            "additional Index$i\t ${additionalValueController[i].text}");
                                        print(
                                            "additional Index$i\t ${additionalKeyController[i].text}");
                                        additionalInfoData?.add(KeyValues(
                                            value: additionalValueController[i]
                                                .text,
                                            key: additionalKeyController[i]
                                                .text));
                                      }

                                      for (int i = 0;
                                          i < specificationKeyController.length;
                                          i++) {
                                        print(
                                            "specification Index$i\t ${specificationValueController[i].text}");
                                        print(
                                            "specification Index$i\t ${specificationKeyController[i].text}");
                                        specificationData?.add(KeyValues(
                                            value:
                                                specificationValueController[i]
                                                    .text,
                                            key: specificationKeyController[i]
                                                .text));
                                        print(
                                            "new Specification Data${specificationData?.length}");
                                      }

                                      for (int i = 0;
                                          i <
                                              productFeatureKeyController
                                                  .length;
                                          i++) {
                                        print(
                                            "productFeature Index$i\t ${productFeatureValueController[i].text}");
                                        print(
                                            "productFeature Index$i\t ${productFeatureKeyController[i].text}");
                                        productFeatureData?.add(KeyValues(
                                            value:
                                                productFeatureValueController[i]
                                                    .text,
                                            key: productFeatureKeyController[i]
                                                .text));
                                      }

                                      //single field table
                                      for (int i = 0;
                                          i < storageNameController.length;
                                          i++) {
                                        storageNameData?.add(NameCreate(
                                            name:
                                                storageNameController[i].text));
                                      }
                                      for (int i = 0;
                                          i < ingredientsNameController.length;
                                          i++) {
                                        ingredientsNameData?.add(NameCreate(
                                            name:
                                                storageNameController[i].text));
                                      }
                                      for (int i = 0;
                                          i <
                                              usageDirectionNameController
                                                  .length;
                                          i++) {
                                        usageDirectionNameData?.add(NameCreate(
                                            name:
                                                usageDirectionNameController[i]
                                                    .text));
                                      }
                                      for (int i = 0;
                                          i < aboutNameController.length;
                                          i++) {
                                        aboutNameData?.add(NameCreate(
                                            name: aboutNameController[i].text));
                                      }

                                      print(
                                          "Specification Data$specificationData");
                                      additionalInfoDataName = Abouttheproducts(
                                          name: additionalHeadController.text,
                                          keyvalues: additionalInfoData);

                                      impInfoDataName = Abouttheproducts(
                                          name: impHeadController.text,
                                          keyvalues: impInfoData);
                                      nutriDataName = Abouttheproducts(
                                          name: nutriHeadController.text,
                                          keyvalues: nutriData);
                                      productDetailsDataName = Abouttheproducts(
                                          name:
                                              productDetailsHeadController.text,
                                          keyvalues: productDetailsData);
                                      specificationDataName = Abouttheproducts(
                                          name:
                                              specificationHeadController.text,
                                          keyvalues: specificationData);
                                      productFeatureDataName = Abouttheproducts(
                                          name:
                                              productFeatureHeadController.text,
                                          keyvalues: productFeatureData);
                                      // nameData;
                                      storageData = ProductDetails(
                                          name: storageController.text,
                                          keyvalues: storageNameData);
                                      usageDirectionData = ProductDetails(
                                          name: usageDirectionController.text,
                                          keyvalues: usageDirectionNameData);
                                      ingredientsData = ProductDetails(
                                          name: ingredientsController.text,
                                          keyvalues: ingredientsNameData);
                                      aboutData = ProductDetails(
                                          name: aboutController.text,
                                          keyvalues: aboutNameData);
                                      productBehaviour?.add(
                                            SubClassBehaviour(
                                                ageGroup:
                                                    ageGroupController.text,
                                                countries:
                                                    countryController.text,
                                                ethnic: ethnicController.text,
                                                genderGroup:
                                                    genderController.text,
                                                purpose: purposeController.text));

                                      // storageNameData?.clear();
                                      print("manufacture: ${manufacture}");
                                      print("variant: ${variantValues.length}");
                                      print(
                                          "additional info: ${additionalInfoData?.length}");
                                      print(
                                          "storage: ${storageNameController.length}");
                                      print(
                                          "ingredients: ${ingredientsNameController.length}");
                                      print(
                                          "ingredients: ${ingredientsNameController[0].text == ''}");
                                      print(
                                          "imp info: ${impKeyController.length}");
                                      print(
                                          "imp info: ${impKeyController[0].text == ''}");
                                      print(
                                          "NutriFacts: ${nutriKeyController.length}");
                                      print(
                                          "NutriFacts: ${nutriKeyController[0].text == ''}");
                                      print(
                                          "Product Details: ${productDetailsKeyController.length}");
                                      print(
                                          "Product Details: ${productDetailsKeyController[0].text == ''}");
                                      print(
                                          "Specification: ${productDetailsKeyController.length}");
                                      print(
                                          "Specification: ${productDetailsKeyController[0].text == ''}");
                                      print(
                                          "Specification: ${productDetailsKeyController.length}");
                                      print(
                                          "Specification: ${productDetailsKeyController[0].text == ''}");
                                      print(
                                          "Usage Direction: ${usageDirectionNameData?.length}");
                                      print(
                                          "Product Features: ${productFeatureKeyController.length}");
                                      print(
                                          "Product Features: ${aboutNameController.length}");
                                      // print("Usage Direction: ${usageDirectionNameData?[0]==null}");

                                      manufacture != null &&
                                              additionalKeyController.isEmpty &&
                                              storageNameController.isEmpty &&
                                              ingredientsNameController
                                                  .isEmpty &&
                                              impKeyController.isEmpty &&
                                              nutriKeyController.isEmpty &&
                                              productDetailsKeyController
                                                  .isEmpty &&
                                              specificationKeyController
                                                  .isEmpty &&
                                              productFeatureKeyController
                                                  .isEmpty &&
                                              aboutNameController.isEmpty
                                          ? Fluttertoast.showToast(
                                              msg: 'Please fill all fields',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white)
                                          : setState(() {
                                              _controller.index = 3;
                                            });
                                    },
                                  ),
                                  SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        isOther
                            ? ScrollConfiguration(
                                behavior: NoGlow(),
                                child: SingleChildScrollView(
                                  child: Container(
                                    // color: Colors.grey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                            // color: Colors.grey,
                                            //   padding: const EdgeInsets.symmetric(
                                            //       horizontal: 16),
                                            child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: SegmantFlowCard(
                                                division: widget.division,
                                                category: widget.category,
                                                subCategory: widget.subCategory,
                                                group: widget.group,
                                                item: widget.item,
                                                uom: widget.uom,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: GeneralTab(
                                                sales: sales,

                                                id: widget.uomId,
                                                varientName:
                                                    varientNameController,
                                                displayName:
                                                    displayNameController,
                                                searchName:
                                                    searchNameController,
                                                description:
                                                    descriptionController,
                                                oldSystemCode:
                                                    oldSystemController,
                                                arabicDescription:
                                                    arabicDescription,
                                                additionalDescription:
                                                    additionalDescription,
                                                identification:
                                                    identificationController,
                                                barCode: barCode,
                                                producedCountry:
                                                    producedCountry,
                                                posName: posName,
                                                // onChangeBaseUom: onChangeBaseUom,
                                                onChangeSalesUom:
                                                    onChangeSalesUom,
                                                onChangeChannel:
                                                    onChangeChannel,
                                                variantModel:
                                                    widget.variantModel,
                                                channel: channel,
                                              ),
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: ProfilingTab()),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: VariationsTab(
                                                itemId: widget.itemId,
                                                varientFrameId:
                                                    widget.varientId,
                                                onChangeManufacture:
                                                    onChangeManufacture,
                                                purposeController:
                                                    purposeController,
                                                genderController:
                                                    genderController,
                                                ethnicController:
                                                    ethnicController,
                                                countryController:
                                                    countryController,
                                                ageGroupController:
                                                    ageGroupController,
                                                headController: headController,
                                                storageNameController:
                                                    storageNameController,
                                                storageController:
                                                    storageController,
                                                aboutNameController:
                                                    aboutNameController,
                                                ingredientsNameController:
                                                    ingredientsNameController,
                                                usageDirectionNameController:
                                                    usageDirectionNameController,
                                                aboutController:
                                                    aboutController,
                                                ingredientsController:
                                                    ingredientsController,
                                                usageDirectionController:
                                                    usageDirectionController,
                                                additionalKeyController:
                                                    additionalKeyController,
                                                additionalValueController:
                                                    additionalValueController,
                                                additionalHeadController:
                                                    additionalHeadController,
                                                impKeyController:
                                                    impKeyController,
                                                impValueController:
                                                    impValueController,
                                                impHeadController:
                                                    impHeadController,
                                                nutriKeyController:
                                                    nutriKeyController,
                                                nutriValueController:
                                                    nutriValueController,
                                                nutriHeadController:
                                                    nutriHeadController,
                                                productDetailsKeyController:
                                                    productDetailsKeyController,
                                                productDetailsValueController:
                                                    productDetailsValueController,
                                                productDetailsHeadController:
                                                    productDetailsHeadController,
                                                specificationKeyController:
                                                    specificationKeyController,
                                                specificationValueController:
                                                    specificationValueController,
                                                specificationHeadController:
                                                    specificationHeadController,
                                                productFeatureKeyController:
                                                    productFeatureKeyController,
                                                productFeatureValueController:
                                                    productFeatureValueController,
                                                productFeatureHeadController:
                                                    productFeatureHeadController,
                                                manufacture: manufacture,

                                              ),
                                            ),
                                            OtherTab(
                                              rePlacementTime: rePlacementTime,
                                              returnTime: returnTime,
                                              shelfTime: shelfTime,
                                              onChangeSibling: onChangeSibling,
                                              onChangeGift: onChangeGift,
                                              onChangeWrap: onChangeWrap,
                                              variantHeight: variantHeight,
                                              variantLength: variantLength,
                                              variantWeight: variantWeight,
                                              variantWidth: variantWidth,
                                              grossWeight: grossWeight,
                                              netWeight: netWeight,
                                              minimumSales: minimumSales,
                                              maximumSales: maximumSales,
                                              vat: vat,
                                              excessTax: excessTax,
                                              minimumGp: minimumGp,
                                              maximumGp: maximumGp,
                                              averageGp: averageGp,
                                              targetGp: targetGp,
                                              videoUrl: videoUrl,
                                              onChangerRefund: onChangeRefund,
                                              onChangerReturn: onChangeReturn,
                                              onChangerShelf: onChangeShelf,
                                              onChangeSales: onChangeSales,
                                              unitCost: unitCost,
                                              actualCost: actualCost,
                                              returnType: returnType,
                                              replacementType: replacementType,
                                              shelfType: shelfType,
                                              sibling: sibling,
                                              isGift: isGift,
                                              isWrap: isWrap,

                                            ),
                                          ],
                                        )),
                                        // OtherTab(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: ContinueButton(
                                            label: "Continue and Add",
                                            onTap: () {
                                              context.read<InventoryBloc>().add(VariantEvent(
                                                  variantModel: CreateVariantModel(
                                                      inventoryId: authentication.authenticatedUser.organisationCode,
                                                      inventoryName: Variable.inventoryName,
                                                      itemId: widget.varientId,
                                                      channelCode: channel,
                                                      channelId: channelId,
                                                      // inventoryId: authentication.authenticatedUser.,
                                                      name: varientNameController.text,
                                                      barcode: barCode.text,
                                                      searchName: searchNameController.text,
                                                      displayName: displayNameController.text,
                                                      description: descriptionController.text,
                                                      image1: picModel[0].data,
                                                      salesUom: salesId,
                                                      producedCountry: producedCountry.text,
                                                      image2: picModel[1].data,
                                                      image3: picModel[2].data,
                                                      image4: picModel[3].data,
                                                      image5: picModel[4].data,
                                                      catalog1: catalogueList[0].data,
                                                      catalog2: catalogueList[1].data,
                                                      catalog3: catalogueList[2].data,
                                                      catalog4: catalogueList[3].data,
                                                      catalog5: catalogueList[4].data,
                                                      catalog6: catalogueList[5].data,
                                                      catalog7: catalogueList[6].data,
                                                      catalog8: catalogueList[7].data,
                                                      manufactureId: manufactureId,
                                                      arabicDescription: arabicDescription.text,
                                                      additionalDescription: additionalDescription.text,
                                                      posName: posName.text,
                                                      variantValue: variantValues,
                                                      manufactureName: manufacture,
                                                      height: double.parse(variantHeight.text),
                                                      width: double.parse(variantWidth.text),
                                                      weight: double.parse(variantWeight.text),
                                                      length: double.parse(variantLength.text),
                                                      haveGiftOption: isGift,
                                                      haveWrapOption: isWrap,
                                                      grossWeight: grossWeight.text,
                                                      netWeight: netWeight.text,
                                                      unitCost: double.parse(unitCost.text),
                                                      actualCost: double.parse(actualCost.text),
                                                      minSalesOrderLimit: int.parse(minimumSales.text),
                                                      maxSalesOrderLimit: int.parse(maximumSales.text),
                                                      vat: double.parse(vat.text),
                                                      excessTax: double.parse(excessTax.text),
                                                      minimumGp: double.parse(minimumGp.text),
                                                      maximumGp: double.parse(maximumGp.text),
                                                      averageGp: double.parse(averageGp.text),
                                                      targetedGp: double.parse(targetGp.text),
                                                      videoUrl: videoUrl.text,
                                                      siblingCode: sibling,
                                                      siblingId: siblingId,
                                                      returnTime: returnTime.text,
                                                      replacementTime: rePlacementTime.text,
                                                      shelfTime: int.parse(shelfTime.text),
                                                      vendorDetails: vendorDetails,
                                                      returnType: returnType,
                                                      shelfType: shelfType,
                                                      replacementType: replacementType,
                                                      productBehaviour: productBehaviour,
                                                      storage: storageData,
                                                      ingredients: ingredientsData,
                                                      usageDirection: usageDirectionData,
                                                      aboutTheProducts: aboutData,
                                                      additionalInfo: additionalInfoDataName,
                                                      importantInfo: impInfoDataName,
                                                      nutrientsFacts: nutriDataName,
                                                      productDetails: productDetailsDataName,
                                                      productFeatures: productFeatureDataName,

                                                      salesBlock: isSales,
                                                      itemCatalog: false,
                                                      itemImage: false,
                                                      varAlternativeRfid: [],
                                                      alternativeBarcode: [],
                                                      needMultipleIntegration: false,
                                                      oldSystemCode: oldSystemController.text)));
                                              // PersistentNavBarNavigator
                                              //     .pushNewScreen(
                                              //   context,
                                              //   screen: ItemSubmitScreen(),
                                              //   withNavBar: false,
                                              //   // OPTIONAL VALUE. True by default.
                                              //   pageTransitionAnimation:
                                              //       PageTransitionAnimation.fade,
                                              // );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : ScrollConfiguration(
                                behavior: NoGlow(),
                                child: SingleChildScrollView(
                                  child: Container(
                                    // padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: SegmantFlowCard(
                                              division: widget.division,
                                              category: widget.category,
                                              subCategory: widget.subCategory,
                                              group: widget.group,
                                              item: widget.item,
                                              uom: widget.uom,
                                            )),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        OtherTab(
                                          rePlacementTime: rePlacementTime,
                                          returnTime: returnTime,
                                          shelfTime: shelfTime,
                                          onChangeSibling: onChangeSibling,
                                          onChangeGift: onChangeGift,
                                          onChangeWrap: onChangeWrap,
                                          variantHeight: variantHeight,
                                          variantLength: variantLength,
                                          variantWeight: variantWeight,
                                          variantWidth: variantWidth,
                                          grossWeight: grossWeight,
                                          netWeight: netWeight,
                                          minimumSales: minimumSales,
                                          maximumSales: maximumSales,
                                          vat: vat,
                                          excessTax: excessTax,
                                          minimumGp: minimumGp,
                                          maximumGp: maximumGp,
                                          averageGp: averageGp,
                                          targetGp: targetGp,
                                          videoUrl: videoUrl,
                                          onChangerRefund: onChangeRefund,
                                          onChangerReturn: onChangeReturn,
                                          onChangerShelf: onChangeShelf,
                                          onChangeSales: onChangeSales,
                                          unitCost: unitCost,
                                          actualCost: actualCost,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: ContinueButton(
                                            label: "Save",
                                            onTap: () {
                                              replacementType != null &&
                                                      rePlacementTime.text !=
                                                          null &&
                                                      rePlacementTime.text !=
                                                          '' &&
                                                      returnType != null &&
                                                      returnTime.text != null &&
                                                      returnTime.text != "" &&
                                                      shelfTime.text != null &&
                                                      shelfTime.text != "" &&
                                                      shelfType != null &&
                                                      sibling != "" &&
                                                      variantHeight.text !=
                                                          null &&
                                                      variantHeight.text !=
                                                          "" &&
                                                      variantWeight.text !=
                                                          null &&
                                                      variantWeight.text !=
                                                          "" &&
                                                      variantWidth.text !=
                                                          null &&
                                                      variantWidth.text != "" &&
                                                      variantLength.text !=
                                                          null &&
                                                      variantLength.text != ""&&
                                                      grossWeight.text !=
                                                          null &&
                                                  grossWeight.text != ""&&
                                                      netWeight.text !=
                                                          null &&
                                                  netWeight.text != ""&&
                                                  unitCost.text != ""&&
                                                  unitCost.text !=
                                                          null &&
                                                  actualCost.text != ""&&
                                                  actualCost.text !=
                                                          null &&
                                                  minimumSales.text != ""&&
                                                  minimumSales.text !=
                                                          null &&
                                                  maximumSales.text != ""&&
                                                  maximumSales.text !=
                                                          null &&
                                                  vat.text != ""&&
                                                  vat.text !=
                                                          null  &&
                                                  excessTax.text != ""&&
                                                  excessTax.text !=
                                                          null   &&
                                                  minimumGp.text != ""&&
                                                  minimumGp.text !=
                                                          null   &&
                                                  maximumGp.text != ""&&
                                                  maximumGp.text !=
                                                          null &&
                                                  averageGp.text != ""&&
                                                  averageGp.text !=
                                                          null&&
                                                  targetGp.text != ""&&
                                                  targetGp.text !=
                                                          null&&
                                                  videoUrl.text != ""&&
                                                  videoUrl.text !=
                                                          null
                                                  ? setState(() {
                                                      isOther = true;
                                                      _controller.index = 3;
                                                    })
                                                  : Fluttertoast.showToast(
                                                      msg:
                                                          'Please fill all fields',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
