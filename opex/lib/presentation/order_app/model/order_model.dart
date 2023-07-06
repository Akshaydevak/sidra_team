import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class ListOrdersModel extends Equatable {
  final String? fname;
  final int? id;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'order_created')
  final String? orderCreated;
  @JsonKey(name: 'order_id')
  final int? orderId;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'order_type')
  final String? orderType;
  @JsonKey(name: 'order_code')
  final String? orderCode;
  @JsonKey(name: 'delivery_address_id')
  final String? deliveryAddressId;
  @JsonKey(name: 'legalentity_code')
  final String? legalEntityCode;
  @JsonKey(name: 'employee_code')
  final String? employeeCode;
  @JsonKey(name: 'order_meta')
  final OrderMeta? orderMeta;
  @JsonKey(name: 'order_lines')
  final List<OrderLines>? orderLines;
  @JsonKey(name: 'line_items')
  final List<OrderLines>? lineItems;
  @JsonKey(name: 'total_amount')
  final double? totalAmount;
  final String? email;
  final String? status;
  final String? created;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;


  const ListOrdersModel({this.orderCreated,this.employeeCode,this.legalEntityCode, this.fname,this.orderMeta,this.deliveryAddressId,this.status,this.orderCode,this.lineItems, this.orderLines,this.orderId,this.createdAt, this.paymentStatus, this.userId, this.paymentMethod, this.orderType, this.totalAmount, this.email, this.created,
    
    this.id,
    this.isActive,
    this.isDelete,
  });

  @override
  List<Object> get props => [];

  factory ListOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$ListOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListOrdersModelToJson(this);
}

@JsonSerializable()
class OrderLines extends Equatable {
  final int? id;
  final String? status;
  @JsonKey(name: 'variant_id')
  final String? variantId;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'total_quantity')
  final int? totalQty;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'order_lines_meta')
  final OrderLinesMeta? orderLinesMeta;
  final double? amount;


  const OrderLines({this.paymentStatus,this.inventoryId, this.variantId, this.totalQty, this.amount,this.orderLinesMeta,this.status,
    
    this.id,
  });

  @override
  List<Object> get props => [];

  factory OrderLines.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLinesToJson(this);
}

@JsonSerializable()
class OrderMeta extends Equatable {
  @JsonKey(name: 'payment_id')
  final int? paymentId;

  @JsonKey(name: 'customer_data')
  final CustomerData? customerData;


  const OrderMeta({this.paymentId, this.customerData
  });

  @override
  List<Object> get props => [];

  factory OrderMeta.fromJson(Map<String, dynamic> json) =>
      _$OrderMetaFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMetaToJson(this);
}



@JsonSerializable()
class CustomerData extends Equatable {
  final int? id;
  final String? email;
  final String? fname;
  final String? lname;
  final String? mobile;
  @JsonKey(name: 'variant_id')
  final String? variantId;
  @JsonKey(name: 'total_quantity')
  final int? totalQty;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'order_lines_meta')
  final OrderLinesMeta? orderLinesMeta;
  final double? amount;


  const CustomerData({this.paymentStatus, this.email, this.fname, this.lname, this.mobile,this.variantId, this.totalQty, this.amount,this.orderLinesMeta,
    
    this.id,
  });

  @override
  List<Object> get props => [];

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);
}


@JsonSerializable()
class OrderLinesMeta extends Equatable {
  final String? image;
  final String? image1;
  @JsonKey(name: 'variant_name')
  final String? variantName;
  @JsonKey(name: 'variant_code')
  final String? varianCode;
  @JsonKey(name: 'delivery_data')
  final DeliveryData? deliveryData;
  final double? amount;
  


  const OrderLinesMeta({this.deliveryData,this.varianCode, this.image, this.image1, this.variantName, this.amount,
    
  });

  @override
  List<Object> get props => [];

  factory OrderLinesMeta.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLinesMetaToJson(this);
}
@JsonSerializable()
class CreatePickingModel extends Equatable {
  final String? inventory;
  @JsonKey(name: 'order_code')
  final String? orderCode;
  @JsonKey(name: 'order_status')
  final String? orderStatus;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'total_amount')
  final double? totalAmount;

  @JsonKey(name: 'line_items')
  final List<LineItems>? lineItems;
  const CreatePickingModel({this.inventory, this.totalAmount, this.orderCode, this.orderStatus,this.createdBy,this.lineItems
  });

  @override
  List<Object> get props => [];

  factory CreatePickingModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePickingModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePickingModelToJson(this);
}
@JsonSerializable()
class DeliveryData extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? notes;

  final String? inventory;
  @JsonKey(name: 'order_code')
  final String? orderCode;
  @JsonKey(name: 'delivery_date')
  final String? deliveryData;
  @JsonKey(name: 'delivery_day')
  final int? deliveryDay;
  @JsonKey(name: 'order_status')
  final String? orderStatus;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'line_items')
  final LineItems? lineItems;
  const DeliveryData({this.id, this.code, this.name, this.notes, this.deliveryData, this.deliveryDay, this.inventory, this.orderCode, this.orderStatus,this.createdBy,this.lineItems
    
  });

  @override
  List<Object> get props => [];

  factory DeliveryData.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryDataToJson(this);
}
@JsonSerializable()
class LineItems extends Equatable {
  final String? status;
  final int? id;
  final double? amount;
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @JsonKey(name: 'variant_code')
  final String? variantCode;
  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;
  @JsonKey(name: 'delivery_slot')
  final String? deliverySlot;
  @JsonKey(name: 'delivery_address')
  final String? deliveryAddress;


  const LineItems({this.id, this.paymentStatus,this.amount, this.variantCode,this.totalQuantity, this.status,this.deliveryAddress,this.deliverySlot
    
  });

  @override
  List<Object> get props => [];

  factory LineItems.fromJson(Map<String, dynamic> json) =>
      _$LineItemsFromJson(json);

  Map<String, dynamic> toJson() => _$LineItemsToJson(this);
}