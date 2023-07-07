import 'dart:io';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/inventory/new_list_tab/other_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/model/manufacture_model.dart';
import 'package:cluster/presentation/inventory/model/read_variant_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/profiling_tab.dart';
import 'package:cluster/presentation/inventory/new_list_tab/textfield_tab.dart';
import 'package:cluster/presentation/inventory/widget/inventory_vendor_list_card.dart';
import 'package:cluster/presentation/inventory/widget/product_behaviour_card.dart';
import 'package:cluster/presentation/inventory/widget/readonly_card.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:cluster/presentation/product_hub/widget/table_card.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateVariant extends StatefulWidget {
  final int? id;

  const UpdateVariant({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateVariant> createState() => _UpdateVariantState();
}

class _UpdateVariantState extends State<UpdateVariant> {
  String sales = "- select -";
  int? salesUom;
  int indexImage = 0;
  bool isCatalogue = false;

  final picker = ImagePicker();
  List<InventoryModel>? uomList = [];
  List<InventoryModel>? channelList = [];
  ReadVariantModel? variantList;
  int? select;
  List<InventoryModel>? dataList = [];
  File? cropImage;
  bool _cropped = false;

  // List<String>? channelIdList = [];
  String? selectChannel;
  int? isSelectSales;
  String manufacture = "";
  int? manufactureId;

  List<PicModel> picModel = [];
  List<PicModel> catalogueList = [];
  int? isSelect;
  List<VendorDetails> vendorDetails = [];
  List<TextEditingController> vendorReference = [];

  TextEditingController variantNameController = TextEditingController();
  TextEditingController searchNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController posNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController additionalDescriptionController =
      TextEditingController();
  TextEditingController oldSystemController = TextEditingController();
  TextEditingController identificationController = TextEditingController();

  TextEditingController producedCountryController = TextEditingController();
  TextEditingController returnTimeController = TextEditingController();
  TextEditingController replacementTimeController = TextEditingController();
  TextEditingController shelfController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController unitCostController = TextEditingController();
  TextEditingController actualCostController = TextEditingController();
  TextEditingController minSalesController = TextEditingController();
  TextEditingController maxSalesController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController excessTaxController = TextEditingController();
  TextEditingController minGpController = TextEditingController();
  TextEditingController maxGpController = TextEditingController();
  TextEditingController avgGpController = TextEditingController();
  TextEditingController targetGpController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  List<ManufactureModel> ManufactureList = [];
  List<TextEditingController> additionalKeyController = [];
  List<TextEditingController> additionalValueController = [];
  TextEditingController additionalHeadController = TextEditingController();
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
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  List<TextEditingController> storageNameController = [];

  List<TextEditingController> ingredientsNameController = [];

  List<TextEditingController> usageDirectionNameController = [];

  List<TextEditingController> aboutNameController = [];
  TextEditingController impHeadController = TextEditingController();
  TextEditingController nutriHeadController = TextEditingController();

  List<TextEditingController> impKeyController = [];
  List<TextEditingController> impValueController = [];
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

  String? selectReturnType, returntype;
  String? selectReplacementType;
  String? shelfType;
  List<String>? returnList = [];
  String siblings = "";
  int? siblingId;
  String? siblingCode;
  List<String> kiloStatus = ['Gm', 'Kg'];
  List<String> measureStatus = ['Cm', 'Mm', 'M'];

  bool isWrap = false;
  bool isSales = false;
  bool isGift = false;

  onRefresh() {
    setState(() {});
  }

  List<SubClassBehaviour> productBehaviour=[];
  ProductDetails? storageData;
  List<NameCreate>? storageNameData = [];
  ProductDetails? ingredientsData;
  List<NameCreate>? ingredientsNameData = [];
  ProductDetails? usageDirectionData;
  List<NameCreate>? usageDirectionNameData = [];
  ProductDetails? aboutData;
  List<NameCreate>? aboutNameData = [];
  Abouttheproducts? productDetailsDataName;
  List<KeyValues>? productDetailsData = [];
  Abouttheproducts? productFeatureDataName;
  List<KeyValues>? productFeatureData;
  Abouttheproducts? nutriDataName;
  List<KeyValues>? nutriData = [];
  Abouttheproducts? impInfoDataName;
  List<KeyValues>? impInfoData = [];
  Abouttheproducts? specificationDataName;
  List<KeyValues>? specificationData = [];

  List<InventoryModel> allVariants = [];
  bool isEmptyPage = false;
  bool _hasNextPage = true;
  dynamic _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  int page = 1;
  String url = "";
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  _loadMore() async {
    print("inside load more");
    if (_hasNextPage == true &&
        // _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      page += 1;
      print("inside");
      try {
        context
            .read<InventoryBloc>()
            .add(GetManufactureEvent(search: '', url: url));
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  FocusNode searchNameFocus = FocusNode();
  FocusNode displayNameFocus = FocusNode();
  FocusNode posNameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode arabicDescriptionFocus = FocusNode();
  FocusNode additionalDescriptionFocus = FocusNode();
  FocusNode oldSystemCodeFocus = FocusNode();
  FocusNode producedCountryFocus = FocusNode();
  FocusNode returnTimeFocus = FocusNode();
  FocusNode replacementTimeFocus = FocusNode();
  FocusNode shelfTimeFocus = FocusNode();
  FocusNode grossWeightFocus = FocusNode();
  FocusNode netWeightFocus = FocusNode();
  FocusNode unitCostFocus = FocusNode();
  FocusNode actualCostFocus = FocusNode();
  FocusNode minSalesFocus = FocusNode();
  FocusNode maxSalesFocus = FocusNode();
  FocusNode vatFocus = FocusNode();
  FocusNode excessTaxFocus = FocusNode();
  FocusNode minGpFocus = FocusNode();
  FocusNode maxGpFocus = FocusNode();
  FocusNode avgGpFocus = FocusNode();
  FocusNode targetGpFocus = FocusNode();
  FocusNode videoFocus = FocusNode();
  FocusNode heightFocus = FocusNode();
  FocusNode weightFocus = FocusNode();
  FocusNode widthFocus = FocusNode();
  FocusNode lengthFocus = FocusNode();
  FocusNode ethnicFocus = FocusNode();
  FocusNode purposeFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode countriesFocus = FocusNode();
  FocusNode genderFocus = FocusNode();

  @override
  void initState() {
    picModel.clear();
    for (int i = 0; i < 5; i++) {
      picModel.add(PicModel(data: null, url: ""));
    }
    for (int j = 0; j < 8; j++) {
      catalogueList.add(PicModel(data: null, url: ""));
    }
    context.read<InventoryBloc>().add(const ReturnTypeEvent());
    context.read<InventoryBloc>().add(ReadVariantEvent(id: widget.id ?? 0));
    context.read<InventoryBloc>().add(const GetManufactureEvent(search: ''));
    context.read<InventoryBloc>().add(const GetSiblingEvent());
    // TODO: implement initState
    super.initState();
  }

  unfocusMethod() {
    displayNameFocus.unfocus();
    searchNameFocus.unfocus();
    posNameFocus.unfocus();
    descriptionFocus.unfocus();
    arabicDescriptionFocus.unfocus();
    additionalDescriptionFocus.unfocus();
    oldSystemCodeFocus.unfocus();
    producedCountryFocus.unfocus();
    returnTimeFocus.unfocus();
    replacementTimeFocus.unfocus();
    shelfTimeFocus.unfocus();
    grossWeightFocus.unfocus();
    netWeightFocus.unfocus();
    unitCostFocus.unfocus();
    actualCostFocus.unfocus();
    minSalesFocus.unfocus();
    maxSalesFocus.unfocus();
    vatFocus.unfocus();
    excessTaxFocus.unfocus();
    minGpFocus.unfocus();
    maxGpFocus.unfocus();
    avgGpFocus.unfocus();
    targetGpFocus.unfocus();
    videoFocus.unfocus();
    heightFocus.unfocus();
    widthFocus.unfocus();
    weightFocus.unfocus();
    lengthFocus.unfocus();
    ethnicFocus.unfocus();
    purposeFocus.unfocus();
    ageFocus.unfocus();
    countriesFocus.unfocus();
    genderFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BackAppBar(
          label: "Update Variant",
          isBack: false,
          onTap: () {
            // picModel.clear();
            // catalogueList.clear();

            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is UpdateVariantSuccess) {
            Fluttertoast.showToast(
                msg: "${state.data}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: ColorPalette.black,
                textColor: Colors.white);
            Navigator.pop(context);
          }
          if (state is PicLoading) {
            print("Inside Loading");
          }
          if (state is PicSuccess) {
            setState(() {
              isCatalogue
                  ? catalogueList.replaceRange(indexImage, indexImage + 1,
                      [PicModel(data: state.data, url: state.url)])
                  : picModel.replaceRange(indexImage, indexImage + 1,
                      [PicModel(data: state.data, url: state.url)]);
            });
            print("pic model length${picModel[0].data}");
          }
          if (state is ReturnTypeSuccess) {
            for (int i = 0; i < state.data!.length; i++)
              returnList?.add(state.data?[i] ?? '');
            setState(() {});
            print(".......return list$returnList");
          }
          if (state is GetUomSuccess) {
            uomList = state.inventory;
          }
          if (state is ManufacturerSuccess) {
            ManufactureList = state.data ?? [];
            setState(() {
              
            });
            print("ManufactureList${ManufactureList[0].name}");
            vendorDetails.clear();
            for (int i = 0; i < ManufactureList.length; i++) {
              vendorDetails.add(VendorDetails(
                  vendorName: ManufactureList[i].name,
                  vendorCode: ManufactureList[i].code,
                  vendorReferenceCode: ""));
              vendorReference.add(TextEditingController());
            }
            print("vendorDetails${vendorDetails.length}");
          }

          if (state is SiblingSuccess) {
            dataList = state.data;
          }
          if (state is ReadVariantSuccess) {
            variantList = state.data;
            manufactureId = variantList?.manufactureId ?? 0;
            siblingId = variantList?.siblingId ?? 0;
            sales = variantList?.salesUomData?.salesUomName ?? "";
            salesUom=int.tryParse(variantList?.salesUom.toString()??"") ;
            context
                .read<InventoryBloc>()
                .add(GetSalesUomEvent(id: variantList?.uomId ?? 0));
            // context.read<InventoryBloc>().add(GetSalesUomEvent(id: state.data.uomId??""));
            print("..................\n${state.data?.posName}");
            print("${state.data?.displayName}");
            variantNameController =
                TextEditingController(text: state.data?.name);
            searchNameController =
                TextEditingController(text: state.data?.searchName);
            displayNameController =
                TextEditingController(text: state.data?.displayName);
            posNameController =
                TextEditingController(text: state.data?.posName);
            descriptionController =
                TextEditingController(text: state.data?.description);
            arabicDescriptionController =
                TextEditingController(text: state.data?.arabicDescription);
            additionalDescriptionController =
                TextEditingController(text: state.data?.additionalDescription);

            producedCountryController =
                TextEditingController(text: state.data?.producedCountry);
            shelfController = TextEditingController(
                text: state.data?.shelfTime == null
                    ? ""
                    : state.data?.shelfTime.toString());
            returnTimeController = TextEditingController(
                text: state.data?.returnTime == null
                    ? ""
                    : state.data?.returnTime.toString());
            replacementTimeController = TextEditingController(
                text: state.data?.replacementTime == null
                    ? ""
                    : state.data?.replacementTime.toString());
            grossWeightController = TextEditingController(
                text: state.data?.grossWeight == null
                    ? ""
                    : state.data?.grossWeight.toString());
            netWeightController = TextEditingController(
                text: state.data?.netWeight == null
                    ? ""
                    : state.data?.netWeight.toString());
            unitCostController = TextEditingController(
                text: state.data?.unitCost == null
                    ? ""
                    : state.data?.unitCost.toString());
            actualCostController = TextEditingController(
                text: state.data?.actualCost == null
                    ? ""
                    : state.data?.actualCost.toString());
            minSalesController = TextEditingController(
                text: state.data?.minSalesOrderLimit == null
                    ? ""
                    : state.data?.minSalesOrderLimit.toString());
            maxSalesController = TextEditingController(
                text: state.data?.maxSalesOrderLimit == null
                    ? ""
                    : state.data?.maxSalesOrderLimit.toString());
            vatController = TextEditingController(
                text:
                    state.data?.vat == null ? "" : state.data?.vat.toString());
            excessTaxController = TextEditingController(
                text: state.data?.excessTax == null
                    ? ""
                    : state.data?.excessTax.toString());
            minGpController = TextEditingController(
                text: state.data?.minGp == null
                    ? ""
                    : state.data?.minGp.toString());
            maxGpController = TextEditingController(
                text: state.data?.maxGp == null
                    ? ""
                    : state.data?.maxGp.toString());
            avgGpController = TextEditingController(
                text: state.data?.avrgGp == null
                    ? ""
                    : state.data?.avrgGp.toString());
            targetGpController = TextEditingController(
                text: state.data?.targetedGp == null
                    ? ""
                    : state.data?.targetedGp.toString());
            videoController = TextEditingController(
                text: state.data?.videoUrl == null
                    ? ""
                    : state.data?.videoUrl.toString());

            picModel.setAll(0, [PicModel(url: state.data?.image1)]);
            picModel.setAll(1, [
              PicModel(
                  url: state.data?.variantMeta?.varImage?.keyValues?.image2 ??
                      "")
            ]);
            picModel.setAll(2, [
              PicModel(
                  url: state.data?.variantMeta?.varImage?.keyValues?.image3 ??
                      "")
            ]);
            picModel.setAll(3, [
              PicModel(
                  url: state.data?.variantMeta?.varImage?.keyValues?.image4 ??
                      "")
            ]);
            picModel.setAll(4, [
              PicModel(
                  url: state.data?.variantMeta?.varImage?.keyValues?.image5 ??
                      "")
            ]);
            catalogueList.setAll(0, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog1 ??
                      "")
            ]);
            catalogueList.setAll(1, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog2 ??
                      "")
            ]);
            catalogueList.setAll(2, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog3 ??
                      "")
            ]);
            catalogueList.setAll(3, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog4 ??
                      "")
            ]);
            catalogueList.setAll(4, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog5 ??
                      "")
            ]);
            catalogueList.setAll(5, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog6 ??
                      "")
            ]);
            catalogueList.setAll(6, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog7 ??
                      "")
            ]);
            catalogueList.setAll(7, [
              PicModel(
                  url: state.data?.variantMeta?.catalog?.keyvalues?.catalog8 ??
                      "")
            ]);
            manufacture = state.data?.manufactureName ?? "";
            returntype = state.data?.returnType ?? "";
            returnTimeController = TextEditingController(
                text: state.data?.returnTime == null
                    ? ""
                    : state.data?.returnTime.toString());
            storageController = TextEditingController(
                text: state.data?.variantMeta?.storage?.name ?? "Storage");
            ingredientsController = TextEditingController(
                text: state.data?.variantMeta?.ingredients?.name.toString());
            impHeadController = TextEditingController(
                text: state.data?.variantMeta?.importantInfo?.name.toString());

            additionalHeadController = TextEditingController(
                text: state.data?.variantMeta?.additionalInfo?.name ??
                    "Additional info");
            nutriHeadController = TextEditingController(
                text: state.data?.variantMeta?.nutrientsFacts?.name ?? "");
            productDetailsHeadController = TextEditingController(
                text: state.data?.variantMeta?.productDetails?.name ?? "");
            specificationHeadController = TextEditingController(
                text: state.data?.variantMeta?.specifications?.name ?? "");
            usageDirectionController = TextEditingController(
                text: state.data?.variantMeta?.usageDirection?.name ?? "");
            productFeatureHeadController = TextEditingController(
                text: state.data?.variantMeta?.productFeatures?.name ?? "");
            aboutController = TextEditingController(
                text: state.data?.variantMeta?.aboutTheProducts?.name ?? "");
            headController = TextEditingController(text: "Product Behaviour");
            ageGroupController = TextEditingController(
                text: state.data?.variantMeta?.productBehaviour?.length == 0
                    ? ""
                    : state.data?.variantMeta?.productBehaviour?[0].ageGroup ??
                        "null");
            countryController = TextEditingController(
                text: state.data?.variantMeta?.productBehaviour?.length == 0
                    ? ""
                    : state.data?.variantMeta?.productBehaviour?[0].country ??
                        "null");
            ethnicController = TextEditingController(
                text: state.data?.variantMeta?.productBehaviour?.length == 0
                    ? ""
                    : state.data?.variantMeta?.productBehaviour?[0].ethnic ??
                        "null");
            genderController = TextEditingController(
                text: state.data?.variantMeta?.productBehaviour?.length == 0
                    ? ""
                    : state.data?.variantMeta?.productBehaviour?[0]
                            .genderGroup ??
                        "null");
            purposeController = TextEditingController(
                text: state.data?.variantMeta?.productBehaviour?.length == 0
                    ? ""
                    : state.data?.variantMeta?.productBehaviour?[0].purpose ??
                        "null");
            int length =
                state.data?.variantMeta?.storage?.keyvalues?.length ?? 0;
            if (length != 0) {
              storageNameController.clear();
            }
            for (int i = 0; i < length; i++) {
              storageNameController.add(TextEditingController(
                  text: state.data?.variantMeta?.storage?.keyvalues?[i].name ??
                      ''));
            }

            int ingredientLength =
                state.data?.variantMeta?.ingredients?.keyvalues?.length ?? 0;
            if (ingredientLength != 0) {
              ingredientsNameController.clear();
            }
            print(
                "ingredients length${state.data?.variantMeta?.ingredients?.keyvalues?.length}");
            for (int i = 0; i < ingredientLength; i++) {
              ingredientsNameController.add(TextEditingController(
                  text: state
                          .data?.variantMeta?.ingredients?.keyvalues?[i].name ??
                      ''));
            }

            int aboutProductLength =
                state.data?.variantMeta?.aboutTheProducts?.keyvalues?.length ??
                    0;
            if (aboutProductLength != 0) {
              aboutNameController.clear();
            }
            print(
                "ingredients length${state.data?.variantMeta?.aboutTheProducts?.keyvalues?.length}");
            for (int i = 0; i < aboutProductLength; i++) {
              aboutNameController.add(TextEditingController(
                  text: state.data?.variantMeta?.aboutTheProducts?.keyvalues?[i]
                          .name ??
                      ''));
            }

            int usageLength =
                state.data?.variantMeta?.usageDirection?.keyvalues?.length ?? 0;
            if (usageLength != 0) {
              usageDirectionNameController.clear();
            }
            for (int i = 0; i < usageLength; i++) {
              usageDirectionNameController.add(TextEditingController(
                  text: state.data?.variantMeta?.usageDirection?.keyvalues?[i]
                          .name ??
                      ''));
            }

            int additionalInfoLength =
                state.data?.variantMeta?.additionalInfo?.keyvalues?.length ?? 0;
            if (additionalInfoLength != 0) {
              additionalKeyController.clear();
              additionalValueController.clear();
            }
            for (int i = 0; i < additionalInfoLength; i++) {
              additionalKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.additionalInfo?.keyvalues?[i]
                          .key ??
                      ''));
              additionalValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.additionalInfo?.keyvalues?[i]
                          .value ??
                      ''));
            }

            int impInfoLength =
                state.data?.variantMeta?.importantInfo?.keyvalues?.length ?? 0;
            if (impInfoLength != 0) {
              impKeyController.clear();
              impValueController.clear();
            }
            for (int i = 0; i < impInfoLength; i++) {
              impKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.importantInfo?.keyvalues?[i]
                          .key ??
                      ''));
              impValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.importantInfo?.keyvalues?[i]
                          .value ??
                      ''));
            }
            int nutriLength =
                state.data?.variantMeta?.nutrientsFacts?.keyvalues?.length ?? 0;
            if (nutriLength != 0) {
              nutriKeyController.clear();
              nutriValueController.clear();
            }
            for (int i = 0; i < nutriLength; i++) {
              nutriKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.nutrientsFacts?.keyvalues?[i]
                          .key ??
                      ''));
              nutriValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.nutrientsFacts?.keyvalues?[i]
                          .value ??
                      ''));
            }

            int productDetailsLength =
                state.data?.variantMeta?.productDetails?.keyvalues?.length ?? 0;
            if (productDetailsLength != 0) {
              productDetailsKeyController.clear();
              productDetailsValueController.clear();
            }
            for (int i = 0; i < productDetailsLength; i++) {
              productDetailsKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.productDetails?.keyvalues?[i]
                          .key ??
                      ''));
              productDetailsValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.productDetails?.keyvalues?[i]
                          .value ??
                      ''));
            }
            int specificationLength =
                state.data?.variantMeta?.specifications?.keyvalues?.length ?? 0;
            if (specificationLength != 0) {
              specificationKeyController.clear();
              specificationValueController.clear();
            }
            for (int i = 0; i < specificationLength; i++) {
              specificationKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.specifications?.keyvalues?[i]
                          .key ??
                      ''));
              specificationValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.specifications?.keyvalues?[i]
                          .value ??
                      ''));
            }
            int productFeatureLength =
                state.data?.variantMeta?.productFeatures?.keyvalues?.length ??
                    0;
            if (productFeatureLength != 0) {
              productFeatureKeyController.clear();
              productFeatureValueController.clear();
            }
            for (int i = 0; i < productFeatureLength; i++) {
              productFeatureKeyController.add(TextEditingController(
                  text: state.data?.variantMeta?.productFeatures?.keyvalues?[i]
                          .key ??
                      ''));
              productFeatureValueController.add(TextEditingController(
                  text: state.data?.variantMeta?.productFeatures?.keyvalues?[i]
                          .value ??
                      ''));
            }
            heightController = TextEditingController(
                text: state.data?.dimension?.height.toString());
            widthController = TextEditingController(
                text: state.data?.dimension?.width.toString());
            weightController = TextEditingController(
                text: state.data?.dimension?.weight.toString());
            lengthController = TextEditingController(
                text: state.data?.dimension?.length.toString());
            isWrap = state.data?.haveWrapOption ?? false;
            isGift = state.data?.haveGiftOption ?? false;
            isSales = state.data?.salesBlock ?? false;
            int vendorLength = state.data?.vendorDetails?.length ?? 0;
            for (int i = 0; i < vendorLength; i++)
              vendorReference.add(TextEditingController(
                  text:
                      state.data?.vendorDetails?[i].vendorReferenceCode ?? ''));
            setState(() {});
          }
        },
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldTab(
                    readOnly: true,
                    isMandatory: false,
                    // focusNode: currentFocus,
                    controller: variantNameController,
                    label: "Variant Name",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Inventory Name",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ReadOnlyCard(
                    label: "${variantList?.inventoryName}",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    // focusNode: searchFocus,
                    controller: searchNameController,
                    label: "Search Name",
                    hint: "",
                    focusNode: searchNameFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    // focusNode: displayFocus,
                    isMandatory: false,
                    controller: displayNameController,
                    label: "Display Name",
                    hint: "",
                    focusNode: displayNameFocus,
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    // focusNode: posFocus,
                    isMandatory: false,
                    controller: posNameController,
                    label: "Pos Name",
                    hint: "",
                    focusNode: posNameFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    // focusNode: descriptionFocus,
                    isMandatory: false,
                    controller: descriptionController,
                    maxLine: 5,
                    label: "Description",
                    hint: "",
                    focusNode: descriptionFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    // focusNode: arabicDescriptionFocus,
                    controller: arabicDescriptionController,
                    maxLine: 5,
                    label: "Arabic Description",
                    hint: "",
                    focusNode: arabicDescriptionFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    // focusNode: additionalDescriptionFocus,
                    controller: additionalDescriptionController,
                    maxLine: 5,
                    label: "Additional Description",
                    hint: "",
                    focusNode: additionalDescriptionFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    // focusNode: oldFocus,
                    // controller: widget.oldSystemCode,
                    label: "Old System Code",
                    hint: "",
                    focusNode: oldSystemCodeFocus,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Base UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ReadOnlyCard(
                    label: "${variantList?.uomNameData?.uomName}",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Sales UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      unfocusMethod();
                      _showModalBottomSheetSales();
                    },
                    child: Container(
                      width: w1,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sales ?? "-  Select  -",
                            style: TextStyle(
                              color: Color(0xbf666161),
                              fontSize: w / 24,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0x7f666161))
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Channel",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ReadOnlyCard(
                    label: "${variantList?.channelCode}",
                  ),

                  // SizedBox(
                  //   height: 16,
                  // ),
                  // TextFieldTab(
                  //   // controller: widget.identification,
                  //   label: "Identification",
                  //   hint: "",
                  // ),
                  SizedBox(
                    height: 16,
                  ),

                  Text(
                    "BarCode",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ReadOnlyCard(
                    label: "${variantList?.barcode?.barcodeNumber}",
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: producedCountryController,
                    label: "Produced country",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Images",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
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
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,
                                  childAspectRatio: 1.5 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 8),
                          itemBuilder: (context, i) {
                            // print("eeeeeeeeeeeee  ${picModel[i].url}");
                            return GestureDetector(
                              onTap: () {
                                isCatalogue = false;
                                indexImage = i;
                                setState(() {});
                                getImage(ImageSource.gallery);
                              },
                              // getImage(ImageSource.gallery);
                              // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                              child: picModel[i].url != "" &&
                                      picModel[i].url != null &&
                                      picModel[i].url!.isNotEmpty
                                  ? Container(
                                      width: 88,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  picModel[i].url.toString()),
                                              fit: BoxFit.fill)))
                                  : Container(
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
                                      child: const Icon(Icons.add,
                                          color: Color(0x7f666161))),
                            );
                          })),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Catalogues",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
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
                          itemCount: 8,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,
                                  childAspectRatio: 1.5 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 8),
                          itemBuilder: (context, i) {
                            print("eeeeeeeeeeeee${catalogueList[i].url}");
                            return GestureDetector(
                              onTap: () {
                                isCatalogue = true;
                                indexImage = i;
                                setState(() {});
                                getImage(ImageSource.gallery);
                              },
                              // getImage(ImageSource.gallery);
                              // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                              child: catalogueList[i].url != "" &&
                                      catalogueList[i].url!.isNotEmpty
                                  ? Container(
                                      width: 88,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  catalogueList[i]
                                                      .url
                                                      .toString()),
                                              fit: BoxFit.fill)),
                                    )
                                  : Container(
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
                                      child: const Icon(Icons.add,
                                          color: Color(0x7f666161))),
                            );
                          })),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        "Manufactures",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      unfocusMethod();
                      context.read<InventoryBloc>().add(const GetManufactureEvent());
                      _showModalBottomSheetManufacturer();
                    },
                    child: Container(
                      width: w,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            manufacture ?? "-  Select  -",
                            style: TextStyle(
                              color: Color(0xbf666161),
                              fontSize: w / 24,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0x7f666161))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Return Type",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                      child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color(0x7f666161)),
                          elevation: 1,
                          underline: Container(),
                          value: selectReturnType,
                          items: returnList?.map((String items) {
                            return DropdownMenuItem(
                              alignment: Alignment.centerLeft,
                              enabled: true,
                              value: items,
                              child: Text(items,
                                  style: GoogleFonts.poppins(
                                      color: ColorPalette.black)),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              selectReturnType = value;
                            });
                          },
                          hint: Text(
                            returntype ?? "null",
                            style: TextStyle(
                              color: Color(0xbf666161),
                              fontSize: w / 24,
                            ),
                          ))),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: returnTimeController,
                    keyboardType: TextInputType.number,
                    label: "Return Time",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Replacement Type",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0x7f666161)),
                        elevation: 1,
                        underline: Container(),
                        value: selectReplacementType,
                        items: returnList?.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.black)),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectReplacementType = value;
                          });
                        },
                        // hint: Text(
                        //   "Select",
                        //   style: TextStyle(
                        //     color: Color(0xbf666161),
                        //     fontSize: w / 24,
                        //   ),
                        // )
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: replacementTimeController,
                    keyboardType: TextInputType.number,
                    label: "Replacement Time",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Shelf Type",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Color(0x7f666161)),
                        elevation: 1,
                        underline: Container(),
                        value: shelfType,
                        items: returnList?.map((String items) {
                          return DropdownMenuItem(
                            alignment: Alignment.centerLeft,
                            enabled: true,
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.black)),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            shelfType = value;
                          });
                        },
                        // hint: Text(
                        //   "Select",
                        //   style: TextStyle(
                        //     color: Color(0xbf666161),
                        //     fontSize: w / 24,
                        //   ),
                        // )
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: shelfController,
                    keyboardType: TextInputType.number,
                    label: "Shelf Time",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Siblings",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      unfocusMethod();
                      _showModalBottomSheetSibling();
                    },
                    child: Container(
                      width: w,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: w / 1.3,
                            child: Text(
                              siblings,
                              style: TextStyle(
                                color: Color(0xbf666161),
                                fontSize: w / 24,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0x7f666161))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // variantList?.vendorDetails != []
                  //     ?
                  // Column(
                  //         children: [
                  Text(
                    "Vendors",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  ListView.separated(
                    itemCount: ManufactureList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print("Hello vendor");
                      return Container(
                        // color: Colors.green,
                        child: InventoryVendorListCard(
                          name: ManufactureList[index].name ?? "",
                          id: ManufactureList[index].id.toString() ?? "",
                          controller: vendorReference[index],
                          index: index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 6,
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: grossWeightController,
                    keyboardType: TextInputType.text,
                    label: "Gross Weight",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: netWeightController,
                    keyboardType: TextInputType.text,
                    label: "Net Weight",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: unitCostController,
                    keyboardType: TextInputType.number,
                    label: "Unit Cost",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: actualCostController,
                    keyboardType: TextInputType.number,
                    label: "Actual Cost",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    controller: minSalesController,
                    keyboardType: TextInputType.text,
                    label: "min sales order limit",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: maxSalesController,
                    label: "Max sales order limit",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: vatController,
                    label: "Vat",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: excessTaxController,
                    label: "Excess Tax",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: minGpController,
                    label: "Minimum GP",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: maxGpController,
                    label: "maximum GP",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: avgGpController,
                    label: "average GP",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.number,
                    controller: targetGpController,
                    label: "targeted GP",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    isMandatory: false,
                    keyboardType: TextInputType.text,
                    controller: videoController,
                    label: "Video Url",
                    hint: "",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Variant Height",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OtherCard(
                      controller: heightController,
                      // measure: measureStatus,
                      focusNode: heightFocus,
                      hint: "CM"),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Variant weight",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OtherCard(
                    controller: weightController,
                    // measure: kiloStatus,
                    focusNode: weightFocus,
                    hint: "KG",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Variant width",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OtherCard(
                    controller: widthController,
                    // measure: measureStatus,
                    focusNode: widthFocus,
                    hint: "CM",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Variant Length",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OtherCard(
                    controller: lengthController,
                    // measure: measureStatus,
                    focusNode: lengthFocus,
                    hint: "CM",
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TableCard(
                    // head: "Additional Information",
                    title1: "Key",
                    title2: "Value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    headController: additionalHeadController,
                    keyController: additionalKeyController,
                    valueController: additionalValueController,
                  ),
                  SingleTableCard(
                      head: "storage",
                      title: "Name",
                      content: 'Enter Value',
                      headController: storageController,
                      nameController: storageNameController),
                  SingleTableCard(
                      head: "Ingredients",
                      title: "Name",
                      content: 'Enter Value',
                      headController: ingredientsController,
                      nameController: ingredientsNameController),
                  TableCard(
                    // head: "Important Info",
                    title1: "Key",
                    title2: "value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    keyController: impKeyController,
                    valueController: impValueController,
                    headController: impHeadController,
                  ),
                  TableCard(
                    // head: "Nutrial Facts",
                    title1: "Key",
                    title2: "value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    keyController: nutriKeyController,
                    valueController: nutriValueController,
                    headController: nutriHeadController,
                  ),
                  TableCard(
                    //head: "Product Details",
                    title1: "Key",
                    title2: "value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    keyController: productDetailsKeyController,
                    valueController: productDetailsValueController,
                    headController: productDetailsHeadController,
                  ),
                  TableCard(
                    // head: "Specifications",
                    title1: "Key",
                    title2: "value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    keyController: specificationKeyController,
                    valueController: specificationValueController,
                    headController: specificationHeadController,
                  ),
                  SingleTableCard(
                    headController: usageDirectionController,
                    nameController: usageDirectionNameController,
                    head: "Usage Direction",
                    title: "Name",
                    content: 'Enter Value',
                  ),
                  TableCard(
                    // head: "Product Features",
                    title1: "Key",
                    title2: "value",
                    content1: "Enter  name",
                    content2: "Enter details",
                    keyController: productFeatureKeyController,
                    valueController: productFeatureValueController,
                    headController: productFeatureHeadController,
                  ),
                  SingleTableCard(
                    headController: aboutController,
                    nameController: aboutNameController,
                    head: "About Products",
                    title: "Name",
                    content: 'Enter Value',
                  ),
                  SizedBox(height: 10,),
                  ProductBehaviourCard(
                    isUpdate: true,
                    headController: headController,
                    ageGroupController: ageGroupController,
                    ageFocus: ageFocus,
                    countriesFocus: countriesFocus,
                    ethnicFocus: ethnicFocus,
                    genderFocus: genderFocus,
                    purposeFocus: purposeFocus,
                    countryController: countryController,
                    ethnicController: ethnicController,
                    genderController: genderController,
                    purposeController: purposeController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            unfocusMethod();
                            isGift = !isGift;
                            setState(() {});
                          },
                          child: isGift
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxActiveIcon))
                              : Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxIcon))),
                      Text(
                        "Gift option available",
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontWeight: FontWeight.w500,
                          fontSize: w / 22,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            unfocusMethod();
                            isWrap = !isWrap;
                            setState(() {});
                          },
                          child: isWrap
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxActiveIcon))
                              : Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxIcon))),
                      Text(
                        "Wrap option available",
                        style: TextStyle(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            unfocusMethod();
                            isSales = !isSales;
                            setState(() {});
                          },
                          child: isSales
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxActiveIcon))
                              : Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SvgPicture.string(
                                      OrderSvg().checkBoxIcon))),
                      Text(
                        "Sales block available",
                        style: TextStyle(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                      onPressed: () {
                        unfocusMethod();
                        Abouttheproducts? additionalInfoDataName;
                        List<KeyValues>? additionalInfoData = [];
                        for (int i = 0;
                            i < additionalKeyController.length;
                            i++) {
                          additionalInfoData.add(KeyValues(
                              value: additionalValueController[i].text,
                              key: additionalKeyController[i].text));
                        }
                        additionalInfoDataName = Abouttheproducts(
                            name: additionalHeadController.text,
                            keyvalues: additionalInfoData);

                        for (int i = 0; i < aboutNameController.length; i++) {
                          aboutNameData?.add(
                              NameCreate(name: aboutNameController[i].text));
                        }
                        aboutData = ProductDetails(
                            name: aboutController.text,
                            keyvalues: aboutNameData);

                        for (int i = 0;
                            i < productDetailsKeyController.length;
                            i++) {
                          // print(
                          //     "product details Index$i\t ${additionalValueController[i].text}");
                          // print(
                          //     "product details Index$i\t ${additionalKeyController[i].text}");
                          productDetailsData?.add(KeyValues(
                              value: productDetailsValueController[i].text,
                              key: productDetailsKeyController[i].text));
                        }
                        productDetailsDataName = Abouttheproducts(
                            name: productDetailsHeadController.text,
                            keyvalues: productDetailsData);

                        for (int i = 0;
                            i < productFeatureKeyController.length;
                            i++) {
                          // print(
                          //     "productFeature Index$i\t ${productFeatureValueController[i].text}");
                          // print(
                          //     "productFeature Index$i\t ${productFeatureKeyController[i].text}");
                          productFeatureData?.add(KeyValues(
                              value: productFeatureValueController[i].text,
                              key: productFeatureKeyController[i].text));
                        }
                        productFeatureDataName = Abouttheproducts(
                            name: productFeatureHeadController.text,
                            keyvalues: productFeatureData);

                        for (int i = 0; i < nutriValueController.length; i++) {
                          print(
                              "nutri Index$i\t ${nutriValueController[i].text}");
                          print(
                              "nutri Index$i\t ${nutriKeyController[i].text}");
                          nutriData?.add(KeyValues(
                              value: nutriValueController[i].text,
                              key: nutriKeyController[i].text));
                        }
                        nutriDataName = Abouttheproducts(
                            name: nutriHeadController.text,
                            keyvalues: nutriData);

                        for (int i = 0;
                            i < ingredientsNameController.length;
                            i++) {
                          ingredientsNameData?.add(
                              NameCreate(name: storageNameController[i].text));
                        }
                        ingredientsData = ProductDetails(
                            name: ingredientsController.text,
                            keyvalues: ingredientsNameData);
                        for (int i = 0;
                            i < usageDirectionNameController.length;
                            i++) {
                          usageDirectionNameData?.add(NameCreate(
                              name: usageDirectionNameController[i].text));
                        }
                        usageDirectionData = ProductDetails(
                            name: usageDirectionController.text,
                            keyvalues: usageDirectionNameData);
                        for (int i = 0; i < storageNameController.length; i++) {
                          storageNameData?.add(
                              NameCreate(name: storageNameController[i].text));
                        }
                        storageData = ProductDetails(
                            name: storageController.text,
                            keyvalues: storageNameData);
                        for (int i = 0; i < impKeyController.length; i++) {
                          print("imp Index$i\t ${impValueController[i].text}");
                          print("imp Index$i\t ${impKeyController[i].text}");
                          impInfoData?.add(KeyValues(
                              value: impValueController[i].text,
                              key: impKeyController[i].text));
                        }
                        impInfoDataName = Abouttheproducts(
                            name: impHeadController.text,
                            keyvalues: impInfoData);
                            print("ethniccc contollerrr ${ethnicController.text}");
                        productBehaviour?.add(SubClassBehaviour(
                            ageGroup: ageGroupController.text,
                            countries: countryController.text,
                            ethnic: ethnicController.text,
                            genderGroup: genderController.text,
                            purpose: purposeController.text));
                            print("ethniccc contollerrr $productBehaviour");

                        // productBehaviour =
                        //       SubClassBehaviour(
                        //           ageGroup: ageGroupController.text,
                        //           countries: countryController.text,
                        //           ethnic: ethnicController.text,
                        //           genderGroup: genderController.text,
                        //           purpose: purposeController.text)
                        //     );
                        print("heightController.text${heightController.text}");
                        print("sales uom${salesUom}");
                        try {
                          context.read<InventoryBloc>().add(UpdateVariantEvent(
                              id: widget.id,
                              dataModel: CreateVariantModel(
                                // siblingCode: siblings,
                                
                                  variantName: variantList?.name,
                                  salesUom: salesUom,
                                  barcode: variantList?.barcode?.barcodeNumber,
                                  returnType: returntype,
                                  returnTime:
                                      returnTimeController.text,
                                  shelfType: shelfType,
                                  shelfTime: int.tryParse(shelfController.text),
                                  // height: 10,
                                  height:
                                      double.tryParse(heightController.text),
                                  weight:
                                      double.tryParse(weightController.text),
                                  length:
                                      double.tryParse(lengthController.text),
                                  width: double.tryParse(widthController.text),
                                  needMultipleIntegration: true,
                                  haveWrapOption: isWrap,
                                  haveGiftOption: isGift,
                                  inventoryId: authentication
                                      .authenticatedUser.organisationCode,
                                  searchName: searchNameController.text,
                                  displayName: displayNameController.text,
                                  description: descriptionController.text,
                                  arabicDescription:
                                      arabicDescriptionController.text,
                                  additionalDescription:
                                      additionalDescriptionController.text,
                                  posName: posNameController.text,
                                  grossWeight: grossWeightController.text,
                                  netWeight: netWeightController.text,
                                  unitCost:
                                      double.tryParse(unitCostController.text),
                                  actualCost:
                                      double.tryParse(actualCostController.text),
                                  producedCountry:
                                      producedCountryController.text,
                                      
                                  salesBlock: true,
                                  minSalesOrderLimit:
                                      int.tryParse(minSalesController.text),
                                  maxSalesOrderLimit:
                                      int.tryParse(maxSalesController.text),
                                  itemImage: true,
                                  itemCatalog: true,
                                  image1: picModel[0].data,
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
                                  videoUrl: videoController.text,
                                  minimumGp:
                                      double.tryParse(minGpController.text),
                                  maximumGp:
                                      double.tryParse(maxGpController.text),
                                  averageGp:
                                      double.tryParse(avgGpController.text),
                                  targetedGp:
                                      double.tryParse(targetGpController.text),
                                  vat: double.tryParse(vatController.text),
                                  excessTax:
                                      double.tryParse(excessTaxController.text),
                                  additionalInfo: additionalInfoDataName,
                                  aboutTheProducts: aboutData,
                                  productDetails: productDetailsDataName,
                                  productFeatures: productFeatureDataName,
                                  nutrientsFacts: nutriDataName,
                                  ingredients: ingredientsData,
                                  usageDirection: usageDirectionData,
                                  storage: storageData,
                                  importantInfo: impInfoDataName,
                                  productBehaviour: productBehaviour,
                                  alternativeBarcode: [],
                                  manufactureName: manufacture,
                                  manufactureId: manufactureId,
                                  siblingId: siblingId,
                                  isActive: true
                                  // height: int.parse(he.text),

                                  // aboutTheProducts:additionalInfoDataName
                                  )));
                        } catch (e) {
                          print("exxxxxxccc $e");
                        }
                        context.read<InventoryBloc>().add(UpdateVariantEvent(
                            id: widget.id,
                            dataModel: CreateVariantModel(
                              
                              replacementTime: replacementTimeController.text,
                              replacementType: selectReplacementType,
                                variantName: variantList?.name,
                                salesUom: salesUom,
                                barcode: variantList?.barcode?.barcodeNumber,
                                returnType: returntype,
                                returnTime:
                                    returnTimeController.text,
                                shelfType: shelfType,
                                shelfTime: int.tryParse(shelfController.text),
                                // height: 10,
                                height: double.tryParse(heightController.text),
                                weight: double.tryParse(weightController.text),
                                length: double.tryParse(lengthController.text),
                                width: double.tryParse(widthController.text),
                                needMultipleIntegration: true,
                                haveWrapOption: isWrap,
                                haveGiftOption: isGift,
                                inventoryId: authentication
                                    .authenticatedUser.organisationCode,
                                searchName: searchNameController.text,
                                displayName: displayNameController.text,
                                description: descriptionController.text,
                                arabicDescription:
                                    arabicDescriptionController.text,
                                additionalDescription:
                                    additionalDescriptionController.text,
                                posName: posNameController.text,
                                grossWeight: grossWeightController.text,
                                netWeight: netWeightController.text,
                                unitCost: double.tryParse(unitCostController.text),
                                actualCost:
                                    double.tryParse(actualCostController.text),
                                producedCountry: producedCountryController.text,
                                salesBlock: true,
                                minSalesOrderLimit:
                                    int.tryParse(minSalesController.text),
                                maxSalesOrderLimit:
                                    int.tryParse(maxSalesController.text),
                                itemImage: true,
                                itemCatalog: true,
                                image1: picModel[0].data,
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
                                videoUrl: videoController.text,
                                minimumGp:
                                    double.tryParse(minGpController.text),
                                maximumGp:
                                    double.tryParse(maxGpController.text),
                                averageGp:
                                    double.tryParse(avgGpController.text),
                                targetedGp:
                                    double.tryParse(targetGpController.text),
                                vat: double.tryParse(vatController.text),
                                excessTax:
                                    double.tryParse(excessTaxController.text),
                                additionalInfo: additionalInfoDataName,
                                aboutTheProducts: aboutData,
                                productDetails: productDetailsDataName,
                                productFeatures: productFeatureDataName,
                                nutrientsFacts: nutriDataName,
                                ingredients: ingredientsData,
                                usageDirection: usageDirectionData,
                                storage: storageData,
                                importantInfo: impInfoDataName,
                                productBehaviour: productBehaviour,
                                alternativeBarcode: [],
                                manufactureName: manufacture,
                                manufactureId: manufactureId,
                                siblingId: siblingId,
                                isActive: true
                                // height: int.parse(he.text),

                                // aboutTheProducts:additionalInfoDataName
                                )));
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
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheetSibling() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: w,
                          padding: EdgeInsets.only(right: 10, top: 10),
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Siblings",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      stateSetter(() {
                                        // widget.onChangeSibling!(
                                        //     dataList?[index].name ?? "",
                                        //     dataList?[index].id ?? 0);
                                        siblings = dataList?[index].name ?? "";
                                        siblingId = dataList?[index].id ?? 0;
                                        siblingCode = dataList?[index].code ?? "";
                                        isSelect = index;
                                      });
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: isSelect == index
                                        ? Container(
                                            // padding: EdgeInsets.all(10),
                                            child: SvgPicture.string(
                                                OrderSvg().checkBoxActiveIcon))
                                        : SvgPicture.string(
                                            OrderSvg().checkBoxIcon,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: w / 1.2,
                                      child: Text(dataList?[index].name ?? ""))
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: dataList!.length),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetSales() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: w,
                          padding: EdgeInsets.only(right: 10, top: 10),
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Sales Uom",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      uomList!.isEmpty
                          ? Container(
                              width: w, child: Text('Base uom not available'))
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // widget.onChangeSalesUom!(
                                            //     uomList?[index].name ?? "", uomList?[index].id??0 );
                                            sales = uomList?[index].name ?? "";
                                            salesUom = uomList?[index].id ?? 0;
                                            isSelectSales = index;
                                          });
                                          onRefresh();
                                          Navigator.pop(context);
                                        },
                                        child: isSelectSales == index
                                            ? Container(
                                                // padding: EdgeInsets.all(10),
                                                child: SvgPicture.string(
                                                    OrderSvg()
                                                        .checkBoxActiveIcon))
                                            : SvgPicture.string(
                                                OrderSvg().checkBoxIcon,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(uomList?[index].name ?? "")
                                    ],
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: uomList!.length),

                      // SizedBox(height: 40,),
                      // Container(
                      //   padding: EdgeInsets.all(16),
                      //   child: GradientButton(
                      //       color: ColorPalette.primary,
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       gradient: const LinearGradient(
                      //           begin: Alignment.topCenter,
                      //           end: Alignment.bottomCenter,
                      //           colors: [
                      //             ColorPalette.primary,
                      //             ColorPalette.primary
                      //           ]),
                      //       child: Text(
                      //         "Continue",
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.roboto(
                      //           color: Colors.white,
                      //           fontSize: w/22,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       )),
                      // )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetManufacturer() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: w,
                          padding: EdgeInsets.only(right: 10, top: 10),
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Manufacture",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: SearchCard(
                            hint: "Search manufacture",
                            onchange: (val) {
                              print("Inside on Chnge$val");
                              context
                                  .read<InventoryBloc>()
                                  .add(GetManufactureEvent(search: val));
                              setState(() {});
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ManufactureList.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          stateSetter(() {
                                            manufacture = ManufactureList[index]
                                                    .name ??
                                                "";
                                            manufactureId =
                                                ManufactureList[index].id ?? 0;
                                            select = index;
                                          });
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: select == index
                                            ? SvgPicture.string(
                                                OrderSvg().checkBoxActiveIcon)
                                            : SvgPicture.string(
                                                OrderSvg().checkBoxIcon,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(ManufactureList[index]
                                              .name ??
                                          "")
                                    ],
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: ManufactureList.length)
                          : Text("Loading.........."),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> getImage(source) async {
    try {
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        BlocProvider.of<InventoryBloc>(context)
            .add(PicEvent(image: cropImage!));
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
