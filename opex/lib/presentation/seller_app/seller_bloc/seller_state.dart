part of 'seller_bloc.dart';

abstract class SellerState extends Equatable {
  const SellerState();

  @override
  List<Object> get props => [];
}

class NewOrderListLoading extends SellerState {}

class NewOrderListSuccess extends SellerState  {
  final List<GetNewOrderSellerList>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const NewOrderListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class NewOrderListFailed extends SellerState {
  final String msg;
  NewOrderListFailed(this.msg);
}

//out
class OutOfStockListLoading extends SellerState {}

class OutOfStockListSuccess extends SellerState  {
  final List<VariantListModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const OutOfStockListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class OutOfStockListFailed extends SellerState {
  final String msg;
  OutOfStockListFailed(this.msg);
}

//seller
class SellersListLoading extends SellerState {}

class SellersListSuccess extends SellerState  {
  final List<SellerList>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const SellersListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class SellersListFailed extends SellerState {
  final String msg;
  SellersListFailed(this.msg);
}


class GetDashboardDataLoading extends SellerState {}

// class GetDashboardDataSuccess extends SellerState {
//   final OrderAnalyticsModel ordersList;
//
//   const GetDashboardDataSuccess(this.ordersList);
// }

class GetDashboardDataFailed extends SellerState {}

//
class GetTotalProductLoading extends SellerState {}

class GetTotalProductSuccess extends SellerState {
  final int totalMark;
  GetTotalProductSuccess({required this.totalMark});
  @override
  List<Object> get props => [totalMark];
}

class GetTotalProductFailed extends SellerState {
  final String error;GetTotalProductFailed(this.error);
}


//newly
class NewlyAddedListLoading extends SellerState {}

class NewlyAddedListSuccess extends SellerState  {
  final List<VariantListModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const NewlyAddedListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class NewlyAddedListFailed extends SellerState {
  final String msg;
  NewlyAddedListFailed(this.msg);
}


//topsellinh
class TopSellingListLoading extends SellerState {}

class TopSellingListSuccess extends SellerState  {
  final List<VariantListModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const TopSellingListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class TopSellingListFailed extends SellerState {
  final String msg;
  TopSellingListFailed(this.msg);
}


//topReview
class TopReviewdListLoading extends SellerState {}

class TopReviewdListSuccess extends SellerState  {
  final List<VariantListModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const TopReviewdListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class TopReviewdListFailed extends SellerState {
  final String msg;
  TopReviewdListFailed(this.msg);
}
