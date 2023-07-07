import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../blocs/discount_bloc/discount_bloc.dart';
import '../models_promotion/discount_models/model_discount.dart';

class SelectProductNegotiation extends StatefulWidget {
  final bool editProduct;
  final List<ProductListPromotion>? SelectedVariants;
  final List<String>? segmentList;
  final String type;
  final String typeCode;
  final List<int>? idListSelected;
  final bool? buyMoreBool;
  final bool? addNewInPatch;
  final List<ProductListPromotion>? selectedProduct;
  final Function(List<ProductListPromotion>, List<int>,bool selectAll) productlist;
  final Function(List<ProductListPromotion>, List<int>,bool selectAll)? productlistBuymore;
  const SelectProductNegotiation({super.key, required this.editProduct, this.SelectedVariants, this.segmentList, required this.type, required this.typeCode, this.idListSelected, this.buyMoreBool, this.addNewInPatch, this.selectedProduct, required this.productlist, this.productlistBuymore});

  @override
  State<SelectProductNegotiation> createState() => _SelectProductNegotiationState();
}

class _SelectProductNegotiationState extends State<SelectProductNegotiation> {

  @override
  void initState() {

    idList.clear();
    varCode.clear();
    productList.clear();
    if(widget.SelectedVariants!=null && widget.SelectedVariants!.isNotEmpty)
      for(var i=0;i<widget.idListSelected!.length;i++){
        print("proddd${widget.SelectedVariants?[i].variantId}");
        idList.add(widget.idListSelected?[i]??0);
        // varCode.add(widget.idListSelected?[i].variantCode??"");
        productList.add(widget.SelectedVariants![i]);
        productListBuyMore.add(widget.SelectedVariants![i]);
      }
    print("varrr iddd $idList");
    print("varrr code $varCode");

    print("proddd${productList.length}");
    print("proddd${idList.length}");
    super.initState();
  }
  bool isSelectAll = false;
  bool isActive = false;
  List<ProductListPromotion> productList = [];
  List<ProductListPromotion> selectedProdList = [];
  List<ProductListPromotion> productListBuyMore = [];
  List<int> idList = [];
  List<String> varCode = [];
  String next="";
  String prev="";
  bool addNewProduct=false;
  List<ProductListPromotion> fullProductList=[];
  TextEditingController controller = TextEditingController();

