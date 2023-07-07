part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable{
  const CouponEvent();

  @override
  List<Object> get props => [];
}
class GetOfferApplyingBasedOnReadCouponEvent extends CouponEvent {
  const GetOfferApplyingBasedOnReadCouponEvent();
  @override
  List<Object> get props => [];
}
class CreateCouponGetMoreEvent extends CouponEvent {
  final dynamic image;
  final String name;
  final List<ProductListPromotion> lines;
  final bool isActive;
  final bool canApplyTogather;
  final bool canApplyMultiple;
  final String inventoryId;
  final String channelCode;
  final String description;
  final String basedOn;
  final int offerPeriodId;
  final bool isAvailableForAll;
  final String createdBy;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  final String couponApplyingOn;
  final String couponApplyingOnName;
  final int couponApplyingOnId;
  final String couponApplyingOnCode;
  final String? channelId;
  final String? coupenType;
  final String? displayName;
  final double? priceOrPercentage;
  final double? totalValue;
  final int? maxCount;
  final List<String> termsList;
  const CreateCouponGetMoreEvent( {
    required this.isActive,
    required this.lines,
    required this.termsList,
    required this.description,
    required this.name,
    required this.couponApplyingOn,
    required this.couponApplyingOnCode,
    required this.couponApplyingOnId,
    required this.channelId,
    required this.couponApplyingOnName,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.isAvailableForAll,
    required this.segmentList,
    required  this.customerList,
    required this.image,
    required this.channelCode,
    required this.inventoryId,
    required this.canApplyMultiple,
    required this.priceOrPercentage,
    required this.maxCount,
    required this.canApplyTogather,
    required this.coupenType,
    required this.displayName,
    required this.totalValue,
  });
  @override
  List<Object> get props => [
    name,
  ];
}
//list
class PaginatedCouponListEvent extends CouponEvent {
  final String code;
  final String prev;
  const PaginatedCouponListEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}
//serch
class SearchPaginatedCouponListEvent extends CouponEvent {
  final String? nextPageUrl;
  final String query;

  const SearchPaginatedCouponListEvent({required this.query,this.nextPageUrl});
  @override
  List<Object> get props => [this.query];
}
//readcoupon
class GetCouponReadEvent extends CouponEvent {
  final int id;
  const GetCouponReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deletecoupon
class DeleteCouponEvent extends CouponEvent {
  final int id;
  const DeleteCouponEvent(this.id);
}
//update
class UpdateCouponEvent extends CouponEvent {
  final dynamic image;
  final String name;
  final List<ProductListPromotion> lines;
  final List<String> termsList;
  final bool isActive;
  final bool canApplyTogather;
  final bool canApplyMultiple;
  final String inventoryId;
  final String channelCode;
  final String description;
  final String basedOn;
  final int offerPeriodId;
  final bool isAvailableForAll;
  final String createdBy;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  final String couponApplyingOn;
  final String couponApplyingOnName;
  final int couponApplyingOnId;
  final String couponApplyingOnCode;
  final String? coupenType;
  final String? displayName;
  final double? priceOrPercentage;
  final double? totalValue;
  final int? maxCount;
  final int? id;
  const UpdateCouponEvent( {
    required this.isActive,
    required this.termsList,
    required this.lines,
    required this.description,
    required this.name,
    required this.couponApplyingOn,
    required this.couponApplyingOnCode,
    required this.couponApplyingOnId,
    required this.couponApplyingOnName,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.isAvailableForAll,
    required this.segmentList,
    required this.customerList,
    required this.image,
    required this.channelCode,
    required this.inventoryId,
    required this.id,
    required this.canApplyMultiple,
    required this.priceOrPercentage,
    required this.maxCount,
    required this.canApplyTogather,
    required this.coupenType,
    required this.displayName,
    required this.totalValue,
  });
  @override
  List<Object> get props => [name];
}