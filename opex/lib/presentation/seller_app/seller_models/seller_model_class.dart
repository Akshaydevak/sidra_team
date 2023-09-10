import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seller_model_class.g.dart';

@JsonSerializable()
class GetNewOrderSellerList extends Equatable {
  final int? id;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'order_status')
  final String? orderStatus;
  @JsonKey(name: 'order_date')
  final String? orderDate;
  @JsonKey(name: 'order_meta')
  final OrderMetaSeller? orderMetaSeller;
  @JsonKey(name: 'order_lines')
  final List<OrderLinesSeller>? orderLines;



  const GetNewOrderSellerList( {
    this.id,
    this.orderDate,
    this.orderMetaSeller,
    this.status,
    this.orderStatus,
    this.orderLines,

  });
  @override
  List<Object> get props => [];
  factory GetNewOrderSellerList.fromJson(Map<String, dynamic> json) =>
      _$GetNewOrderSellerListFromJson(json);

  Map<String, dynamic> toJson() => _$GetNewOrderSellerListToJson(this);
}


@JsonSerializable()
class OrderMetaSeller extends Equatable {

  @JsonKey(name: 'customer_name')
  final String? customerName;
  @JsonKey(name: 'address_data')
  final CustomerDataSeller? customerDataSeller;



  const OrderMetaSeller( {
    this.customerDataSeller,
    this.customerName,

  });
  @override
  List<Object> get props => [];
  factory OrderMetaSeller.fromJson(Map<String, dynamic> json) =>
      _$OrderMetaSellerFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMetaSellerToJson(this);
}


@JsonSerializable()
class CustomerDataSeller extends Equatable {

  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'full_name')
  final String? fname;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'street_name')
  final String? streetName;



  const CustomerDataSeller( {
    this.fname,
    this.email,
    this.country,
    this.state,
    this.city,
    this.streetName,

  });
  @override
  List<Object> get props => [];
  factory CustomerDataSeller.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataSellerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataSellerToJson(this);
}



@JsonSerializable()
class OrderLinesSeller extends Equatable {

  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'fname')
  final String? fname;
  @JsonKey(name: 'country')
  final String? country;



  const OrderLinesSeller( {
    this.fname,
    this.email,
    this.country,

  });
  @override
  List<Object> get props => [];
  factory OrderLinesSeller.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesSellerFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLinesSellerToJson(this);
}


//variant
@JsonSerializable()
class VariantListModel extends Equatable {

  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image1')
  final String? image1;
  @JsonKey(name: 'stock_count')
  final int? stockCount;
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @JsonKey(name: 'barcode')
  final BarcodeModel? barcode;



  const VariantListModel( {
    this.name,
    this.barcode,
    this.id,
    this.image1,
    this.code,
    this.brandName,
    this.stockCount,

  });
  @override
  List<Object> get props => [];
  factory VariantListModel.fromJson(Map<String, dynamic> json) =>
      _$VariantListModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantListModelToJson(this);
}


@JsonSerializable()
class BarcodeModel extends Equatable {

  @JsonKey(name: 'file_name')
  final String? fName;
  @JsonKey(name: 'barcode_number')
  final String? bNumber;



  const BarcodeModel( {
    this.bNumber,
    this.fName,


  });
  @override
  List<Object> get props => [];
  factory BarcodeModel.fromJson(Map<String, dynamic> json) =>
      _$BarcodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeModelToJson(this);
}


@JsonSerializable()
class SellerList extends Equatable {

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'store_logo')
  final String? logo;
  @JsonKey(name: 'business_unit_code')
  final String? code;



  const SellerList( {
    this.name,
    this.code,
    this.logo,


  });
  @override
  List<Object> get props => [];
  factory SellerList.fromJson(Map<String, dynamic> json) =>
      _$SellerListFromJson(json);

  Map<String, dynamic> toJson() => _$SellerListToJson(this);
}