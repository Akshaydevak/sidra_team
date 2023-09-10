import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../organisation/model/org_model.dart';

part 'seller_admin_models.g.dart';

@JsonSerializable()
class CategoryListSeller extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'legal_unit_type')
  final int? legalUnitType;



  const CategoryListSeller( {
    this.id,
    this.isActive,
    this.description,
    this.name,
    this.code,
    this.legalUnitType,


  });
  @override
  List<Object> get props => [];
  factory CategoryListSeller.fromJson(Map<String, dynamic> json) =>
      _$CategoryListSellerFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListSellerToJson(this);
}


@JsonSerializable()
class SellerListAdmin extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'search_name')
  final String? searchname;
  @JsonKey(name: 'display_name')
  final String? displayname;
  @JsonKey(name: 'code')
  final String? entityCode;
  @JsonKey(name: 'business_unit_code')
  final String? businessUnitCode;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'contact')
  final Contact? contact;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'company_logo')
  final String? logo;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'address_one')
  final String? addressOne;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'city_or_town')
  final String? cityortown;
  @JsonKey(name: 'pin')
  final String? pin;
  @JsonKey(name: 'land_mark')
  final String? landmark;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;

  const SellerListAdmin( {
    this.id,
    this.businessUnitCode,
    this.categoryId,
    this.categoryName,
    this.isActive,
    this.logo,
    this.state,
    this.location,
    this.landmark,
    this.country,
    this.addressOne,
    this.cityortown,
    this.pin,
    this.description,
    this.name,
    this.email,
    this.contact,
    this.displayname,
    this.entityCode,
    this.searchname,


  });
  @override
  List<Object> get props => [];
  factory SellerListAdmin.fromJson(Map<String, dynamic> json) =>
      _$SellerListAdminFromJson(json);

  Map<String, dynamic> toJson() => _$SellerListAdminToJson(this);
}


///rolemodel

@JsonSerializable()
class RoleModelList extends Equatable {
  final int? id;
  @JsonKey(name: 'role_type')
  final String? roleType;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'priority')
  final int? priority;



  const RoleModelList( {
    this.id,
    this.isActive,
    this.description,
    this.priority,
    this.code,
    this.role,
    this.roleType,


  });
  @override
  List<Object> get props => [];
  factory RoleModelList.fromJson(Map<String, dynamic> json) =>
      _$RoleModelListFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelListToJson(this);
}


//departmebt
@JsonSerializable()
class DepartmentModelList extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'search_name')
  final String? serchName;
  @JsonKey(name: 'operaiton_code')
  final String? opCode;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'category')
  final int? category;
  @JsonKey(name: 'legalentity')
  final int? legalentity;
  @JsonKey(name: 'address')
  final int? address;



  const DepartmentModelList({
    this.id,
    this.opCode,
    this.code,
    this.isActive,
    this.description,
    this.address,
    this.category,
    this.displayName,
    this.title,
    this.legalentity,
    this.name,
    this.serchName,


  });
  @override
  List<Object> get props => [];
  factory DepartmentModelList.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelListFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelListToJson(this);
}


//user

@JsonSerializable()
class SellerUserModel extends Equatable {
  final int? id;
  @JsonKey(name: 'primary_mail')
  final String? email;
  @JsonKey(name: 'primary_mobile')
  final String? mobile;
  @JsonKey(name: 'fname')
  final String? fname;
  @JsonKey(name: 'lname')
  final String? lname;
  @JsonKey(name: 'employee_code')
  final String? empCode;
  @JsonKey(name: 'director_code')
  final String? dirCode;




  const SellerUserModel({
    this.id,
    this.fname,
    this.email,
    this.dirCode,
    this.empCode,
    this.lname,
    this.mobile,


  });
  @override
  List<Object> get props => [];
  factory SellerUserModel.fromJson(Map<String, dynamic> json) =>
      _$SellerUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SellerUserModelToJson(this);
}


//country
@JsonSerializable()
class CountryStateModel extends Equatable {

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;

  const CountryStateModel({
    this.name,
    this.code,
  });
  @override
  List<Object> get props => [];
  factory CountryStateModel.fromJson(Map<String, dynamic> json) =>
      _$CountryStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryStateModelToJson(this);
}


//state
@JsonSerializable()
class StateModel extends Equatable {

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'name')
  final String? name;

  const StateModel({
    this.name,
    this.code,
  });
  @override
  List<Object> get props => [];
  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}


//

@JsonSerializable()
class FaqList extends Equatable {

