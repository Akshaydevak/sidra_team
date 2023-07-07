part of 'discount_bloc.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}
class GetSegmentListEvent extends DiscountEvent {
  const GetSegmentListEvent();
}

class CreateOfferPeriodEvent extends DiscountEvent {
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String title;
  final String description;
  final String note;
  final String? createdBy;
  final bool? isActive;
  CreateOfferPeriodEvent({
    required this.isActive,
    required this.description,
    required this.createdBy,
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.note,
    required this.toDate,
    required this.toTime,
  });
  @override
  List<Object> get props => [
    title,
  ];
}

//offerPeriodlist
class PaginatedOfferPeriodEvent extends DiscountEvent {
  final String code;
  final String? prev;
  const PaginatedOfferPeriodEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}

//readOfferPeriod
class GetOfferPeriodReadEvent extends DiscountEvent {
  final int id;
  const GetOfferPeriodReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteofferperiod
class DeleteOfferPeriodEvent extends DiscountEvent {
  final int id;
  const DeleteOfferPeriodEvent(this.id);
}
//updateOfferPeriod
class UpdateOfferPeriodEvent extends DiscountEvent {
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String title;
  final String description;
  final String note;
  final String? createdBy;
  final bool? isActive;
  final int? id;
  UpdateOfferPeriodEvent({
    required this.id,
    required this.isActive,
    required this.description,
    required this.createdBy,
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.note,
    required this.toDate,
    required this.toTime,
  });
  @override
  List<Object> get props => [
    title,
  ];
}
//channelList
class PaginatedChannelListEvent extends DiscountEvent {
  final String code;
  const PaginatedChannelListEvent(this.code);
  @override
  List<Object> get props => [this.code];
}
//postImage
class PostImageDiscountEvent extends DiscountEvent {
  final File image;
  const PostImageDiscountEvent(this.image);
}

//createOfferGroup
class CreateOfferGroupEvent extends DiscountEvent {
  final int image;
  final int priorty;
  final String channelCode;
  final String title;
  final String description;
  final String inventoryId;
  final String? createdBy;
  final bool? isActive;
  CreateOfferGroupEvent({
    required this.isActive,
    required this.description,
    required this.createdBy,
    required this.title,
    required this.image,
    required this.priorty,
    required this.channelCode,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    title,
  ];
}

//listOfferGroup
class PaginatedOfferGroupEvent extends DiscountEvent {
  final String code;
  const PaginatedOfferGroupEvent(this.code);
  @override
  List<Object> get props => [this.code];
}
//readOfferGroup
class GetOfferGroupReadEvent extends DiscountEvent {
  final int id;
  const GetOfferGroupReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//updateofferGroup
class UpdateOfferGroupEvent extends DiscountEvent {
  final int img;
  final String title;
  final String description;
  final String? createdBy;
  final bool? isActive;
  final int? id;
  final int? priority;
  UpdateOfferGroupEvent({
    required this.id,
    required this.isActive,
    required this.description,
    required this.createdBy,
    required this.title,
    required this.img,
    required this.priority,

  });
  @override
  List<Object> get props => [
    title,
  ];
}
//deleteofergroup
class DeleteOfferGroupEvent extends DiscountEvent {
  final int id;
  const DeleteOfferGroupEvent(this.id);
}
//readofferAppliying
class GetOfferAppliyingBasedOnReadEvent extends DiscountEvent {
  const GetOfferAppliyingBasedOnReadEvent();
  @override
  List<Object> get props => [];
}
//typeappliying
class PostTypeAppliyingListEvent extends DiscountEvent {
  final String type;
  final String? searchElement;
  final List<String> segmentList;
  final String inventoryId;
  final String? nextUrl;
  final String? prevUrl;
  PostTypeAppliyingListEvent( {
    this.prevUrl,
    this.nextUrl,
    required this.segmentList,
    required this.type,
     this.searchElement,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    type,
  ];
}

//productlist
class PostProductListEvent extends DiscountEvent {
  final String applyingType;
  final String? searchElement;
  final List<String> segmentList;
  final String? applyingtypeCode;
  final String inventoryId;
  final String? nextUrl;
  final String? prevUrl;
  PostProductListEvent( {
    this.prevUrl,
    this.nextUrl,
    required this.applyingtypeCode,
    required this.segmentList,
    required this.applyingType,
    this.searchElement,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    applyingtypeCode??"",
  ];
}
//customergroup
class PaginatedCustomerGroupEvent extends DiscountEvent {
  final String? code;
  final String? prev;
  const PaginatedCustomerGroupEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code.toString()];
}
//createDiscount
class CreateDiscountEvent extends DiscountEvent {
  final String typeApplying;
  final int typeId;
  final String typeCode;
  final dynamic image;
  final String title;
  final List<ProductListPromotion> variants;
  final bool isActive;
  final int maxQty;
  final int priority;
  final String inventoryId;
  final String channelCode;
  final String description;
  final double discountPercentagePrice;
  final String basedOn;
  final int offerPeriodId;
  final int offerGroupId;
  final bool isAvailableForAll;
  final String createdBy;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  CreateDiscountEvent( {
    required this.isActive,
    required this.typeApplying,
    required this.typeId,
    required this.typeCode,
    required this.variants,
    required this.description,
    required this.maxQty,
    required this.priority,
    required this.discountPercentagePrice,
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

//listDiscount
class PaginatedDiscountListEvent extends DiscountEvent {
  final String code;
  final String prev;
  const PaginatedDiscountListEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}
//serch
class SearchPaginatedDiscountListEvent extends DiscountEvent {
  final String? nextPageUrl;
  final String query;


  const SearchPaginatedDiscountListEvent({required this.query,this.nextPageUrl});
  @override
  List<Object> get props => [this.query];
}
//readDiscount
class GetDiscountReadEvent extends DiscountEvent {
  final int id;
  const GetDiscountReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteDiscountEvent extends DiscountEvent {
  final int id;
  const DeleteDiscountEvent(this.id);
}
//updateDiscount
class UpdateDiscountEvent extends DiscountEvent {
  final String typeApplying;
  final int typeId;
  final int id;
  final int offerLineId;
  final String typeCode;
  final String offerProductGroupCode;
  final dynamic image;
  final String title;
  final List<ProductListPromotion> variants;
  final bool isActive;
  final int maxQty;
  final String inventoryId;
  final String channelCode;
  final String description;
  final double discountPercentagePrice;
  final String basedOn;
  final int offerPeriodId;
  final int priority;
  final int? offerGroupId;
  final bool isAvailableForAll;
  final String createdBy;
  final List<GetSegmentList> segmentList;
  final List<GetTypeApplying> customerList;
  const UpdateDiscountEvent({
    required this.id,
    required this.priority,
    required this.offerProductGroupCode,
    required this.offerLineId,
    required this.isActive,
    required this.typeApplying,
    required this.typeId,
    required this.typeCode,
    required this.variants,
    required this.description,
    required this.maxQty,
    required this.discountPercentagePrice,
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
//listselectedVariants
class PaginatedSelectedVariantListEvent extends DiscountEvent {
  final String code;
  final String offerGroupCode;
  const PaginatedSelectedVariantListEvent(this.code, this.offerGroupCode);
  @override
  List<Object> get props => [this.code];
}


//postDeactivatePrevProm
class DeactivatePreviousPromotionEvent extends DiscountEvent {
  final String typeData;
  final List<int> idList;
  final bool type;
  final bool isCoupon;


  DeactivatePreviousPromotionEvent(   {
    required this.isCoupon,
    required this.typeData, required this.idList,required this.type

  });
  @override
  List<Object> get props => [
    typeData,
  ];
}

//selectivevariants
class DeleteSelectiveVariantsEvent extends DiscountEvent {
  final List<ProductListPromotion> variants;

  DeleteSelectiveVariantsEvent( {
    required this.variants,
  });
  @override
  List<Object> get props => [
    variants,
  ];
}

