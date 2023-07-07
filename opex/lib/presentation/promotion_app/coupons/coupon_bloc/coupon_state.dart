part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  const CouponState();
  @override
  List<Object> get props => [];
}

//baseeOn
class GetOfferAppliyingBasedOnReadCouponInitial extends CouponState {}


class GetOfferAppliyingBasedOnReadCouponLoading extends CouponState {}

class GetOfferAppliyingBasedOnReadCouponSuccess extends CouponState {
  final GetDiscount discount;
  GetOfferAppliyingBasedOnReadCouponSuccess({required this.discount});
  @override
  List<Object> get props => [discount];
}

class GetOfferAppliyingBasedOnReadCouponFailed extends CouponState {
  final String error;
  const GetOfferAppliyingBasedOnReadCouponFailed(this.error);
}
//createCopen
class CouponCreateInitial extends CouponState {}

class CouponCreateLoading extends CouponState {}

class CouponCreateSuccess extends CouponState {
  final String?  successMessage;

  const CouponCreateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CouponCreateFailed extends CouponState {
  final String error;

  const CouponCreateFailed(this.error);
  @override
  List<Object> get props => [];
}
//list
class GetCouponListInitial extends CouponState {}

class GetCouponListLoading extends CouponState {}

class GetCouponListSuccess extends CouponState {
  final PaginatedResponse couponList;

  GetCouponListSuccess({required this.couponList});
  @override
  List<Object> get props => [couponList];
}

class GetCouponListFailed extends CouponState {
  GetCouponListFailed();
}
//search

class GetSearchedCouponInitial extends CouponState {}

class GetSearchedCouponLoading extends CouponState {}

class GetSearchedCouponSuccess extends CouponState {
  final String nextPageUrl;
  final PaginatedResponse productItem;
  GetSearchedCouponSuccess({required this.productItem,required this.nextPageUrl
  });
  @override
  List<Object> get props => [productItem];
}

class GetSearchedCouponFailed extends CouponState {
  GetSearchedCouponFailed();
}

//readCoupon
class GetCouponReadInitial extends CouponState {}


class GetCouponReadLoading extends CouponState {}

class GetCouponReadSuccess extends CouponState {
  final CouponList couponList;
  GetCouponReadSuccess({required this.couponList});
  @override
  List<Object> get props => [couponList];
}

class GetCouponReadFailed extends CouponState {
  final String error;
  const GetCouponReadFailed(this.error);
}
//deleteCoupon
class DeleteCouponInitial extends CouponState {}

class DeleteCouponLoading extends CouponState {}

class DeleteCouponSuccess extends CouponState {}

class DeleteCouponFailed extends CouponState {}

//update
class CouponUpdateInitial extends CouponState {}

class CouponUpdateLoading extends CouponState {}

class CouponUpdateSuccess extends CouponState {
  final String?  successMessage;

  const CouponUpdateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CouponUpdateFailed extends CouponState {
  final String error;

  const CouponUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
