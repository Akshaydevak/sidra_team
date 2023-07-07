

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_discount.g.dart';

@JsonSerializable()
class GetSegmentList extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'segment_name')
  final String? segmentName;
  @JsonKey(name: 'segment_code')
  final String? segmentCode;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'is_sales_blocked', defaultValue: false)
  final bool? isSalesBlock;


  const GetSegmentList( {
    this.id,
    this.name,
    this.segmentName,
    this.segmentCode,
    this.code,
    this.image,
    this.isSalesBlock,
  });
  @override
  List<Object> get props => [];
  factory GetSegmentList.fromJson(Map<String, dynamic> json) =>
      _$GetSegmentListFromJson(json);

  Map<String, dynamic> toJson() => _$GetSegmentListToJson(this);
}

//offerPeriod
@JsonSerializable()
class GetOfferPeriod extends Equatable {
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'offer_period_code')
  final String? offerPeriodCode;
  @JsonKey(name: 'from_time')
  final String? fromTime;
  @JsonKey(name: 'to_time')
  final String? toTime;
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @JsonKey(name: 'to_date')
  final String? toDate;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;


  const GetOfferPeriod( {
    this.id,
    this.title,
    this.offerPeriodCode,
    this.isActive,
    this.createdBy,
    this.description,
    this.fromTime,
    this.toDate,
    this.toTime,
    this.notes,
    this.createdAt,
    this.fromDate,
  });
  @override
  List<Object> get props => [];
  factory GetOfferPeriod.fromJson(Map<String, dynamic> json) =>
      _$GetOfferPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$GetOfferPeriodToJson(this);
}
//channelList
@JsonSerializable()
class ChannelList extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'channel_code')
  final String? channelCode;



  const ChannelList( {
    this.id,
    this.name,
    this.channelCode,

  });
  @override
  List<Object> get props => [];
  factory ChannelList.fromJson(Map<String, dynamic> json) =>
      _$ChannelListFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelListToJson(this);
}

//offergroup
@JsonSerializable()
class GetOfferGroup extends Equatable {
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'channel_id')
  final int? channelId;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'priority')
  final int? priority;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;



  const GetOfferGroup( {
    this.id,
    this.priority,
    this.title,
    this.channelCode,
    this.image,
    this.isActive,
    this.description,
    this.channelId

  });
  @override
  List<Object> get props => [];
  factory GetOfferGroup.fromJson(Map<String, dynamic> json) =>
      _$GetOfferGroupFromJson(json);

  Map<String, dynamic> toJson() => _$GetOfferGroupToJson(this);
}

//getDiscount
@JsonSerializable()
class GetDiscount extends Equatable {
  @JsonKey(name: 'type_applying')
  final List<String>? typeAppliying;
  @JsonKey(name: 'attribute_types')
  final List<String>? attributeType;
  @JsonKey(name: 'based_on')
  final List<String>? basedOn;
  @JsonKey(name: 'buy_more_applying_on')
  final List<String>? buyMoreTypeAppliying;
  @JsonKey(name: 'coupon_type')
  final List<String>? couponType;
  @JsonKey(name: 'coupon_applying_on')
  final List<String>? couponAppliyingOn;
  @JsonKey(name: 'coupon_based_on')
  final List<String>? couponBasedOn;

  const GetDiscount( {
    this.basedOn,
    this.attributeType,
    this.buyMoreTypeAppliying,
    this.typeAppliying,
    this.couponAppliyingOn,
    this.couponBasedOn,
    this.couponType,

  });
  @override
  List<Object> get props => [];
  factory GetDiscount.fromJson(Map<String, dynamic> json) =>
      _$GetDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$GetDiscountToJson(this);
}

//typrAppliying
@JsonSerializable()
class GetTypeApplying extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'customer_group_id')
  final String? customerGroupId;
  @JsonKey(name: 'customer_group_code')
  final String? customerGroupCode;
  @JsonKey(name: 'code')
  final String? code;

  const GetTypeApplying( {
    this.id,
    this.name,
    this.code,
    this.customerGroupCode,
    this.customerGroupId,

  });
  @override
  List<Object> get props => [];
  factory GetTypeApplying.fromJson(Map<String, dynamic> json) =>
      _$GetTypeApplyingFromJson(json);

  Map<String, dynamic> toJson() => _$GetTypeApplyingToJson(this);
}
//productLisyt
@JsonSerializable()
class ProductListPromotion extends Equatable {

