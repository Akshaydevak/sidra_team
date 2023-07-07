import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/division_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/warranty_pages/warranty_cards.dart';
import 'package:cluster/presentation/product_hub/warranty/warranty_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../../promotion_app/buy_more_get_form/costumtable.dart';
import '../../promotion_app/dropdown_card.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';

class CreateWarrantyInventory extends StatefulWidget {
  final InventoryModel? variantList;
  const CreateWarrantyInventory({Key? key, this.variantList}) : super(key: key);

  @override
  State<CreateWarrantyInventory> createState() =>
      _CreateWarrantyInventoryState();
}

class _CreateWarrantyInventoryState extends State<CreateWarrantyInventory> {
  bool isActive = true;
  String warrantyTypeName = '';
  int warrantyTypeId = 0;
  TextEditingController titleWarrantyType = TextEditingController();
  TextEditingController descriptionWarrantyType = TextEditingController();
  WarrantyTypeRead? readData;
  List<ConditionList> termsList = [];
  List<TextEditingController> termsListController = [];
  TextEditingController termsControllr = TextEditingController();
  bool? onChangeVal = false;
  TextEditingController warrantyDurationController = TextEditingController();
  TextEditingController warrantyDescriptionController = TextEditingController();
  TextEditingController warrantypriceController = TextEditingController();
  TextEditingController warrantySectionController = TextEditingController();
  List<WarrantyDetailsModel> additionalData=[];
  WarrantyReadModel? readWarrantyData;
  void additionalClass(List<WarrantyDetailsModel> product) {
    additionalData = product;
    setState(() {});
    print("uuu${additionalData?[0].conditionList}");
    // print("uuu$idList");
  }
  List<WarrantyDetailsModel> extendedList=[];


  void extendedClass(List<WarrantyDetailsModel> product) {
    extendedList = product;
    extendedList.add(WarrantyDetailsModel(exConditionList: [ConditionList(data: "abcdd",),ConditionList(data: "efghh")],
        exdescription: "ddddd"));
    // extendedList=[WarrantyD
    // etailsModel(exConditionList: [ConditionList(data: "abcdd",),ConditionList(data: "efghh")])];
    // print("uuu${extendedList?[0].exdescription}");
    // print("uuu${extendedList?[0].exConditionList}");
    setState(() {});

    // print("uuu$idList");
  }
  bool isEdit=false;

