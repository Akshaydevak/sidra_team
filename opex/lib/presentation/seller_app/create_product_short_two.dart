import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/segmant_flow_card.dart';
import 'package:cluster/presentation/seller_app/create_tab_variant.dart';
import 'package:cluster/presentation/seller_app/submit_screen_short_variant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/title_app_bar.dart';
import '../../core/color_palatte.dart';

import '../inventory/model/inventory_model.dart';
import '../inventory/new_list_tab/general_tab.dart';
import '../inventory/new_list_tab/other_tab.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
import '../inventory/new_list_tab/variations_tab.dart';
import '../seller_app/continue_btn.dart';
import 'item_submit_screen.dart';

List<PicModel> picModel = [];
List<PicModel> catalogueList = [];
List<VarintValue> variantValues = [];
List<NameCreate> value = [];

class CreateProductShortTwo extends StatefulWidget {
  final BaseUomData? variantModel;
  final String? division, category, subCategory, group, item, uom;
  final int? uomId, itemId, varientId;

  const CreateProductShortTwo(
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
  State<CreateProductShortTwo> createState() => _CreateProductShortTwoState();
}

class _CreateProductShortTwoState extends State<CreateProductShortTwo>
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
  List<KeyValues>? productFeatureData = [];
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
    additionalHeadController =
        TextEditingController(text: "Additional Information");
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
          label: "Add New Product",
          isBack: false,
          isAction: false,
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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
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
                CreateTab(
                  id: widget.uomId,
                  varientName: varientNameController,
                  displayName: displayNameController,
                  searchName: searchNameController,
                  description: descriptionController,
                  oldSystemCode: oldSystemController,
                  arabicDescription: arabicDescription,
                  additionalDescription: additionalDescription,
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
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ItemSubmitShortScreen(),
                        withNavBar: false,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      currentFocus.unfocus();

                      varientNameController.text != '' &&
                              displayNameController.text != '' &&
                              searchNameController.text != '' &&
                              descriptionController.text != '' &&
                              arabicDescription.text != '' &&
                              additionalDescription.text != '' &&
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
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorPalette.primary, ColorPalette.primary]),
                    child: Text(
                      "Add New Variant",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: ColorPalette.white,
                        fontSize: w / 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
