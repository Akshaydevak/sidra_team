import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:equatable/equatable.dart';

import '../../blocs/discount_bloc/repo&data/dicount_repo.dart';
import '../../blocs/discount_bloc/repo&data/discount_datasource.dart';
import '../../models_promotion/discount_models/model_discount.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final DiscountDataSource _discountDataSource = DiscountDataSource();
  final DiscountRepo _discountRepo = DiscountRepo();
  List<CouponList>couponList=[];
  String? next;
  CouponBloc() : super(GetOfferAppliyingBasedOnReadCouponInitial());
  @override
  Stream<CouponState> mapEventToState(CouponEvent event,) async* {

    if (event is GetOfferApplyingBasedOnReadCouponEvent) {
      yield* getOfferApplyingBasedOnCouponRead();
    }
    if (event is CreateCouponGetMoreEvent) {
      yield* createCouponPost(
        termsList: event.termsList,
        channelCode: event.channelCode.trim(),
        inventoryId: event.inventoryId.trim(),
        image: event.image,
        description: event.description.trim(),
        createdBy: event.createdBy,
        isActive: event.isActive,
        basedOn: event.basedOn.trim(),
        customer: event.customerList,
        isAvailableforAll: event.isAvailableForAll,
        offerPeriodId: event.offerPeriodId,
        segment: event.segmentList,
        totalValue: event.totalValue,
        lines: event.lines,
        displayName: event.displayName?.trim(),
        couponType: event.coupenType,
        couponApplyingOnName: event.couponApplyingOnName.trim(),
        couponApplyingOnCode: event.couponApplyingOnCode.trim(),
        canApplyTogather: event.canApplyTogather,
        canApplyMultiple: event.canApplyMultiple,
        name: event.name,
        couponApplyingOn: event.couponApplyingOn,
        couponApplyingOnId: event.couponApplyingOnId,
        maxCount: event.maxCount,
        percentagePrice: event.priceOrPercentage,
        channelId: event.channelId
      );
    }
    if (event is PaginatedCouponListEvent) {
      yield* paginatedCouponList(event.code.trim(),event.prev.trim());
    }
    if (event is SearchPaginatedCouponListEvent) {
      yield* getSearchCoponListState(event.query.trim());
    }
    else if (event is GetCouponReadEvent) {
      yield* getCouponRead(event.id);
    }
    if (event is DeleteCouponEvent) {
      yield* deleteCoupon(id: event.id);
    }
    if (event is UpdateCouponEvent) {
      yield* updateCoupenPost(
        termsList: event.termsList,
        channelCode: event.channelCode.trim(),
        id: event.id??0,
        inventoryId: event.inventoryId.trim(),
        name: event.name.trim(),
        image: event.image,
        description: event.description.trim(),
        createdBy: event.createdBy,
        isActive: event.isActive,
        basedOn: event.basedOn.trim(),
        customer: event.customerList,
        isAvailableforAll: event.isAvailableForAll,
        offerPeriodId: event.offerPeriodId,
        segment: event.segmentList,
        lines: event.lines,
        percentagePrice: event.priceOrPercentage,
        maxCount: event.maxCount,
        couponApplyingOnId: event.couponApplyingOnId,
        couponApplyingOn: event.couponApplyingOn,
        canApplyMultiple: event.canApplyMultiple,
        canApplyTogather: event.canApplyTogather,
        couponApplyingOnCode: event.couponApplyingOnCode,
        couponApplyingOnName: event.couponApplyingOnName,
        couponType: event.coupenType,
        displayName: event.displayName,
        totalValue: event.totalValue,


      );
    }
  }

  //
  Stream<CouponState> getOfferApplyingBasedOnCouponRead() async* {

    yield GetOfferAppliyingBasedOnReadCouponLoading();

    final dataResponse = await _discountRepo.getOfferApplyingBasedOnCouponRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetOfferAppliyingBasedOnReadCouponSuccess(discount: dataResponse.data);
    } else {
      yield GetOfferAppliyingBasedOnReadCouponFailed(dataResponse.error.toString(),
      );
    }
  }
  //cfreate
  Stream<CouponState> createCouponPost(
      {
        required String name,
        required int? offerPeriodId,
        required String? basedOn,
        required String inventoryId,
        required double? percentagePrice,
        required int? maxCount,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required String couponApplyingOnName,
        required int couponApplyingOnId,
        required String couponApplyingOnCode,
        required String? couponApplyingOn,
        required String? channelCode,
        required String? channelId,
        required String? couponType,
        required int image,
        required String? description,
        required double? totalValue,
        required List<ProductListPromotion> lines,
        required bool? isActive,
        required bool? canApplyTogather,
        required bool? canApplyMultiple,
        required bool? isAvailableforAll,
        required String? displayName,
        required List<String> termsList,
        required List<GetTypeApplying>? customer,
      }) async* {
    yield CouponCreateLoading();

    final dataResponse = await _discountRepo.createCouponPost(
        isActive: isActive,
        createdBy: createdBy,
        termsList: termsList,
        description: description,
        segment: segment,
        offerPeriodId: offerPeriodId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
        channelCode: channelCode,
        inventoryId: inventoryId,
        channelId: channelId,
      percentagePrice: percentagePrice,
      maxCount: maxCount,
      couponApplyingOnId: couponApplyingOnId,
      couponApplyingOn: couponApplyingOn,
      name: name,
      canApplyMultiple: canApplyMultiple,
      canApplyTogather: canApplyTogather,
      couponApplyingOnCode: couponApplyingOnCode,
      couponApplyingOnName: couponApplyingOnName,
      couponType: couponType,
      displayName: displayName,
      lines: lines,
      totalValue: totalValue
    );

    if (dataResponse.data ) {
      print("BOLOC SUCCESS");
      yield CouponCreateSuccess(successMessage: dataResponse.error);
    } else {
      yield CouponCreateFailed(
        dataResponse.error ?? "",);
    }

  }
  //list
  Stream<CouponState> paginatedCouponList(String code,String prev) async* {
    couponList=[];
    yield GetCouponListLoading();

    final dataResponse = await _discountRepo.paginatedCouponList(code, prev);

    dataResponse.fold((l) => emit(GetCouponListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        couponList.add((element));
      });

      emit(GetCouponListSuccess(
          couponList: PaginatedResponse(couponList, r.nextPage, r.previousUrl)));
    });
  }

  //serach
  Stream<CouponState> getSearchCoponListState(
      String searchQuery) async* {
    couponList = [];
    next = null;
    yield GetSearchedCouponLoading();

    final dataResponse =
    await _discountRepo.getSearchCoponList(searchQuery, next);

    dataResponse.fold((l) => emit(GetSearchedCouponFailed()), (r) {
      next = r.nextPage;
      couponList = r.data ?? [];

      emit(GetSearchedCouponSuccess(productItem: r,nextPageUrl: r.nextPage??""));
    });
  }

  //discountRead
  Stream<CouponState> getCouponRead(int id) async* {

    yield GetCouponReadLoading();

    final dataResponse = await _discountRepo.getCouponRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetCouponReadSuccess(couponList: dataResponse.data);
    } else {
      yield GetCouponReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<CouponState> deleteCoupon({required int id}) async* {
    yield DeleteCouponLoading();
    final dataResponse = await _discountDataSource.deleteCoupon(id);
    if (dataResponse == "success") {
      yield DeleteCouponSuccess();
    } else {
      yield DeleteCouponFailed();
    }
  }

  //update
  Stream<CouponState> updateCoupenPost(
      {
        required int id,
        required String name,
        required int? offerPeriodId,
        required String? basedOn,
        required String inventoryId,
        required double? percentagePrice,
        required int? maxCount,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required String couponApplyingOnName,
        required int couponApplyingOnId,
        required String couponApplyingOnCode,
        required String? couponApplyingOn,
        required String? channelCode,
        required String? couponType,
        required dynamic image,
        required String? description,
        required double? totalValue,
        required List<ProductListPromotion> lines,
        required bool? isActive,
        required bool? canApplyTogather,
        required bool? canApplyMultiple,
        required bool? isAvailableforAll,
        required String? displayName,
        required List<GetTypeApplying>? customer,
        required List<String>? termsList,
      }) async* {
    yield CouponUpdateLoading();

    final dataResponse = await _discountRepo.updateCoupenPost(
        isActive: isActive,
        termsList: termsList,
        createdBy: createdBy,
        description: description,
        segment: segment,
        offerPeriodId: offerPeriodId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
        channelCode: channelCode,
        inventoryId: inventoryId,
        percentagePrice: percentagePrice,
        maxCount: maxCount,
        couponApplyingOnId: couponApplyingOnId,
        couponApplyingOn: couponApplyingOn,
        name: name,
        id: id,
        canApplyMultiple: canApplyMultiple,
        canApplyTogather: canApplyTogather,
        couponApplyingOnCode: couponApplyingOnCode,
        couponApplyingOnName: couponApplyingOnName,
        couponType: couponType,
        displayName: displayName,
        lines: lines,
        totalValue: totalValue
    );

    if (dataResponse.data ) {
      print("BOLOC SUCCESS");
      yield CouponUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield CouponUpdateFailed(
        dataResponse.error ?? "",);
    }
  }
}
