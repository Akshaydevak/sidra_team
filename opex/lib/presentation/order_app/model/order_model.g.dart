// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOrdersModel _$ListOrdersModelFromJson(Map<String, dynamic> json) =>
    ListOrdersModel(
      orderCreated: json['order_created'] as String?,
      employeeCode: json['employee_code'] as String?,
      legalEntityCode: json['legalentity_code'] as String?,
      fname: json['fname'] as String?,
      orderMeta: json['order_meta'] == null
          ? null
          : OrderMeta.fromJson(json['order_meta'] as Map<String, dynamic>),
      deliveryAddressId: json['delivery_address_id'] as String?,
      status: json['status'] as String?,
      orderCode: json['order_code'] as String?,
      lineItems: (json['line_items'] as List<dynamic>?)
          ?.map((e) => OrderLines.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderLines: (json['order_lines'] as List<dynamic>?)
          ?.map((e) => OrderLines.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderId: json['order_id'] as int?,
      createdAt: json['created_at'] as String?,
      paymentStatus: json['payment_status'] as String?,
      userId: json['user_id'] as String?,
      paymentMethod: json['payment_method'] as String?,
      orderType: json['order_type'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      email: json['email'] as String?,
      created: json['created'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
    );

Map<String, dynamic> _$ListOrdersModelToJson(ListOrdersModel instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'id': instance.id,
      'payment_status': instance.paymentStatus,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'order_created': instance.orderCreated,
      'order_id': instance.orderId,
      'payment_method': instance.paymentMethod,
      'order_type': instance.orderType,
      'order_code': instance.orderCode,
      'delivery_address_id': instance.deliveryAddressId,
      'legalentity_code': instance.legalEntityCode,
      'employee_code': instance.employeeCode,
      'order_meta': instance.orderMeta,
      'order_lines': instance.orderLines,
      'line_items': instance.lineItems,
      'total_amount': instance.totalAmount,
      'email': instance.email,
      'status': instance.status,
      'created': instance.created,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

OrderLines _$OrderLinesFromJson(Map<String, dynamic> json) => OrderLines(
      paymentStatus: json['payment_status'] as String?,
      inventoryId: json['inventory_id'] as String?,
      variantId: json['variant_id'] as String?,
      totalQty: json['total_quantity'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      orderLinesMeta: json['order_lines_meta'] == null
          ? null
          : OrderLinesMeta.fromJson(
              json['order_lines_meta'] as Map<String, dynamic>),
      status: json['status'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$OrderLinesToJson(OrderLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'variant_id': instance.variantId,
      'inventory_id': instance.inventoryId,
      'total_quantity': instance.totalQty,
      'payment_status': instance.paymentStatus,
      'order_lines_meta': instance.orderLinesMeta,
      'amount': instance.amount,
    };

OrderMeta _$OrderMetaFromJson(Map<String, dynamic> json) => OrderMeta(
      paymentId: json['payment_id'] as int?,
      customerData: json['customer_data'] == null
          ? null
          : CustomerData.fromJson(
              json['customer_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderMetaToJson(OrderMeta instance) => <String, dynamic>{
      'payment_id': instance.paymentId,
      'customer_data': instance.customerData,
    };

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
      paymentStatus: json['payment_status'] as String?,
      email: json['email'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      mobile: json['mobile'] as String?,
      variantId: json['variant_id'] as String?,
      totalQty: json['total_quantity'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      orderLinesMeta: json['order_lines_meta'] == null
          ? null
          : OrderLinesMeta.fromJson(
              json['order_lines_meta'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fname': instance.fname,
      'lname': instance.lname,
      'mobile': instance.mobile,
      'variant_id': instance.variantId,
      'total_quantity': instance.totalQty,
      'payment_status': instance.paymentStatus,
      'order_lines_meta': instance.orderLinesMeta,
      'amount': instance.amount,
    };

OrderLinesMeta _$OrderLinesMetaFromJson(Map<String, dynamic> json) =>
    OrderLinesMeta(
      deliveryData: json['delivery_data'] == null
          ? null
          : DeliveryData.fromJson(
              json['delivery_data'] as Map<String, dynamic>),
      varianCode: json['variant_code'] as String?,
      image: json['image'] as String?,
      image1: json['image1'] as String?,
      variantName: json['variant_name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderLinesMetaToJson(OrderLinesMeta instance) =>
    <String, dynamic>{
      'image': instance.image,
      'image1': instance.image1,
      'variant_name': instance.variantName,
      'variant_code': instance.varianCode,
      'delivery_data': instance.deliveryData,
      'amount': instance.amount,
    };

CreatePickingModel _$CreatePickingModelFromJson(Map<String, dynamic> json) =>
    CreatePickingModel(
      inventory: json['inventory'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      orderCode: json['order_code'] as String?,
      orderStatus: json['order_status'] as String?,
      createdBy: json['created_by'] as String?,
      lineItems: (json['line_items'] as List<dynamic>?)
          ?.map((e) => LineItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePickingModelToJson(CreatePickingModel instance) =>
    <String, dynamic>{
      'inventory': instance.inventory,
      'order_code': instance.orderCode,
      'order_status': instance.orderStatus,
      'created_by': instance.createdBy,
      'total_amount': instance.totalAmount,
      'line_items': instance.lineItems,
    };

DeliveryData _$DeliveryDataFromJson(Map<String, dynamic> json) => DeliveryData(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      notes: json['notes'] as String?,
      deliveryData: json['delivery_date'] as String?,
      deliveryDay: json['delivery_day'] as int?,
      inventory: json['inventory'] as String?,
      orderCode: json['order_code'] as String?,
      orderStatus: json['order_status'] as String?,
      createdBy: json['created_by'] as String?,
      lineItems: json['line_items'] == null
          ? null
          : LineItems.fromJson(json['line_items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeliveryDataToJson(DeliveryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'notes': instance.notes,
      'inventory': instance.inventory,
      'order_code': instance.orderCode,
      'delivery_date': instance.deliveryData,
      'delivery_day': instance.deliveryDay,
      'order_status': instance.orderStatus,
      'created_by': instance.createdBy,
      'line_items': instance.lineItems,
    };

LineItems _$LineItemsFromJson(Map<String, dynamic> json) => LineItems(
      id: json['id'] as int?,
      paymentStatus: json['payment_status'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      variantCode: json['variant_code'] as String?,
      totalQuantity: json['total_quantity'] as int?,
      status: json['status'] as String?,
      deliveryAddress: json['delivery_address'] as String?,
      deliverySlot: json['delivery_slot'] as String?,
    );

Map<String, dynamic> _$LineItemsToJson(LineItems instance) => <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'amount': instance.amount,
      'payment_status': instance.paymentStatus,
      'variant_code': instance.variantCode,
      'total_quantity': instance.totalQuantity,
      'delivery_slot': instance.deliverySlot,
      'delivery_address': instance.deliveryAddress,
    };