  final int? id;
  @JsonKey(name: 'variant_id')
  final int? variantId;
  @JsonKey(name: 'coupon_line_code')
  final String? couponLineCode;
  @JsonKey(name: 'negotiation_line_code')
  final String? negotiationLineCode;
  @JsonKey(name: 'variant_code')
  final String? variantCode;
  @JsonKey(name: 'image1')
  final String? image;
  @JsonKey(name: 'variant_name')
  final String? variantName;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'barcode')
  final Barcode? barcode;
  @JsonKey(name: 'unit_cost')
  final double? unitCost;
  @JsonKey(name: 'uom_name')
  final String? uomName;
  @JsonKey(name: 'is_active',defaultValue: false)
   bool? isActive;
  @JsonKey(name: 'discount_id')
  final int? discountId;
  @JsonKey(name: 'offer_products_group_id')
  final int? offerProductGroupId;
  @JsonKey(name: 'offer_lines_id')
  final int? offerLineId;
  @JsonKey(name: 'offer_name')
  final String? offerName;
  @JsonKey(name: 'coupon_name')
  final String? couponName;
  @JsonKey(name: 'type_data')
  final String? typeData;

   ProductListPromotion( {
    this.uomName,
    this.negotiationLineCode,
    this.couponLineCode,
    this.typeData,
    this.couponName,
    this.image,
    this.offerName,
    this.offerLineId,
    this.isActive,
    this.discountId,
    this.offerProductGroupId,
    this.id,
    this.name,
    this.variantName,
    this.barcode,
    this.unitCost,
    this.variantCode,
    this.variantId,

  });
  @override
  List<Object> get props => [];
  factory ProductListPromotion.fromJson(Map<String, dynamic> json) =>
      _$ProductListPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListPromotionToJson(this);
}

//barcode
@JsonSerializable()
class Barcode extends Equatable {

  @JsonKey(name: 'file_name')
  final String? fileName;
  @JsonKey(name: 'barcode_number')
  final String? barcodeNumber;


  const Barcode( {
    this.barcodeNumber,
    this.fileName,
  });
  @override
  List<Object> get props => [];
  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeToJson(this);
}

//discoutList
@JsonSerializable()
class DiscountList extends Equatable {

  final int? id;
  @JsonKey(name: 'discount_code')
  final String? discountCode;
  @JsonKey(name: 'offer_group_name')
  final String? offerGroupName;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'priority')
  final int? priority;
  @JsonKey(name: 'offer_lines')
  final List<OfferLines>? offerLines;
  @JsonKey(name: 'offer_period_details')
  final OfferPeriodDetails? offerPeriodDetails;
  @JsonKey(name: 'offer_period_name')
  final String? offerPeriodName;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'segments')
  final List<GetSegmentList>? segments;
  @JsonKey(name: 'channel_id')
  final int? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_available_for_all',defaultValue: false)
  final bool? isAvailableForAll;
  @JsonKey(name: 'available_customer_groups')
  final List<GetTypeApplying>? customer;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'discount_percentage_or_price')
  final double? discountPercentageorPrice;
  @JsonKey(name: 'based_on')
  final String? basedOn;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'offer_period_id')
  final int? offerPeriodId;
  @JsonKey(name: 'offer_group_id')
  final int? offerGroupId;

  const DiscountList(   {
    this.title,
    this.basedOn,
    this.priority,
    this.isActive,
    this.updatedAt,
    this.createdBy,
    this.offerPeriodId,
    this.offerGroupId,
    this.offerGroupName,
    this.isAvailableForAll,
    this.offerPeriodDetails,
    this.customer,
    this.image,
    this.discountPercentageorPrice,
    this.offerLines,
    this.offerPeriodName,
    this.inventoryId,
    this.segments,
    this.channelId,
    this.channelCode,
    this.description,
    this.id,
    this.discountCode,
  });
  @override
  List<Object> get props => [];
  factory DiscountList.fromJson(Map<String, dynamic> json) =>
      _$DiscountListFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountListToJson(this);
}

//offerPeriodDetails
@JsonSerializable()
class OfferPeriodDetails extends Equatable {

  final int? id;
  @JsonKey(name: 'from_time')
  final String? fromTime;
  @JsonKey(name: 'to_time')
  final String? toTime;
  @JsonKey(name: 'from_date')
  final String? fromDate;
  @JsonKey(name: 'to_date')
  final String? toDate;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'offer_period_name')
  final String? offerPeriodName;
  @JsonKey(name: 'offer_period_id')
  final int? offerPeriodId;
  @JsonKey(name: 'offer_period_code')
  final String? offerPeriodCode;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;


  const OfferPeriodDetails(   {
    this.id,
    this.offerPeriodId,
    this.offerPeriodName,
    this.toDate,
    this.fromDate,
    this.title,
    this.toTime,
    this.fromTime,
    this.createdAt,
    this.createdBy,
    this.description,
    this.notes,
    this.offerPeriodCode,
    this.isActive,

  });
  @override
  List<Object> get props => [];
  factory OfferPeriodDetails.fromJson(Map<String, dynamic> json) =>
      _$OfferPeriodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OfferPeriodDetailsToJson(this);
}