  @JsonKey(name: 'tittle')
  final String? tittle;
  @JsonKey(name: 'values')
  final List<ValuesFaq>? values;


  FaqList({
    this.values,
    this.tittle
  });

  @override
  List<Object> get props => [];

  factory FaqList.fromJson(Map<String, dynamic> json) => _$FaqListFromJson(json);

  Map<String, dynamic> toJson() => _$FaqListToJson(this);
}

@JsonSerializable()
class ValuesFaq extends Equatable {

  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;



  ValuesFaq({
    this.description,
    this.title,
    this.id,this.lastUpdated
  });

  @override
  List<Object> get props => [];

  factory ValuesFaq.fromJson(Map<String, dynamic> json) => _$ValuesFaqFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesFaqToJson(this);
}

//
@JsonSerializable()
class PolicyModel extends Equatable {
  @JsonKey(name: 'category_id')
  final int? categoryId;
  final int? id;
  final String? description;
  final String? title;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;

  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  PolicyModel({
    this.categoryId,
    this.id,
    this.description,
    this.title,
    this.lastUpdated,
    this.isActive,
  });
  @override
  List<Object> get props => [];

  factory PolicyModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyModelToJson(this);
}
//
@JsonSerializable()
class SellerAdminDashboard extends Equatable {

  @JsonKey(name: 'total_sellers')
  final int? totalSellers;
   @JsonKey(name: 'active_sellers')
  final int? activeSellers;
   @JsonKey(name: 'total_outlates')
  final int? totalOutlets;
   @JsonKey(name: 'total_active_outlates')
  final int? totalActiveOutlets;
   @JsonKey(name: 'total_orders')
  final String? totalOrders;
   @JsonKey(name: 'total_customers')
  final String? totalCustomers;
  @JsonKey(name: 'new_order')
  final int? newOrders;
  @JsonKey(name: 'payment_pending')
  final int? paymentPending;
  @JsonKey(name: 'cancelled_orders')
  final int? cancelledOrder;
  @JsonKey(name: 'cancelled_items')
  final int? cancelledItems;
  @JsonKey(name: 'return_order')
  final int? returnOrders;
  @JsonKey(name: 'completed_order')
  final int? completedOrders;
  @JsonKey(name: 'shipped_order')
  final int? shippedOrders;
  @JsonKey(name: 'deliverd_order')
  final int? deliverdOrders;
  @JsonKey(name: 'out_of_delivery')
  final int? outOfDeliveryOrder;

  const SellerAdminDashboard({
    this.activeSellers,
    this.totalActiveOutlets,
    this.totalCustomers,
    this.totalOrders,
    this.totalOutlets,
    this.totalSellers,
    this.completedOrders,
    this.cancelledItems,
    this.cancelledOrder,
    this.deliverdOrders,
    this.newOrders,
    this.outOfDeliveryOrder,
    this.paymentPending,
    this.returnOrders,
    this.shippedOrders,
  });
  @override
  List<Object> get props => [];
  factory SellerAdminDashboard.fromJson(Map<String, dynamic> json) =>
      _$SellerAdminDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$SellerAdminDashboardToJson(this);
}

//verify
@JsonSerializable()
class VerifyUserList extends Equatable {

  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'document_1')
  final String? docOne;
  @JsonKey(name: 'document_2')
  final String? docTwo;
  @JsonKey(name: 'business_data')
  final BusinessData? businessData;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_verified', defaultValue: false)
  final bool? isVerified;
  VerifyUserList({
    this.code,
    this.id,
    this.isVerified,
    this.docOne,
    this.docTwo,
    this.businessData,
    this.status,
    this.isActive,
  });
  @override
  List<Object> get props => [];

  factory VerifyUserList.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserListFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyUserListToJson(this);
}


//business
@JsonSerializable()
class BusinessData extends Equatable {

  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'tax_numner')
  final String? taxNumber;
  @JsonKey(name: 'business_mail')
  final String? email;
  @JsonKey(name: 'business_name')
  final String? businessName;
  @JsonKey(name: 'business_phone')
  final String? phone;
  @JsonKey(name: 'business_person_name')
  final String? name;
  BusinessData({
    this.state,
    this.email,
    this.name,
    this.phone,
    this.country,
    this.location,
    this.address,
    this.password,
    this.businessName,
    this.city,
    this.taxNumber,
  });
  @override
  List<Object> get props => [];

  factory BusinessData.fromJson(Map<String, dynamic> json) =>
      _$BusinessDataFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessDataToJson(this);
}