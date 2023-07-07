import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/promotion_app/buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import 'package:cluster/presentation/promotion_app/dropdown_card.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:cluster/presentation/promotion_app/select_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/loading.dart';
import '../../../core/utils/variables.dart';
import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../blocs/discount_bloc/discount_bloc.dart';
import 'buy_more_success_screen.dart';
import 'costumtable.dart';


class BuyMoreGetFormTwo extends StatefulWidget {
  final List<String>? segmentList;
  final bool editBuyMore;
  final bool? changeedSeg;
  final List<GetSegmentList>? discountSegment;
  final String? promotionTitle;
  final String? promotionDiscription;
  final bool? isAvailableForAll;
  final List<GetTypeApplying>? customerList;
  final int? offerPeriodId;
  final int? offerGroupId;
  final String? basedOn;
  final String? channelCode;
  final String? channelId;
  final double? discountPercentagePrice;
  dynamic imageId;
  final BuyMoreList? buyMore;

  BuyMoreGetFormTwo({Key? key, this.segmentList,this.channelId,
    required this.editBuyMore, this.discountSegment,
    this.promotionTitle, this.promotionDiscription, this.isAvailableForAll,
    this.customerList, this.offerPeriodId, this.offerGroupId, this.basedOn,this.imageId,
    this.channelCode, this.discountPercentagePrice, this.buyMore, this.changeedSeg}) : super(key: key);

  @override
  State<BuyMoreGetFormTwo> createState() => _NewPromotion2State();
}

class _NewPromotion2State extends State<BuyMoreGetFormTwo> {
  String? selGender;
  bool isActive = true;
  bool isTableActive = false;
  bool isSelect = false;
  String? selectedGender;
  bool isPress=false;

