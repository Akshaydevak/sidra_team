// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_model_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewOrderSellerList _$GetNewOrderSellerListFromJson(
        Map<String, dynamic> json) =>
    GetNewOrderSellerList(
      id: json['id'] as int?,
      orderDate: json['order_date'] as String?,
      orderMetaSeller: json['order_meta'] == null
          ? null
          : OrderMetaSeller.fromJson(
              json['order_meta'] as Map<String, dynamic>),
      status: json['status'] as String?,
      orderStatus: json['order_status'] as String?,
      orderLines: (json['order_lines'] as List<dynamic>?)
          ?.map((e) => OrderLinesSeller.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNewOrderSellerListToJson(
        GetNewOrderSellerList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'order_status': instance.orderStatus,
      'order_date': instance.orderDate,
      'order_meta': instance.orderMetaSeller,
      'order_lines': instance.orderLines,
    };

OrderMetaSeller _$OrderMetaSellerFromJson(Map<String, dynamic> json) =>
    OrderMetaSeller(
      customerDataSeller: json['address_data'] == null
          ? null
          : CustomerDataSeller.fromJson(
              json['address_data'] as Map<String, dynamic>),
      customerName: json['customer_name'] as String?,
    );

Map<String, dynamic> _$OrderMetaSellerToJson(OrderMetaSeller instance) =>
    <String, dynamic>{
      'customer_name': instance.customerName,
      'address_data': instance.customerDataSeller,
    };

CustomerDataSeller _$CustomerDataSellerFromJson(Map<String, dynamic> json) =>
    CustomerDataSeller(
      fname: json['full_name'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      streetName: json['street_name'] as String?,
    );

Map<String, dynamic> _$CustomerDataSellerToJson(CustomerDataSeller instance) =>
    <String, dynamic>{
      'email': instance.email,
      'full_name': instance.fname,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'street_name': instance.streetName,
    };

OrderLinesSeller _$OrderLinesSellerFromJson(Map<String, dynamic> json) =>
    OrderLinesSeller(
      fname: json['fname'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$OrderLinesSellerToJson(OrderLinesSeller instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fname': instance.fname,
      'country': instance.country,
    };

VariantListModel _$VariantListModelFromJson(Map<String, dynamic> json) =>
    VariantListModel(
      name: json['name'] as String?,
      barcode: json['barcode'] == null
          ? null
          : BarcodeModel.fromJson(json['barcode'] as Map<String, dynamic>),
      id: json['id'] as int?,
      image1: json['image1'] as String?,
      code: json['code'] as String?,
      brandName: json['brand_name'] as String?,
      stockCount: json['stock_count'] as int?,
    );

Map<String, dynamic> _$VariantListModelToJson(VariantListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'image1': instance.image1,
      'stock_count': instance.stockCount,
      'brand_name': instance.brandName,
      'barcode': instance.barcode,
    };

BarcodeModel _$BarcodeModelFromJson(Map<String, dynamic> json) => BarcodeModel(
      bNumber: json['barcode_number'] as String?,
      fName: json['file_name'] as String?,
    );

Map<String, dynamic> _$BarcodeModelToJson(BarcodeModel instance) =>
    <String, dynamic>{
      'file_name': instance.fName,
      'barcode_number': instance.bNumber,
    };

SellerList _$SellerListFromJson(Map<String, dynamic> json) => SellerList(
      name: json['name'] as String?,
      code: json['business_unit_code'] as String?,
      logo: json['store_logo'] as String?,
    );

Map<String, dynamic> _$SellerListToJson(SellerList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'store_logo': instance.logo,
      'business_unit_code': instance.code,
    };
