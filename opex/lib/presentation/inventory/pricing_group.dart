import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/custom_checkbox.dart';
import '../../common_widgets/loading.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/common_snackBar.dart';
import '../authentication/authentication.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../promotion_app/dropdown_card.dart';
import '../promotion_app/models_promotion/discount_models/model_discount.dart';
import 'bloc/inventory_bloc.dart';

class PricingGroup extends StatefulWidget {
  final bool edit;
  const PricingGroup({Key? key,  this.edit=false}) : super(key: key);

  @override
  State<PricingGroup> createState() => _PricingGroupState();
}

class _PricingGroupState extends State<PricingGroup> {
  bool isActive = true;
  bool isActivePriceGroup = true;
  TextEditingController priceNameController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController codeController=TextEditingController();
  List<CostingModel>? pricingTypeList;
  CostingModel? data;
  int priceTypeId=0;
  int priceGroupId=0;
  String priceTypeName="";
  String customerGroupCode="";
  List<GetTypeApplying> availableCustomerList = [];
  List<GetTypeApplying> customerList = [];
  List<String> customercode=[];
  refresh(){
    setState(() {

    });
  }
  TextEditingController priceGroupNameController=TextEditingController();
  TextEditingController discriptionPriceGroupController=TextEditingController();
  TextEditingController codePriceGroupController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingTypeLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is PricingTypeSuccess){
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          BlocProvider.of<InventoryBloc>(context).add(
              PricingTypeListEvent("",""));
          Navigator.pop(context);
        }
        if(state is PricingTypeFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingTypeReadLoading){

        }
        if(state is PricingTypeReadSuccess){
          print("GG${state.costingModel}");
          data=state.costingModel;
          priceNameController.text=state.costingModel.pricingTypeName??"";
          discriptionController.text=state.costingModel.description??"";
          codeController.text=state.costingModel.pricingTypeCode??"";
          isActive=state.costingModel.isActive??false;
          priceTypeId=state.costingModel.id??0;
          setState(() {

          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingTypeUpdateLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is PricingTypeUpdateSuccess){
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          BlocProvider.of<InventoryBloc>(context).add(
              PricingTypeListEvent("",""));
          Navigator.pop(context);
        }
        if(state is PricingTypeUpdateFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is DeletePricingTypeLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is DeletePricingTypeSuccess){
          showSnackBar(context,
              message: "Deleted Successfully"??'', color: ColorPalette.green);
          BlocProvider.of<InventoryBloc>(context).add(
              PricingTypeListEvent("",""));
          Navigator.pop(context);
        }
        if(state is DeletePricingTypeFailed){
          showSnackBar(context,
              message: "Delete Failed", color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    //pricingGroup
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingGroupLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is PricingGroupSuccess){
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          context.read<InventoryBloc>().add( PricingGroupListEvent("",""));
          Navigator.pop(context);
        }
        if(state is PricingGroupFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingGroupReadLoading){

        }
        if(state is PricingGroupReadSuccess){
          print("GG${state.costingModel}");
          priceGroupNameController.text=state.costingModel.pricingGroupName??"";
          discriptionPriceGroupController.text=state.costingModel.description??"";
          codePriceGroupController.text=state.costingModel.pricingGroupCode??"";
          customerGroupCode=state.costingModel.customerGroupCode??"";
          priceTypeName=state.costingModel.pricingTypeName??"";
          priceGroupId=state.costingModel.id??0;
          priceTypeId=state.costingModel.pricingTypeId??0;
          setState(() {

          });
        }
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is PricingGroupUpdateLoading){
          showSnackBar(context,
              message: "Creation Loading", color: ColorPalette.green);
        }
        if(state is PricingGroupUpdateSuccess){
          showSnackBar(context,
              message: state.successMessage??'', color: ColorPalette.green);
          context.read<InventoryBloc>().add( PricingGroupListEvent("",""));
          Navigator.pop(context);
        }
        if(state is PricingGroupUpdateFailed){
          showSnackBar(context,
              message: state.error, color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
    BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if(state is DeletePricingGroupLoading){
          showSnackBar(context,
              message: "Deletion Loading", color: ColorPalette.green);
        }
        if(state is DeletePricingGroupSuccess){
          showSnackBar(context,
              message: "Deleted Successfully"??'', color: ColorPalette.green);
          context.read<InventoryBloc>().add( PricingGroupListEvent("",""));
          Navigator.pop(context);
        }
        if(state is DeletePricingGroupFailed){
          showSnackBar(context,
              message: "Delete Failed", color: ColorPalette.green);
        }
        // TODO: implement listener
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Pricing Group",
          isAction: false,
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
                // Text(
                //   "Pricing Type ID",
                //   style: GoogleFonts.roboto(
                //     color: ColorPalette.black,
                //     fontSize: w / 24,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),

                DropDownCard(
                  selValue: priceTypeName,
                  label: "Pricing Type ID",
                  onTap: () {
                    BlocProvider.of<InventoryBloc>(context).add(
                        PricingTypeListEvent("",""));
                    _showModalBottomSheetPricingTypeList(priceTypeName);
                  },
                ),
                // GestureDetector(
                //   onTap: (){
                //
                // },
                //   child: ClusterCard(
                //       child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         priceTypeName,
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Icon(Icons.keyboard_arrow_down_outlined)
                //     ],
                //   )),
                // ),
                SizedBox(height: 16,),
          DropDownCard(
            selValue: customerGroupCode,
            label: "Customer Group",
            onTap: () {
              context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent("",""));
              _showModalBottomSheetCustomer(customerGroupCode);
            },
          ),
                SizedBox(height: 16,),
                TextFormReusable(
                  label: "Name",
                  hint: "",
                  controller: priceGroupNameController,
                ), SizedBox(height: 16,),
                TextFormReusable(
                  label: "Code",
                  hint: "",
                  readOnly: true,
                  controller: codePriceGroupController,
                ),SizedBox(height: 16,),
                TextFormReusable(
                  label: "Description",
                  hint: "",
                  controller: discriptionPriceGroupController,
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
                              isActivePriceGroup = !isActivePriceGroup;
                            });
                          },
                          child: isActivePriceGroup
                              ? SvgPicture.string(HomeSvg().toggleActive)
                              : SvgPicture.string(HomeSvg().toggleInActive),
                        )
                      ],
                    )),
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
                widget.edit==true?
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      BlocProvider.of<InventoryBloc>(context).add(
                          UpdatePricingGroupEvent(
                              discription: discriptionPriceGroupController.text,
                              createdBy: authentication.authenticatedUser.code??"",
                              pricingGroupName: priceGroupNameController.text,
                              customerGroupCode: customerGroupCode,
                              id: priceGroupId,
                            isActive: isActivePriceGroup,
                            pricingTypeId: priceTypeId

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
                    )):
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      BlocProvider.of<InventoryBloc>(context).add(
                          PricingGroupCreateEvent(
                              discription: discriptionPriceGroupController.text,
                              createdBy: authentication.authenticatedUser.code??"",
                              pricingGroupName: priceGroupNameController.text,
                            customerGroupCode: customerGroupCode,
                            priceTypeId: priceTypeId

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
                widget.edit==true?
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      BlocProvider.of<InventoryBloc>(context).add(
                          DeletePricingGroupEvent(
                              priceGroupId));
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
                    )):Container(),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
  _showModalBottomSheet(bool edit) {
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
                  height: 550,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),

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
                              "Pricing Type Create",
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
                                  label: "Code",
                                  hint: "",
                                  controller: codeController,
                                  readOnly: true,
                                ), SizedBox(height: 16,),
                                TextFormReusable(
                                  label: "Name",
                                  hint: "",
                                  controller: priceNameController,
                                ),SizedBox(height: 16,),
                                TextFormReusable(
                                  label: "Description",
                                  hint: "",
                                  controller: discriptionController,
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
                                          UpdatePricingTypeEvent(
                                              discription: discriptionController.text,
                                              createdBy: authentication.authenticatedUser.code??"",
                                              pricingTypeName: priceNameController.text,
                                            isActive: isActive,
                                            pricingTypeCode: codeController.text,
                                            id: priceTypeId

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
                                          PricingTypeCreateEvent(
                                              discription: discriptionController.text,
                                              createdBy: authentication.authenticatedUser.code??"",
                                              pricingTypeName: priceNameController.text
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
                                          DeletePricingTypeEvent(
                                            priceTypeId));
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

  _showModalBottomSheetPricingTypeList(String? offerPeriodNameNew) {


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
                        "Select Pricing Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("sssss$state");
                          if (state is PricingTypeListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is PricingTypeListSuccess) {

                            pricingTypeList=state.product.data;
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: pricingTypeList!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            priceTypeId = pricingTypeList?[index].id ??
                                                0;
                                            priceTypeName = pricingTypeList?[index].pricingTypeName ??
                                                "";
                                            setState(() {});
                                            print("mmmmm$priceTypeName");
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(pricingTypeList?[index]
                                                .pricingTypeName ==
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
                                          pricingTypeList?[index].pricingTypeName ??
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

                                            priceNameController.clear();
                                            discriptionController.clear();
                                            context.read<InventoryBloc>().add(
                                                PricingTypeReadEvent(pricingTypeList?[index].id??0));
                                            _showModalBottomSheet(true);
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
                                        priceNameController.clear();
                                        discriptionController.clear();
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
  _showModalBottomSheetCustomer(String customerCode) {

    String nextCustomer="";
    String prevCustomer="";
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
                        "Select Customer Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<DiscountBloc, DiscountState>(
                        builder: (context, state) {
                          if (state is GetCustomerGroupListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetCustomerGroupListSuccess) {
                            customerList = state.customerGroup.data;
                            nextCustomer=state.customerGroup.nextPageUrl??"";
                            prevCustomer=state.customerGroup.count??"";
                            print("CUSTOMER GROUP LIST$customerList");
                            print("CUSTOMER GROUP LIST$prevCustomer");
                            print("CUSTOMER GROUP LIST$nextCustomer");

                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: customerList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        // CustomCheckBox(
                                        //   key: UniqueKey(),
                                        //   value: customercode
                                        //       .contains(customerList[index].code),
                                        //   onChange: (p0) {
                                        //     if (p0) {
                                        //       availableCustomerList
                                        //           .add(GetTypeApplying(
                                        //         customerGroupId:
                                        //         customerList[index].code,
                                        //         customerGroupCode:
                                        //         customerList[index].code,
                                        //       ));
                                        //       customercode.add(
                                        //           customerList[index].code ?? "");
                                        //     } else {
                                        //       availableCustomerList
                                        //           .remove(GetTypeApplying(
                                        //         customerGroupId:
                                        //         customerList[index].code,
                                        //         customerGroupCode:
                                        //         customerList[index].code,
                                        //       ));
                                        //       customercode.remove(
                                        //           customerList[index].code ?? "");
                                        //     }
                                        //     print(
                                        //         "customer list${availableCustomerList}");
                                        //   },
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            customerGroupCode = customerList?[index].code ??
                                                "";

                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                bottom: 10,
                                                top: 5,
                                                right: 8),
                                            child: SvgPicture.string(customerList[index]
                                                .code ==
                                                customerCode
                                            // selectIndex == index
                                                ? HomeSvg().radioButtonActive
                                                : HomeSvg().radioInActive),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          customerList[index].name ?? "",
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
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      prevCustomer==null||prevCustomer==""?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(null,prevCustomer));
                                        },
                                        child: Text(
                                          "Previous",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),
                                      state.customerGroup.nextPageUrl==null?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(nextCustomer,null));
                                        },
                                        child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),

                                    ],
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
}
