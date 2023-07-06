import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logistics_model.g.dart';

@JsonSerializable()
class LogisticOrderModel extends Equatable {
  final String? count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<ResultModel>? results;

  LogisticOrderModel({this.count, this.results, this.next, this.previous});

  @override
  List<Object> get props => [];

  factory LogisticOrderModel.fromJson(Map<String, dynamic> json) =>
      _$LogisticOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogisticOrderModelToJson(this);
}

@JsonSerializable()
class ResultModel extends Equatable {
  final int? id;
  @JsonKey(name: 'referance_code')
  final String? referanceCode;
  @JsonKey(name: 'order_stage')
  final String? orderStage;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final String? updated;
  final String? status;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_deleted', defaultValue: false)
  final bool? isDeleted;
  final String? state;
  @JsonKey(name: 'assign_order')
  final int? assignOrder;
  @JsonKey(name: 'order_line')
  final int? orderLine;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'order_line_data')
  final OrderLineData? orderLineData;

  ResultModel(
      {this.id,
      this.referanceCode,
      this.orderStage,
      this.paymentStatus,
      this.createdAt,
      this.isActive,
      this.updated,
      this.isDeleted,
      this.assignOrder,
      this.state,
      this.orderLine,
      this.orderLineData,this.paymentMethod,this.status});

  @override
  List<Object> get props => [];

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}

@JsonSerializable()
class OrderLineData extends Equatable {
  final int? id;
  @JsonKey(name: 'order_id_id')
  final int? orderIdId;
  @JsonKey(name: 'cart_id')
  final int? cartId;
  @JsonKey(name: 'variant_id')
  final String? variantId;
  @JsonKey(name: 'is_subscribe', defaultValue: false)
  final bool? isSubscribe;
  @JsonKey(name: 'variant_code')
  final String? variantCode;
  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  final double? amount;
  final String? status;
  @JsonKey(name: 'seller_id')
  final String? sellerId;
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool? isActive;
  @JsonKey(name: 'is_approve')
  final String? isApprove;
  final String? created;
  final String? updated;
  @JsonKey(name: 'return_date')
  final String? returnDate;
  final String? deleted;
  @JsonKey(name: 'order_lines_meta')
  final OrderLinesMeta? orderLinesMeta;
  @JsonKey(name: 'delivery_address_id')
  final String? deliveryAddressId;
  @JsonKey(name: 'delivery_slot')
  final String? deliverySlot;
  @JsonKey(name: 'order_state')
  final String? orderState;
  @JsonKey(name: 'site_name')
  final String? siteName;
  @JsonKey(name: 'supplementary_amount')
  final double? supplementaryAmount;

  OrderLineData({
    this.id,
    this.orderIdId,
    this.cartId,
    this.variantId,
    this.isSubscribe,
    this.variantCode,
    this.totalQuantity,
    this.inventoryId,
    this.amount,
    this.status,
    this.sellerId,
    this.isActive,
    this.isApprove,
    this.created,
    this.updated,
    this.returnDate,
    this.deleted,
    this.orderLinesMeta,
    this.deliveryAddressId,
    this.deliverySlot,
    this.orderState,
    this.siteName,
    this.supplementaryAmount,
  });

  @override
  List<Object> get props => [];

  factory OrderLineData.fromJson(Map<String, dynamic> json) =>
      _$OrderLineDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineDataToJson(this);
}

@JsonSerializable()
class OrderLinesMeta extends Equatable {
  final String? uom;
  final String? name;
  final double? price;
  @JsonKey(name: "cart_data")
  final CartData? cartData;
  @JsonKey(name: "group_code")
  final String? groupCode;
  @JsonKey(name: "group_name")
  final String? groupName;
  @JsonKey(name: "unit_price")
  final double? unitPrice;
  final String? description;
  @JsonKey(name: "variant_name")
  final String? variantName;
  @JsonKey(name: "category_code")
  final String? categoryCode;
  @JsonKey(name: "category_name")
  final String? categoryName;
  @JsonKey(name: "selling_price")
  final double? selling_price;
  @JsonKey(name: "shope_address")
  final String? shopAddress;
  @JsonKey(name: "inventory_code")
  final String? inventoryCode;
  @JsonKey(name: "subscribe_data")
  final SubScribeData? subscribeData;


  OrderLinesMeta({this.cartData,this.variantName,this.uom, this.name, this.price, this.groupCode, this.groupName, this.unitPrice, this.description, this.categoryCode, this.categoryName, this.selling_price, this.shopAddress, this.inventoryCode, this.subscribeData, });

  @override
  List<Object> get props => [];

  factory OrderLinesMeta.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLinesMetaToJson(this);
}

