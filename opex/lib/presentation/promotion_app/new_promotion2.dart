import 'dart:core';

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/discount_bloc.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:cluster/presentation/promotion_app/select_products.dart';
import 'package:cluster/presentation/promotion_app/success_promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/custom_checkbox.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/loading.dart';
import '../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import 'buy_more_get_form/costumtable.dart';
import 'dropdown_card.dart';
import 'models_promotion/discount_models/model_discount.dart';

class NewPromotion2 extends StatefulWidget {
  final List<String>? segmentList;
  final List<GetSegmentList>? discountSegment;
  final String? promotionTitle;
  final String? promotionDiscription;
  final bool? isAvailableForAll;
  final List<GetTypeApplying>? customerList;
  final int? offerPeriodId;
  final int? offerGroupId;
  final String? basedOn;
  final String? channelCode;
  final double? discountPercentagePrice;
   dynamic imageId;
  final DiscountList? readDiscount;
  final bool editDiscount;
  final bool? changeSegment;
   NewPromotion2({Key? key,
     this.changeSegment,
    this.channelCode,
    this.segmentList,
    this.discountSegment,
    this.promotionTitle,
    this.promotionDiscription,
    this.isAvailableForAll,
    this.customerList,
    this.offerPeriodId,
    this.offerGroupId,
    this.basedOn,
    this.discountPercentagePrice,
     this.imageId, this.readDiscount,  this.editDiscount=false}) : super(key: key);

  @override
  State<NewPromotion2> createState() => _NewPromotion2State();
}

class _NewPromotion2State extends State<NewPromotion2> {
  String? selGender;
  bool isActive = true;
  bool isSelect = false;
  String? selectedGender;
  List<String> typeAppliying=[];
  String nextUrlProduct="";
  String nextUrl="";
  String prevUrl="";
  String prevUrlproduct="";

