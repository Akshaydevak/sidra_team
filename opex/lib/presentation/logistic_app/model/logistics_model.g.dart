// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogisticOrderModel _$LogisticOrderModelFromJson(Map<String, dynamic> json) =>
    LogisticOrderModel(
      count: json['count'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$LogisticOrderModelToJson(LogisticOrderModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
      id: json['id'] as int?,
      referanceCode: json['referance_code'] as String?,
      orderStage: json['order_stage'] as String?,
      paymentStatus: json['payment_status'] as String?,
      createdAt: json['created_at'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      updated: json['updated'] as String?,
      isDeleted: json['is_deleted'] as bool? ?? false,
      assignOrder: json['assign_order'] as int?,
      state: json['state'] as String?,
      orderLine: json['order_line'] as int?,
      orderLineData: json['order_line_data'] == null
          ? null
          : OrderLineData.fromJson(
              json['order_line_data'] as Map<String, dynamic>),
      paymentMethod: json['payment_method'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referance_code': instance.referanceCode,
      'order_stage': instance.orderStage,
      'payment_status': instance.paymentStatus,
      'created_at': instance.createdAt,
      'updated': instance.updated,
      'status': instance.status,
      'is_active': instance.isActive,
      'is_deleted': instance.isDeleted,
      'state': instance.state,
      'assign_order': instance.assignOrder,
      'order_line': instance.orderLine,
      'payment_method': instance.paymentMethod,
      'order_line_data': instance.orderLineData,
    };

OrderLineData _$OrderLineDataFromJson(Map<String, dynamic> json) =>
    OrderLineData(
      id: json['id'] as int?,
      orderIdId: json['order_id_id'] as int?,
      cartId: json['cart_id'] as int?,
      variantId: json['variant_id'] as String?,
      isSubscribe: json['is_subscribe'] as bool? ?? false,
      variantCode: json['variant_code'] as String?,
      totalQuantity: json['total_quantity'] as int?,
      inventoryId: json['inventory_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      sellerId: json['seller_id'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isApprove: json['is_approve'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      returnDate: json['return_date'] as String?,
      deleted: json['deleted'] as String?,
      orderLinesMeta: json['order_lines_meta'] == null
          ? null
          : OrderLinesMeta.fromJson(
              json['order_lines_meta'] as Map<String, dynamic>),
      deliveryAddressId: json['delivery_address_id'] as String?,
      deliverySlot: json['delivery_slot'] as String?,
      orderState: json['order_state'] as String?,
      siteName: json['site_name'] as String?,
      supplementaryAmount: (json['supplementary_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderLineDataToJson(OrderLineData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id_id': instance.orderIdId,
      'cart_id': instance.cartId,
      'variant_id': instance.variantId,
      'is_subscribe': instance.isSubscribe,
      'variant_code': instance.variantCode,
      'total_quantity': instance.totalQuantity,
      'inventory_id': instance.inventoryId,
      'amount': instance.amount,
      'status': instance.status,
      'seller_id': instance.sellerId,
      'is_active': instance.isActive,
      'is_approve': instance.isApprove,
      'created': instance.created,
      'updated': instance.updated,
      'return_date': instance.returnDate,
      'deleted': instance.deleted,
      'order_lines_meta': instance.orderLinesMeta,
      'delivery_address_id': instance.deliveryAddressId,
      'delivery_slot': instance.deliverySlot,
      'order_state': instance.orderState,
      'site_name': instance.siteName,
      'supplementary_amount': instance.supplementaryAmount,
    };

OrderLinesMeta _$OrderLinesMetaFromJson(Map<String, dynamic> json) =>
    OrderLinesMeta(
      cartData: json['cart_data'] == null
          ? null
          : CartData.fromJson(json['cart_data'] as Map<String, dynamic>),
      variantName: json['variant_name'] as String?,
      uom: json['uom'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      groupCode: json['group_code'] as String?,
      groupName: json['group_name'] as String?,
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      categoryCode: json['category_code'] as String?,
      categoryName: json['category_name'] as String?,
      selling_price: (json['selling_price'] as num?)?.toDouble(),
      shopAddress: json['shope_address'] as String?,
      inventoryCode: json['inventory_code'] as String?,
      subscribeData: json['subscribe_data'] == null
          ? null
          : SubScribeData.fromJson(
              json['subscribe_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderLinesMetaToJson(OrderLinesMeta instance) =>
    <String, dynamic>{
      'uom': instance.uom,
      'name': instance.name,
      'price': instance.price,
      'cart_data': instance.cartData,
      'group_code': instance.groupCode,
      'group_name': instance.groupName,
      'unit_price': instance.unitPrice,
      'description': instance.description,
      'variant_name': instance.variantName,
      'category_code': instance.categoryCode,
      'category_name': instance.categoryName,
      'selling_price': instance.selling_price,
      'shope_address': instance.shopAddress,
      'inventory_code': instance.inventoryCode,
      'subscribe_data': instance.subscribeData,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      addressData: json['address_data'] == null
          ? null
          : Addressdata.fromJson(json['address_data'] as Map<String, dynamic>),
      baseUom: json['base_uom'] as int?,
      groupCode: json['group_code'] as String?,
      groupName: json['group_name'] as String?,
      image1: json['image1'] as String?,
      salesUom: json['sales_uom'] as String?,
      segmentation: (json['segmentation'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryCode: json['category_code'] as String?,
      categoryName: json['category_name'] as String?,
      deliveryData: json['delivery_data'] == null
          ? null
          : DeliveryData.fromJson(
              json['delivery_data'] as Map<String, dynamic>),
      variantName: json['variant_name'] as String?,
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'image1': instance.image1,
      'base_uom': instance.baseUom,
      'sales_uom': instance.salesUom,
      'group_code': instance.groupCode,
      'group_name': instance.groupName,
      'address_data': instance.addressData,
      'segmentation': instance.segmentation,
      'variant_name': instance.variantName,
      'category_code': instance.categoryCode,
      'category_name': instance.categoryName,
      'delivery_data': instance.deliveryData,
    };

SubScribeData _$SubScribeDataFromJson(Map<String, dynamic> json) =>
    SubScribeData(
      freequancy: json['freequancy'] as String?,
      freequancyNumber: json['freequancy_number'] as int?,
      freequancytype: json['freequancy_type'] as String?,
    );

Map<String, dynamic> _$SubScribeDataToJson(SubScribeData instance) =>
    <String, dynamic>{
      'freequancy': instance.freequancy,
      'freequancy_type': instance.freequancytype,
      'freequancy_number': instance.freequancyNumber,
    };

Addressdata _$AddressdataFromJson(Map<String, dynamic> json) => Addressdata(
      id: json['id'] as int?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      updated: json['updated'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      addressTag: json['address_tag'] as String?,
      addressType: json['address_type'] as String?,
      buildingName: json['building_name'] as String?,
      buildingNo: json['building_no'] as String?,
      contact: json['contact'] as String?,
      country: json['country'] as String?,
      created: json['created'] as String?,
      fullName: json['full_name'] as String?,
      instructions: json['instructions'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
      landmark: json['landmark'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      postalCode: json['postal_code'] as String?,
      streetName: json['street_name'] as String?,
      userCode: json['user_code'] as String?,
      userLoginId: json['user_login_id'] as int?,
      divisionCode: json['division_code'] as String?,
      divisionName: json['division_name'] as String?,
    );

Map<String, dynamic> _$AddressdataToJson(Addressdata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'state': instance.state,
      'contact': instance.contact,
      'country': instance.country,
      'created': instance.created,
      'updated': instance.updated,
      'landmark': instance.landmark,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'full_name': instance.fullName,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
      'is_default': instance.isDefault,
      'user_code': instance.userCode,
      'address_tag': instance.addressTag,
      'building_no': instance.buildingNo,
      'postal_code': instance.postalCode,
      'street_name': instance.streetName,
      'address_type': instance.addressType,
      'instructions': instance.instructions,
      'building_name': instance.buildingName,
      'user_login_id': instance.userLoginId,
      'division_code': instance.divisionCode,
      'division_name': instance.divisionName,
    };

DeliveryData _$DeliveryDataFromJson(Map<String, dynamic> json) => DeliveryData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      code: json['code'] as String?,
      dateList: (json['date_list'] as List<dynamic>?)
          ?.map((e) => DateList.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryDay: json['delivery_day'] as int?,
      deliveryMonth: json['delivery_month'] as int?,
      deliveryProcess: json['delivery_process'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      deliveryYear: json['delivery_year'] as int?,
      distance: json['distance'] as int?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DeliveryDataToJson(DeliveryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'notes': instance.notes,
      'distance': instance.distance,
      'date_list': instance.dateList,
      'delivery_day': instance.deliveryDay,
      'delivery_date': instance.deliveryDate,
      'delivery_time': instance.deliveryTime,
      'delivery_year': instance.deliveryYear,
      'delivery_month': instance.deliveryMonth,
      'delivery_process': instance.deliveryProcess,
    };

DateList _$DateListFromJson(Map<String, dynamic> json) => DateList(
      id: json['id'] as int?,
      name: json['name'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      code: json['code'] as String?,
      dateList: (json['date_list'] as List<dynamic>?)
          ?.map((e) => DateList.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryDay: json['delivery_day'] as int?,
      deliveryMonth: json['delivery_month'] as int?,
      deliveryProcess: json['delivery_process'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      deliveryYear: json['delivery_year'] as int?,
      distance: json['distance'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DateListToJson(DateList instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'notes': instance.notes,
      'distance': instance.distance,
      'date_list': instance.dateList,
      'delivery_day': instance.deliveryDay,
      'delivery_date': instance.deliveryDate,
      'delivery_time': instance.deliveryTime,
      'delivery_year': instance.deliveryYear,
      'delivery_month': instance.deliveryMonth,
      'delivery_process': instance.deliveryProcess,
    };
