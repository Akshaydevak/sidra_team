import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/inventory_new_list.dart';
import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/model/manufacture_model.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:cluster/presentation/promotion_app/buy_more_get_form/costumtable.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../product_hub/widget/table_card.dart';
import '../widget/product_behaviour_card.dart';

Abouttheproducts? aboutProduct;
ProductDetails? singleProduct;

class VariationsTab extends StatefulWidget {
  final TextEditingController? storageController;
  final TextEditingController? ingredientsController;
  final TextEditingController? usageDirectionController;
  final TextEditingController? aboutController;

  List<TextEditingController> storageNameController = [];

  List<TextEditingController> ingredientsNameController = [];

  List<TextEditingController> usageDirectionNameController = [];

  List<TextEditingController> aboutNameController = [];

  final TextEditingController? additionalHeadController;
  List<TextEditingController> additionalKeyController = [];
  List<TextEditingController> additionalValueController = [];
  final TextEditingController? impHeadController;
  List<TextEditingController> impKeyController = [];
  List<TextEditingController> impValueController = [];
  final TextEditingController? nutriHeadController;
  List<TextEditingController> nutriKeyController = [];
  List<TextEditingController> nutriValueController = [];
  final TextEditingController? productDetailsHeadController;
  List<TextEditingController> productDetailsKeyController = [];
  List<TextEditingController> productDetailsValueController = [];
  final TextEditingController? specificationHeadController;
  List<TextEditingController> specificationKeyController = [];
  List<TextEditingController> specificationValueController = [];
  final TextEditingController? productFeatureHeadController;
  List<TextEditingController> productFeatureKeyController = [];
  List<TextEditingController> productFeatureValueController = [];

  final TextEditingController? ethnicController;
  final TextEditingController? purposeController;
  final TextEditingController? ageGroupController;
  final TextEditingController? countryController;
  final TextEditingController? genderController;
  final TextEditingController? headController;
  final int? itemId, varientFrameId;
  final Function(String, int)? onChangeManufacture;
  final String? manufacture;

  VariationsTab(
      {Key? key,
        this.manufacture,
      this.itemId,
      this.varientFrameId,
      this.onChangeManufacture,
      this.ethnicController,
      this.purposeController,
      this.ageGroupController,
      this.countryController,
      this.genderController,
      this.headController,
      this.storageController,
      required this.storageNameController,
      required this.aboutNameController,
      required this.ingredientsNameController,
      required this.usageDirectionNameController,
      this.ingredientsController,
      this.usageDirectionController,
      this.aboutController,
      this.additionalHeadController,
      required this.additionalKeyController,
      required this.additionalValueController,
      this.impHeadController,
      required this.impKeyController,
      required this.impValueController,
      this.nutriHeadController,
      required this.nutriKeyController,
      required this.nutriValueController,
      this.productDetailsHeadController,
      required this.productDetailsKeyController,
      required this.productDetailsValueController,
      this.productFeatureHeadController,
      required this.productFeatureKeyController,
      required this.productFeatureValueController,
      this.specificationHeadController,
      required this.specificationKeyController,
      required this.specificationValueController,
      })
      : super(key: key);

  @override
  State<VariationsTab> createState() => _VariationsTabState();
}

class _VariationsTabState extends State<VariationsTab> {
// List<VarintValue> variantValues=[];
  List<InventoryModel>? inventory;
  List<InventoryModel> combination = [];
  String? selItem = "- select -";

  void onselectVariant(String val) {
    setState(() {
      selItem = val;
    });
  }

  // TextEditingController storageController = TextEditingController();
  // TextEditingController ingredientsController = TextEditingController();
  // TextEditingController usageDirectionController = TextEditingController();
  // TextEditingController aboutController = TextEditingController();
  // List<TextEditingController> storageNameController=[] ;

  int? select;
  List<int>? selectList = [];
  List<ManufactureModel> ManufactureList = [];
  String manufacture = "- select -";
  List<InventoryModel>? uomList = [];