  List<ProductListPromotion> passingList=[];
  List<int>idList=[];
  void grpVal(List<ProductListPromotion> product,List<int>idListt,bool selectedAll){
    passingList=product;
    selectedAll=selectedAll;
    idList=idListt;
    setState((){});
    print("uuu$passingList");
    print("uuu$idList");
  }
  List<ProductListPromotion> passingListBuyMore=[];
  void buyVal(List<ProductListPromotion> product,List<int>idListt,bool selectedAll){
    passingListBuyMore=product;
    selectedAll=selectedAll;
    idList=idListt;
    productAdd();
    setState((){});
    print("uuu$passingListBuyMore");
  }
  List<bool>isActiveList=[];
  @override
  void initState() {
    widget.editBuyMore?readData():null;
    context.read<BuyMoreBloc>().add( const GetOfferApplyingBasedOnReadBuyMoreEvent());
    BlocProvider.of<DiscountBloc>(context).add(
        PostTypeAppliyingListEvent(
            nextUrl: "",
            prevUrl: "",
            inventoryId: authentication.authenticatedUser.organisationCode.toString(),
            type: widget.buyMore?.buyMoreAppliyingOn??"",
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
        applyingtypeCode: widget.buyMore?.buyMoreAppliyingOnCode??"",
        applyingType: widget.buyMore?.buyMoreAppliyingOn??""));
    super.initState();
  }
  List<String> typeAppliying = [];
  String nextUrlProduct="";
  String nextUrl="";
  String prevUrl="";
  String prevUrlproduct="";
  List<GetTypeApplying> typeApply=[];
  List<ProductListPromotion> idListPost=[];
  List<ProductListPromotion> productlist=[];
  List<ProductListPromotion> selectedProduct=List.from([]);
  String? typeCode;
  int? typeId;
  String? typeIdName;
  bool? onChangeVal=false;
  TextEditingController maxQtycontroller=TextEditingController();
  List<ProductListPromotion> returedList=[];
  readData(){

    idList.clear();
    for(int i=0;i<widget.buyMore!.lines!.length;i++){
      idList.add(widget.buyMore!.lines![i].variantId??0);
    }
    print("readddddddd$idList");
    isActive=widget.buyMore?.isActive??false;
    countList=widget.buyMore?.countList??[];
    widget.changeedSeg==true?typeIdName="":
    typeIdName=widget.buyMore?.buyMoreAppliyingOnName??"";
    widget.changeedSeg==true?selectedGender:selectedGender=widget.buyMore?.buyMoreAppliyingOn??"";
    selectedProduct=widget.buyMore?.lines??[];
    for(var i=0;i<widget.buyMore!.countList!.length;i++){
      conutController.add(TextEditingController(text: widget.buyMore?.countList?[i].count.toString()));
      priceController.add(TextEditingController(text: widget.buyMore?.countList?[i].priceOrPercentage.toString()));
      print("controooo${conutController}");
      print("controooo$priceController");
    }

  }
  List<GetCount> countList=List.from([]);
  List<TextEditingController> conutController=[];
  List<TextEditingController> priceController=[];
  List<bool> boolList=[];
  bool selectAll=false;
  TextEditingController countControllr=TextEditingController();
  TextEditingController priceControllr=TextEditingController();
  productAdd(){
    print("before${passingList.length}");
    print("before${selectedProduct.length}");
    print("before${idList.length}");


    if(selectAll==true){
      selectedProduct.clear();
      for (int i = 0; i < passingListBuyMore.length; i++) {
        selectedProduct.add(ProductListPromotion(
          id: null,
          isActive: true,
          variantCode: passingListBuyMore[i].variantCode,
          variantName: passingListBuyMore[i].variantName,
          variantId: passingListBuyMore[i].variantId,
          barcode: passingListBuyMore[i].barcode,
        ));
      }}
    else{
      selectedProduct.clear();
      for (int i = 0; i < passingListBuyMore.length; i++) {
        selectedProduct.add(ProductListPromotion(
          id: null,
          isActive: true,
          variantCode: passingListBuyMore[i].variantCode,
          variantName: passingListBuyMore[i].variantName,
          variantId: passingListBuyMore[i].variantId,
          barcode: passingListBuyMore[i].barcode,
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
  int countIndex=0;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<BuyMoreBloc, BuyMoreState>(
      listener: (context, state) {
        print("Success State Msg$state");
        if (state is BuyMoreCreateLoading) {
          showSnackBar(context,
              message: "BuyMore Loading",
              color: ColorPalette.green);
        } else if (state is BuyMoreCreateSuccess) {
          showSnackBar(context,
              message: "Buy more created successfully",
              color: ColorPalette.green);
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<BuyMoreBloc>().add(GetBuyMoreReadEvent(int.tryParse(state.successMessage.toString())??0));
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SuccessScreenBuyMore(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        } else if (state is BuyMoreCreateFailed) {
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
    BlocListener<BuyMoreBloc, BuyMoreState>(
      listener: (context, state) {
        if(state is GetOfferAppliyingBasedOnReadBuyMoreLoading){
          customCupertinoLoading();
        }
        if(state is GetOfferAppliyingBasedOnReadBuyMoreSuccess){
          typeAppliying=state.discount.buyMoreTypeAppliying!;

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
    // BlocListener<DiscountBloc, DiscountState>(
    //   listener: (context, state) {
    //     if(state is GetSelectedVariantListLoading){
    //       customCupertinoLoading();
    //     }
    //     if(state is GetSelectedVariantListSuccess){
    //
    //       idList.clear();
    //       selectedProduct=state.variants.data;
    //       if(passingList.isNotEmpty){
    //         for(var i=0;i<passingList.length;i++){
    //           selectedProduct.add(
    //               ProductListPromotion(id: passingList[i].id,
    //                   name: passingList[i].name,
    //                   variantName: passingList[i].name,
    //                   barcode: passingList[i].barcode
    //               ));
    //
    //         }
    //
    //       }
    //       print("PRODUCT Before$idList");
    //       if(selectedProduct.isNotEmpty){
    //         for(var i=0;i<selectedProduct.length;i++){
    //           idList.add(selectedProduct[i].id??0);
    //         }
    //
    //       }
    //
    //       print("PRODUCT SEELE$selectedProduct");
    //       print("PRODUCT SEELE$idList");
    //
    //     }
    //   },
    // ),
    // BlocListener<DiscountBloc, DiscountState>(
    //   listener: (context, state) {
    //     if(state is ProductListPostLoading){
    //       customCupertinoLoading();
    //     }
    //     if(state is ProductListPostSuccess){
    //       print("SUSSSS POOO${state.productList}");
    //       productlist=state.productList;
    //       nextUrlProduct=state.nextPageUrl;
    //       prevUrlproduct=state.prevPageUrl;
    //     }
    //   },
    // ),
    BlocListener<BuyMoreBloc, BuyMoreState>(
      listener: (context, state) {
        if (state is BuyMoreUpdateLoading) {
          showSnackBar(context,
              message: "Buy More Update Loading",
              color: ColorPalette.green);
        } else if (state is BuyMoreUpdateSuccess) {
          showSnackBar(context,
              message: "Buy More Updated",
              color: ColorPalette.green);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<BuyMoreBloc>().add(GetBuyMoreReadEvent(int.tryParse(state.successMessage.toString())??0));
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const SuccessScreenBuyMore(update: true,),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );

        } else if (state is BuyMoreUpdateFailed) {
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
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "New BuyMore",
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
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.string(PromotionSvg().progressDesign2),
                SizedBox(
                  height: 16,
                ),

                widget.editBuyMore==true?
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
                                  padding: EdgeInsets.only(left: 200),
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
                SizedBox(height: 16,),
                widget.editBuyMore==true?
                ReadDropDownCard(
                  label: "Type Name",
                  selValue: typeIdName??typeCode,
                ):DropDownCard(
                  selValue: typeIdName??typeCode,
                  label: "Type Name",
                  onTap: widget.editBuyMore?null:(){
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
                const SizedBox(
                  height: 16,
                ),

                widget.editBuyMore?DropDownCard(
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
                              applyingType: selectedGender??widget.buyMore!.buyMoreAppliyingOn.toString(),
                              segmentList: widget.segmentList??[],
                              searchElement: null
                          ));
                    });
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SelectProducts(
                        editProduct: widget.editBuyMore,
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
                        color: const Color(0xfffe5762),
                        width: 1,
                      ),
                      color: const Color(0x0cfe5762),
                    ),
                    child: Text(widget.editBuyMore==true?"${passingListBuyMore.length} Products Selected":
                    widget.editBuyMore==false?"${passingListBuyMore.length} Products Selected":"Select Product",
                      style: GoogleFonts.roboto(
                        color: const Color(0xfffe5762),
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
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
                      0: const FlexColumnWidth(2),
                      1: const FlexColumnWidth(2),
                      2: const FlexColumnWidth(1),
                      // 3: const FlexColumnWidth(2),

                    },
                    childrens: [
                      TableRow(
                          children: [
                            tableHeadtextTwo(
                              'Count',
                              height: 50,
                              size: 13,
                            ),
                            tableHeadtextTwo(
                              'Price/Percentage',
                              height: 50,
                              size: 13,
                            ),
                            tableHeadtextTwo(
                              'Is Active',
                              height: 50,
                              size: 13,
                            ),
                            // tableHeadtextTwo(
                            //   '',
                            //   height: 50,
                            //   size: 13,
                            // ),


                          ]),
                      if(countList.isNotEmpty)...[
                      for(var i=0;i<countList.length;i++)

                        TableRow(
                            children: [
                              TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 50,
                                    child: TextFormField(
                                      controller: conutController[i],
                                      onChanged: (va){
                                        onChangeVal=true;
                                        countList[i]=GetCount(
                                            count: int.tryParse(conutController[i].text),
                                            priceOrPercentage: double.tryParse(priceController[i].text));
                                        setState(() {

                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                  child:  Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 50,
                                    child: TextFormField(
                                      controller: priceController[i],
                                      onChanged: (va){
                                        onChangeVal=true;
                                        countList[i]=GetCount(
                                            count: int.tryParse(conutController[i].text),
                                            priceOrPercentage: double.tryParse(priceController[i].text));
                                        setState(() {

                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      decoration: InputDecoration(
                                          fillColor: Color(0xfff9f9f9),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Color(0xffccdae3),width: 1
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
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
                                  )),
                              // TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                              //     child:  Container()
                              // ),
                              TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomCheckBox(
                                      key: UniqueKey(),
                                      value:widget.editBuyMore?true:true,
                                      onChange: (p0) {
                                        if (p0) {
                                          conutController.add(TextEditingController(text: conutController[i].text));
                                          priceController.add(TextEditingController(text: priceController[i].text));
                                          countList.add(GetCount(
                                              count: int.tryParse(conutController[i].text),
                                              priceOrPercentage: double.tryParse(priceController[i].text)));
                                          boolList.add(isTableActive);

                                        }
                                        else {
                                          conutController.removeAt(i);
                                          priceController.removeAt(i);
                                          countList.removeAt(i);
                                          setState(() {

                                          });
                                        }
                                        // print("seg-list$idListPost");
                                        //

                                      },
                                    ),
                                    // TextButton(
                                    //   onPressed: (){
                                    //     countList[i]=GetCount(
                                    //       priceOrPercentage: double.tryParse(priceController[i].text),
                                    //       count: int.tryParse(conutController[i].text)
                                    //     );
                                    //   print("count$countList");
                                    //   print("count$conutController");
                                    //   print("count$priceController");
                                    //
                                    // },
                                    //   style: TextButton.styleFrom(
                                    //     foregroundColor: Colors.white,
                                    //       backgroundColor: ColorPalette.primary// Text Color
                                    //   ),child:  Text(onChangeVal==true?"Update":"Add"),),
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
                                    controller: countControllr,
                                    onChanged: (va){
                                      setState(() {

                                      });
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                    ],
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                  child:  Container(
                                    padding: EdgeInsets.all(5),
                                    height: 50,
                                    child: TextFormField(
                                      controller: priceControllr,
                                      onChanged: (va){
                                        setState(() {

                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      decoration: InputDecoration(
                                          fillColor: Color(0xfff9f9f9),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Color(0xffccdae3),width: 1
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
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
                                  )),
                              // TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                              //   child: Container()
                                // CustomCheckBox(
                                //   key: UniqueKey(),
                                //
                                //   onChange: (p0) {
                                //     if (p0) {
                                //       conutController.add(TextEditingController(text: countControllr.text));
                                //       priceController.add(TextEditingController(text: priceControllr.text));
                                //       countList.add(GetCount(
                                //           count: int.tryParse(countControllr.text),
                                //           priceOrPercentage: double.tryParse(priceControllr.text)));
                                //       boolList.add(isTableActive);
                                //
                                //     }
                                //     else {
                                //       conutController.remove(TextEditingController(text: countControllr.text));
                                //       priceController.remove(TextEditingController(text: priceControllr.text));
                                //       countList.remove(GetCount(
                                //           count: int.tryParse(countControllr.text),
                                //           priceOrPercentage: double.tryParse(priceControllr.text)));
                                //     }
                                //     print("seg-list$idListPost");
                                //   },
                                // )
                                // ),
                              TableCell(verticalAlignment: TableCellVerticalAlignment.middle,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: countControllr.text!=""&&priceControllr.text!=""?
                                    TextButton(onPressed: (){
                                      conutController.add(TextEditingController(text: countControllr.text));
                                      priceController.add(TextEditingController(text: priceControllr.text));
                                      countList.add(GetCount(
                                          count: int.tryParse(countControllr.text),
                                          priceOrPercentage: double.tryParse(priceControllr.text)));
                                      // boolList.add(isTableActive);
                                      print("count$countList");
                                      print("count$conutController");
                                      print("count$priceController");
                                      setState(() {
                                        countControllr.clear();
                                        priceControllr.clear();
                                      });
                                    },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: ColorPalette.primary// Text Color
                                      ),child: const Text("Add"),):
                                    TextButton(
                                      onPressed: (){
                                      // conutController.add(TextEditingController(text: countControllr.text));
                                      // priceController.add(TextEditingController(text: priceControllr.text));
                                      // countList.add(GetCount(
                                      //     count: int.tryParse(countControllr.text),
                                      //     priceOrPercentage: double.tryParse(priceControllr.text)));
                                      // // boolList.add(isTableActive);
                                      // print("count$countList");
                                      // print("count$conutController");
                                      // print("count$priceController");
                                      // setState(() {
                                      //   countControllr.clear();
                                      //   priceControllr.clear();
                                      // });
                                    },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: ColorPalette.primary// Text Color
                                      ),child: const Text("Add"),),
                                  )),
                            ]
                        ),

                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: w,
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
                                isActive = !isActive;
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
                      countList.isEmpty? Fluttertoast.showToast(
                          msg: 'Please Fill The Table',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.white,
                          textColor: Colors.black):widget.editBuyMore?
                      BlocProvider.of<BuyMoreBloc>(context).add(
                          UpdateBuyMoreGetMoreEvent(
                            createdBy: authentication.authenticatedUser.code??"",
                              isActive: isActive,
                              channelCode: widget.channelCode??"",
                              offerPeriodId: widget.offerPeriodId??0,
                              offerGroupId: widget.offerGroupId??0,
                              basedOn: widget.basedOn??"",
                              isAvailableForAll: widget.isAvailableForAll??false,
                              image: widget.imageId,
                              customerList: widget.customerList??[],
                              inventoryId: authentication.authenticatedUser.organisationCode??"",
                              segmentList: widget.discountSegment??[],
                              description: widget.promotionDiscription??"",
                              title: widget.promotionTitle??"",
                              variants: selectedProduct,
                              count: countList,
                              buyMoreApplyingOn: selectedGender.toString(),
                              buyMoreApplyingOnName: typeIdName??"",
                              buyMoreApplyingOnId: typeId??0,
                              buyMoreApplyingOnCode: widget.buyMore?.buyMoreAppliyingOnCode??"",
                              id: widget.buyMore?.id??0)):
                      BlocProvider.of<BuyMoreBloc>(context).add(
                          CreateBuyMoreGetMoreEvent(
                              isActive: isActive,
                              channelCode: widget.channelCode??"",
                              offerPeriodId: widget.offerPeriodId??0,
                              offerGroupId: widget.offerGroupId??0,
                              basedOn: widget.basedOn??"",
                              isAvailableForAll: widget.isAvailableForAll??false,
                              image: widget.imageId,
                              customerList: widget.customerList??[],
                              inventoryId: authentication.authenticatedUser.organisationCode??"",
                              createdBy: authentication.authenticatedUser.code??"",
                              segmentList: widget.discountSegment??[],
                              description: widget.promotionDiscription??"",
                              title: widget.promotionTitle??"",
                              variants: passingListBuyMore,
                             count: countList,
                            channelId: widget.channelId,
                            buyMoreApplyingOn: selectedGender.toString(),
                            buyMoreApplyingOnName: typeIdName??"",
                            buyMoreApplyingOnId: typeId??0,
                            buyMoreApplyingOnCode: typeCode??""
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
                      "Save Promotion",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
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
                            child:GestureDetector(
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
                                            const SizedBox(
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
                                            const Spacer(),
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
                                            addNewInPatch: true,
                                            editProduct: widget.editBuyMore,
                                            buyMoreBool: true,
                                            typeCode: typeCode??"",
                                            type: selectedGender??"",
                                            segmentList: widget.segmentList,
                                            SelectedVariants: selectedProduct,
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
}