//offerLimes
@JsonSerializable()
class OfferLines extends Equatable {

  final int? id;
  @JsonKey(name: 'offer_product_group_code')
  final String? offerProductGroupCode;
  @JsonKey(name: 'offer_line_code')
  final String? offerLineCode;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'type_applying')
  final String? typeApplying;
  @JsonKey(name: 'priority')
  final String? priority;
  @JsonKey(name: 'type_id')
  final int? typeId;
  @JsonKey(name: 'override_priority',defaultValue: false)
  final bool? overridePriority;
  @JsonKey(name: 'type_code')
  final String? typeCode;
  @JsonKey(name: 'maximum_qty')
  final int? maxQty;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'offer_product_group_id')
  final int? offerProductGroupId;


  const OfferLines(   {
    this.id,
    this.offerProductGroupCode,
    this.offerLineCode,
    this.title,
    this.image,
    this.typeApplying,
    this.priority,
    this.typeId,
    this.overridePriority,
    this.typeCode,
    this.maxQty,
    this.isActive,
    this.offerProductGroupId,
  });
  @override
  List<Object> get props => [];
  factory OfferLines.fromJson(Map<String, dynamic> json) =>
      _$OfferLinesFromJson(json);

  Map<String, dynamic> toJson() => _$OfferLinesToJson(this);
}

//count
@JsonSerializable()
class GetCount extends Equatable {
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'value')
  final int? value;
  @JsonKey(name: 'price_percentage')
  final double? priceOrPercentage;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;

  const GetCount( {
    this.count,
    this.value,
    this.isActive,
    this.priceOrPercentage,


  });
  @override
  List<Object> get props => [];
  factory GetCount.fromJson(Map<String, dynamic> json) =>
      _$GetCountFromJson(json);

  Map<String, dynamic> toJson() => _$GetCountToJson(this);
}

//listBuymore
@JsonSerializable()
class BuyMoreList extends Equatable {

  final int? id;
  @JsonKey(name: 'buy_more_code')
  final String? buyMoreCode;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'lines')
  final List<ProductListPromotion>? lines;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'segments')
  final List<GetSegmentList>? segments;
  @JsonKey(name: 'channel_id')
  final String? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'offer_period_name')
  final String? offerPerodName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_available_for_all',defaultValue: false)
  final bool? isAvailableForAll;
  @JsonKey(name: 'available_customer_groups')
  final List<GetTypeApplying>? customer;
  @JsonKey(name: 'count_price_percentage')
  final List<GetCount>? countList;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'buy_more_applying_on')
  final String? buyMoreAppliyingOn;
  @JsonKey(name: 'buy_more_applying_on_name')
  final String? buyMoreAppliyingOnName;
  @JsonKey(name: 'buy_more_applying_on_id')
  final int? buyMoreAppliyingOnId;
  @JsonKey(name: 'buy_more_applying_on_code')
  final String? buyMoreAppliyingOnCode;
  @JsonKey(name: 'maximum_count')
  final double? maxCount;
  @JsonKey(name: 'based_on')
  final String? basedOn;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'offer_period_id')
  final int? offerPeriodId;
  @JsonKey(name: 'offer_group_id')
  final int? offerGroupId;

  const BuyMoreList(   {
    this.title,
    this.offerPerodName,
    this.basedOn,
    this.isActive,
    this.updatedAt,
    this.createdBy,
    this.offerPeriodId,
    this.offerGroupId,
    this.isAvailableForAll,
    this.customer,
    this.image,
    this.countList,
    this.buyMoreAppliyingOn,
    this.buyMoreAppliyingOnCode,
    this.buyMoreAppliyingOnId,
    this.buyMoreAppliyingOnName,
    this.maxCount,
    this.lines,
    this.inventoryId,
    this.segments,
    this.channelId,
    this.channelCode,
    this.description,
    this.id,
    this.buyMoreCode,
  });
  @override
  List<Object> get props => [];
  factory BuyMoreList.fromJson(Map<String, dynamic> json) =>
      _$BuyMoreListFromJson(json);

  Map<String, dynamic> toJson() => _$BuyMoreListToJson(this);
}

//coupon
@JsonSerializable()
class CouponList extends Equatable {