  @override
  void initState() {
    print("inside additional info header ${widget.additionalHeadController?.text}");
    print("inside variant${widget.varientFrameId}");
manufacture=widget.manufacture??"";
    BlocProvider.of<InventoryBloc>(context)
        .add(GetvariantEvent(itemId: widget.itemId));
    BlocProvider.of<InventoryBloc>(context)
        .add(GetCombinationEvent(id: widget.varientFrameId));
    context.read<InventoryBloc>().add(const GetManufactureEvent());
    //GetManufacturerEvent
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("additional header name${widget.additionalHeadController?.text}");
    var w = MediaQuery.of(context).size.width;
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        print("state$state");
        if (state is VariantLoading) {
          print("Loading");
        }
        if (state is VariantSuccess) {
          inventory = state.inventory;
          print("Success${inventory}");
          setState(() {});
        }
        if (state is CombinationSuccess) {

          combination = state.inventory ?? [];
          print("Success${combination}");
          variantValues.add(VarintValue(
              attributeCode: combination[0].code,
              attributeId: combination[0].id,
              key: combination[0].attributeData?.attributeName,
              value: combination[0].values?[0]));
          for (int j = 0; j < combination.length; j++) {
            selectList?.add(0);

          }
          setState(() {});
        }
        if (state is ManufacturerSuccess) {
          ManufactureList = state.data ?? [];
          print("ManufactureList$ManufactureList");
        }
        //   ManufactureList = state.inventory ?? [];
        //   print("Success${ManufactureList}");
        //   for (int j = 0; j < ManufactureList.length; j++) {
        //     selectList?.add(0);
        //   }
        //   setState(() {});
        // }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _showModalBottomSheet();
            },
            child: Text(
              "Variant Under Item",
              style: GoogleFonts.roboto(
                color: ColorPalette.primary,
                fontSize: w / 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 30,
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
              SizedBox(
                width: 10,
              ),
              SvgPicture.string(
                SellerSvg().validationIcon,
                height: 15,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              // context.read<InventoryBloc>().add(const GetManufactureEvent());
              _showModalBottomSheetManufacturer();
            },
            child: Container(
              width: w,
              // padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //height: 20.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        combination[index].attributeData?.attributeName ?? "",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: w,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            child: Row(
                                children: List.generate(
                                    combination[index].values!.length, (i) {
                                      print("combination[index].name${combination[index].attributeData?.attributeName}");
                              return GestureDetector(
                                onTap: () {
                                  selectList?.setAll(index, [i]);

                                  variantValues.setAll(index, [
                                    VarintValue(
                                        attributeCode: combination[index].code,
                                        attributeId: combination[index].id,
                                        key: combination[index].attributeData?.attributeName,
                                        value: combination[index].values?[i])
                                  ]);
                                  // print("VariantValue..........${variantValues[index].attributeId}");
                                  setState(() {
                                    select = i;
                                  });
                                  print("eeeeeeeeeeeeeeeee${variantValues.length}");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 60,
                                  height: 60,
                                  decoration: selectList?[index] == i
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xfffe5762),
                                            width: 1,
                                          ),
                                          color: Color(0x0cfe5762),
                                        )
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                  alignment: Alignment.center,
                                  child: Text(combination[index].values![i]),
                                ),
                              );
                            }))),
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 16,
                  ),
              itemCount: combination.length),
          TableCard(
            // head: "Additional Information",
            title1: "Key",
            title2: "Value",
            content1: "Enter  name",
            content2: "Enter details",
            keyController: widget.additionalKeyController,
            valueController: widget.additionalValueController,
            headController: widget.additionalHeadController,
          ),
          SingleTableCard(
              head: "storage",
              title: "Name",
              content: 'Enter Value',
              headController: widget.storageController,
              nameController: widget.storageNameController),
          SingleTableCard(
              head: "Ingredients",
              title: "Name",
              content: 'Enter Value',
              headController: widget.ingredientsController,
              nameController: widget.ingredientsNameController),
          TableCard(
            // head: "Important Info",
            title1: "Key",
            title2: "value",
            content1: "Enter  name",
            content2: "Enter details",
            keyController: widget.impKeyController,
            valueController: widget.impValueController,
            headController: widget.impHeadController,
          ),
          TableCard(
            // head: "Nutrial Facts",
            title1: "Key",
            title2: "value",
            content1: "Enter  name",
            content2: "Enter details",
            keyController: widget.nutriKeyController,
            valueController: widget.nutriValueController,
            headController: widget.nutriHeadController,
          ),
          TableCard(
            // head: "Product Details",
            title1: "Key",
            title2: "value",
            content1: "Enter  name",
            content2: "Enter details",
            keyController: widget.productDetailsKeyController,
            valueController: widget.productDetailsValueController,
            headController: widget.productDetailsHeadController,
          ),
          TableCard(
            // head: "Specifications",
            title1: "Key",
            title2: "value",
            content1: "Enter  name",
            content2: "Enter details",
            keyController: widget.specificationKeyController,
            valueController: widget.specificationValueController,
            headController: widget.specificationHeadController,
          ),
          SingleTableCard(
            headController: widget.usageDirectionController,
            nameController: widget.usageDirectionNameController,
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
            keyController: widget.productFeatureKeyController,
            valueController: widget.productFeatureValueController,
            headController: widget.productFeatureHeadController,
          ),
          SingleTableCard(
            headController: widget.aboutController,
            nameController: widget.aboutNameController,
            head: "About Products",
            title: "Name",
            content: 'Enter Value',
          ),
          ProductBehaviourCard(
            headController: widget.headController,
            ageGroupController: widget.ageGroupController,
            countryController: widget.countryController,
            ethnicController: widget.ethnicController,
            genderController: widget.genderController,
            purposeController: widget.purposeController,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet() {
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
        isScrollControlled: true,
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
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Variant under Items",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: ColorPalette.divider,
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            color: ColorPalette.divider,
                            thickness: 1.1,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: inventory?.length??0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    width: w / 1.3,
                                    child: Text(
                                      inventory?[index].name ?? "",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    color: ColorPalette.divider,
                                    height: 1,
                                    width: w,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])),
                  ));
            },
          );
        });
  }

  _showModalBottomSheetManufacturer() {
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
                        onTap: (){
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
                      ManufactureList.isNotEmpty? ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      stateSetter(() {
                                        widget.onChangeManufacture!(
                                            ManufactureList[index]
                                                    .name ??
                                                "",
                                            ManufactureList[index].id ?? 0);
                                        manufacture = ManufactureList[index]
                                                .name ??
                                            "";
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
                                  Text(
                                      ManufactureList[index].name ??
                                          "")
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: ManufactureList.length):Text("Loading.........."),

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
}