  @override
  void initState() {
    widget.editDiscount?readData():null;
    context.read<DiscountBloc>().add( const GetOfferAppliyingBasedOnReadEvent());
    BlocProvider.of<DiscountBloc>(context).add(
        PostTypeAppliyingListEvent(
            nextUrl: "",
            prevUrl: "",
            inventoryId: authentication.authenticatedUser.organisationCode.toString(),
            type: widget.readDiscount?.offerLines?[0].typeApplying??"",
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
        applyingtypeCode: widget.readDiscount?.offerLines?[0].typeCode??"",
        applyingType: widget.readDiscount?.offerLines?[0].typeApplying??""));
    super.initState();
  }
  List<ProductListPromotion> returedList=[];
  List<ProductListPromotion> passingList=[];
  List<int>idList=[];
  bool selectAll=false;
  void grpVal(List<ProductListPromotion> product,List<int>idListt,bool selectedAll){
    selectAll=selectedAll;
    passingList=product;
    idList=idListt;
    productAdd();
    setState((){});
      print("uuu$selectAll");
      print("uuu$passingList");
    print("uuu$idList");
  }
  List<GetTypeApplying> typeApply=[];
  List<ProductListPromotion> idListPost=[];
  List<ProductListPromotion> productlistPassing=[];
  List<ProductListPromotion> selectedProduct=List.from([]);
  String? typeCode;
  int? typeId;
  String? typeIdName;
  TextEditingController maxQtycontroller=TextEditingController();
  TextEditingController prioritycontroller=TextEditingController();
  readData(){
    maxQtycontroller.text=widget.readDiscount?.offerLines?[0].maxQty.toString()??"";
    prioritycontroller.text=widget.readDiscount?.priority.toString()??'';
    isActive=widget.readDiscount?.isActive??false;
    widget.changeSegment==true?selectedGender:selectedGender=widget.readDiscount?.offerLines?[0].typeApplying??"";
    widget.changeSegment==true?typeIdName="":typeIdName=widget.readDiscount?.offerLines?[0].typeCode??"";
    context.read<DiscountBloc>().add( PaginatedSelectedVariantListEvent("",widget.readDiscount?.offerLines?[0].offerProductGroupCode??""));


  }
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
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return MultiBlocListener(
  listeners: [
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if(state is GetOfferAppliyingBasedOnReadLoading){
          customCupertinoLoading();
        }
        if(state is GetOfferAppliyingBasedOnReadSuccess){
          typeAppliying=state.discount.typeAppliying!;

          print("BAES$typeAppliying");

          setState(() {

          });
        }
      },
),
    // BlocListener<DiscountBloc, DiscountState>(
    //   listener: (context, state) {
    //    if(state is TypeAppliyingListPostLoading){
    //      customCupertinoLoading();
    //    }
    //    if(state is TypeAppliyingListPostSuccess){
    //      print("SUSSSS${state.typeApply}");
    //      typeApply=state.typeApply;
    //      nextUrl=state.nextPageUrl;
    //      prevUrl=state.prevPageUrl;
    //    }
    //   },
    // ),
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        print("nnnnnn$state");
        if(state is GetSelectedVariantListLoading){
          customCupertinoLoading();
        }
        if(state is GetSelectedVariantListSuccess){

          idList.clear();
          print("the list coming${state.variants.data}");
          selectedProduct=state.variants.data;

          if(passingList.isNotEmpty){
            print("the list passing${selectedProduct.length}");
            for(var i=0;i<passingList.length;i++){
              selectedProduct.add(
                  ProductListPromotion(id: passingList[i].id,
                    name: passingList[i].name,
                    variantName: passingList[i].name,
                    barcode: passingList[i].barcode
              ));

            }

          }
          idList.clear();
          for(int i=0;i<selectedProduct.length;i++){
            idList.add(selectedProduct[i].variantId??0);
          }
          print("PRODUCT Before$idList");
          // if(selectedProduct.isNotEmpty){
          //   for(var i=0;i<selectedProduct.length;i++){
          //     idList.add(selectedProduct[i].id??0);
          //   }
          //
          // }

          print("PRODUCT SEELE$selectedProduct");
          print("PRODUCT SEELE$idList");

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
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        print("Sucsess Msg$state");
        if (state is DiscountCreateLoading) {
          showSnackBar(context,
              message: "Discount Loading",
              color: ColorPalette.green);
        } else if (state is DiscountCreateSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(context,
              message: "Discount Created Successfully",
              color: ColorPalette.green);
          context.read<DiscountBloc>().add(GetDiscountReadEvent(int.tryParse(state.successMessage.toString())??0));
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SuccessPromotion(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );

        } else if (state is DiscountCreateFailed) {
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
                                          isCoupon: false,
                                            type: false,
                                            typeData: Variable.typeData,
                                            idList: idList
                                        ));
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
                                          isCoupon: false,
                                          type: true,
                                            typeData: Variable.typeData,
                                            idList: idList
                                        ));
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
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        if (state is DiscountUpdateLoading) {
          showSnackBar(context,
              message: "Discount Update Loading",
              color: ColorPalette.green);
        } else if (state is DiscountUpdateSuccess) {
          showSnackBar(context,
              message: "Discount Updated",
              color: ColorPalette.green);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<DiscountBloc>().add(GetDiscountReadEvent(int.tryParse(state.successMessage.toString())??0));
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SuccessPromotion(update: true,),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );

        } else if (state is DiscountUpdateFailed) {
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
                                          isCoupon: false,
                                            type: false,
                                            typeData: Variable.typeData,
                                            idList: idList
                                        ));
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
                                          isCoupon: false,
                                            type: true,
                                            typeData: Variable.typeData,
                                            idList: idList
                                        ));
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
    BlocListener<DiscountBloc, DiscountState>(
      listener: (context, state) {
        print("SEelel$state");
        if (state is DeleteSelectiveVariantsLoading) {
          showSnackBar(context,
              message: "Discount Loading",
              color: ColorPalette.green);
        } else if (state is DeleteSelectiveVariantsSuccess) {
          showSnackBar(context,
              message: state.successMessage??"",
              color: ColorPalette.green);
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: SuccessPromotion(),
          //   withNavBar: true, // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );

        } else if (state is DeleteSelectiveVariantsFailed) {
          showSnackBar(context,
              message: state.error, color: ColorPalette.black);


        }
      },
    ),
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: "New Discount",
              isBack: true,
              isAction: false,
              onTap: (){
                Navigator.pop(context);
              }),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.string(PromotionSvg().progressDesign2),
                  const SizedBox(
                    height: 16,
                  ),
                  widget.editDiscount==true?
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
                                    widget.changeSegment==true?print("TTTRRRRRR"):print("JHJHH");
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
                                    typeCode="";
                                    selectedProduct.clear();
                                    passingList.clear();
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
                  SizedBox(height: 16,),
                  widget.editDiscount==true?
                  ReadDropDownCard(
                    label: "Type Name",
                    selValue: typeIdName??typeCode,
                  ):DropDownCard(
                    selValue: typeIdName??typeCode,
                    label: "Type Name",
                    onTap: widget.editDiscount?null:(){
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
                  widget.editDiscount?DropDownCard(
                    selValue: "${selectedProduct.length} Variants Selected",
                    label: "Selected Variants",
                    onTap: (){
                      // BlocProvider.of<DiscountBloc>(context).add(
                      //     PostProductListEvent(
                      //         nextUrl: "",
                      //         prevUrl: "",
                      //         applyingtypeCode: widget.readDiscount?.offerLines?[0].typeCode??"",
                      //         inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                      //         applyingType: selectedGender??"",
                      //         segmentList: widget.segmentList??[],
                      //         searchElement: null
                      //     ));
                      _showModalBottomSheetSelectedVariants();
                    },
                  ):GestureDetector(
                    onTap: () {
                      setState(() {

                        isSelect=false;
                      });
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SelectProducts(
                          editProduct: widget.editDiscount,
                            type: selectedGender??"",
                            segmentList: widget.segmentList,
                            SelectedVariants: productlistPassing,
                            typeCode: typeCode??"",
                            idListSelected: idList??[],
                            selectedProduct: passingList,
                            productlist: grpVal),
                        withNavBar: true,
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
                      child: Text(widget.editDiscount==true?"${selectedProduct.length} Products Selected":
                      widget.editDiscount==false?"${passingList.length} Products Selected":"Select Product",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormReusable(
                    label: "Priority",
                    hint: "",
                    controller: prioritycontroller,
                    numField: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormReusable(
                    label: "Maximum Inventory",
                    hint: "",
                    controller: maxQtycontroller,
                    numField: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: w,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
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
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {
                        widget.editDiscount?BlocProvider.of<DiscountBloc>(context).add(
                            UpdateDiscountEvent(
                              inventoryId: authentication.authenticatedUser.organisationCode??"",
                              channelCode: widget.channelCode??"",
                              priority: int.tryParse(prioritycontroller.text)??0,
                              offerLineId: widget.readDiscount?.offerLines?[0].id??0,
                              offerProductGroupCode: widget.readDiscount?.offerLines?[0].offerProductGroupCode??"",
                              id: widget.readDiscount?.id??0,
                                isActive: isActive,
                                offerPeriodId: widget.offerPeriodId??0,
                                offerGroupId: widget.offerGroupId??null,
                                basedOn: widget.basedOn??"",
                                isAvailableForAll: widget.isAvailableForAll??false,
                                discountPercentagePrice: widget.discountPercentagePrice??0,
                                image: widget.imageId??null,
                                customerList: widget.customerList??[],
                                // inventoryId: authentication.authenticatedUser.organisationCode??"",
                                createdBy: authentication.authenticatedUser.code??"",
                                segmentList: widget.discountSegment??[],
                                description: widget.promotionDiscription??"",
                                title: widget.promotionTitle??"",
                                variants: selectedProduct,
                                typeApplying: selectedGender??widget.readDiscount?.offerLines?[0].typeApplying.toString()??"",
                                typeCode: typeCode??widget.readDiscount?.offerLines?[0].typeCode??"",
                                typeId:typeId??widget.readDiscount?.offerLines?[0].typeId??0,
                                maxQty: int.tryParse(maxQtycontroller.text)??0
                            )):
                        BlocProvider.of<DiscountBloc>(context).add(
                            CreateDiscountEvent(
                                isActive: isActive,
                                priority: int.tryParse(prioritycontroller.text)??0,
                                channelCode: widget.channelCode??"",
                                offerPeriodId: widget.offerPeriodId??0,
                                offerGroupId: widget.offerGroupId??0,
                                basedOn: widget.basedOn??"",
                                isAvailableForAll: widget.isAvailableForAll??false,
                                discountPercentagePrice: widget.discountPercentagePrice??0,
                                image: widget.imageId??null,
                                customerList: widget.customerList??[],
                                inventoryId: authentication.authenticatedUser.organisationCode??"",
                                createdBy: authentication.authenticatedUser.code??"",
                                segmentList: widget.discountSegment??[],
                                description: widget.promotionDiscription??"",
                                title: widget.promotionTitle??"",
                              variants: passingList,
                              typeApplying: selectedGender??"",
                              typeCode: typeCode??"",
                              typeId:typeId??0,
                              maxQty: int.tryParse(maxQtycontroller.text)??0
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
  _showModalBottomSheetOfferPeriod(String? typeIdNAME) {
    int select = 0;
    bool searching=false;
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
          var w = MediaQuery.of(context).size.width;
          
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
                                  hint: "Search Type Applying...",
                                  onchange: (val){
                                    searching=true;
                                    BlocProvider.of<DiscountBloc>(context).add(
                                        PostTypeAppliyingListEvent(
                                            nextUrl: "",
                                            prevUrl: "",
                                            inventoryId: authentication.authenticatedUser.organisationCode.toString(),
                                            type: selectedGender??"",
                                            segmentList: widget.segmentList??[],
                                            searchElement: val
                                        ));
                                    setState((){});
                                  },
                                )),
                               BlocBuilder<DiscountBloc, DiscountState>(
                            builder: (context, state) {
                              if(state is TypeAppliyingListPostLoading){
                                Container(
                                    width: w,
                                    height: 300,
                                    child: customCupertinoLoading());
                              }
                              if(state is TypeAppliyingListPostSuccess){
                                print("SUSSSSSUSSSS${state.typeApply}");
                                print("SUSSSSSUSSSS${typeApply.length}");
                                typeApply=state.typeApply;
                                nextUrl=state.nextPageUrl;
                                prevUrl=state.prevPageUrl;

                            return ListView.separated(
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
                                              print("TTYYPPEECODE$typeCode");
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
                                                  typeApply[index].name==typeIdNAME
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
                                );

                              }
                              if(state is TypeAppliyingListPostFailed) {
                                return Container(
                                    width: w,
                                    height: 300,
                                    child: Center(
                                        child: Text("No Data Found")));
                              }
                              return Container(
                                  width: w,
                                  height: 300,
                                  child: customCupertinoLoading());

  },
),
                                const SizedBox(
                                  height: 30,
                                ),
                                searching==true?Container():Row(mainAxisAlignment: MainAxisAlignment
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
                                GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {},
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: Text(
                                      "Select",
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
                                                      print("THATTT${selectedProduct[index].variantName}${selectedProduct[index].isActive}");
                                                      setState((){});
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
                                                editProduct: widget.editDiscount,
                                                  typeCode: typeCode??"",
                                                type: selectedGender??"",
                                                  segmentList: widget.segmentList,idListSelected: idList,
                                                  selectedProduct: passingList,
                                                  SelectedVariants: selectedProduct,
                                                  productlist: grpVal),
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
                                                    child: Text(returedList[i].offerName??"")),


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