@JsonSerializable()
class CartData extends Equatable {
  final String? image1;
  @JsonKey(name: 'base_uom')
  final int? baseUom;
  @JsonKey(name: 'sales_uom')
  final String? salesUom;
  @JsonKey(name: 'group_code')
  final String? groupCode;
  @JsonKey(name: 'group_name')
  final String? groupName;
  @JsonKey(name: 'address_data')
  final Addressdata? addressData;
  final List<String>? segmentation;
  @JsonKey(name: 'variant_name')
  final String? variantName;
  @JsonKey(name: 'category_code')
  final String? categoryCode;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @JsonKey(name: 'delivery_data')
  final DeliveryData? deliveryData;

  CartData(
      {this.addressData,
      this.baseUom,
      this.groupCode,
      this.groupName,
      this.image1,
      this.salesUom,
      this.segmentation,
      this.categoryCode,
      this.categoryName,
      this.deliveryData,
      this.variantName});

  @override
  List<Object> get props => [];

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}
@JsonSerializable()
class SubScribeData extends Equatable {
  final String? freequancy;
  @JsonKey(name: 'freequancy_type')
  final String? freequancytype;
  @JsonKey(name: 'freequancy_number')
  final int? freequancyNumber;


  SubScribeData(
      {this.freequancy,this.freequancyNumber,this.freequancytype
     });

  @override
  List<Object> get props => [];

  factory SubScribeData.fromJson(Map<String, dynamic> json) =>
      _$SubScribeDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubScribeDataToJson(this);
}

@JsonSerializable()
class Addressdata extends Equatable {
  final int? id;
  final String? city;
  final String? state;
  final String? contact;
  final String? country;
  final String? created;
  final String? updated;
  final String? landmark;
  final String? latitude;
  final String? longitude;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'is_default', defaultValue: false)
  final bool? isDefault;
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'address_tag')
  final String? addressTag;
  @JsonKey(name: 'building_no')
  final String? buildingNo;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @JsonKey(name: 'street_name')
  final String? streetName;
  @JsonKey(name: 'address_type')
  final String? addressType;
  final String? instructions;
  @JsonKey(name: 'building_name')
  final String? buildingName;
  @JsonKey(name: 'user_login_id')
  final int? userLoginId;
  @JsonKey(name: 'division_code')
  final String? divisionCode;
  @JsonKey(name: 'division_name')
  final String? divisionName;

  Addressdata(
      {this.id,
      this.city,
      this.state,
      this.updated,
      this.isActive,
      this.addressTag,
      this.addressType,
      this.buildingName,
      this.buildingNo,
      this.contact,
      this.country,
      this.created,
      this.fullName,
      this.instructions,
      this.isDefault,
      this.isDelete,
      this.landmark,
      this.latitude,
      this.longitude,
      this.postalCode,
      this.streetName,
      this.userCode,
      this.userLoginId,
      this.divisionCode,
      this.divisionName});

  @override
  List<Object> get props => [];

  factory Addressdata.fromJson(Map<String, dynamic> json) =>
      _$AddressdataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressdataToJson(this);
}

@JsonSerializable()
class DeliveryData extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? notes;
  final int? distance;
  @JsonKey(name: 'date_list')
  final List<DateList>? dateList;
  @JsonKey(name: 'delivery_day')
  final int? deliveryDay;
  @JsonKey(name: 'delivery_date')
  final String? deliveryDate;
  @JsonKey(name: 'delivery_time')
  final String? deliveryTime;
  @JsonKey(name: 'delivery_year')
  final int? deliveryYear;
  @JsonKey(name: 'delivery_month')
  final int? deliveryMonth;
  @JsonKey(name: 'delivery_process')
  final String? deliveryProcess;

  DeliveryData(
      {this.id,
      this.name,
      this.deliveryDate,
      this.code,
      this.dateList,
      this.deliveryDay,
      this.deliveryMonth,
      this.deliveryProcess,
      this.deliveryTime,
      this.deliveryYear,
      this.distance,
      this.notes});

  @override
  List<Object> get props => [];

  factory DeliveryData.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryDataToJson(this);
}
@JsonSerializable()
class DateList extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? notes;
  final String? distance;
  @JsonKey(name: 'date_list')
  final List<DateList>? dateList;
  @JsonKey(name: 'delivery_day')
  final int? deliveryDay;
  @JsonKey(name: 'delivery_date')
  final String? deliveryDate;
  @JsonKey(name: 'delivery_time')
  final String? deliveryTime;
  @JsonKey(name: 'delivery_year')
  final int? deliveryYear;
  @JsonKey(name: 'delivery_month')
  final int? deliveryMonth;
  @JsonKey(name: 'delivery_process')
  final String? deliveryProcess;

  DateList(
      {this.id,
      this.name,
      this.deliveryDate,
      this.code,
      this.dateList,
      this.deliveryDay,
      this.deliveryMonth,
      this.deliveryProcess,
      this.deliveryTime,
      this.deliveryYear,
      this.distance,
      this.notes});

  @override
  List<Object> get props => [];

  factory DateList.fromJson(Map<String, dynamic> json) =>
      _$DateListFromJson(json);

  Map<String, dynamic> toJson() => _$DateListToJson(this);
}