  bool selectAll=false;
  selectUnSelect(){
    productList.clear();

    productListBuyMore.clear();
    idList.clear();
    print("FFFFF${fullProductList.length}");
    print("FFFFF${productList.length}");
    for(var i=0;i<fullProductList.length;i++){
      if(selectAll){
        fullProductList[i].isActive=true;
        setState(() {

        });
        print("proofdddd list length ${productList.length}");
        productList.add(
            ProductListPromotion(
                id: null,
                isActive: fullProductList[i].isActive,
                barcode: fullProductList[i]
                    .barcode,
                variantId: fullProductList[i]
                    .variantId,
                variantCode: fullProductList[i]
                    .variantCode,
                variantName: fullProductList[i]
                    .variantName));
        idList.add(fullProductList[
        i].variantId ??
            0);
        productListBuyMore.add(
            ProductListPromotion(
                id: null,
                isActive: fullProductList[i].isActive,
                variantName: fullProductList[
                i]
                    .variantName,
                variantId: fullProductList[
                i]
                    .variantId,
                variantCode:fullProductList[i].variantCode,
                barcode:fullProductList[
                i]
                    .barcode));

      }
      else{
        idList.clear();
        fullProductList[i].isActive=false;
        productList.remove(
            ProductListPromotion(
                id: null,
                isActive: fullProductList[i].isActive,
                barcode: fullProductList[i]
                    .barcode,
                variantId: fullProductList[i]
                    .variantId,
                variantCode: fullProductList[i]
                    .variantCode,
                variantName: fullProductList[i]
                    .variantName));
        idList.add(fullProductList[
        i].variantId ??
            0);
        productListBuyMore.remove(
            ProductListPromotion(
                id: null,
                isActive: fullProductList[i].isActive,
                variantName: fullProductList[
                i]
                    .variantName,
                variantId: fullProductList[
                i]
                    .variantId,
                variantCode:fullProductList[i].variantCode,
                barcode:fullProductList[
                i]
                    .barcode));
        setState(() {

        });
      }
    }

  }
  checkBoxClickSelectUnselct(){

    for(var n in fullProductList)
    {
      if(n.isActive==false){
        selectAll=false;
        break;
      }
      else{
        selectAll=true;
      }
      setState(() {

      });

    }

  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
            label: "Select Product",
            isBack: true,
            isAction: false,
            onTap: () {
              print("passing$productList");
              widget.productlist(productList, idList,selectAll);
              widget.buyMoreBool == true
                  ? widget.productlistBuymore!(productListBuyMore,idList,selectAll)
                  : null;
              Navigator.pop(context);
            }),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 10),
                              child: SearchCard(
                                hint: "Search Products...",
                                controller: controller,
                                onchange: (va) {
                                  BlocProvider.of<DiscountBloc>(context).add(
                                      PostProductListEvent(
                                          nextUrl: "",
                                          prevUrl: "",
                                          inventoryId: authentication
                                              .authenticatedUser
                                              .organisationCode
                                              .toString(),
                                          segmentList: widget.segmentList ?? [],
                                          searchElement: va,
                                          applyingtypeCode: widget.typeCode,
                                          applyingType: widget.type));
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.only(left: 14),
                          //     child: Row(
                          //       children: [
                          //         CustomCheckBox(
                          //           key: UniqueKey(),
                          //           value: selectAll,
                          //           // widget.idListSelected!.contains(widget.productList?[index].variantId),
                          //           onChange: (p0) {
                          //             selectAll=!selectAll;
                          //             selectUnSelect();
                          //
                          //           },
                          //         ),
                          //         const SizedBox(
                          //           width: 10,
                          //         ),
                          //         Text(
                          //           "Select All",
                          //           style: GoogleFonts.roboto(
                          //             color: Colors.black,
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const Divider(),
                          BlocBuilder<DiscountBloc, DiscountState>(
                            builder: (context, state) {
                              // print("SAAS$state");
                              if (state is ProductListPostLoading) {
                                Container(
                                    width: w,
                                    height: MediaQuery.of(context).size.height/2,
                                    child: customCupertinoLoading());
                              }
                              if (state is ProductListPostSuccess) {

                                next = state.nextPageUrl;
                                prev = state.prevPageUrl;


                                // print("success pro list${widget.selectedProduct?[0].name}");
                                // print("success pro list${widget.selectedProduct?[0].variantName}");
                                print("success pro list$prev");
                                print("success pro list${state.productList}");

                                print("POOOOO${widget.idListSelected}");
                                if(widget.editProduct==false){
                                  productList=widget.selectedProduct??[];
                                  print("edit and idlist her $idList");
                                  // idList.clear();
                                  // for (int i = 0;
                                  //     i < productList.length;
                                  //     i++) {
                                  //   idList.add(productList[i].variantId??0);
                                  // }
                                  // productList.clear();
//                                     for (int i = 0;
//                                         i < widget.selectedProduct!.length;
//                                         i++) {
//
// print("ediiittt noooyt ${productList?.length}");
//                                       productList.add(ProductListPromotion(
//                                         id: widget.selectedProduct?[i].variantId,
//                                         name:
//                                             widget.selectedProduct?[i].variantName,
//                                         barcode: widget.selectedProduct?[i].barcode,
//                                       ));
//                                     }
                                }
                                // for (int i = 0;
                                //     i < widget.selectedProduct!.length;
                                //     i++) {
                                //   productListBuyMore.add(
                                //       ProductListPromotion(
                                //           id: null,
                                //           isActive: true,
                                //           variantName:widget.selectedProduct?[
                                //           i]
                                //               .variantName,
                                //           variantId: widget.selectedProduct?[
                                //           i]
                                //               .variantId,
                                //           variantCode:widget.selectedProduct?[i].variantCode,
                                //           barcode:widget.selectedProduct?[
                                //           i].barcode));
                                // }

                                return Column(
                                  children: [
                                    ListView.separated(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                        // SelectProductCard(productList: productList?[index],),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: const BoxDecoration(
                                              color: Color(0xfffdf2f2),
                                            ),
                                            child: Row(
                                              children: [
                                                CustomCheckBox(
                                                  key: UniqueKey(),
                                                  value:idList.contains(state.productList[index].variantId)  ,

                                                  // widget.editProduct==true?widget.idListSelected!.contains(widget.productList?[index].variantId):
                                                  // fullProductList[index].isActive??false,
                                                  // selectAll==true?fullProductList[index].isActive??false:widget.idListSelected!.contains(widget.productList?[index].variantId),
                                                  onChange: (p0) {
                                                    if (p0==true) {
                                                      // addNewProduct=true;
                                                      // fullProductList[index].isActive=true;
                                                      productList.add(
                                                          ProductListPromotion(
                                                              id: null,
                                                              isActive: p0,
                                                              barcode: state.productList[
                                                              index]
                                                                  .barcode,
                                                              variantId: state.productList[
                                                              index]
                                                                  .variantId,
                                                              variantCode: state.productList[
                                                              index]
                                                                  .variantCode,
                                                              variantName: state.productList[
                                                              index]
                                                                  .variantName));
                                                      idList.add(state.productList[
                                                      index]
                                                          .variantId ??
                                                          0); varCode.add(state.productList[
                                                      index]
                                                          .variantCode ??
                                                          "");
                                                      print("idddddJJJJ afdddddddd $idList");

                                                      productListBuyMore.add(
                                                          ProductListPromotion(
                                                              id: null,
                                                              isActive: p0,
                                                              variantName: state.productList[
                                                              index]
                                                                  .variantName,
                                                              variantId: state.productList[
                                                              index]
                                                                  .variantId,
                                                              variantCode:state.productList[index].variantCode,
                                                              barcode:state.productList[
                                                              index]
                                                                  .barcode));
                                                    }
                                                    else if(p0 ==false) {
                                                      // fullProductList[index].isActive=false;
                                                      // addNewProduct=true;
                                                      productList.remove(
                                                          ProductListPromotion(
                                                              barcode: state.productList[
                                                              index]
                                                                  .barcode,
                                                              variantId: state.productList[
                                                              index]
                                                                  .variantId,
                                                              variantCode: state.productList[
                                                              index]
                                                                  .variantCode,
                                                              variantName: state.productList[
                                                              index]
                                                                  .variantName));
                                                      print("idddddJJJJ${idList}");
                                                      idList.remove(state.productList[
                                                      index]
                                                          .variantId ??
                                                          0);
                                                      varCode.remove(state.productList[
                                                      index]
                                                          .variantCode ??
                                                          "");

                                                      productListBuyMore.remove(
                                                          ProductListPromotion(
                                                              variantName: state.productList[
                                                              index]
                                                                  .variantName,
                                                              variantId: state.productList[
                                                              index]
                                                                  .variantId,
                                                              variantCode: state.productList[index].variantCode,
                                                              barcode: state.productList[
                                                              index]
                                                                  .barcode));

                                                      print("idddddJJJJ${state.productList[index].variantId}");
                                                      print("idddddJJJJ${idList}");

                                                      // selectAll=false;
                                                      setState(() {

                                                      });
                                                    }
                                                    // checkBoxClickSelectUnselct();
                                                    print(
                                                        "product-list$productList");
                                                    print("id-list$idList");
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Container(
                                                  width: 54,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    border: Border.all(
                                                      color: const Color(0xffe2e2e2),
                                                      width: 1,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.network(
                                                    state.productList[index]
                                                        .image ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.productList[index]
                                                          .variantCode ??
                                                          "",
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w / 2,
                                                      height: 37,
                                                      child: Text(
                                                        state.productList[index]
                                                            .variantName ??
                                                            "",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            Container(
                                              width: w,
                                              height: 1,
                                              color: ColorPalette.divider,
                                            ),
                                        itemCount: state.productList.length),
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          prev==null||prev==""?Container():GestureDetector(
                                            onTap: (){
                                              BlocProvider.of<DiscountBloc>(context).add(
                                                  PostProductListEvent(
                                                      nextUrl: "",
                                                      prevUrl: prev,
                                                      inventoryId: authentication
                                                          .authenticatedUser.organisationCode
                                                          .toString(),
                                                      segmentList: widget.segmentList ?? [],
                                                      searchElement: null,
                                                      applyingtypeCode: widget.typeCode,
                                                      applyingType: widget.type));
                                            },
                                            child: Text(
                                              "Prev",
                                              style: GoogleFonts.roboto(
                                                color: ColorPalette.primary,
                                                fontSize: w / 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          next==null||next==""?Container():GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<DiscountBloc>(context).add(
                                                  PostProductListEvent(
                                                      nextUrl: next,
                                                      prevUrl: "",
                                                      inventoryId: authentication
                                                          .authenticatedUser.organisationCode
                                                          .toString(),
                                                      segmentList: widget.segmentList ?? [],
                                                      searchElement: null,
                                                      applyingtypeCode: widget.typeCode,
                                                      applyingType: widget.type));
                                            },
                                            child: Text(
                                              "Next",
                                              style: GoogleFonts.roboto(
                                                color: ColorPalette.primary,
                                                fontSize: w / 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              if(state is ProductListPostFailed){
                                Container(
                                    width: w,
                                    height: MediaQuery.of(context).size.height/2,
                                    child: Text("NO DATA FOUND"));
                              }
                              return Container(
                                  width: w,
                                  height: MediaQuery.of(context).size.height/2,
                                  child: customCupertinoLoading());
                            },
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: w,
                padding: const EdgeInsets.all(5),
                child: GradientButton(
                    onPressed: () {
                      print("vvvvv$productList");
                      print("vvvvv$idList");
                      print("vvvvv$varCode");
                      widget.productlist(productList, idList,selectAll);
                      widget.buyMoreBool == true
                          ? widget.productlistBuymore!(productListBuyMore,idList,selectAll)
                          : null;
                      Navigator.pop(context);

                    },
                    gradient: const LinearGradient(
                      colors: [ColorPalette.primary, ColorPalette.primary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: Colors.transparent,
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
