import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/pricing_group.dart';
import 'package:cluster/presentation/inventory/widget/costing_card.dart';
import 'package:cluster/presentation/inventory/widget/inventory_outstock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/loading.dart';
import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../promotion_app/dropdown_card.dart';
import '../seller_app/new_list_tab/textfield_tab.dart';
import '../stock_app/out_stock_card.dart';
import 'model/inventory_model.dart';

class CostingView extends StatefulWidget {
  final InventoryModel? variantData;
  final bool editCosting;
  const CostingView({Key? key, this.variantData,this.editCosting=false}) : super(key: key);

  @override
  State<CostingView> createState() => _CostingViewState();
}

class _CostingViewState extends State<CostingView> {

  rerfresh(){
    setState(() {

    });
  }
  List<String> priceGp = [];
  List<String> gpOperationsList = [];
  List<String> priceTypeList = [];
  bool isActive = true;
  String? selectedGender;
  List<CostingModel>? methodType;
  List<CostingModel>? methodLoist;
  List<CostingModel>? priceGroupList;
  CostingModel? costModel;
  String? typeName;
  String? methodName;
  String? pricingGroupName;
  int? typeId;
  String? drop;
  String gpOparation="increase";
  String? pricetype;
  int? methodTypeId;
  int? priceGroupId;
  TextEditingController typeNameController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController codeController=TextEditingController();
  TextEditingController methodNameController=TextEditingController();
  TextEditingController discriptionMethodController=TextEditingController();
  TextEditingController stockCodeController=TextEditingController();
  TextEditingController costingCodeController=TextEditingController();
  TextEditingController costingNameController=TextEditingController();
  TextEditingController actualCostController=TextEditingController();
  TextEditingController recommentedPriceController=TextEditingController();
  TextEditingController sellingPriceController=TextEditingController();
  TextEditingController actualSellingPriceController=TextEditingController();
  TextEditingController GpPercentageValueController=TextEditingController();
  int costMethodtypeId=0;
  StockDataModel? stockData;
  CostingReadData? costReadData;
  calculation(double actualcost,double gppercent){
    if(gpOparation=="increase"){
      setState(() {
      recommentedPriceController.text=(actualcost+(gppercent/100)).toString();
      print("increase$actualcost");
      print("increase$gppercent");
      print("increase${recommentedPriceController.text}");
      });
    }
    else if(gpOparation=="decrease"){
      setState(() {
      recommentedPriceController.text=(actualcost-(gppercent/100)).toString();
      print("decrease${recommentedPriceController.text}");


      });
    }

  }
  @override
  void initState() {
    context.read<InventoryBloc>().add( CostMethodTypeListEvent("",""));
    context.read<InventoryBloc>().add( PricingGpTypeReadEvent(widget.variantData?.id??0));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<InventoryBloc, InventoryState>(
  listener: (context, state) {
    if(state is CreateMethodTypeLoading){
      showSnackBar(context,
          message: "Creation Loading", color: ColorPalette.green);
    }
    if(state is CreateMethodTypeSuccess){
      Navigator.pop(context);
      context.read<InventoryBloc>().add( const CostMethodTypeListEvent("",""));
      showSnackBar(context,
          message: state.successMessage??'', color: ColorPalette.green);
    }
    if(state is CreateMethodTypeFailed){
      showSnackBar(context,
          message: state.error, color: ColorPalette.green);
    }
    // TODO: implement listener
  },
),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
       if(state is CostMethodTypeListLoading){

       }
       if(state is CostMethodTypeListSuccess){
         methodType=state.product.data;
         setState(() {

         });
       }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is GetCostMethodTypeReadLoading){

        }
        if(state is GetCostMethodTypeReadSuccess){
          print("GG${state.costingModel}");
          costModel=state.costingModel;
          typeNameController.text=costModel?.typeName??"";
          discriptionController.text=costModel?.description??"";
          costMethodtypeId=costModel?.id??0;
          setState(() {

          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CostMethodTypeUpdateLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is CostMethodTypeUpdateSuccess){
          Navigator.pop(context);
          context.read<InventoryBloc>().add( const CostMethodTypeListEvent("",""));
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
        }
        if(state is CostMethodTypeUpdateFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is DeleteCostMethodTypeLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is DeleteCostMethodTypeSuccess){
          Navigator.pop(context);
          context.read<InventoryBloc>().add( const CostMethodTypeListEvent("",""));
          showSnackBar(context,
              message: "Deleted Successfully"??'', color: ColorPalette.green);
        }
        if(state is DeleteCostMethodTypeFailed){
          showSnackBar(context,
              message: "Delete Failed", color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CreateMethodLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is CreateMethodSuccess){

          // context.read<InventoryBloc>().add( const CostMethodTypeListEvent("",""));
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          Navigator.pop(context);
          context.read<InventoryBloc>().add( CostMethodListEvent("",""));
        }
        if(state is CreateMethodFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is GetCostMethodReadLoading){

        }
        if(state is GetCostMethodReadSuccess){
          print("GG${state.costingModel}");
          methodNameController.text=state.costingModel.methodName??"";
          discriptionMethodController.text=state.costingModel.description??"";
          codeController.text=state.costingModel.methodCode??"";
          methodName=state.costingModel.methodName??"";
          isActive=state.costingModel.isActive??false;
          setState(() {

          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CostMethodUpdateLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is CostMethodUpdateSuccess){
          Navigator.pop(context);
          context.read<InventoryBloc>().add( const CostMethodListEvent("",""));
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
        }
        if(state is CostMethodUpdateFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is DeleteCostMethodLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is DeleteCostMethodSuccess){
          Navigator.pop(context);
          context.read<InventoryBloc>().add( const CostMethodListEvent("",""));
          showSnackBar(context,
              message: "Deleted Successfully"??'', color: ColorPalette.green);
        }
        if(state is DeleteCostMethodFailed){
          showSnackBar(context,
              message: "Delete Failed", color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingGpTypeReadLoading){

        }
        if(state is PricingGpTypeReadSuccess){
          print("GG${state.readCostingData.pricingGpType}");
          priceGp=state.readCostingData.pricingGpType??[];
          priceTypeList=state.readCostingData.priceType??[];
          gpOperationsList=state.readCostingData.gpOperations??[];
          stockData=state.readCostingData.dataModel?.stockDataModel;
          print("stock CODE${state.readCostingData.dataModel?.stockDataModel?.stockCode}");
          stockCodeController.text=state.readCostingData.dataModel?.stockDataModel?.stockCode??"";
          actualCostController.text=state.readCostingData.dataModel?.actualCost?.toString()??"0";




          setState(() {


          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is GPPercentagePostLoading){
          // showSnackBar(context,
          //     message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is GPPercentagePostSuccess){
          GpPercentageValueController.text=(state.successMessage!="null"?state.successMessage:"0")!;
          print("GGGGPPPP${GpPercentageValueController.text}");
          // calculation(double.tryParse(actualCostController.text)??0, int.tryParse(GpPercentageValueController.text)??0);
          // context.read<InventoryBloc>().add( const CostMethodTypeListEvent("",""));
          // showSnackBar(context,
          //     message: state.successMessage??'', color: ColorPalette.green);
        }
        if(state is GPPercentagePostFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CreateCostingPostLoading){
          // showSnackBar(context,
          //     message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is CreateCostingPostSuccess){

          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          context.read<InventoryBloc>().add(  CostingListEvent("", "",widget.variantData?.id??0));
          Navigator.pop(context);
        }
        if(state is CreateCostingPostFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CostingReadLoading){

        }
        if(state is CostingReadSuccess){
          print("Reda COATR${state.costingModel}");
          setState(() {
            costReadData=state.costingModel;
            methodName=state.costingModel.costingMethodData?.costingMethodName??"";
            methodTypeId=state.costingModel.costMethod??0;
            priceGroupId=state.costingModel.pricingGroupId??0;
            pricingGroupName=state.costingModel.pricingGroupData?.priceGroupName??"";
            stockCodeController.text=state.costingModel.stockDataModel?.stockCode??"";
            costingCodeController.text=state.costingModel.costingCode??"";
            costingNameController.text=state.costingModel.costingName??"";
            actualSellingPriceController.text=state.costingModel.actualSellingPrice.toString();
            drop=state.costingModel.priceGpType??"";
            GpPercentageValueController.text=state.costingModel.gpPercentage.toString();

            pricetype=state.costingModel.priceType??"";
            gpOparation=state.costingModel.gpOperation??"";
            sellingPriceController.text=state.costingModel.sellingPrice.toString();

          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is CostingUpdateLoading){
          showSnackBar(context,
              message: "Updation Loading", color: ColorPalette.green);
        }
        if(state is CostingUpdateSuccess){
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          context.read<InventoryBloc>().add(  CostingListEvent("", "",widget.variantData?.id??0));
          Navigator.pop(context);
        }
        if(state is CostingUpdateFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "New Costing",
        isAction: false,
        isBack: false,
        onTap: (){
          print("back");
          context.read<InventoryBloc>().add(  CostingListEvent("", "",widget.variantData?.id??0));
          Navigator.pop(context);
        },),
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
                InventoryOutStockCard(
                  isStock: true,
                  variantList: widget.variantData,
                ),
                SizedBox(height: 16,),
                DropDownCard(
                  selValue: methodName,

                  label: "Costing Method ID",
                  onTap: () {
                    context.read<InventoryBloc>().add( CostMethodListEvent("",""));
                    _showModalBottomSheetMethodId(methodName);
                  },
                ),
                // TextFieldTab(
                //   label: "Costing Method ID ",
                //   isMandatory: false,
                //   hint: "1109",
                //   child: GestureDetector(
                //     onTap: (){
                //       _showModalBottomSheet();
                //     },
                //     child: Text(
                //       "Create New",
                //       style: GoogleFonts.roboto(
                //         color: Color(0xfffe5762),
                //         fontSize: w/24,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 16,),
                DropDownCard(
                  selValue: pricingGroupName,

                  label: "Pricing Group ID",
                  onTap: () {
                    context.read<InventoryBloc>().add( PricingGroupListEvent("",""));
                    _showModalBottomSheetPricingGroupList(pricingGroupName);
                  },
                ),
                // TextFieldTab(
                //   label: "Pricing Group ID",
                //   isMandatory: false,
                //   hint: "1109",
                //   child: GestureDetector(
                //     onTap: (){
                //       PersistentNavBarNavigator.pushNewScreen(
                //         context,
                //         screen: PricingGroup(),
                //         withNavBar: true, // OPTIONAL VALUE. True by default.
                //         pageTransitionAnimation: PageTransitionAnimation.fade,
                //       );
                //     //  PricingGroup
                //     },
                //     child: Text(
                //       "Create New",
                //       style: GoogleFonts.roboto(
                //         color: Color(0xfffe5762),
                //         fontSize: w/24,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/2.3,
                      child: TextFormReusable(
                        label: "Stock Code",
                        hint: "1109",
                        readOnly: true,
                        controller: stockCodeController,
                      ),
                    ) , Container(
                      width: w/2.3,
                      child: TextFormReusable(
                        label: "Costing Code",
                        hint: "1109",
                        readOnly: true,
                        controller: costingCodeController,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                TextFormReusable(
                  label: "Costing Name",
                  hint: "1109",
                  controller: costingNameController,
                ),   SizedBox(height: 16,),
                TextFormReusable(
                  label: "Actual Cost",
                  hint: "1109",
                  readOnly: false,
                  floatVal: true,
                  isError: actualCostController.text=="0"?true:false,
                  error: "Variant Actual Cost Not Mentioned",
                  controller: actualCostController,
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pricing GP Type",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),),
                        Container(
                            width: w/2.3,
                            padding: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(color: Colors.white,
                                border: Border.all(color: Color(0xffe6ecf0)),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                              underline: Container(),
                              icon:  Icon(Icons.arrow_drop_down_circle),
                              hint: const Text("Select Channel"),
                              value: drop,
                              onChanged: (value) {
                                setState(() {
                                  drop = value;
                                  BlocProvider.of<InventoryBloc>(context).add(
                                      GPPercentagePostEvent(
                                        inventoryId: authentication.authenticatedUser.organisationCode??"",
                                        variantId: widget.variantData?.id??0,
                                        GPType: value??""
                                      ));
                                });
                              },

                              items: priceGp
                                  .map<DropdownMenuItem<String>>((
                                  String _value) =>
                                  DropdownMenuItem<String>(
                                      value: _value,
                                      child: Text(_value ?? "",)
                                  )).toList(),
                            )
                        ),
                      ],
                    ),

                    Container(
                      width: w/2.3,
                      child: TextFormReusable(
                        label: "GP Percentage",
                        hint: "1109",
                        controller: GpPercentageValueController,
                        readOnly: true,
                        numField: true,
                      ),
                    ) ,
                  ],
                ),
                SizedBox(height: 16,),
                Text("Pricing Type",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),),
                Container(
                    width: w,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Color(0xffe6ecf0)),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      underline: Container(),
                      icon:  Padding(
                        padding: const EdgeInsets.only(left: 190),
                        child: Icon(Icons.arrow_drop_down_circle),
                      ),
                      hint: const Text(""),
                      value: pricetype,
                      onChanged: (value) {
                        setState(() {
                          pricetype = value;
                        });
                      },

                      items: priceTypeList
                          .map<DropdownMenuItem<String>>((
                          String _value) =>
                          DropdownMenuItem<String>(
                              value: _value,
                              child: Text(_value ?? "",)
                          )).toList(),
                    )
                ),

                SizedBox(height: 16,),
                Text("GP Operation",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),),
                Container(
                    width: w,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Color(0xffe6ecf0)),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      underline: Container(),
                      icon:  Padding(
                        padding: const EdgeInsets.only(left: 215),
                        child: Icon(Icons.arrow_drop_down_circle),
                      ),
                      hint: const Text(""),
                      value: gpOparation,
                      onChanged: (value) {
                        setState(() {
                          gpOparation = value??"";
                          print("jJJJJJ${GpPercentageValueController.text}");
                          calculation(double.tryParse(actualCostController.text)??0, double.tryParse(GpPercentageValueController.text)??0);
                        });
                      },

                      items: gpOperationsList
                          .map<DropdownMenuItem<String>>((
                          String _value) =>
                          DropdownMenuItem<String>(
                              value: _value,
                              child: Text(_value ?? "",)
                          )).toList(),
                    )
                ),

                SizedBox(height: 16,),
                TextFormReusable(
                  label: "Recommended Price",
                  hint: "1109",
                  controller: recommentedPriceController,
                  readOnly: true,
                ),
                SizedBox(height: 16,),
                TextFormReusable(
                  label: "Selling Price / Integration Price",
                  hint: "1109",
                  floatVal: true,
                  controller: sellingPriceController,
                ),
                SizedBox(height: 5,),
                TextFormReusable(
                  label: "Actual Selling Price",
                  hint: "1109",
                  floatVal: true,
                  controller: actualSellingPriceController,
                ),
                SizedBox(height: 5,),
                Text(
                  "*Fill all mandatory fields",
                  style: GoogleFonts.roboto(
                    color: Color(0xff3c3b3b),
                    fontSize: w/30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30,),
                widget.editCosting==true?
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      BlocProvider.of<InventoryBloc>(context).add(
                          UpdateCostingEvent(
                              createdBy: authentication.authenticatedUser.code??"",
                              channelId: "1",
                              actualcost: double.tryParse(actualCostController.text)??0,
                              actualSellingPrice: double.tryParse(actualSellingPriceController.text)??0,
                              channelCode: "CHAN001",
                              costingMethodId: methodTypeId??0,
                              costingName: costingNameController.text,
                              gpOperation: gpOparation,
                              GpPercentage: double.tryParse(GpPercentageValueController.text)??0,
                              invId: authentication.authenticatedUser.organisationCode??"",
                              pricingGpType: drop??"",
                              pricingGroupId: priceGroupId??0,
                              pricrType: pricetype??"",
                              sellingPrice: double.tryParse(sellingPriceController.text)??0,
                              stockCode: stockCodeController.text,
                              unitCost: double.tryParse(actualCostController.text)??0,
                              varientCode: widget.variantData?.code??"",
                              varientId: widget.variantData?.id??0,
                            id: costReadData?.id??0,
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
                      "Update",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
                        fontWeight: FontWeight.w600,
                      ),
                    )):
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      print("THIS IS WRONG${GpPercentageValueController.text}");
                      BlocProvider.of<InventoryBloc>(context).add(
                          CostingCreationPostEvent(
                              createdBy: authentication.authenticatedUser.code??"",
                              channelId: "1",
                            actualcost: double.tryParse(actualCostController.text)??0,
                            actualSellingPrice: double.tryParse(actualSellingPriceController.text)??0,
                            channelCode: "CHAN001",
                            costingMethodId: methodTypeId??0,
                            costingName: costingNameController.text,
                            gpOperation: gpOparation,
                            GpPercentage: double.tryParse(GpPercentageValueController.text)??0,
                            invId: authentication.authenticatedUser.organisationCode??"",
                            pricingGpType: drop??"",
                            pricingGroupId: priceGroupId??0,
                            pricrType: pricetype??"",
                            sellingPrice: double.tryParse(sellingPriceController.text)??0,
                            stockCode: stockCodeController.text,
                            unitCost: double.tryParse(actualCostController.text)??0,
                            varientCode: widget.variantData?.code??"",
                            varientId: widget.variantData?.id??0
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
                      "Create",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }

  _showModalBottomSheet(bool? edit) {

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
                height: 600,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: ScrollConfiguration(
              behavior: NoGlow(),
              child:
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10,top: 10),
                        width: w,
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close,color: ColorPalette.black,),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Costing Method Create",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: 5,
                            ),
                            DropDownCard(
                              selValue: typeName,
                              label: "Costing Method ID Type",
                              onTap: () {
                                context.read<InventoryBloc>().add( CostMethodTypeListEvent("",""));
                                _showModalBottomSheetOfferPeriod(typeName);
                              },
                            ),
                            SizedBox(height: 16,),
                            TextFormReusable(
                              label: "Code",
                              hint: "",
                              controller: codeController,
                              readOnly: true,
                            ), SizedBox(height: 16,),
                            TextFormReusable(
                              label: "Method Name",
                              hint: "",
                              controller: methodNameController,
                            ),SizedBox(height: 16,),
                            TextFormReusable(
                              label: "Description",
                              hint: "",
                              controller: discriptionMethodController,
                            ),
                            SizedBox(height: 30,),
                            ClusterCard(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Is Active",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isActive = !isActive;
                                        });
                                      },
                                      child: isActive
                                          ? SvgPicture.string(HomeSvg().toggleActive)
                                          : SvgPicture.string(HomeSvg().toggleInActive),
                                    )
                                  ],
                                )),
                            SizedBox(height: 30,),
                            edit==true?GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  BlocProvider.of<InventoryBloc>(context).add(
                                      UpdateCostMethodEvent(
                                        id: methodTypeId??0,
                                          isActive: isActive,
                                          methodName: methodNameController.text,
                                          discription: discriptionMethodController.text,
                                          createdBy: authentication.authenticatedUser.code??"",
                                          methodTypeId:typeId??0

                                      ));
                                  //  SuccessPromotion
                                },
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: const [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )):GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  BlocProvider.of<InventoryBloc>(context).add(
                                      CostingMethodCreateEvent(
                                          methodName: methodNameController.text,
                                          discription: discriptionMethodController.text,
                                          createdBy: authentication.authenticatedUser.code??"",
                                        methodTypeId:typeId??0

                                      ));
                                  //  SuccessPromotion
                                },
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: const [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Create",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            edit==true?GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  BlocProvider.of<InventoryBloc>(context).add(
                                      DeleteCostMethodEvent(methodTypeId??0));
                                  //  SuccessPromotion
                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.white,
                                      ColorPalette.white
                                    ]),
                                child: Text(
                                  "Delete",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.primary,
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )):Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
            },
          );
        });
  }

  _showModalBottomSheetMethodType(bool edit) {

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
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child:
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10,top: 10),
                            width: w,
                            alignment: Alignment.topRight,
                            child: Icon(Icons.close,color: ColorPalette.black,),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Costing Method Type Create",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(
                            color: ColorPalette.divider,
                            thickness: 1.1,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormReusable(
                                  label: "Type Name",
                                  hint: "",
                                  controller: typeNameController,
                                ), SizedBox(height: 16,),
                                TextFormReusable(
                                  label: "Description",
                                  hint: "",
                                  controller: discriptionController,
                                ),
                                SizedBox(height: 30,),
                                edit==true?GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      BlocProvider.of<InventoryBloc>(context).add(
                                          UpdateCostMethodTypeEvent(
                                            isActive: true,
                                              id: costMethodtypeId,
                                              typeName: typeNameController.text,
                                              discription: discriptionController.text,
                                              createdBy: authentication.authenticatedUser.code??""

                                          ));
                                    },
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: const [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: Text(
                                      "Update",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w/22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )):GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      BlocProvider.of<InventoryBloc>(context).add(
                                          CreateCostingMethodTypeEvent(
                                             typeName: typeNameController.text,
                                            discription: discriptionController.text,
                                            createdBy: authentication.authenticatedUser.code??""

                                          ));
                                    },
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: const [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w/22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                edit==true?GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      BlocProvider.of<InventoryBloc>(context).add(
                                          DeleteCostMethodTypeEvent(costMethodtypeId));
                                    },
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: const [
                                          ColorPalette.white,
                                          ColorPalette.white
                                        ]),
                                    child: Text(
                                      "Delete",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.primary,
                                        fontSize: w/22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )):Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }

  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {


    int selectIndex = 0;
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
                      SizedBox(height: 10,),
                      Text(
                        "Select Method Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is CostMethodTypeListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is CostMethodTypeListSuccess) {

                            methodType=state.product.data;
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: methodType!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            setState(() {});
                                            typeId = methodType?[index].id ??
                                                0;
                                            typeName = methodType?[index].typeName ??
                                                "";
                                            rerfresh();
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(methodType?[index]
                                                .typeName ==
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
                                          methodType?[index].typeName ??
                                              "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            print("pressrd");

                                            typeNameController.clear();
                                            discriptionController.clear();
                                            context.read<InventoryBloc>().add(
                                                GetCostMethodTypeReadEvent(methodType?[index].id??0));
                                            _showModalBottomSheetMethodType(true);
                                            context.read<InventoryBloc>().add(
                                                CostMethodTypeListEvent("",""));
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        )
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
                                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     methodType.count==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",state.product.data.count));
                                  //       },
                                  //       child: Text(
                                  //         "Previous",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //     state.product.data.nextPageUrl==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",""));
                                  //       },
                                  //       child: Text(
                                  //         "Next",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //
                                  //   ],
                                  // ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        typeNameController.clear();
                                        discriptionController.clear();
                                        _showModalBottomSheetMethodType(false);
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
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetMethodId(String? offerPeriodNameNew) {


    int selectIndex = 0;
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
                      SizedBox(height: 10,),
                      Text(
                        "Select Costing Method",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is CostMethodListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is CostMethodListSuccess) {

                            methodLoist=state.product.data;
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: methodLoist!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            setState(() {});
                                            methodTypeId = methodLoist?[index].id ??
                                                0;
                                            methodName = methodLoist?[index].methodName ??
                                                "";
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(methodLoist?[index]
                                                .methodName ==
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
                                          methodLoist?[index].methodName ??
                                              "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<InventoryBloc>().add(
                                                GetCostMethodReadEvent(methodLoist?[index].id??0));
                                            _showModalBottomSheet(true);
                                            context.read<InventoryBloc>().add(
                                                CostMethodListEvent("",""));
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        )
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
                                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     methodType.count==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",state.product.data.count));
                                  //       },
                                  //       child: Text(
                                  //         "Previous",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //     state.product.data.nextPageUrl==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",""));
                                  //       },
                                  //       child: Text(
                                  //         "Next",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //
                                  //   ],
                                  // ),

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
                      GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
                            methodNameController.clear();
                            discriptionMethodController.clear();
                            codeController.clear();
                            typeName="";
                            _showModalBottomSheet(false);
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
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetPricingGroupList(String? offerPeriodNameNew) {


    int selectIndex = 0;
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
                      SizedBox(height: 10,),
                      Text(
                        "Select Pricing Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is PricingGroupListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is PricingGroupListSuccess) {

                            priceGroupList=state.product.data;
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: priceGroupList!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            setState(() {});
                                            priceGroupId = priceGroupList?[index].id ??
                                                0;
                                            pricingGroupName = priceGroupList?[index].pricingGroupName ??
                                                "";
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(priceGroupList?[index]
                                                .pricingGroupName ==
                                                offerPeriodNameNew
                                                ? HomeSvg().radioButtonActive
                                                : HomeSvg().radioInActive),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          priceGroupList?[index].pricingGroupName ??
                                              "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<InventoryBloc>().add(
                                                PricingGroupReadEvent(priceGroupList?[index].id??0));
                                            PersistentNavBarNavigator.pushNewScreen(
                                              context,
                                              screen: const PricingGroup(edit: true,),
                                              withNavBar: true, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation: PageTransitionAnimation.fade,
                                            );
                                            // context.read<InventoryBloc>().add(
                                            //     CostMethodListEvent("",""));
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        )
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
                                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     methodType.count==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",state.product.data.count));
                                  //       },
                                  //       child: Text(
                                  //         "Previous",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //     state.product.data.nextPageUrl==null?Text(""):
                                  //     GestureDetector(
                                  //       onTap: (){
                                  //         context.read<InventoryBloc>().add(CostMethodTypeListEvent(state.product.data.nextPageUrl??"",""));
                                  //       },
                                  //       child: Text(
                                  //         "Next",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: ColorPalette.primary,
                                  //             fontSize: w / 24),
                                  //       ),
                                  //     ),
                                  //
                                  //   ],
                                  // ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        methodNameController.clear();
                                        discriptionMethodController.clear();
                                        codeController.clear();
                                        PersistentNavBarNavigator.pushNewScreen(
                                                    context,
                                                    screen: PricingGroup(),
                                                    withNavBar: true, // OPTIONAL VALUE. True by default.
                                                    pageTransitionAnimation: PageTransitionAnimation.fade,
                                                  );
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
                    ],
                  ),
                ),
              );
            },
          );
        });
  }


}
