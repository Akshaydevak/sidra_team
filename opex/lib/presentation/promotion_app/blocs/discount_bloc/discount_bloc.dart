import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/repo&data/dicount_repo.dart';
import 'package:cluster/presentation/promotion_app/blocs/discount_bloc/repo&data/discount_datasource.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/variables.dart';


part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountDataSource _discountDataSource = DiscountDataSource();
  final DiscountRepo _discountRepo = DiscountRepo();
  List<GetOfferPeriod> offerList = [];
  List<GetOfferGroup> offerGriuplist = [];
  List<GetTypeApplying> typeApply = [];
  List<DiscountList> discountList=[];
  List<ProductListPromotion> productList=[];
  List<ChannelList>? channelList;
  String? next;
  DiscountBloc() : super(GetSegmentListInitial());

  @override
  Stream<DiscountState> mapEventToState(DiscountEvent event,) async* {

    if (event is GetSegmentListEvent) {
      yield* getSegmentList();
    }
    if (event is PaginatedOfferPeriodEvent) {
      yield* paginatedOffereriodListState(event.code.trim(),event.prev?.trim());
    }
    if (event is CreateOfferPeriodEvent) {
      yield* createOfferPeriodPost(
        toTime: event.toTime.trim(),
        toDate: event.toDate.trim(),
        title: event.title.trim(),
        note: event.note.trim(),
        fromTime: event.fromTime.trim(),
        description: event.description.trim(),
        createdBy: event.createdBy,
        fromDate: event.fromDate,
        isActive: event.isActive
      );
    }
    else if (event is GetOfferPeriodReadEvent) {
      yield* getOfferPeriodRead(event.id);
    }
    if (event is UpdateOfferPeriodEvent) {
      yield* updateOfferPeriod(
        id: event.id,
          toTime: event.toTime.trim(),
          toDate: event.toDate.trim(),
          title: event.title.trim(),
          note: event.note.trim(),
          fromTime: event.fromTime.trim(),
          description: event.description.trim(),
          createdBy: event.createdBy,
          fromDate: event.fromDate,
          isActive: event.isActive
      );
    }
    if (event is DeleteOfferPeriodEvent) {
      yield* deleteofferPeriod(id: event.id);
    }
    if (event is PaginatedChannelListEvent) {
      yield* paginatedChannelListState(event.code.trim());
    }
    else if (event is PostImageDiscountEvent) {
      yield* postImageDiscountState(img: event.image);}
    if (event is CreateOfferGroupEvent) {
      yield* createOfferGroupPost(
        priority: event.priorty,
          channelCode: event.channelCode.trim(),
          inventoryId: event.inventoryId.trim(),
          title: event.title.trim(),
          image: event.image,
          description: event.description.trim(),
          createdBy: event.createdBy,
          isActive: event.isActive
      );
    }
    if (event is PaginatedOfferGroupEvent) {
      yield* paginatedOfferGroupListState(event.code.trim());
    }
    else if (event is GetOfferGroupReadEvent) {
      yield* getOfferGroupRead(event.id);
    }
    if (event is UpdateOfferGroupEvent) {
      yield* updateOffergroup(
        priority: event.priority??0,
          id: event.id,
          title: event.title.trim(),
          description: event.description.trim(),
          createdBy: event.createdBy,
          img: event.img,
          isActive: event.isActive
      );
    }
    if (event is DeleteOfferGroupEvent) {
      yield* deleteofferGroup(id: event.id);
    }
    else if (event is GetOfferAppliyingBasedOnReadEvent) {
      yield* getOfferAppliyingBasedOnRead();
    }
    if (event is PostTypeAppliyingListEvent) {
      yield* typeAppliyingPost(
          segmentList: event.segmentList,
          inventoryId: event.inventoryId.trim(),
          type: event.type.trim(),
          searchElement: event.searchElement,
        nextUrl: event.nextUrl
      );
    }
    if (event is PostProductListEvent) {
      yield* productListPost(
        applyingTypeCode: event.applyingtypeCode,
          prevUrl: event.prevUrl,
          segmentList: event.segmentList,
          inventoryId: event.inventoryId.trim(),
          applyingType: event.applyingType.trim(),
          searchElement: event.searchElement,
        nextUrl: event.nextUrl
      );
    }
    if (event is PaginatedCustomerGroupEvent) {
      yield* paginatedCustomerGroupListState(event.code,event.prev);
    }
    if (event is CreateDiscountEvent) {
      yield* createDiscountPost(
        priority: event.priority,
          channelCode: event.channelCode.trim(),
          inventoryId: event.inventoryId.trim(),
          title: event.title.trim(),
          image: event.image,
          description: event.description.trim(),
          createdBy: event.createdBy,
          isActive: event.isActive,
        typeId: event.typeId,
        basedOn: event.basedOn.trim(),
        customer: event.customerList,
         discountPercentagePrice: event.discountPercentagePrice,
        isAvailableforAll: event.isAvailableForAll,
        maxQty: event.maxQty,
        offerGroupId: event.offerGroupId,
        offerPeriodId: event.offerPeriodId,
         segment: event.segmentList,
        typeApplying: event.typeApplying.trim(),
        typeCode: event.typeCode.trim(),
        variants: event.variants
      );
    }
    if (event is PaginatedDiscountListEvent) {
      yield* paginatedDiscountListState(event.code.trim(),event.prev.trim());
    }
    if (event is SearchPaginatedDiscountListEvent) {
      yield* getSearchDiscountListState(event.query.trim());
    }
    else if (event is GetDiscountReadEvent) {
      yield* getDiscountRead(event.id);
    }
    if (event is DeleteDiscountEvent) {
      yield* deleteDiscount(id: event.id);
    }
    if (event is UpdateDiscountEvent) {
      yield* updateDiscountPost(
        channelCode: event.channelCode,
        inventoryId: event.inventoryId,
        priority: event.priority,
        offerProductGroupCode: event.offerProductGroupCode.trim(),
          title: event.title.trim(),
          id: event.id,
          offerLineId: event.offerLineId,
          image: event.image,
          description: event.description.trim(),
          createdBy: event.createdBy,
          isActive: event.isActive,
          typeId: event.typeId,
          basedOn: event.basedOn.trim(),
          customer: event.customerList,
          discountPercentagePrice: event.discountPercentagePrice,
          isAvailableforAll: event.isAvailableForAll,
          maxQty: event.maxQty,
          offerGroupId: event.offerGroupId,
          offerPeriodId: event.offerPeriodId,
          segment: event.segmentList,
          typeApplying: event.typeApplying.trim(),
          typeCode: event.typeCode.trim(),
          variants: event.variants
      );
    }
    if (event is PaginatedSelectedVariantListEvent) {
      yield* paginatedSelectedVariantsState(event.code.trim(),event.offerGroupCode.trim());
    }

    if (event is DeactivatePreviousPromotionEvent) {
      yield* deactivatePrevPromotion(
        isCoupon: event.isCoupon,
        type: event.type,
          idList: event.idList,
        typeData: event.typeData.trim()
      );
    }
    if (event is DeleteSelectiveVariantsEvent) {
      yield* deleteSelectiveVariantsPost(
          variants: event.variants
      );
    }

  }

  //segmentList
  Stream<DiscountState> getSegmentList() async* {
    yield GetSegmentListLoading();

    final dataResponse = await _discountRepo.getSegmentList();

    if (dataResponse.data.isNotEmpty) {
      yield GetSegmentListSuccess(dataResponse.data);
    } else {
      yield GetSegmentListFailed();
    }
  }
  //createOfferperiod
  Stream<DiscountState> createOfferPeriodPost(
      {
        required String fromDate,
        required String toDate,
        required String fromTime,
        required String toTime,
        required String title,
        required String description,
        required String note,
        required String? createdBy,
        required bool? isActive,
      }) async* {
    yield OfferPeriodCreateLoading();

    final dataResponse = await _discountRepo.offerperiodPost(
      fromDate: fromDate,
      isActive: isActive,
      createdBy: createdBy,
      description: description,
      fromTime: fromTime,
      note: note,
      title: title,
      toDate: toDate,
      toTime: toTime
    );


    if (dataResponse.data ) {
      yield OfferPeriodCreateSuccess(successMessage: dataResponse.error);
    } else {
      yield OfferPeriodCreateFailed(
        dataResponse.error ?? "",);
    }

  }

  //offerist
  Stream<DiscountState> paginatedOffereriodListState(String code,String? prev) async* {
    offerList=[];
    yield GetOfferPeriodListLoading();

    final dataResponse = await _discountRepo.getOfferPeriodList(code, prev);

    dataResponse.fold((l) => emit(GetOfferPeriodListFailed()), (r) {
      next = r.nextPage;

      r.data?.forEach((element) {
        offerList.add((element));
      });

      print("bloc${r.previousUrl}");
      print("bloc${r.previousPage}");
      print("bloc${r.nextPage}");
      emit(GetOfferPeriodListSuccess(
          offerPeriod: PaginatedResponse(offerList, r.nextPage, r.previousUrl)));
    });
  }

  //readOfferPeriod
  Stream<DiscountState> getOfferPeriodRead(int id) async* {

    yield GetOfferPeriodReadLoading();

    final dataResponse = await _discountRepo.getOfferPeriodRead(id);

    if (dataResponse.hasData) {
      yield GetOfferPeriodReadSuccess(offerPeriod: dataResponse.data);
    } else {
      yield GetOfferPeriodReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //updateofferperiod
  Stream<DiscountState> updateOfferPeriod(
      {
        required String fromDate,
        required String toDate,
        required String fromTime,
        required String toTime,
        required String title,
        required String description,
        required String note,
        required String? createdBy,
        required bool? isActive,
        required int? id,
      }) async* {
    yield OfferPeriodUpdateLoading();

    final dataResponse = await _discountRepo.updateOfferperiodPatch(
        fromDate: fromDate,
        id: id,
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        fromTime: fromTime,
        note: note,
        title: title,
        toDate: toDate,
        toTime: toTime
    );

    if (dataResponse.data ) {
      yield OfferPeriodUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield OfferPeriodUpdateFailed(
        dataResponse.error ?? "",);
    }
  }
  //deleteofferperiod
  Stream<DiscountState> deleteofferPeriod({required int id}) async* {
    yield DeleteOfferPeriodLoading();
    final dataResponse = await _discountDataSource.deleteofferPeriod(id);
    if (dataResponse == "success") {
      yield DeleteOfferPeriodSuccess();
    } else {
      yield DeleteOfferPeriodFailed();
    }
  }

  //channelList
  Stream<DiscountState> paginatedChannelListState(String code) async* {
    channelList=[];
    yield GetChannelListLoading();

    final dataResponse = await _discountRepo.getChannelList(code, next);

    dataResponse.fold((l) => emit(GetChannelListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        channelList?.add((element));
      });

      emit(GetChannelListSuccess(
          channelList: PaginatedResponse(channelList, r.nextPage, r.count)));
    });
  }

  //imageUpload
  Stream<DiscountState> postImageDiscountState(
      {required File img}) async* {
    yield PostImageDiscontLoading();
    final dataResponse = await _discountDataSource.PostImage(img: img);
    if (dataResponse.data1) {
      yield PostImageDiscontSuccess(id: dataResponse.data2);
    } else {
      yield PostImageDiscontFailed(error: dataResponse.data2);
    }
  }

  //offerGroupCreateion
  Stream<DiscountState> createOfferGroupPost(
      {
        required int image,
        required String channelCode,
        required String inventoryId,
        required String title,
        required String description,
        required String? createdBy,
        required bool? isActive,
        required int priority,
      }) async* {
    yield OfferGroupCreateLoading();

    final dataResponse = await _discountRepo.offerGroupPost(
        channelCode: channelCode,
        priority: priority,
        isActive: isActive,
        createdBy: createdBy,
        description: description,
         inventoryId: inventoryId,
        image: image,
        title: title,
    );

    if (dataResponse.data) {
      yield OfferGroupCreateSuccess(dataResponse.error);
    } else {
      yield OfferGroupCreateFailed(
        dataResponse.error ?? "",);
    }

  }
  //listOfferGroup
  Stream<DiscountState> paginatedOfferGroupListState(String code) async* {
    offerGriuplist=[];
    yield GetOfferGroupListLoading();

    final dataResponse = await _discountRepo.getOfferGroupList(code, next);

    dataResponse.fold((l) => emit(GetOfferGroupListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        offerGriuplist.add((element));
      });

      emit(GetOfferGroupListSuccess(
          offerGroup: PaginatedResponse(offerGriuplist, r.nextPage, r.count)));
    });
  }

  //readOfferGroup
  Stream<DiscountState> getOfferGroupRead(int id) async* {

    yield GetOfferGroupReadLoading();

    final dataResponse = await _discountRepo.getOfferGroupRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetOfferGroupReadSuccess(offerGroup: dataResponse.data);
    } else {
      yield GetOfferGroupReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //updateOfferPeriod
  Stream<DiscountState> updateOffergroup(
      {
        required int img,
        required String title,
        required String description,
        required String? createdBy,
        required bool? isActive,
        required int? id,
        required int priority,
      }) async* {
    yield OfferGroupUpdateLoading();

    final dataResponse = await _discountRepo.updateOffergroup(
        id: id,
        priority: priority,
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        title: title,
        img: img
    );

    if (dataResponse.data) {
      yield OfferGroupUpdateSuccess(dataResponse.error);
    } else {
      yield OfferGroupUpdateFailed(
        dataResponse.error ?? "",);
    }
  }
  //deleteofferGroup
  Stream<DiscountState> deleteofferGroup({required int id}) async* {
    yield DeleteOfferGroupLoading();
    final dataResponse = await _discountDataSource.deleteofferGroup(id);
    if (dataResponse == "success") {
      yield DeleteOfferGroupSuccess();
    } else {
      yield DeleteOfferGroupFailed();
    }
  }

  //offerappliyinBasedOn
  Stream<DiscountState> getOfferAppliyingBasedOnRead() async* {

    yield GetOfferAppliyingBasedOnReadLoading();

    final dataResponse = await _discountRepo.getOfferAppliyingBasedOnRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetOfferAppliyingBasedOnReadSuccess(discount: dataResponse.data);
    } else {
      yield GetOfferAppliyingBasedOnReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //typeAppliyingListPost
  Stream<DiscountState> typeAppliyingPost(
      {
        required String type,
        String? searchElement,
        String? nextUrl,
        required List<String> segmentList,
        required String inventoryId,
      }) async* {
    typeApply=[];
    yield TypeAppliyingListPostLoading();

    final dataResponse = await _discountDataSource.typeAppliyingPost(
      type: type,
      segmentList: segmentList,
      searchElement: searchElement,
      inventoryId: inventoryId,
      nextUrl: nextUrl
    );

    if (dataResponse.data.isNotEmpty) {
      yield TypeAppliyingListPostSuccess(
        prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          typeApply: dataResponse.data);
    } else {
      yield TypeAppliyingListPostFailed();
    }
  }

  //productlist
  Stream<DiscountState> productListPost(
      {
        required String applyingType,
        required String inventoryId,
        required String? applyingTypeCode,
        required List<String> segmentList,
        String? searchElement,
        String? nextUrl,
        String? prevUrl,
      }) async* {
    typeApply=[];
    yield ProductListPostLoading();

    final dataResponse = await _discountDataSource.productListPost(
        applyingTypeCode: applyingTypeCode,
        applyingType: applyingType,
        prevUrl: prevUrl,
        segmentList: segmentList,
        searchElement: searchElement,
        inventoryId: inventoryId,
        nextUrl: nextUrl
    );

    if (dataResponse.data.isNotEmpty) {
      yield ProductListPostSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          productList: dataResponse.data);
    } else {
      yield ProductListPostFailed();
    }
  }

  //customerGroup
  Stream<DiscountState> paginatedCustomerGroupListState(String? code,String? prev) async* {
    typeApply=[];
    yield GetCustomerGroupListLoading();

    final dataResponse = await _discountRepo.getCustomerGroupList(code, prev);

    dataResponse.fold((l) => emit(GetCustomerGroupListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        typeApply.add((element));
      });

      emit(GetCustomerGroupListSuccess(
          customerGroup: PaginatedResponse(typeApply, r.nextPage, r.previousUrl)));
    });
  }

  //createDiscount
  Stream<DiscountState> createDiscountPost(
      {
        required String typeApplying,
        required int typeId,
        required String typeCode,
        required dynamic image,
        required String title,
        required List<ProductListPromotion> variants,
        required bool? isActive,
        required int maxQty,
        required String inventoryId,
        required String? channelCode,
        required String? description,
        required double? discountPercentagePrice,
        required String? basedOn,
        required int? offerPeriodId,
        required int? offerGroupId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
        required int priority,
      }) async* {
    yield DiscountCreateLoading();

    final dataResponse = await _discountRepo.createDiscountPost(
        isActive: isActive,
        priority: priority,
        createdBy: createdBy,
        description: description,
        title: title,
      variants: variants,
      typeCode: typeCode,
      typeApplying: typeApplying,
      segment: segment,
      offerPeriodId: offerPeriodId,
      offerGroupId: offerGroupId,
      maxQty: maxQty,
      isAvailableforAll: isAvailableforAll,
      discountPercentagePrice: discountPercentagePrice,
      customer: customer,
      basedOn: basedOn,
      typeId: typeId,
      image: image,
      channelCode: channelCode,
      inventoryId: inventoryId
    );

    if (dataResponse.data ) {
      yield DiscountCreateSuccess(successMessage: dataResponse.error);
    } else {
      yield DiscountCreateFailed(
        dataResponse.error ?? "",);
    }

  }

  //listDiscount
  Stream<DiscountState> paginatedDiscountListState(String code,String prev) async* {
    discountList=[];
    yield GetDiscountListLoading();

    final dataResponse = await _discountRepo.getDiscountList(code, prev);

    dataResponse.fold((l) => emit(GetDiscountListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        discountList.add((element));
      });

      emit(GetDiscountListSuccess(
          discountList: PaginatedResponse(discountList, r.nextPage, r.previousUrl)));
    });
  }
  //search
  Stream<DiscountState> getSearchDiscountListState(
      String searchQuery) async* {
    discountList = [];
    next = null;
    yield GetSearchedDiscountLoading();

    final dataResponse =
    await _discountRepo.getSearchedDiscount(searchQuery, next);

    dataResponse.fold((l) => emit(GetSearchedDiscountFailed()), (r) {
      next = r.nextPage;
      discountList = r.data ?? [];

      emit(GetSearchedDiscountSuccess(productItem: r,nextPageUrl: r.nextPage??""));
    });
  }

  //discountRead
  Stream<DiscountState> getDiscountRead(int id) async* {

    yield GetDiscountReadLoading();

    final dataResponse = await _discountRepo.getDiscountRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetDiscountReadSuccess(discountList: dataResponse.data);
    } else {
      yield GetDiscountReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<DiscountState> deleteDiscount({required int id}) async* {
    yield DeleteDiscountLoading();
    final dataResponse = await _discountDataSource.deleteDiscount(id);
    if (dataResponse == "success") {
      yield DeleteDiscountSuccess();
    } else {
      yield DeleteDiscountFailed();
    }
  }

  //updateDiscount
  Stream<DiscountState> updateDiscountPost(
      {
        required String typeApplying,
        required int typeId,
        required String typeCode,
        required dynamic image,
        required String title,
        required List<ProductListPromotion> variants,
        required bool? isActive,
        required int maxQty,
        required String inventoryId,
        required String? channelCode,
        required String? description,
        required int id,
        required double? discountPercentagePrice,
        required String? basedOn,
        required int? offerPeriodId,
        required int? offerGroupId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required String? offerProductGroupCode,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
        required int offerLineId,
        required int priority,
      }) async* {
    yield DiscountUpdateLoading();

    final dataResponse = await _discountRepo.updateDiscountPost(
      priority: priority,
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        title: title,
        offerProductGroupCode: offerProductGroupCode,
        id: id,
        variants: variants,
        typeCode: typeCode,
        typeApplying: typeApplying,
        segment: segment,
        offerPeriodId: offerPeriodId,
        offerGroupId: offerGroupId,
        maxQty: maxQty,
        isAvailableforAll: isAvailableforAll,
        discountPercentagePrice: discountPercentagePrice,
        customer: customer,
        basedOn: basedOn,
        typeId: typeId,
        image: image,
        offerLineId: offerLineId,
        channelCode: channelCode,
        inventoryId: inventoryId
    );

    if (dataResponse.data ) {
      yield DiscountUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield DiscountUpdateFailed(
        dataResponse.error ?? "",);
    }

  }
  //selectedVariants
  Stream<DiscountState> paginatedSelectedVariantsState(String code,String groupCode) async* {
    productList=[];
    yield GetSelectedVariantListLoading();

    final dataResponse = await _discountRepo.getSelectedVariantsList(code, next,groupCode);

    dataResponse.fold((l) => emit(GetSelectedVariantListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });

      emit(GetSelectedVariantListSuccess(
          variants: PaginatedResponse(productList, r.nextPage, r.count)));
    });
  }

  //deactivate
  Stream<DiscountState> deactivatePrevPromotion(
      {
        required String typeData,
        required List<int> idList,
        required bool type,
        required bool isCoupon,

      }) async* {
    yield DeactivatePrevPromotionLoading();

    final dataResponse = await _discountDataSource.deactivatePrevPromotion(
       typeData: typeData,
      idList: idList,
      isCoupon: isCoupon,
      type: type
    );

    if (dataResponse.data1) {
      print("vannu");
      yield DeactivatePrevPromotionSuccess(returnList: dataResponse.data2);
    } else {
      print("poyi${dataResponse.data1}");
      yield DeactivatePrevPromotionFailed(Variable.errorMessage);
    }

  }

  //selctiveVariants
  Stream<DiscountState> deleteSelectiveVariantsPost(
      {
        required List<ProductListPromotion> variants,

      }) async* {
    yield DeleteSelectiveVariantsLoading();

    final dataResponse = await _discountRepo.deleteSelectiveVariantsPost(
        variants: variants,

    );

    if (dataResponse.data ) {
      yield DeleteSelectiveVariantsSuccess(successMessage: dataResponse.error);
    } else {
      yield DeleteSelectiveVariantsFailed(
        dataResponse.error ?? "",);
    }

  }
}
