part of 'buy_more_bloc.dart';


abstract class BuyMoreState extends Equatable {
  const BuyMoreState();
  @override
  List<Object> get props => [];
}

//baseeOn
class GetOfferAppliyingBasedOnReadBuyMoreInitial extends BuyMoreState {}


class GetOfferAppliyingBasedOnReadBuyMoreLoading extends BuyMoreState {}

class GetOfferAppliyingBasedOnReadBuyMoreSuccess extends BuyMoreState {
  final GetDiscount discount;
  GetOfferAppliyingBasedOnReadBuyMoreSuccess({required this.discount});
  @override
  List<Object> get props => [discount];
}

class GetOfferAppliyingBasedOnReadBuyMoreFailed extends BuyMoreState {
  final String error;
  const GetOfferAppliyingBasedOnReadBuyMoreFailed(this.error);
}
//createBuyMore
class BuyMoreCreateInitial extends BuyMoreState {}

class BuyMoreCreateLoading extends BuyMoreState {}

class BuyMoreCreateSuccess extends BuyMoreState {
  final String?  successMessage;

  const BuyMoreCreateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class BuyMoreCreateFailed extends BuyMoreState {
  final String error;

  const BuyMoreCreateFailed(this.error);
  @override
  List<Object> get props => [];
}
//listBuyMore
class GetBuyMoreListInitial extends BuyMoreState {}

class GetBuyMoreListLoading extends BuyMoreState {}

class GetBuyMoreListSuccess extends BuyMoreState {
  final PaginatedResponse discountList;

  GetBuyMoreListSuccess({required this.discountList});
  @override
  List<Object> get props => [discountList];
}

class GetBuyMoreListFailed extends BuyMoreState {
  GetBuyMoreListFailed();
}
//search

class GetSearchedBuyMoreInitial extends BuyMoreState {}

class GetSearchedBuyMoreLoading extends BuyMoreState {}

class GetSearchedBuyMoreSuccess extends BuyMoreState {
  final String nextPageUrl;
  final PaginatedResponse productItem;
  GetSearchedBuyMoreSuccess({required this.productItem,required this.nextPageUrl
  });
  @override
  List<Object> get props => [productItem];
}

class GetSearchedBuyMoreFailed extends BuyMoreState {
  GetSearchedBuyMoreFailed();
}



//readDiscout
class GetBuyMoreReadInitial extends BuyMoreState {}


class GetBuyMoreReadLoading extends BuyMoreState {}

class GetBuyMoreReadSuccess extends BuyMoreState {
  final BuyMoreList buyMoreList;
  GetBuyMoreReadSuccess({required this.buyMoreList});
  @override
  List<Object> get props => [buyMoreList];
}

class GetBuyMoreReadFailed extends BuyMoreState {
  final String error;
  const GetBuyMoreReadFailed(this.error);
}
//deleteDiscount
class DeleteBuyMoreInitial extends BuyMoreState {}

class DeleteBuyMoreLoading extends BuyMoreState {}

class DeleteBuyMoreSuccess extends BuyMoreState {}

class DeleteBuyMoreFailed extends BuyMoreState {}

//update
class BuyMoreUpdateInitial extends BuyMoreState {}

class BuyMoreUpdateLoading extends BuyMoreState {}

class BuyMoreUpdateSuccess extends BuyMoreState {
  final String?  successMessage;

  const BuyMoreUpdateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class BuyMoreUpdateFailed extends BuyMoreState {
  final String error;

  const BuyMoreUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}