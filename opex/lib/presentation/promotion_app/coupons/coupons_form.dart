import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_bloc/coupon_bloc.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:cluster/presentation/promotion_app/select_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../../core/utils/variables.dart';
import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../blocs/discount_bloc/discount_bloc.dart';
import '../buy_more_get_form/costumtable.dart';
import '../dropdown_card.dart';
import '../models_promotion/discount_models/model_discount.dart';
import 'coupon_success_screen.dart';

class CouponsForm extends StatefulWidget {
  final List<String>? segmentList;
  final bool editCoupen;
  final bool? changeedSeg;
  final List<GetSegmentList>? discountSegment;
  final String? promotionName;
  final String? promotionDescription;
  final String? displayName;
  final bool? isAvailableForAll;
  final List<GetTypeApplying>? customerList;
  final int? offerPeriodId;
  final String? basedOn;
  final String? channelCode;
  final double? discountPercentagePrice;
  dynamic imageId;
  final CouponList? coupenList;

  CouponsForm({Key? key, this.segmentList, required this.editCoupen,this.imageId,
    this.changeedSeg, this.discountSegment, this.isAvailableForAll, this.customerList, this.offerPeriodId,
    this.basedOn, this.channelCode, this.discountPercentagePrice, this.coupenList, this.promotionName, this.promotionDescription, this.displayName}) : super(key: key);

  @override
  State<CouponsForm> createState() => _NewPromotion2State();
}

