import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/seller_app/data_and_repo/seller_datasource.dart';
import 'package:cluster/presentation/seller_app/data_and_repo/seller_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../order_app/model/order_model.dart';
import '../seller_models/seller_model_class.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final SellerRepo _sellerRepo = SellerRepo();
  final SellerDataSource _dataSource = SellerDataSource();

  // SellerBloc(super.initialState);

  SellerBloc() : super(NewOrderListLoading());

  @override
  Stream<SellerState> mapEventToState(SellerEvent event) async* {
    if (event is NewOrderListEvent) {
      yield* newOrderListSeller(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim(),
        filter: event.filter,
        endDate: event.endDate,
        startDate: event.startDate
      );
    }
    if (event is OutOfStockListEvent) {
      yield* outOfStockListSeller(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim(),
        code: event.code
      );
    }
    if (event is SellersListEvent) {
      yield* sellersListSeller(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim()
      );
    }
    // else if (event is DashBoardDataEvent) {
    //   yield* getDashboardData();
    // }
    if (event is TotalProductCountEvent) {
      yield* productCount();
    }
    if (event is NewlyAddedListEvent) {
      yield* newlyAddedList(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim(),
          code: event.code
      );
    }
    if (event is TopSellingListEvent) {
      yield* topSellingList(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim(),
          code: event.code
      );
    }
    if (event is TopReviewedListEvent) {
      yield* topReviewedList(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim(),
          code: event.code
      );
    }

  }
  Stream<SellerState> newOrderListSeller({
    String? search,
    String? next,String? prev,String? filter,
    String? startDate,String? endDate
  }) async* {
    yield NewOrderListLoading();
    final dataResponse = await _sellerRepo.newOrderListSeller(search,next,prev,filter,startDate,endDate);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield NewOrderListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);  }

    else {
      yield NewOrderListFailed("failed");
    }
  }

  //out
  Stream<SellerState> outOfStockListSeller({
    String? search,
    String? next,String? prev,
    String? code,
  }) async* {
    yield OutOfStockListLoading();
    final dataResponse = await _sellerRepo.outOfStockListSeller(search,next,prev,code);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield OutOfStockListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);
    }

    else {
      yield OutOfStockListFailed("failed");
    }
  }

  //sellers
  Stream<SellerState> sellersListSeller({
    String? search,
    String? next,String? prev
  }) async* {
    yield SellersListLoading();
    final dataResponse = await _sellerRepo.sellersListSeller(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield SellersListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);
    }

    else {
      yield SellersListFailed("failed");
    }
  }

  //dashbooad
  // Stream<SellerState> getDashboardData() async* {
  //   yield GetDashboardDataLoading();
  //
  //   final dataResponse = await _sellerRepo.getDashboardData();
  //
  //   if (dataResponse.error=="success") {
  //     yield GetDashboardDataSuccess(dataResponse.data);
  //   } else {
  //     yield GetDashboardDataFailed();
  //   }
  // }

  Stream<SellerState> productCount() async* {

    yield GetTotalProductLoading();

    final dataResponse = await _sellerRepo.productCount();

    if (dataResponse.hasData) {
      yield GetTotalProductSuccess(totalMark: dataResponse.data);
    } else {
      yield GetTotalProductFailed(dataResponse.error.toString(),
      );
    }
  }

  //
  Stream<SellerState> newlyAddedList({
    String? search,
    String? next,String? prev,
    String? code,
  }) async* {
    yield NewlyAddedListLoading();
    final dataResponse = await _sellerRepo.newlyAddedList(search,next,prev,code);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield NewlyAddedListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);
    }

    else {
      yield NewlyAddedListFailed("failed");
    }
  }

  //
  Stream<SellerState> topSellingList({
    String? search,
    String? next,String? prev,
    String? code,
  }) async* {
    yield TopSellingListLoading();
    final dataResponse = await _sellerRepo.topSellingList(search,next,prev,code);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield TopSellingListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);
    }
    else {
      yield TopSellingListFailed("failed");
    }
  }

  Stream<SellerState> topReviewedList({
    String? search,
    String? next,String? prev,
    String? code,
  }) async* {
    yield TopReviewdListLoading();
    final dataResponse = await _sellerRepo.topReviewedList(search,next,prev,code);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield TopReviewdListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          orders:  dataResponse.data);
    }

    else {
      yield TopReviewdListFailed("failed");
    }
  }
}
