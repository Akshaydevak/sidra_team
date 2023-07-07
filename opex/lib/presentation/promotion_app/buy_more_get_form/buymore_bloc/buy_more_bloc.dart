import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:equatable/equatable.dart';

import '../../blocs/discount_bloc/repo&data/dicount_repo.dart';
import '../../blocs/discount_bloc/repo&data/discount_datasource.dart';
import '../../models_promotion/discount_models/model_discount.dart';

part 'buy_more_event.dart';
part 'buy_more_state.dart';

class BuyMoreBloc extends Bloc<BuyMoreEvent, BuyMoreState> {
  final DiscountDataSource _discountDataSource = DiscountDataSource();
  final DiscountRepo _discountRepo = DiscountRepo();
  List<BuyMoreList> buyMoreList=[];
  String? next;
  BuyMoreBloc() : super(GetOfferAppliyingBasedOnReadBuyMoreInitial());

    @override
    Stream<BuyMoreState> mapEventToState(BuyMoreEvent event,) async* {

      if (event is GetOfferApplyingBasedOnReadBuyMoreEvent) {
        yield* getOfferApplyingBasedOnBuyMoreRead();
      }
      if (event is CreateBuyMoreGetMoreEvent) {
        yield* createBuyMorePost(
            channelCode: event.channelCode.trim(),
            inventoryId: event.inventoryId.trim(),
            title: event.title.trim(),
            image: event.image,
            description: event.description.trim(),
            createdBy: event.createdBy,
            isActive: event.isActive,
            basedOn: event.basedOn.trim(),
            customer: event.customerList,
            isAvailableforAll: event.isAvailableForAll,
            offerGroupId: event.offerGroupId,
            offerPeriodId: event.offerPeriodId,
            segment: event.segmentList,
            variants: event.variants,
          buyMoreApplyingOn: event.buyMoreApplyingOn.trim(),
          buyMoreApplyingOnCode: event.buyMoreApplyingOnCode.trim(),
          buyMoreApplyingOnId: event.buyMoreApplyingOnId,
          buyMoreApplyingOnName: event.buyMoreApplyingOnName.trim(),
          channelId: event.channelId,
          count: event.count,
          // offerAppliedTo: event.offerAppliedTo?.trim(),
          // offerAppliedToCode: event.offerAppliedToCode?.trim(),
          // offerAppliedToId: event.offerAppliedToId
        );
      }
      if (event is PaginatedBuyMoreListEvent) {
        yield* paginatedBuyMoreListState(event.code.trim(),event.prev.trim());
      }
      if (event is SearchPaginatedBuyMoreListEvent) {
        yield* getSearchBuyMoreListState(event.query.trim());
      }
      else if (event is GetBuyMoreReadEvent) {
        yield* getBuyMoreRead(event.id);
      }
      if (event is DeleteBuyMoreEvent) {
        yield* deleteBuyMore(id: event.id);
      }
      if (event is UpdateBuyMoreGetMoreEvent) {
        yield* updateBuyMorePost(
          id: event.id,
          channelCode: event.channelCode.trim(),
          inventoryId: event.inventoryId.trim(),
          title: event.title.trim(),
          image: event.image,
          description: event.description.trim(),
          createdBy: event.createdBy,
          isActive: event.isActive,
          basedOn: event.basedOn.trim(),
          customer: event.customerList,
          isAvailableforAll: event.isAvailableForAll,
          offerGroupId: event.offerGroupId,
          offerPeriodId: event.offerPeriodId,
          segment: event.segmentList,
          variants: event.variants,
          buyMoreApplyingOn: event.buyMoreApplyingOn.trim(),
          buyMoreApplyingOnCode: event.buyMoreApplyingOnCode.trim(),
          buyMoreApplyingOnId: event.buyMoreApplyingOnId,
          buyMoreApplyingOnName: event.buyMoreApplyingOnName.trim(),
          // channelId: event.channelId,
          count: event.count,
        );
      }
    }

