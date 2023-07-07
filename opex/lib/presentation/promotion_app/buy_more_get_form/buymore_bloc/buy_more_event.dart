part of 'buy_more_bloc.dart';


abstract class BuyMoreEvent extends Equatable{
  const BuyMoreEvent();

  @override
  List<Object> get props => [];
}
class GetOfferApplyingBasedOnReadBuyMoreEvent extends BuyMoreEvent {
  const GetOfferApplyingBasedOnReadBuyMoreEvent();
  @override
  List<Object> get props => [];
}
class CreateBuyMoreGetMoreEvent extends BuyMoreEvent {

  final dynamic image;
  final String title;
  final List<ProductListPromotion> variants;
  final bool isActive;
  // final int maxQty;
  final String inventoryId;
  final String channelCode;
  final String description;
  // final double discountPercentagePrice;
  final String basedOn;
  final int offerPeriodId;
  final int offerGroupId;
  final bool isAvailableForAll;
  final String createdBy;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  final String buyMoreApplyingOn;
  final String buyMoreApplyingOnName;
  final int buyMoreApplyingOnId;
  final String buyMoreApplyingOnCode;
  final List<GetCount>? count;
  // final String? offerAppliedTo;
  // final int? offerAppliedToId;
  // final String? offerAppliedToCode;
  final String? channelId;
  const CreateBuyMoreGetMoreEvent( {
    required this.isActive,
    required this.variants,
    required this.description,
    required this.buyMoreApplyingOn,
    required this.buyMoreApplyingOnCode,
    required this.buyMoreApplyingOnId,
    required this.buyMoreApplyingOnName,
    required this.channelId,
    required this.count,
    // required this.offerAppliedTo,
    // required this.offerAppliedToCode,
    // required this.offerAppliedToId,
    // required this.maxQty,
    // required this.discountPercentagePrice,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.offerGroupId,
    required this.isAvailableForAll,
    required this.segmentList,
    required  this.customerList,
    required this.title,
    required this.image,
    required this.channelCode,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    title,
  ];
}
//listByMore
class PaginatedBuyMoreListEvent extends BuyMoreEvent {
  final String code;
  final String prev;
  const PaginatedBuyMoreListEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}
//search
class SearchPaginatedBuyMoreListEvent extends BuyMoreEvent {
  final String? nextPageUrl;
  final String query;

  const SearchPaginatedBuyMoreListEvent({required this.query,this.nextPageUrl});
  @override
  List<Object> get props => [this.query];
}
//readByMore
class GetBuyMoreReadEvent extends BuyMoreEvent {
  final int id;
  const GetBuyMoreReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteByMore
class DeleteBuyMoreEvent extends BuyMoreEvent {
  final int id;
  const DeleteBuyMoreEvent(this.id);
}
//updaterBuyMore
class UpdateBuyMoreGetMoreEvent extends BuyMoreEvent {

  final dynamic image;
  final String title;
  final String createdBy;
  final List<ProductListPromotion> variants;
  final bool isActive;
  final String inventoryId;
  final String channelCode;
  final String description;
  final String basedOn;
  final int id;
  final int offerPeriodId;
  final int offerGroupId;
  final bool isAvailableForAll;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  final String buyMoreApplyingOn;
  final String buyMoreApplyingOnName;
  final int buyMoreApplyingOnId;
  final String buyMoreApplyingOnCode;
  final List<GetCount>? count;
  // final String? channelId;
  const UpdateBuyMoreGetMoreEvent( {
    required this.isActive,
    required this.variants,
    required this.description,
    required this.buyMoreApplyingOn,
    required this.buyMoreApplyingOnCode,
    required this.buyMoreApplyingOnId,
    required this.buyMoreApplyingOnName,
    // required this.channelId,
    required this.count,
    required this.id,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.offerGroupId,
    required this.isAvailableForAll,
    required this.segmentList,
    required  this.customerList,
    required this.title,
    required this.image,
    required this.channelCode,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    title,
  ];
}