  final int? id;
  @JsonKey(name: 'coupon_code')
  final String? couponCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'conditions')
  final List<ConditionList>? conditions;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'coupon_type')
  final String? couponType;
  @JsonKey(name: 'line')
  final List<ProductListPromotion>? line;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'segments')
  final List<GetSegmentList>? segments;
  @JsonKey(name: 'channel_id')
  final String? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'offer_period_name')
  final String? offerPerodName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_available_to_all',defaultValue: false)
  final bool? isAvailableToAll;
  @JsonKey(name: 'can_apply_multiple_times',defaultValue: false)
  final bool? canApplyMultiple;
  @JsonKey(name: 'can_apply_together',defaultValue: false)
  final bool? canApplyTogather;
  @JsonKey(name: 'available_customer_groups')
  final List<GetTypeApplying>? customer;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'coupon_applying_on')
  final String? couponApplyingOn;
  @JsonKey(name: 'coupon_applying_on_name')
  final String? couponApplyingName;
  @JsonKey(name: 'coupon_applying_on_id')
  final int? couponApplyingId;
  @JsonKey(name: 'coupon_applying_on_code')
  final String? couponApplyingCode;
  @JsonKey(name: 'maximum_count')
  final int? maxCount;
  @JsonKey(name: 'total_value')
  final double? totalValue;
  @JsonKey(name: 'price_or_percentage')
  final double? priceOrPercentage;
  @JsonKey(name: 'based_on')
  final String? basedOn;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'offer_period_id')
  final int? offerPeriodId;

  const CouponList(   {
    this.name,
    this.offerPerodName,
    this.basedOn,
    this.isActive,
    this.updatedAt,
    this.createdBy,
    this.conditions,
    this.offerPeriodId,
    this.totalValue,
    this.isAvailableToAll,
    this.customer,
    this.image,
    this.displayName,
    this.priceOrPercentage,
    this.couponApplyingOn,
    this.canApplyMultiple,
    this.canApplyTogather,
    this.maxCount,
    this.couponType,
    this.couponApplyingCode,
    this.couponApplyingId,
    this.couponApplyingName,
    this.line,
    this.inventoryId,
    this.segments,
    this.channelId,
    this.channelCode,
    this.description,
    this.id,
    this.couponCode,
  });
  @override
  List<Object> get props => [];
  factory CouponList.fromJson(Map<String, dynamic> json) =>
      _$CouponListFromJson(json);

  Map<String, dynamic> toJson() => _$CouponListToJson(this);
}
@JsonSerializable()
class ConditionList extends Equatable {
  final int? id;
  @JsonKey(name: 'condition')
  final String? condition;


  const ConditionList( {
    this.id,
    this.condition,
  });
  @override
  List<Object> get props => [];
  factory ConditionList.fromJson(Map<String, dynamic> json) =>
      _$ConditionListFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionListToJson(this);
}

//negotiation
@JsonSerializable()
class NegotiationList extends Equatable {

  final int? id;
  @JsonKey(name: 'negotiation_code')
  final String? negotiationCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'offer_period_data')
  final OfferPeriodDetails? offerPeriodDetails;
  @JsonKey(name: 'lines')
  final List<ProductListPromotion>? lines;
  @JsonKey(name: 'segments')
  final List<GetSegmentList>? segments;
  @JsonKey(name: 'channel_id')
  final String? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'offer_period_name')
  final String? offerPerodName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_available_for_all',defaultValue: false)
  final bool? isAvailableForAll;
  @JsonKey(name: 'available_customer_groups')
  final List<GetTypeApplying>? customer;
  @JsonKey(name: 'cart_value_price_percentage')
  final List<GetCount>? cartValueList;
  @JsonKey(name: 'cart_gp_price_percentage')
  final List<GetCount>? cartGpList;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'maximum_count')
  final double? maxCount;
  @JsonKey(name: 'based_on')
  final String? basedOn;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'offer_period_id')
  final int? offerPeriodId;
  @JsonKey(name: 'offer_group_id')
  final int? offerGroupId;

  const NegotiationList(   {
    this.offerPerodName,
    this.basedOn,
    this.isActive,
    this.updatedAt,
    this.createdBy,
    this.offerPeriodId,
    this.offerGroupId,
    this.isAvailableForAll,
    this.customer,
    this.image,
    this.offerPeriodDetails,
    this.maxCount,
    this.lines,
    this.cartValueList,
    this.cartGpList,
    this.segments,
    this.channelId,
    this.channelCode,
    this.description,
    this.id,
    this.name,
    this.negotiationCode,
  });
  @override
  List<Object> get props => [];
  factory NegotiationList.fromJson(Map<String, dynamic> json) =>
      _$NegotiationListFromJson(json);

  Map<String, dynamic> toJson() => _$NegotiationListToJson(this);
}