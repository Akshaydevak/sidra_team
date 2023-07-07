// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSegmentList _$GetSegmentListFromJson(Map<String, dynamic> json) =>
    GetSegmentList(
      id: json['id'] as int?,
      name: json['name'] as String?,
      segmentName: json['segment_name'] as String?,
      segmentCode: json['segment_code'] as String?,
      code: json['code'] as String?,
      image: json['image'] as String?,
      isSalesBlock: json['is_sales_blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$GetSegmentListToJson(GetSegmentList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'segment_name': instance.segmentName,
      'segment_code': instance.segmentCode,
      'image': instance.image,
      'code': instance.code,
      'is_sales_blocked': instance.isSalesBlock,
    };

GetOfferPeriod _$GetOfferPeriodFromJson(Map<String, dynamic> json) =>
    GetOfferPeriod(
      id: json['id'] as int?,
      title: json['title'] as String?,
      offerPeriodCode: json['offer_period_code'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      createdBy: json['created_by'] as String?,
      description: json['description'] as String?,
      fromTime: json['from_time'] as String?,
      toDate: json['to_date'] as String?,
      toTime: json['to_time'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      fromDate: json['from_date'] as String?,
    );

Map<String, dynamic> _$GetOfferPeriodToJson(GetOfferPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'offer_period_code': instance.offerPeriodCode,
      'from_time': instance.fromTime,
      'to_time': instance.toTime,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'description': instance.description,
      'is_active': instance.isActive,
      'notes': instance.notes,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
    };

ChannelList _$ChannelListFromJson(Map<String, dynamic> json) => ChannelList(
      id: json['id'] as int?,
      name: json['name'] as String?,
      channelCode: json['channel_code'] as String?,
    );

Map<String, dynamic> _$ChannelListToJson(ChannelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'channel_code': instance.channelCode,
    };

GetOfferGroup _$GetOfferGroupFromJson(Map<String, dynamic> json) =>
    GetOfferGroup(
      id: json['id'] as int?,
      priority: json['priority'] as int?,
      title: json['title'] as String?,
      channelCode: json['channel_code'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      channelId: json['channel_id'] as int?,
    );

Map<String, dynamic> _$GetOfferGroupToJson(GetOfferGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'channel_code': instance.channelCode,
      'channel_id': instance.channelId,
      'image': instance.image,
      'priority': instance.priority,
      'description': instance.description,
      'is_active': instance.isActive,
    };

GetDiscount _$GetDiscountFromJson(Map<String, dynamic> json) => GetDiscount(
      basedOn: (json['based_on'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      attributeType: (json['attribute_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      buyMoreTypeAppliying: (json['buy_more_applying_on'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      typeAppliying: (json['type_applying'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponAppliyingOn: (json['coupon_applying_on'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponBasedOn: (json['coupon_based_on'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      couponType: (json['coupon_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetDiscountToJson(GetDiscount instance) =>
    <String, dynamic>{
      'type_applying': instance.typeAppliying,
      'attribute_types': instance.attributeType,
      'based_on': instance.basedOn,
      'buy_more_applying_on': instance.buyMoreTypeAppliying,
      'coupon_type': instance.couponType,
      'coupon_applying_on': instance.couponAppliyingOn,
      'coupon_based_on': instance.couponBasedOn,
    };

GetTypeApplying _$GetTypeApplyingFromJson(Map<String, dynamic> json) =>
    GetTypeApplying(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      customerGroupCode: json['customer_group_code'] as String?,
      customerGroupId: json['customer_group_id'] as String?,
    );

Map<String, dynamic> _$GetTypeApplyingToJson(GetTypeApplying instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'customer_group_id': instance.customerGroupId,
      'customer_group_code': instance.customerGroupCode,
      'code': instance.code,
    };

ProductListPromotion _$ProductListPromotionFromJson(
        Map<String, dynamic> json) =>
    ProductListPromotion(
      uomName: json['uom_name'] as String?,
      negotiationLineCode: json['negotiation_line_code'] as String?,
      couponLineCode: json['coupon_line_code'] as String?,
      typeData: json['type_data'] as String?,
      couponName: json['coupon_name'] as String?,
      image: json['image1'] as String?,
      offerName: json['offer_name'] as String?,
      offerLineId: json['offer_lines_id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      discountId: json['discount_id'] as int?,
      offerProductGroupId: json['offer_products_group_id'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      variantName: json['variant_name'] as String?,
      barcode: json['barcode'] == null
          ? null
          : Barcode.fromJson(json['barcode'] as Map<String, dynamic>),
      unitCost: (json['unit_cost'] as num?)?.toDouble(),
      variantCode: json['variant_code'] as String?,
      variantId: json['variant_id'] as int?,
    );

Map<String, dynamic> _$ProductListPromotionToJson(
        ProductListPromotion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'variant_id': instance.variantId,
      'coupon_line_code': instance.couponLineCode,
      'negotiation_line_code': instance.negotiationLineCode,
      'variant_code': instance.variantCode,
      'image1': instance.image,
      'variant_name': instance.variantName,
      'name': instance.name,
      'barcode': instance.barcode,
      'unit_cost': instance.unitCost,
      'uom_name': instance.uomName,
      'is_active': instance.isActive,
      'discount_id': instance.discountId,
      'offer_products_group_id': instance.offerProductGroupId,
      'offer_lines_id': instance.offerLineId,
      'offer_name': instance.offerName,
      'coupon_name': instance.couponName,
      'type_data': instance.typeData,
    };

Barcode _$BarcodeFromJson(Map<String, dynamic> json) => Barcode(
      barcodeNumber: json['barcode_number'] as String?,
      fileName: json['file_name'] as String?,
    );

Map<String, dynamic> _$BarcodeToJson(Barcode instance) => <String, dynamic>{
      'file_name': instance.fileName,
      'barcode_number': instance.barcodeNumber,
    };

DiscountList _$DiscountListFromJson(Map<String, dynamic> json) => DiscountList(
      title: json['title'] as String?,
      basedOn: json['based_on'] as String?,
      priority: json['priority'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as String?,
      offerPeriodId: json['offer_period_id'] as int?,
      offerGroupId: json['offer_group_id'] as int?,
      offerGroupName: json['offer_group_name'] as String?,
      isAvailableForAll: json['is_available_for_all'] as bool? ?? false,
      offerPeriodDetails: json['offer_period_details'] == null
          ? null
          : OfferPeriodDetails.fromJson(
              json['offer_period_details'] as Map<String, dynamic>),
      customer: (json['available_customer_groups'] as List<dynamic>?)
          ?.map((e) => GetTypeApplying.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      discountPercentageorPrice:
          (json['discount_percentage_or_price'] as num?)?.toDouble(),
      offerLines: (json['offer_lines'] as List<dynamic>?)
          ?.map((e) => OfferLines.fromJson(e as Map<String, dynamic>))
          .toList(),
      offerPeriodName: json['offer_period_name'] as String?,
      inventoryId: json['inventory_id'] as String?,
      segments: (json['segments'] as List<dynamic>?)
          ?.map((e) => GetSegmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channel_id'] as int?,
      channelCode: json['channel_code'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      discountCode: json['discount_code'] as String?,
    );

Map<String, dynamic> _$DiscountListToJson(DiscountList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'discount_code': instance.discountCode,
      'offer_group_name': instance.offerGroupName,
      'title': instance.title,
      'priority': instance.priority,
      'offer_lines': instance.offerLines,
      'offer_period_details': instance.offerPeriodDetails,
      'offer_period_name': instance.offerPeriodName,
      'inventory_id': instance.inventoryId,
      'segments': instance.segments,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'description': instance.description,
      'is_available_for_all': instance.isAvailableForAll,
      'available_customer_groups': instance.customer,
      'image': instance.image,
      'discount_percentage_or_price': instance.discountPercentageorPrice,
      'based_on': instance.basedOn,
      'is_active': instance.isActive,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'offer_period_id': instance.offerPeriodId,
      'offer_group_id': instance.offerGroupId,
    };

OfferPeriodDetails _$OfferPeriodDetailsFromJson(Map<String, dynamic> json) =>
    OfferPeriodDetails(
      id: json['id'] as int?,
      offerPeriodId: json['offer_period_id'] as int?,
      offerPeriodName: json['offer_period_name'] as String?,
      toDate: json['to_date'] as String?,
      fromDate: json['from_date'] as String?,
      title: json['title'] as String?,
      toTime: json['to_time'] as String?,
      fromTime: json['from_time'] as String?,
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      offerPeriodCode: json['offer_period_code'] as String?,
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$OfferPeriodDetailsToJson(OfferPeriodDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_time': instance.fromTime,
      'to_time': instance.toTime,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'title': instance.title,
      'offer_period_name': instance.offerPeriodName,
      'offer_period_id': instance.offerPeriodId,
      'offer_period_code': instance.offerPeriodCode,
      'description': instance.description,
      'is_active': instance.isActive,
      'notes': instance.notes,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
    };

OfferLines _$OfferLinesFromJson(Map<String, dynamic> json) => OfferLines(
      id: json['id'] as int?,
      offerProductGroupCode: json['offer_product_group_code'] as String?,
      offerLineCode: json['offer_line_code'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      typeApplying: json['type_applying'] as String?,
      priority: json['priority'] as String?,
      typeId: json['type_id'] as int?,
      overridePriority: json['override_priority'] as bool? ?? false,
      typeCode: json['type_code'] as String?,
      maxQty: json['maximum_qty'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      offerProductGroupId: json['offer_product_group_id'] as int?,
    );

Map<String, dynamic> _$OfferLinesToJson(OfferLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'offer_product_group_code': instance.offerProductGroupCode,
      'offer_line_code': instance.offerLineCode,
      'title': instance.title,
      'image': instance.image,
      'type_applying': instance.typeApplying,
      'priority': instance.priority,
      'type_id': instance.typeId,
      'override_priority': instance.overridePriority,
      'type_code': instance.typeCode,
      'maximum_qty': instance.maxQty,
      'is_active': instance.isActive,
      'offer_product_group_id': instance.offerProductGroupId,
    };

GetCount _$GetCountFromJson(Map<String, dynamic> json) => GetCount(
      count: json['count'] as int?,
      value: json['value'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      priceOrPercentage: (json['price_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GetCountToJson(GetCount instance) => <String, dynamic>{
      'count': instance.count,
      'value': instance.value,
      'price_percentage': instance.priceOrPercentage,
      'is_active': instance.isActive,
    };

BuyMoreList _$BuyMoreListFromJson(Map<String, dynamic> json) => BuyMoreList(
      title: json['title'] as String?,
      offerPerodName: json['offer_period_name'] as String?,
      basedOn: json['based_on'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as String?,
      offerPeriodId: json['offer_period_id'] as int?,
      offerGroupId: json['offer_group_id'] as int?,
      isAvailableForAll: json['is_available_for_all'] as bool? ?? false,
      customer: (json['available_customer_groups'] as List<dynamic>?)
          ?.map((e) => GetTypeApplying.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      countList: (json['count_price_percentage'] as List<dynamic>?)
          ?.map((e) => GetCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      buyMoreAppliyingOn: json['buy_more_applying_on'] as String?,
      buyMoreAppliyingOnCode: json['buy_more_applying_on_code'] as String?,
      buyMoreAppliyingOnId: json['buy_more_applying_on_id'] as int?,
      buyMoreAppliyingOnName: json['buy_more_applying_on_name'] as String?,
      maxCount: (json['maximum_count'] as num?)?.toDouble(),
      lines: (json['lines'] as List<dynamic>?)
          ?.map((e) => ProductListPromotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventoryId: json['inventory_id'] as String?,
      segments: (json['segments'] as List<dynamic>?)
          ?.map((e) => GetSegmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channel_id'] as String?,
      channelCode: json['channel_code'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      buyMoreCode: json['buy_more_code'] as String?,
    );

Map<String, dynamic> _$BuyMoreListToJson(BuyMoreList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buy_more_code': instance.buyMoreCode,
      'title': instance.title,
      'lines': instance.lines,
      'inventory_id': instance.inventoryId,
      'segments': instance.segments,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'offer_period_name': instance.offerPerodName,
      'description': instance.description,
      'is_available_for_all': instance.isAvailableForAll,
      'available_customer_groups': instance.customer,
      'count_price_percentage': instance.countList,
      'image': instance.image,
      'buy_more_applying_on': instance.buyMoreAppliyingOn,
      'buy_more_applying_on_name': instance.buyMoreAppliyingOnName,
      'buy_more_applying_on_id': instance.buyMoreAppliyingOnId,
      'buy_more_applying_on_code': instance.buyMoreAppliyingOnCode,
      'maximum_count': instance.maxCount,
      'based_on': instance.basedOn,
      'is_active': instance.isActive,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'offer_period_id': instance.offerPeriodId,
      'offer_group_id': instance.offerGroupId,
    };

CouponList _$CouponListFromJson(Map<String, dynamic> json) => CouponList(
      name: json['name'] as String?,
      offerPerodName: json['offer_period_name'] as String?,
      basedOn: json['based_on'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as String?,
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      offerPeriodId: json['offer_period_id'] as int?,
      totalValue: (json['total_value'] as num?)?.toDouble(),
      isAvailableToAll: json['is_available_to_all'] as bool? ?? false,
      customer: (json['available_customer_groups'] as List<dynamic>?)
          ?.map((e) => GetTypeApplying.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      displayName: json['display_name'] as String?,
      priceOrPercentage: (json['price_or_percentage'] as num?)?.toDouble(),
      couponApplyingOn: json['coupon_applying_on'] as String?,
      canApplyMultiple: json['can_apply_multiple_times'] as bool? ?? false,
      canApplyTogather: json['can_apply_together'] as bool? ?? false,
      maxCount: json['maximum_count'] as int?,
      couponType: json['coupon_type'] as String?,
      couponApplyingCode: json['coupon_applying_on_code'] as String?,
      couponApplyingId: json['coupon_applying_on_id'] as int?,
      couponApplyingName: json['coupon_applying_on_name'] as String?,
      line: (json['line'] as List<dynamic>?)
          ?.map((e) => ProductListPromotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventoryId: json['inventory_id'] as String?,
      segments: (json['segments'] as List<dynamic>?)
          ?.map((e) => GetSegmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channel_id'] as String?,
      channelCode: json['channel_code'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      couponCode: json['coupon_code'] as String?,
    );

Map<String, dynamic> _$CouponListToJson(CouponList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coupon_code': instance.couponCode,
      'name': instance.name,
      'conditions': instance.conditions,
      'display_name': instance.displayName,
      'coupon_type': instance.couponType,
      'line': instance.line,
      'inventory_id': instance.inventoryId,
      'segments': instance.segments,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'offer_period_name': instance.offerPerodName,
      'description': instance.description,
      'is_available_to_all': instance.isAvailableToAll,
      'can_apply_multiple_times': instance.canApplyMultiple,
      'can_apply_together': instance.canApplyTogather,
      'available_customer_groups': instance.customer,
      'image': instance.image,
      'coupon_applying_on': instance.couponApplyingOn,
      'coupon_applying_on_name': instance.couponApplyingName,
      'coupon_applying_on_id': instance.couponApplyingId,
      'coupon_applying_on_code': instance.couponApplyingCode,
      'maximum_count': instance.maxCount,
      'total_value': instance.totalValue,
      'price_or_percentage': instance.priceOrPercentage,
      'based_on': instance.basedOn,
      'is_active': instance.isActive,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'offer_period_id': instance.offerPeriodId,
    };

ConditionList _$ConditionListFromJson(Map<String, dynamic> json) =>
    ConditionList(
      id: json['id'] as int?,
      condition: json['condition'] as String?,
    );

Map<String, dynamic> _$ConditionListToJson(ConditionList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'condition': instance.condition,
    };

NegotiationList _$NegotiationListFromJson(Map<String, dynamic> json) =>
    NegotiationList(
      offerPerodName: json['offer_period_name'] as String?,
      basedOn: json['based_on'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as String?,
      offerPeriodId: json['offer_period_id'] as int?,
      offerGroupId: json['offer_group_id'] as int?,
      isAvailableForAll: json['is_available_for_all'] as bool? ?? false,
      customer: (json['available_customer_groups'] as List<dynamic>?)
          ?.map((e) => GetTypeApplying.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      offerPeriodDetails: json['offer_period_data'] == null
          ? null
          : OfferPeriodDetails.fromJson(
              json['offer_period_data'] as Map<String, dynamic>),
      maxCount: (json['maximum_count'] as num?)?.toDouble(),
      lines: (json['lines'] as List<dynamic>?)
          ?.map((e) => ProductListPromotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartValueList: (json['cart_value_price_percentage'] as List<dynamic>?)
          ?.map((e) => GetCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartGpList: (json['cart_gp_price_percentage'] as List<dynamic>?)
          ?.map((e) => GetCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      segments: (json['segments'] as List<dynamic>?)
          ?.map((e) => GetSegmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channel_id'] as String?,
      channelCode: json['channel_code'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      negotiationCode: json['negotiation_code'] as String?,
    );

Map<String, dynamic> _$NegotiationListToJson(NegotiationList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'negotiation_code': instance.negotiationCode,
      'name': instance.name,
      'offer_period_data': instance.offerPeriodDetails,
      'lines': instance.lines,
      'segments': instance.segments,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'offer_period_name': instance.offerPerodName,
      'description': instance.description,
      'is_available_for_all': instance.isAvailableForAll,
      'available_customer_groups': instance.customer,
      'cart_value_price_percentage': instance.cartValueList,
      'cart_gp_price_percentage': instance.cartGpList,
      'image': instance.image,
      'maximum_count': instance.maxCount,
      'based_on': instance.basedOn,
      'is_active': instance.isActive,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'offer_period_id': instance.offerPeriodId,
      'offer_group_id': instance.offerGroupId,
    };