    ////
  Stream<BuyMoreState> getOfferApplyingBasedOnBuyMoreRead() async* {

    yield GetOfferAppliyingBasedOnReadBuyMoreLoading();

    final dataResponse = await _discountRepo.getOfferApplyingBasedOnBuyMoreRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetOfferAppliyingBasedOnReadBuyMoreSuccess(discount: dataResponse.data);
    } else {
      yield GetOfferAppliyingBasedOnReadBuyMoreFailed(dataResponse.error.toString(),
      );
    }
  }

  //createBuyMore
  Stream<BuyMoreState> createBuyMorePost(
      {
        required int image,
        required String title,
        required List<ProductListPromotion> variants,
        required bool? isActive,
        // required int maxQty,
        required String inventoryId,
        required String? channelCode,
        required String? description,
        // required double? discountPercentagePrice,
        required String? basedOn,
        required int? offerPeriodId,
        required int? offerGroupId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
        required String buyMoreApplyingOn,
        required String buyMoreApplyingOnName,
        required int buyMoreApplyingOnId,
        required String buyMoreApplyingOnCode,
        required List<GetCount>? count,
        // required String? offerAppliedTo,
        // required int? offerAppliedToId,
        // required String? offerAppliedToCode,
        required String? channelId,
      }) async* {
    yield BuyMoreCreateLoading();

    final dataResponse = await _discountRepo.createBuyMorePost(
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        title: title,
        variants: variants,
        segment: segment,
        offerPeriodId: offerPeriodId,
        offerGroupId: offerGroupId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
        channelCode: channelCode,
        inventoryId: inventoryId,
      // offerAppliedToId: offerAppliedToId,
      // offerAppliedToCode: offerAppliedToCode,
      // offerAppliedTo: offerAppliedTo,
      count: count,
      channelId: channelId,
      buyMoreApplyingOnName: buyMoreApplyingOnName,
      buyMoreApplyingOnId: buyMoreApplyingOnId,
      buyMoreApplyingOnCode: buyMoreApplyingOnCode,
      buyMoreApplyingOn: buyMoreApplyingOn

    );

    if (dataResponse.data ) {
      yield BuyMoreCreateSuccess(successMessage: dataResponse.error);
    } else {
      yield BuyMoreCreateFailed(
        dataResponse.error ?? "",);
    }

  }

  //listDiscount
  Stream<BuyMoreState> paginatedBuyMoreListState(String code,String prev) async* {
    buyMoreList=[];
    yield GetBuyMoreListLoading();

    final dataResponse = await _discountRepo.getBuyMoreList(code, prev);

    dataResponse.fold((l) => emit(GetBuyMoreListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        buyMoreList.add((element));
      });

      emit(GetBuyMoreListSuccess(
          discountList: PaginatedResponse(buyMoreList, r.nextPage, r.previousUrl)));
    });
  }
  //search
  Stream<BuyMoreState> getSearchBuyMoreListState(
      String searchQuery) async* {
    buyMoreList = [];
    next = null;
    yield GetSearchedBuyMoreLoading();

    final dataResponse =
    await _discountRepo.getSearchedBuyMore(searchQuery, next);

    dataResponse.fold((l) => emit(GetSearchedBuyMoreFailed()), (r) {
      next = r.nextPage;
      buyMoreList = r.data ?? [];

      emit(GetSearchedBuyMoreSuccess(productItem: r,nextPageUrl: r.nextPage??""));
    });
  }

  //discountRead
  Stream<BuyMoreState> getBuyMoreRead(int id) async* {

    yield GetBuyMoreReadLoading();

    final dataResponse = await _discountRepo.getBuyMoreRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetBuyMoreReadSuccess(buyMoreList: dataResponse.data);
    } else {
      yield GetBuyMoreReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<BuyMoreState> deleteBuyMore({required int id}) async* {
    yield DeleteBuyMoreLoading();
    final dataResponse = await _discountDataSource.deleteBuyMore(id);
    if (dataResponse == "success") {
      yield DeleteBuyMoreSuccess();
    } else {
      yield DeleteBuyMoreFailed();
    }
  }

  //updateBuyMore
  Stream<BuyMoreState> updateBuyMorePost(
      {
        required dynamic image,
        required String title,
        required List<ProductListPromotion> variants,
        required bool? isActive,
        required String inventoryId,
        required String? channelCode,
        required String? description,
        required String? basedOn,
        required int id,
        required int? offerPeriodId,
        required int? offerGroupId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
        required String buyMoreApplyingOn,
        required String buyMoreApplyingOnName,
        required int buyMoreApplyingOnId,
        required String buyMoreApplyingOnCode,
        required List<GetCount>? count,
        // required String? channelId,
      }) async* {
    yield BuyMoreUpdateLoading();

    final dataResponse = await _discountRepo.updateBuyMorePost(
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        title: title,
        variants: variants,
        segment: segment,
        offerPeriodId: offerPeriodId,
        offerGroupId: offerGroupId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
        channelCode: channelCode,
        inventoryId: inventoryId,
        count: count,
        id: id,
        // channelId: channelId,
        buyMoreApplyingOnName: buyMoreApplyingOnName,
        buyMoreApplyingOnId: buyMoreApplyingOnId,
        buyMoreApplyingOnCode: buyMoreApplyingOnCode,
        buyMoreApplyingOn: buyMoreApplyingOn

    );

    if (dataResponse.data ) {
      yield BuyMoreUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield BuyMoreUpdateFailed(
        dataResponse.error ?? "",);
    }

  }
}
