part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];

}
class NewOrderListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? filter;
  final String? startDate;
  final String? endDate;
  const NewOrderListEvent(this.search, this.next, this.prev, this.filter, this.startDate, this.endDate);
}
class OutOfStockListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? code;
  const OutOfStockListEvent(this.search, this.next, this.prev, this.code);
}
class SellersListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  const SellersListEvent(this.search, this.next, this.prev);
}

class DashBoardDataEvent extends SellerEvent {
  const DashBoardDataEvent();
}

class TotalProductCountEvent extends SellerEvent {
  const TotalProductCountEvent();
}

class NewlyAddedListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? code;
  const NewlyAddedListEvent(this.search, this.next, this.prev, this.code);
}

class TopSellingListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? code;
  const TopSellingListEvent(this.search, this.next, this.prev, this.code);
}

class TopReviewedListEvent extends SellerEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? code;
  const TopReviewedListEvent(this.search, this.next, this.prev, this.code);
}