class _NewPromotion2State extends State<CouponsForm> {
  String? selGender;
  bool isActive = true;
  bool canApplyTogateger = false;
  bool canApplyMultiple = false;
  bool isSelect = false;
  String? selectedGender;
  String? coupunType;
  List<ProductListPromotion> passingList=[];
  List<int>idList=[];
  bool selectAll=false;
  void grpVal(List<ProductListPromotion> product,List<int>idListt,bool selectedAll){
    passingList=product;
    selectAll=selectedAll;
    idList=idListt;
    passingList.isEmpty?null:productAdd();
    setState((){});
    print("uuu$passingList");
    print("uuu$idList");
  }
  List<ProductListPromotion> passingListBuyMore=[];
  void buyVal(List<ProductListPromotion> product,List<int>idListt,bool selectedAll){
    passingListBuyMore=product;
    selectAll=selectedAll;
    idList=idListt;
    passingList.isEmpty?null:productAdd();
    setState((){});
    print("uuu$passingListBuyMore");
    print("is Coming$product");
  }
  List<bool>isActiveList=[];
  @override
  void initState() {
    widget.editCoupen==true?readData():null;
    context.read<CouponBloc>().add( const GetOfferApplyingBasedOnReadCouponEvent());
    BlocProvider.of<DiscountBloc>(context).add(
        PostTypeAppliyingListEvent(
            nextUrl: "",
            prevUrl: "",
            inventoryId: authentication.authenticatedUser.organisationCode.toString(),
            type: widget.coupenList?.couponApplyingOn??"",
            segmentList: widget.segmentList??[],
            searchElement: null
        ));

    BlocProvider.of<DiscountBloc>(context).add(PostProductListEvent(
        nextUrl: "",
        prevUrl: "",
        inventoryId:
        authentication.authenticatedUser.organisationCode.toString(),
        segmentList: widget.segmentList ?? [],
        searchElement: null,
        applyingtypeCode: widget.coupenList?.couponApplyingCode??"",
        applyingType: widget.coupenList?.couponApplyingOn??""));
    super.initState();
  }
  List<String> typeAppliying = [];
  List<String> couponType = [];
  String nextUrlProduct="";
  String nextUrl="";
  String prevUrl="";
  String prevUrlproduct="";
  List<GetTypeApplying> typeApply=[];
  List<ProductListPromotion> idListPost=[];
  List<ProductListPromotion> productlistPassing=[];
  List<ProductListPromotion> selectedProduct=List.from([]);
  String? typeCode;
  int? typeId;
  String? typeIdName;
  TextEditingController maxQtycontroller=TextEditingController();
  List<ProductListPromotion> returedList=[];
  List<String> termsList=[];
  List<TextEditingController> termsListController=[];
  TextEditingController termsControllr=TextEditingController();
  bool? onChangeVal=false;
  readData(){
    widget.changeedSeg==true?typeIdName="":
    typeIdName=widget.coupenList?.couponApplyingName??"";
    widget.changeedSeg==true?selectedGender:selectedGender=widget.coupenList?.couponApplyingOn??"";
    typeCode=widget.coupenList?.couponApplyingCode??"";
    isActive=widget.coupenList?.isActive??false;
    canApplyMultiple=widget.coupenList?.canApplyMultiple??false;
    canApplyTogateger=widget.coupenList?.canApplyTogather??false;
    totalValueController.text=widget.coupenList?.totalValue.toString()??"";
    selectedProduct=widget.coupenList?.line??[];
    maxCountController.text=widget.coupenList?.maxCount.toString()??"";

    idList.clear();
    for(int i=0;i<widget.coupenList!.line!.length;i++){
      idList.add(widget.coupenList!.line![i].variantId??0);
    }

    if(widget.coupenList!.conditions!.isNotEmpty){
      for(var i=0;i<widget.coupenList!.conditions!.length;i++){
        termsList.add(widget.coupenList?.conditions?[i].condition??"");
        termsListController.add(TextEditingController(text: termsList[i].toString()));
      }
      print("read terms$termsList");
      print("read terms$idList");
    }
  }
  TextEditingController totalValueController=TextEditingController();
  TextEditingController maxCountController=TextEditingController();
  productAdd(){
    print("before${passingList.length}");
    print("before${selectedProduct.length}");
    print("before${idList.length}");


    if(selectAll==true){
      selectedProduct.clear();
      for (int i = 0; i < passingList.length; i++) {
        selectedProduct.add(ProductListPromotion(
          id: null,
          isActive: true,
          variantCode: passingList[i].variantCode,
          variantName: passingList[i].variantName,
          variantId: passingList[i].variantId,
          barcode: passingList[i].barcode,
        ));
      }}
    else{
      selectedProduct.clear();
      for (int i = 0; i < passingList.length; i++) {
        selectedProduct.add(ProductListPromotion(
          id: null,
          isActive: true,
          variantCode: passingList[i].variantCode,
          variantName: passingList[i].variantName,
          variantId: passingList[i].variantId,
          barcode: passingList[i].barcode,
        ));
      }


      // for (var j = 0; j < selectedProduct.length; j++) {
      //   for (int i = 0; i < passingList.length; i++) {
      //     if(selectedProduct[j].variantId!=passingList[i].variantId) {
      //       selectedProduct.add(ProductListPromotion(
      //       id: null,
      //       isActive: true,
      //       variantCode: passingList[i].variantCode,
      //       variantName: passingList[i].variantName,
      //       variantId: passingList[i].variantId,
      //       barcode: passingList[i].barcode,
      //
      //     ));
      //     }
      //   }
      // }
    }
    print("afre${passingList.length}");
    print("afre${selectedProduct.length}");
    print("afre${idList.length}");
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            print("SHIIII$state");
            if (state is DeleteSelectiveVariantsLoading) {
              showSnackBar(context,
                  message: "Deactivation Loading",
                  color: ColorPalette.green);
            }
            else if (state is DeleteSelectiveVariantsSuccess) {

              Navigator.pop(context);
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);

            } else if (state is DeactivatePrevPromotionFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<CouponBloc, CouponState>(
          listener: (context, state) {
            print("Sucsess Msg$state");
            if (state is CouponCreateLoading) {
              showSnackBar(context,
                  message: "Coupon Loading",
                  color: ColorPalette.green);
            } else if (state is CouponCreateSuccess) {
              showSnackBar(context,
                  message: "Coupon created successfully",
                  color: ColorPalette.green);
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<CouponBloc>().add(GetCouponReadEvent(int.tryParse(state.successMessage.toString())??0));
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SuccessScreenCoupon(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            } else if (state is CouponCreateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
              if(Variable.isTypeDataCheck==true){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Variable.errorMessage),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: GradientButton(
                                      color:Color(0xfffe5762) ,
                                      onPressed: () {
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            DeactivatePreviousPromotionEvent(
                                              isCoupon: true,
                                                type: false,
                                                typeData: Variable.typeData,
                                                idList: idList
                                            ));
                                        returedList.isNotEmpty?Navigator.pop(context):null;
                                        returedList.isNotEmpty?Variable.isTypeDataCheck=false:null;
                                      },
                                      gradient: const LinearGradient(begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors:[ Color(0xfffe5762),  Color(0xfffe5762)]),
                                      child: Text(
                                        "All Variants",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ),
                                Container(
                                  width: 100,
                                  child: GradientButton(
                                      color:Color(0xfffe5762) ,
                                      onPressed: () {
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            DeactivatePreviousPromotionEvent(
                                              isCoupon: true,
                                                type: true,
                                                typeData: Variable.typeData,
                                                idList: idList
                                            ));
                                        Navigator.pop(context);
                                        Variable.isTypeDataCheck=false;

                                      },
                                      gradient: const LinearGradient(begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xfffe5762),
                                            Color(0xfffe5762)]),
                                      child: Text(
                                        "Deactivate",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }

            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            print("SHIIII$state");
            if (state is DeactivatePrevPromotionLoading) {
              showSnackBar(context,
                  message: "Deactivation Loading",
                  color: ColorPalette.green);
            }
            else if (state is DeactivatePrevPromotionSuccess) {

              if(state.returnList!=null){
                returedList=state.returnList??[];
                _showModalBottomSheetDelete();
              }
              else{
                showSnackBar(context,
                    message: "offers deactivated successfully", color: ColorPalette.black);
              }
              print("RETURNED Response${returedList}");
            } else if (state is DeactivatePrevPromotionFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<CouponBloc, CouponState>(
          listener: (context, state) {
            if(state is GetOfferAppliyingBasedOnReadCouponLoading){
              customCupertinoLoading();
            }
            if(state is GetOfferAppliyingBasedOnReadCouponSuccess){
              typeAppliying=state.discount.couponAppliyingOn!;
              couponType=state.discount.couponType??[];
              print("BAES$typeAppliying");

              setState(() {

              });
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if(state is TypeAppliyingListPostLoading){
              customCupertinoLoading();
            }
            if(state is TypeAppliyingListPostSuccess){
              print("SUSSSS${state.typeApply}");
              typeApply=state.typeApply;
              nextUrl=state.nextPageUrl;
              prevUrl=state.prevPageUrl;
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if(state is ProductListPostLoading){
              customCupertinoLoading();
            }
            if(state is ProductListPostSuccess){
              print("SUSSSS POOO${state.productList}");
              productlistPassing=state.productList;
              nextUrlProduct=state.nextPageUrl;
              prevUrlproduct=state.prevPageUrl;
            }
          },
        ),
        BlocListener<CouponBloc, CouponState>(
          listener: (context, state) {
            print("SSSSSSSEEEEE$state");
            if (state is CouponUpdateLoading) {
              showSnackBar(context,
                  message: "Coupon Update Loading",
                  color: ColorPalette.green);
            } else if (state is CouponUpdateSuccess) {
              showSnackBar(context,
                  message: "Coupon Updated",
                  color: ColorPalette.green);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<CouponBloc>().add(GetCouponReadEvent(int.tryParse(state.successMessage.toString())??0));
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SuccessScreenCoupon(update: true,),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );

            } else if (state is CouponUpdateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
              if(Variable.isTypeDataCheck==true){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Variable.errorMessage),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: GradientButton(
                                      color:Color(0xfffe5762) ,
                                      onPressed: () {
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            DeactivatePreviousPromotionEvent(
                                              isCoupon: true,
                                                type: false,
                                                typeData: Variable.typeData,
                                                idList: idList
                                            ));
                                        Variable.isTypeDataCheck=false;
                                        Navigator.pop(context);
                                      },
                                      gradient: const LinearGradient(begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors:[ Color(0xfffe5762),  Color(0xfffe5762)]),
                                      child: Text(
                                        "All Variants",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ),
                                Container(
                                  width: 100,
                                  child: GradientButton(
                                      color:Color(0xfffe5762) ,
                                      onPressed: () {
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            DeactivatePreviousPromotionEvent(
                                              isCoupon: true,
                                                type: true,
                                                typeData: Variable.typeData,
                                                idList: idList
                                            ));
                                        Variable.isTypeDataCheck=false;
                                        Navigator.pop(context);

                                      },
                                      gradient: const LinearGradient(begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xfffe5762),
                                            Color(0xfffe5762)]),
                                      child: Text(
                                        "Deactivate",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: "New Coupon",
          onTap: (){
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
                  SvgPicture.string(PromotionSvg().progressDesign2),
                  SizedBox(
                    height: 16,
                  ),
                  widget.editCoupen==true?
                  ReadDropDownCard(
                    label: "Type Applying",
                    selValue: selectedGender,
                  ):Flex(direction: Axis.vertical,
                      children:[
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Type Applying",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),),
                            SizedBox(height: 5,),
                            Container(
                                width: w,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(color: Colors.white,
                                    border: Border.all(color: Color(0xffe6ecf0)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  underline:Container(),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 180),
                                    child: Icon(Icons.arrow_drop_down_circle),
                                  ),
                                  hint: const Text("Type Applying"),
                                  value: selectedGender,
                                  onTap: (){
                                    widget.changeedSeg==true?print("TTTRRRRRR"):print("JHJHH");
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                      BlocProvider.of<DiscountBloc>(context).add(
                                          PostTypeAppliyingListEvent(
                                              nextUrl: "",
                                              prevUrl: "",
                                              inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                                              type: selectedGender??"",
                                              segmentList: widget.segmentList??[],
                                              searchElement: null
                                          ));
                                    });
                                    typeIdName="";
                                    setState(() {

                                    });
                                  },

                                  items: typeAppliying.map<DropdownMenuItem<String>>((String value) =>
                                      DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,)
                                      )).toList(),
                                )
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 16,
                  ),
                  widget.editCoupen==true?
                  ReadDropDownCard(
                    label: "Type Name",
                    selValue: typeIdName??typeCode,
                  ):DropDownCard(
                    selValue: typeIdName??typeCode,
                    label: "Type Name",
                    onTap: widget.editCoupen?null:(){
                      BlocProvider.of<DiscountBloc>(context).add(
                          PostTypeAppliyingListEvent(
                              nextUrl: "",
                              prevUrl: "",
                              inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                              type: selectedGender??"",
                              segmentList: widget.segmentList??[],
                              searchElement: null
                          ));
                      _showModalBottomSheetOfferPeriod(typeIdName);
                    },
                  ),
                  SizedBox(height: 16,),
                  widget.editCoupen?DropDownCard(
                    selValue: "${selectedProduct.length} Variants Selected",
                    label: "Selected Variants",
                    onTap: (){

                      _showModalBottomSheetSelectedVariants();
                    },
                  ):GestureDetector(
                    onTap: () {
                      setState(() {

                        isSelect=false;
                        BlocProvider.of<DiscountBloc>(context).add(
                            PostProductListEvent(
                                nextUrl: "",
                                prevUrl: "",
                                applyingtypeCode: typeCode??"",
                                inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                                applyingType: selectedGender??widget.coupenList!.couponApplyingOn.toString(),
                                segmentList: widget.segmentList??[],
                                searchElement: null
                            ));
                      });
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SelectProducts(
                          editProduct: widget.editCoupen,
                          buyMoreBool: true,
                          typeCode: typeCode??"",
                          type: selectedGender??"",
                          segmentList: widget.segmentList,
                          SelectedVariants:  selectedProduct,
                          productlist: grpVal,
                          productlistBuymore: buyVal,
                          idListSelected: idList,
                          selectedProduct: passingList,
                        ),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      //  SelectProducts
                    },
                    child: Container(
                      width: w,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xfffe5762),
                          width: 1,
                        ),
                        color: Color(0x0cfe5762),
                      ),
                      child: Text(widget.editCoupen==true?"${selectedProduct.length} Products Selected":
                      widget.editCoupen==false?"${passingList.length} Products Selected":"Select Product",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 16,),
                  Flex(direction: Axis.vertical,
                      children:[
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Coupon Type",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),),
                            Container(
                                width: w,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(color: Colors.white,
                                    border: Border.all(color: Color(0xffe6ecf0)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  underline:Container(),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 140),
                                    child: Icon(Icons.arrow_drop_down_circle),
                                  ),
                                  hint: const Text("Coupon Type"),
                                  value:
                                  widget.editCoupen==true?
                                 widget.coupenList?.couponType??"": coupunType,
                                  onChanged: (value) {
                                    setState(() {
                                      coupunType = value;

                                    });
                                  },

                                  items: couponType.map<DropdownMenuItem<String>>((String value) =>
                                      DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,)
                                      )).toList(),
                                )
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormReusable(
                    label: "Total value",
                    hint: "",
                    controller: totalValueController,
                    numField: true,
                  ),
                  SizedBox(height: 16,),
                  TextFormReusable(
                    label: "Maximum Count",
                    hint: "",
                    controller: maxCountController,
                    numField: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                    width: w,

                    child: customTableTwo(
                      border:  TableBorder(borderRadius: BorderRadius.circular(100),

                        verticalInside: BorderSide(
                            color: Color(0xffccdae3),width: 1,
                            style:
                            BorderStyle.solid),
                        horizontalInside:
                        const BorderSide(color: Color(0xffccdae3),width: 1, style: BorderStyle.solid),
                        // top: BorderSide(color: Color(0xffccdae3),width: 1,
                        //     style:
                        //     BorderStyle.solid),
                        right: const BorderSide(color: Color(0xffccdae3),width: 1,
                            style:
                            BorderStyle.solid),
                        left: const BorderSide(color: Color(0xffccdae3),width: 1,
                            style:
                            BorderStyle.solid),
                        bottom: const BorderSide(color: Color(0xffccdae3),width: 1,
                            style:
                            BorderStyle.solid),
                      ),
                      tableWidth: .5,
                      widths: {
                        0: const FlexColumnWidth(5),
                        1: const FlexColumnWidth(1),


                      },
                      childrens: [
                        TableRow(
                            children: [
                              tableHeadtextTwo(
                                'Terms & Conditions',
                                height: 50,
                                size: 13,
                              ),
                              tableHeadtextTwo(
                                '',
                                height: 50,
                                size: 13,
                              ),



                            ]),
                        if(termsList.isNotEmpty)...[

                          for(var i=0;i<termsList.length;i++)

                            TableRow(
                                children: [
                                  TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      child: TextFormField(
                                        controller: termsListController[i],
                                        onChanged: (va){
                                          onChangeVal=true;
                                          termsList[i]=termsListController[i].text;
                                          print("term$termsList");
                                          print("ters${termsControllr.text}");
                                          setState(() {

                                          });
                                        },
                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.digitsOnly,],
                                        // keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            fillColor: const Color(0xfff9f9f9),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Color(0xffccdae3),width: 1
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Color(0xffccdae3),width: 1
                                                )
                                            ), focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffccdae3),width: 1
                                            )
                                        ),
                                            contentPadding: const EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),),

                                  TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          onPressed: (){
                                            print("index delete $i");
                                            print("index delete ${termsList[i]}");

                                            termsList.removeAt(i);
                                            termsListController.removeAt(i);
                                            print("index delete $termsList");
                                            setState(() {

                                            });
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: ColorPalette.primary// Text Color
                                          ),child:  Icon(Icons.delete)),
                                      )),


                                ]
                            ),
                        ],
                        TableRow(
                            children: [
                              TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,

                                  child: TextFormField(
                                    controller: termsControllr,
                                    decoration: InputDecoration(
                                        fillColor: Color(0xfff9f9f9),
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffccdae3),width: 1
                                            )
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffccdae3),width: 1
                                            )
                                        ), focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color(0xffccdae3),width: 1
                                        )
                                    ),
                                        contentPadding: EdgeInsets.only(left: 10)
                                    ),
                                  ),
                                ),),

                              TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    TextButton(
                                      onPressed: (){
                                      termsList.add(termsControllr.text);
                                      termsListController.add(TextEditingController(text: termsControllr.text));
                                      print("termsList$termsList");
                                      print("termsList${termsControllr.text}");

                                      setState(() {
                                        termsControllr.clear();

                                      });
                                    },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: ColorPalette.primary// Text Color
                                      ),child:  Icon(Icons.add)),
                                  )),
                            ]
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClusterCard(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Can apply multiple times",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  canApplyMultiple = !canApplyMultiple;
                                });
                              },
                              child: SvgPicture.string(canApplyMultiple
                                  ? HomeSvg().toggleActive
                                  : HomeSvg().toggleInActive)),
                        ],
                      )),
                  SizedBox(height: 10,),
                  ClusterCard(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Can apply together",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  canApplyTogateger = !canApplyTogateger;
                                });
                              },
                              child: SvgPicture.string(canApplyTogateger
                                  ? HomeSvg().toggleActive
                                  : HomeSvg().toggleInActive)),
                        ],
                      )),
                  SizedBox(height: 10,),
                  ClusterCard(
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is Active",
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
                  GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {
                        widget.editCoupen?BlocProvider.of<CouponBloc>(context).add(
                            UpdateCouponEvent(
                              termsList: termsList,
                              id: widget.coupenList?.id,
                                isActive: isActive,
                                channelCode: widget.channelCode??"",
                                offerPeriodId: widget.offerPeriodId??0,
                                basedOn: widget.basedOn??"",
                                isAvailableForAll: widget.isAvailableForAll??false,
                                image: widget.imageId,
                                customerList: widget.customerList??[],
                                inventoryId: authentication.authenticatedUser.organisationCode??"",
                                createdBy: authentication.authenticatedUser.code??"",
                                segmentList: widget.discountSegment??[],
                                description: widget.promotionDescription??"",
                                name: widget.promotionName??"",
                                lines: selectedProduct,
                                couponApplyingOn: widget.editCoupen?widget.coupenList?.couponApplyingOn??"":selectedGender.toString(),
                                couponApplyingOnName: typeIdName??"",
                                couponApplyingOnId: typeId??0,
                                couponApplyingOnCode: typeCode??"",
                                maxCount: int.tryParse(maxCountController.text),
                                canApplyMultiple: canApplyMultiple,
                                canApplyTogather: canApplyTogateger,
                                displayName: widget.displayName,
                                totalValue: double.tryParse(totalValueController.text),
                                priceOrPercentage: widget.discountPercentagePrice,
                                coupenType: widget.editCoupen?widget.coupenList?.couponType:coupunType
                            )):
                        BlocProvider.of<CouponBloc>(context).add(
                            CreateCouponGetMoreEvent(
                                isActive: isActive,
                                channelCode: widget.channelCode??"",
                                offerPeriodId: widget.offerPeriodId??0,
                                basedOn: widget.basedOn??"",
                                isAvailableForAll: widget.isAvailableForAll??false,
                                image: widget.imageId,
                                customerList: widget.customerList??[],
                                inventoryId: authentication.authenticatedUser.organisationCode??"",
                                createdBy: authentication.authenticatedUser.code??"",
                                segmentList: widget.discountSegment??[],
                                description: widget.promotionDescription??"",
                                name: widget.promotionName??"",
                                lines: passingListBuyMore??[],
                                channelId: widget.channelCode,
                                couponApplyingOn: selectedGender.toString(),
                                couponApplyingOnName: typeIdName??"",
                                couponApplyingOnId: typeId??0,
                                couponApplyingOnCode: typeCode??"",
                              maxCount: int.tryParse(maxCountController.text),
                              canApplyMultiple: canApplyMultiple,
                              canApplyTogather: canApplyTogateger,
                               displayName: widget.displayName,
                              totalValue: double.tryParse(totalValueController.text),
                              priceOrPercentage: widget.discountPercentagePrice,
                              coupenType: coupunType,
                              termsList: termsList
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
                        "Save Promotion",
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
          ),
        ),
      ),
    );
  }
  _showModalBottomSheetOfferPeriod(String? typeIddName ) {
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
          print("hhhhh$typeIdName");
          var w = MediaQuery.of(context).size.width;
          return BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20),
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
                          Text(
                            "Type Applying",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width:w/1.1,child: SearchCard(
                                  onchange: (val){
                                    BlocProvider.of<DiscountBloc>(context).add(
                                        PostTypeAppliyingListEvent(
                                            nextUrl: "",
                                            prevUrl: "",
                                            inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                                            type: selectedGender??"",
                                            segmentList: widget.segmentList??[],
                                            searchElement: val
                                        ));
                                  },
                                )),
                                ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: typeApply.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              onselect(index);
                                              setState(() {});
                                              typeId=typeApply[index].id??0;
                                              typeCode=typeApply[index].code??"";
                                              typeIdName=typeApply[index].name??"";
                                              print("hhhhh$typeIdName");
                                              BlocProvider.of<DiscountBloc>(context).add(
                                                  PostProductListEvent(
                                                      nextUrl: "",
                                                      prevUrl: "",
                                                      applyingtypeCode: typeApply[index].code??"",
                                                      inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                                                      applyingType: selectedGender??"",
                                                      segmentList: widget.segmentList??[],
                                                      searchElement: null
                                                  ));
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  bottom: 10,
                                                  top: 5,
                                                  right: 8),
                                              child: SvgPicture.string(
                                                // select == index
                                                  typeApply[index].name==typeIddName
                                                      ? HomeSvg()
                                                      .radioButtonActive
                                                      : HomeSvg()
                                                      .radioInActive),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            typeApply[index].name ?? "",
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500,
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
                                Row(mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            PostTypeAppliyingListEvent(
                                                nextUrl: "",
                                                prevUrl: prevUrl,
                                                inventoryId: authentication
                                                    .authenticatedUser
                                                    .organisationCode
                                                    .toString(),
                                                type: selectedGender ?? "",
                                                segmentList: widget
                                                    .segmentList ?? [],
                                                searchElement: null
                                            ));
                                      },
                                      child: Text("Previous",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.primary,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<DiscountBloc>(context)
                                            .add(
                                            PostTypeAppliyingListEvent(
                                                nextUrl: nextUrl,
                                                prevUrl: "",
                                                inventoryId: authentication
                                                    .authenticatedUser
                                                    .organisationCode
                                                    .toString(),
                                                type: selectedGender ?? "",
                                                segmentList: widget
                                                    .segmentList ?? [],
                                                searchElement: null
                                            ));
                                      },
                                      child: Text("Next",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.primary,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
  _showModalBottomSheetSelectedVariants() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var w = MediaQuery.of(context).size.width;
          return BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
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
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(width: w,
                            padding: EdgeInsets.only(right: 15),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap:(){
                                  Navigator.pop(context);
                                },child: Icon(Icons.close)),),
                          Text(
                            "Selected Variants",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                ListView.separated(
                                  primary: true,
                                  shrinkWrap: true,
                                  itemCount: selectedProduct.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    bottom: 5,
                                                    top: 5,
                                                    right: 8),
                                                child: Text("${index + 1}",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w / 22,
                                                    fontWeight: FontWeight.w500,
                                                  ),)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: w/1.5,
                                              child: Text(
                                                selectedProduct[index].variantName ?? "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: (){
                                                // selectedProduct.removeAt(index);
                                                selectedProduct[index].isActive=false;
                                                setState((){});
                                                print("THATTT${selectedProduct[index].variantName}${selectedProduct[index].isActive}");

                                              },
                                              child: Text(selectedProduct[index].isActive==false?"Removed":"Remove",
                                                style: GoogleFonts.roboto(
                                                  color: ColorPalette.primary,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                            )

                                          ],
                                        ),
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
                                GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      Navigator.pop(context);

                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: SelectProducts(
                                          editProduct: widget.editCoupen,
                                          addNewInPatch: true,
                                          buyMoreBool: true,
                                          typeCode: typeCode??"",
                                          type: selectedGender??"",
                                          segmentList: widget.segmentList,
                                          SelectedVariants:  selectedProduct,
                                          productlist: grpVal,
                                          productlistBuymore: buyVal,
                                          idListSelected: idList,
                                          selectedProduct: passingList,
                                        ),
                                        withNavBar: true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.fade);
                                    },
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: Text(
                                      "Add New Products",
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

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
  _showModalBottomSheetDelete() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var w = MediaQuery.of(context).size.width;
          return BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20),
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
                          Text(
                            "Selected Variants",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ListView.separated(
                                //   primary: true,
                                //   shrinkWrap: true,
                                //   itemCount: returedList.length,
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   itemBuilder: (context, index) =>
                                //       Padding(
                                //         padding: const EdgeInsets.symmetric(vertical: 10),
                                //         child: Row(
                                //           children: [
                                //             CustomCheckBox(
                                //               key: UniqueKey(),
                                //               // value:
                                //               // widget.readUser,
                                //               // segmentListttt.contains(segmentList[index].name),
                                //               onChange: (p0) {
                                //                 if (p0) {
                                //                   idListPost.add(ProductListPromotion(
                                //                     typeData: returedList[index].typeData,
                                //                     variantId: returedList[index].variantId
                                //                   ));
                                //                   // segmentListttt.add(segmentList[index].name ?? "");
                                //                   // discountSegment.add(GetSegmentList(
                                //                   //     segmentName: segmentList[index].name,
                                //                   //     segmentCode: segmentList[index].code
                                //                   // ));
                                //                 }
                                //                 else {
                                //                   idListPost.remove(ProductListPromotion(
                                //                       typeData: returedList[index].typeData,
                                //                       variantId: returedList[index].variantId
                                //                   ));
                                //                 }
                                //                 // widget.listuser(widget.userList);
                                //                 print("seg-list${idListPost}");
                                //
                                //
                                //               },
                                //             ),
                                //             SizedBox(
                                //               width: 5,
                                //             ),
                                //             Container(
                                //               width: w/1.8,
                                //               child: Text(
                                //                 returedList[index].variantName ?? "",
                                //                 style: GoogleFonts.roboto(
                                //                   color: Colors.black,
                                //                   fontSize: w / 22,
                                //                   fontWeight: FontWeight.w500,
                                //                 ),
                                //               ),
                                //             ),
                                //             Text(
                                //               returedList[index].offerName ?? "",
                                //               style: GoogleFonts.roboto(
                                //                 color: Colors.black,
                                //                 fontSize: w / 22,
                                //                 fontWeight: FontWeight.w500,
                                //               ),
                                //             ),
                                //
                                //           ],
                                //         ),
                                //       ),
                                //   separatorBuilder: (context, index) =>
                                //       Container(
                                //         color: ColorPalette.divider,
                                //         height: 1,
                                //         width: w,
                                //       ),
                                // ),
                                //
                                // const SizedBox(
                                //   height: 30,
                                // ),
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                                  width: w,

                                  child: customTableTwo(
                                    border:  TableBorder(borderRadius: BorderRadius.circular(100),

                                      verticalInside: BorderSide(
                                          color: Color(0xffccdae3),width: 1,
                                          style:
                                          BorderStyle.solid),
                                      horizontalInside:
                                      const BorderSide(color: Color(0xffccdae3),width: 1, style: BorderStyle.solid),
                                      // top: BorderSide(color: Color(0xffccdae3),width: 1,
                                      //     style:
                                      //     BorderStyle.solid),
                                      right: const BorderSide(color: Color(0xffccdae3),width: 1,
                                          style:
                                          BorderStyle.solid),
                                      left: const BorderSide(color: Color(0xffccdae3),width: 1,
                                          style:
                                          BorderStyle.solid),
                                      bottom: const BorderSide(color: Color(0xffccdae3),width: 1,
                                          style:
                                          BorderStyle.solid),
                                    ),
                                    tableWidth: .5,
                                    widths: {
                                      0: const FlexColumnWidth(1),
                                      1: const FlexColumnWidth(3),
                                      2: const FlexColumnWidth(1.5),


                                    },
                                    childrens: [
                                      TableRow(
                                          children: [
                                            tableHeadtextTwo(
                                              '',
                                              height: 50,
                                              size: 13,
                                            ),
                                            tableHeadtextTwo(
                                              'Variant Name',
                                              height: 50,
                                              size: 13,
                                            ),
                                            tableHeadtextTwo(
                                              'Offer Name',
                                              height: 50,
                                              size: 13,
                                            ),



                                          ]),
                                      if(returedList.isNotEmpty)...[

                                        for(var i=0;i<returedList.length;i++)

                                          TableRow(
                                              children: [
                                                TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                                  child: CustomCheckBox(
                                                    key: UniqueKey(),
                                                    // value:
                                                    // widget.readUser,
                                                    // segmentListttt.contains(segmentList[index].name),
                                                    onChange: (p0) {
                                                      if (p0) {
                                                        idListPost.add(ProductListPromotion(
                                                            typeData: returedList[i].typeData,
                                                            variantId: returedList[i].variantId
                                                        ));
                                                        // segmentListttt.add(segmentList[index].name ?? "");
                                                        // discountSegment.add(GetSegmentList(
                                                        //     segmentName: segmentList[index].name,
                                                        //     segmentCode: segmentList[index].code
                                                        // ));
                                                      }
                                                      else {
                                                        idListPost.remove(ProductListPromotion(
                                                            typeData: returedList[i].typeData,
                                                            variantId: returedList[i].variantId
                                                        ));
                                                      }
                                                      // widget.listuser(widget.userList);
                                                      print("seg-list${idListPost}");


                                                    },
                                                  ),
                                                ),
                                                TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                                    child: Text(returedList[i].variantName??"")
                                                ),

                                                TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                                    child: Text(returedList[i].couponName??"")),


                                              ]
                                          ),
                                      ],

                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      BlocProvider.of<DiscountBloc>(context)
                                          .add(
                                          DeleteSelectiveVariantsEvent(
                                              variants: idListPost
                                          ));
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
                                      "Submit",
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

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