  @override
  Widget build(BuildContext context) {
    // if(extendedList.isNotEmpty||additionalData.isNotEmpty) {
    //   // print("checkinggggg .... ${extendedList?[0].exdescription}");
    //   for(int i=0;i<additionalData.length;i++){
    //     print("checkinggggg ....${additionalData?[i].conditionList?[i]}");
    //   }
    //
    //   // print("checkinggggg .... ${extendedList?[0].exConditionList}");
    // }
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Create Warranty", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is CreateWarrantyTypeLoading) {
                showSnackBar(context,
                    message: "Loading...", color: Colors.black);
              }
              if (state is CreateWarrantyTypeSuccess) {
                Navigator.pop(context);
                titleWarrantyType.clear();
                descriptionWarrantyType.clear();
                context.read<InventoryBloc>().add(GetWarrantyTypeListEvent(""));
                showSnackBar(context,
                    message: state.successMessage ?? "", color: Colors.black);
              }
              // TODO: implement listener
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is WarrantyTypeReadLoading) {
                customCupertinoLoading();
              }
              if (state is WarrantyTypeReadSuccess) {
                _showModalBottomSheetNew(context, true);
                readData = state.readData;
                titleWarrantyType.text = state.readData.title ?? "";
                descriptionWarrantyType.text = state.readData.description ?? "";
                setState(() {});
              }
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is WarrantyTypeUpdateLoading) {
                showSnackBar(context,
                    message: "Loading...", color: Colors.black);
              }
              if (state is WarrantyTypeUpdateSuccess) {
                Navigator.pop(context);
                titleWarrantyType.clear();
                descriptionWarrantyType.clear();
                context.read<InventoryBloc>().add(GetWarrantyTypeListEvent(""));
                showSnackBar(context,
                    message: state.successMessage ?? "", color: Colors.black);
              }
              // TODO: implement listener
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is DeleteWarrantyTypeLoading) {
                showSnackBar(context,
                    message: "Loading...", color: Colors.black);
              }
              if (state is DeleteWarrantyTypeSuccess) {
                Navigator.pop(context);

                context.read<InventoryBloc>().add(GetWarrantyTypeListEvent(""));
                showSnackBar(context,
                    message: "Warranty Type Deleted Successfully",
                    color: Colors.black);
              }
              // TODO: implement listener
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if(state is CreateWarrantyLoading){
                showSnackBar(context, message: "Loading...", color: Colors.black);
              }
              if(state is CreateWarrantySuccess){
                Navigator.pop(context);
                context.read<InventoryBloc>().add(ProductStockListEvent("", ""));
                showSnackBar(context, message: state.successMessage??"", color: Colors.black);
              }
              // TODO: implement listener
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is WarrantyReadLoading) {

              } else if (state is WarrantyReadSuccess) {
                print("Sttatttat${state.divisionModel.warrantyCode}");
                readWarrantyData=state.divisionModel;
                warrantyTypeName=readWarrantyData?.warrantyTypeName??"";
                warrantyDurationController.text=readWarrantyData?.duration.toString()??"";
                warrantyDescriptionController.text=readWarrantyData?.description??"";
                // warrantySectionController.text=readWarrantyData?.wa
                isActive=readWarrantyData?.isActive??false;
                isEdit=true;
                for(int i=0;i<readWarrantyData!.warrantyCoditions!.length;i++){
                  termsList.add(ConditionList(
                      title: readWarrantyData!.warrantyCoditions?[i].title,
                      id: readWarrantyData!.warrantyCoditions?[i].id));
                  termsListController.add(TextEditingController(text: readWarrantyData!.warrantyCoditions?[i].title));
                }

                setState(() {

                });

              } else if (state is WarrantyReadFailed) {
                showSnackBar(context,
                    message: state.error, color: ColorPalette.black);
              }
            },
          ),
        ],
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEdit==true?ReadDropDownCard(
                        selValue: warrantyTypeName,
                        label: "Warranty Type",
                        onTap: () {
                          context
                              .read<InventoryBloc>()
                              .add(GetWarrantyTypeListEvent(""));
                          _showModalBottomSheetOfferPeriod(warrantyTypeName);
                        },
                      ):DropDownCard(
                        selValue: warrantyTypeName,
                        label: "Warranty Type",
                        onTap: () {
                          context
                              .read<InventoryBloc>()
                              .add(GetWarrantyTypeListEvent(""));
                          _showModalBottomSheetOfferPeriod(warrantyTypeName);
                        },
                      ),
                      TextFieldTab(
                        label: "Duration",
                        hint: "Eg. SEM",
                        controller: warrantyDurationController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFieldTab(
                        label: "Description",
                        hint: "Eg. SEM",
                        controller: warrantyDescriptionController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFieldTab(
                        label: "Warranty Section",
                        hint: "Eg. SEM",
                        controller: warrantySectionController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: w,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14),
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
                                "Is_Active",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // isActive = !isActive;
                                    });
                                  },
                                  child: SvgPicture.string(isActive
                                      ? HomeSvg().toggleActive
                                      : HomeSvg().toggleInActive)),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Warranty Parts",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20))),
                        width: w,
                        child: customTableTwo(
                          border: TableBorder(
                            borderRadius: BorderRadius.circular(100),

                            verticalInside: BorderSide(
                                color: Color(0xffccdae3),
                                width: 1,
                                style: BorderStyle.solid),
                            horizontalInside: const BorderSide(
                                color: Color(0xffccdae3),
                                width: 1,
                                style: BorderStyle.solid),
                            // top: BorderSide(color: Color(0xffccdae3),width: 1,
                            //     style:
                            //     BorderStyle.solid),
                            right: const BorderSide(
                                color: Color(0xffccdae3),
                                width: 1,
                                style: BorderStyle.solid),
                            left: const BorderSide(
                                color: Color(0xffccdae3),
                                width: 1,
                                style: BorderStyle.solid),
                            bottom: const BorderSide(
                                color: Color(0xffccdae3),
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          tableWidth: .5,
                          widths: {
                            0: const FlexColumnWidth(5),
                            1: const FlexColumnWidth(1),
                          },
                          childrens: [
                            TableRow(children: [
                              tableHeadtextTwo(
                                'Data',
                                height: 50,
                                size: 13,
                              ),
                              tableHeadtextTwo(
                                '',
                                height: 50,
                                size: 13,
                              ),
                            ]),
                            if (termsList.isNotEmpty) ...[
                              for (var i = 0; i < termsList.length; i++)
                                TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      child: TextFormField(
                                        controller: termsListController[i],
                                        onChanged: (va) {
                                          onChangeVal = true;
                                          termsList[i] = ConditionList(
                                              data:
                                                  termsListController[i].text);
                                          print("term$termsList");
                                          print("ters${termsControllr.text}");
                                          setState(() {});
                                        },
                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.digitsOnly,],
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            fillColor: const Color(0xfff9f9f9),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Color(0xffccdae3),
                                                    width: 1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Color(0xffccdae3),
                                                    width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Color(0xffccdae3),
                                                    width: 1)),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 10)),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: isEdit==true?Container():Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                            onPressed: () {
                                              print("index delete $i");
                                              print(
                                                  "index delete ${termsList[i]}");

                                              termsList.removeAt(i);
                                              termsListController.removeAt(i);
                                              print("index delete $termsList");
                                              setState(() {});
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: ColorPalette
                                                    .primary // Text Color
                                                ),
                                            child: Icon(Icons.delete)),
                                      )),
                                ]),
                            ],
                            TableRow(children: [
                              isEdit==true?Container():TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,
                                  child: TextFormField(
                                    controller: termsControllr,
                                    decoration: InputDecoration(
                                        fillColor: Color(0xfff9f9f9),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffccdae3),
                                                width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffccdae3),
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Color(0xffccdae3),
                                                width: 1)),
                                        contentPadding:
                                            EdgeInsets.only(left: 10)),
                                  ),
                                ),
                              ),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: isEdit==true?Container():Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        onPressed: () {
                                          termsList.add(ConditionList(
                                            isActive: true,id: null,
                                              data: termsControllr.text));
                                          termsListController.add(
                                              TextEditingController(
                                                  text: termsControllr.text));
                                          print("termsList$termsList");
                                          print(
                                              "termsList${termsControllr.text}");

                                          setState(() {
                                            termsControllr.clear();
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: ColorPalette
                                                .primary // Text Color
                                            ),
                                        child: Icon(Icons.add)),
                                  )),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                WarrantyCardInventory(
                  edit: isEdit,
                    addditionalList: additionalClass,
                additionalRead: readWarrantyData?.additionalWarranty??[]
                ),
                SizedBox(
                  height: 20,
                ),
                ExtendedWarrantyCardInventory(
                  edit: isEdit,
                  exList: readWarrantyData?.extentedWarrantyList,
                    label: "EXTENDED WARRANTY", extendedData: extendedClass),
                SizedBox(
                  height: 10,
                ),
                isEdit==true?Container():Container(
                  padding: EdgeInsets.all(16),
                  child: GradientButton(
                      onPressed: () {
                        print("EXte${extendedList?[0].exConditionList}");
                        print("EXte${additionalData?[0].conditionList!.length}");
                        CreateWarrantyModel warranty = CreateWarrantyModel(
                            variantCode: widget.variantList?.code,
                            variantId: widget.variantList?.id ?? 0,
                            warrantyDetailsModel: [
                              WarrantyDetailsModel(
                                  id: null,
                                  isActive: true,
                                  conditionList: termsList,
                                  description:
                                      warrantyDescriptionController.text,
                                  duration: int.tryParse(
                                      warrantyDurationController.text),
                                  warrantyTypeId: warrantyTypeId,
                                  additionalWarrantyDetails: additionalData,
                                  isExtendedWarraty:
                                      extendedList?[0].isExtendedWarraty,
                                  exIsActive: extendedList?[0].exIsActive,
                                  exDuration: extendedList?[0].exDuration,
                                  exdescription: extendedList?[0].exdescription,
                                  exConditionList:
                                      extendedList?[0].exConditionList,
                                  isAdditionalWarranty: true,
                                  maximumOccurence:
                                      extendedList?[0].maximumOccurence,
                                  warrantySection:
                                      warrantySectionController.text,
                                  price: extendedList?[0].price)
                            ]);
                        BlocProvider.of<InventoryBloc>(context)
                            .add(CreateWarrantyEvent(warrantyModel: warranty));
                      },
                      gradient: const LinearGradient(
                        colors: [
                          ColorPalette.primary,
                          ColorPalette.primary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: ColorPalette.primary,
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
    int selectIndex = 0;
    String nextUrl = "";
    String prevUrl = "";
    void onselect(int index) {
      setState(() {
        selectIndex = index;
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Select Warranty Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SearchCard(
                          hint: "Search Warranty Type...",
                          onchange: (ff) {
                            setState(() {
                              // context.read<InventoryBloc>().add( GetAttributeListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetWarrantyTypeListEvent) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetWarrantyTypeListSuccess) {
                            nextUrl = state.nextPageUrl ?? "";
                            prevUrl = state.prevPageUrl ?? "";
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

                                            warrantyTypeId =
                                                state.inventory?[index].id ?? 0;
                                            warrantyTypeName =
                                                state.inventory?[index].title ??
                                                    "";
                                            setState(() {});

                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          bottom: 10,
                                                          top: 5,
                                                          right: 8),
                                                  child: SvgPicture.string(state
                                                              .inventory?[index]
                                                              .title ==
                                                          offerPeriodNameNew
                                                      // selectIndex == index
                                                      ? HomeSvg()
                                                          .radioButtonActive
                                                      : HomeSvg()
                                                          .radioInActive),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.inventory?[index].title ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              // Spacer(),
                                              SizedBox(
                                                width: w / 3,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<InventoryBloc>()
                                                      .add(WarrantyTypeReadEvent(
                                                          state
                                                                  .inventory?[
                                                                      index]
                                                                  .id ??
                                                              0));

                                                  context
                                                      .read<InventoryBloc>()
                                                      .add(
                                                          GetWarrantyTypeListEvent(
                                                              ""));
                                                },
                                                child: Text(
                                                  "View",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorPalette.primary,
                                                      fontSize: w / 24),
                                                ),
                                              )
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
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        prevUrl != ""
                                            ? GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<InventoryBloc>()
                                                      .add(
                                                          GetAttributeListEvent(
                                                              "", '', prevUrl));
                                                  // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                                },
                                                child: Text(
                                                  "Previous",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorPalette.primary,
                                                      fontSize: w / 24),
                                                ),
                                              )
                                            : Container(),
                                        nextUrl != ""
                                            ? GestureDetector(
                                                onTap: () {
                                                  // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                                  setState(() {
                                                    context
                                                        .read<InventoryBloc>()
                                                        .add(
                                                            GetAttributeListEvent(
                                                                '',
                                                                nextUrl,
                                                                ''));
                                                  });
                                                },
                                                child: Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorPalette.primary,
                                                      fontSize: w / 24),
                                                ),
                                              )
                                            : Text("")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container(
                              width: w,
                              height: 300,
                              child: customCupertinoLoading());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              _showModalBottomSheetNew(context, false);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Create New",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetNew(BuildContext context, bool edit) {
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
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: h / 2,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        edit ? "Update Warranty Type" : "Create Warranty Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormReusable(
                        label: "Title",
                        hint: "Enter Title",
                        controller: titleWarrantyType,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormReusable(
                        controller: descriptionWarrantyType,
                        label: "Description",
                        hint: "Enter Description",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
                            edit == true
                                ? print("edittttt")
                                : print("creatttt");
                            edit
                                ? BlocProvider.of<InventoryBloc>(context)
                                    .add(UpdateWarrantyTypeEvent(
                                    id: readData?.id ?? 0,
                                    isActive: readData?.isActive ?? false,
                                    description: descriptionWarrantyType.text,
                                    title: titleWarrantyType.text ?? "",
                                  ))
                                : BlocProvider.of<InventoryBloc>(context)
                                    .add(WarrantyTypeCreateEvent(
                                    isActive: true,
                                    description:
                                        descriptionWarrantyType.text ?? "",
                                    title: titleWarrantyType.text,
                                  ));
                          },
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorPalette.primary,
                                ColorPalette.primary
                              ]),
                          child: Text(
                            edit ? "Update" : "Create New",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      edit
                          ? GradientButton(
                              color: Colors.white,
                              onPressed: () {
                                BlocProvider.of<InventoryBloc>(context).add(
                                    DeleteWarrantyTypeEvent(readData?.id ?? 0));
                              },
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.white]),
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))
                          : Container()
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
