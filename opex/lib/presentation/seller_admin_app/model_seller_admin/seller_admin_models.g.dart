// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_admin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListSeller _$CategoryListSellerFromJson(Map<String, dynamic> json) =>
    CategoryListSeller(
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      legalUnitType: json['legal_unit_type'] as int?,
    );

Map<String, dynamic> _$CategoryListSellerToJson(CategoryListSeller instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
      'legal_unit_type': instance.legalUnitType,
    };

SellerListAdmin _$SellerListAdminFromJson(Map<String, dynamic> json) =>
    SellerListAdmin(
      id: json['id'] as int?,
      businessUnitCode: json['business_unit_code'] as String?,
      categoryId: json['category_id'] as int?,
      categoryName: json['category_name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      logo: json['company_logo'] as String?,
      state: json['state'] as String?,
      location: json['location'] as String?,
      landmark: json['land_mark'] as String?,
      country: json['country'] as String?,
      addressOne: json['address_one'] as String?,
      cityortown: json['city_or_town'] as String?,
      pin: json['pin'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      displayname: json['display_name'] as String?,
      entityCode: json['code'] as String?,
      searchname: json['search_name'] as String?,
    );

Map<String, dynamic> _$SellerListAdminToJson(SellerListAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'search_name': instance.searchname,
      'display_name': instance.displayname,
      'code': instance.entityCode,
      'business_unit_code': instance.businessUnitCode,
      'email': instance.email,
      'contact': instance.contact,
      'description': instance.description,
      'state': instance.state,
      'company_logo': instance.logo,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'country': instance.country,
      'address_one': instance.addressOne,
      'location': instance.location,
      'city_or_town': instance.cityortown,
      'pin': instance.pin,
      'land_mark': instance.landmark,
      'is_active': instance.isActive,
    };

RoleModelList _$RoleModelListFromJson(Map<String, dynamic> json) =>
    RoleModelList(
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
      code: json['code'] as String?,
      role: json['role'] as String?,
      roleType: json['role_type'] as String?,
    );

Map<String, dynamic> _$RoleModelListToJson(RoleModelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_type': instance.roleType,
      'code': instance.code,
      'role': instance.role,
      'description': instance.description,
      'is_active': instance.isActive,
      'priority': instance.priority,
    };

DepartmentModelList _$DepartmentModelListFromJson(Map<String, dynamic> json) =>
    DepartmentModelList(
      id: json['id'] as int?,
      opCode: json['operaiton_code'] as String?,
      code: json['code'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      address: json['address'] as int?,
      category: json['category'] as int?,
      displayName: json['display_name'] as String?,
      title: json['title'] as String?,
      legalentity: json['legalentity'] as int?,
      name: json['name'] as String?,
      serchName: json['search_name'] as String?,
    );

Map<String, dynamic> _$DepartmentModelListToJson(
        DepartmentModelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'title': instance.title,
      'search_name': instance.serchName,
      'operaiton_code': instance.opCode,
      'display_name': instance.displayName,
      'description': instance.description,
      'is_active': instance.isActive,
      'category': instance.category,
      'legalentity': instance.legalentity,
      'address': instance.address,
    };

SellerUserModel _$SellerUserModelFromJson(Map<String, dynamic> json) =>
    SellerUserModel(
      id: json['id'] as int?,
      fname: json['fname'] as String?,
      email: json['primary_mail'] as String?,
      dirCode: json['director_code'] as String?,
      empCode: json['employee_code'] as String?,
      lname: json['lname'] as String?,
      mobile: json['primary_mobile'] as String?,
    );

Map<String, dynamic> _$SellerUserModelToJson(SellerUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'primary_mail': instance.email,
      'primary_mobile': instance.mobile,
      'fname': instance.fname,
      'lname': instance.lname,
      'employee_code': instance.empCode,
      'director_code': instance.dirCode,
    };

CountryStateModel _$CountryStateModelFromJson(Map<String, dynamic> json) =>
    CountryStateModel(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CountryStateModelToJson(CountryStateModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
      name: json['name'] as String?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

FaqList _$FaqListFromJson(Map<String, dynamic> json) => FaqList(
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => ValuesFaq.fromJson(e as Map<String, dynamic>))
          .toList(),
      tittle: json['tittle'] as String?,
    );

Map<String, dynamic> _$FaqListToJson(FaqList instance) => <String, dynamic>{
      'tittle': instance.tittle,
      'values': instance.values,
    };

ValuesFaq _$ValuesFaqFromJson(Map<String, dynamic> json) => ValuesFaq(
      description: json['description'] as String?,
      title: json['title'] as String?,
      id: json['id'] as int?,
      lastUpdated: json['last_updated'] as String?,
    );

Map<String, dynamic> _$ValuesFaqToJson(ValuesFaq instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'last_updated': instance.lastUpdated,
    };

PolicyModel _$PolicyModelFromJson(Map<String, dynamic> json) => PolicyModel(
      categoryId: json['category_id'] as int?,
      id: json['id'] as int?,
      description: json['description'] as String?,
      title: json['title'] as String?,
      lastUpdated: json['last_updated'] as String?,
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$PolicyModelToJson(PolicyModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'id': instance.id,
      'description': instance.description,
      'title': instance.title,
      'last_updated': instance.lastUpdated,
      'is_active': instance.isActive,
    };

SellerAdminDashboard _$SellerAdminDashboardFromJson(
        Map<String, dynamic> json) =>
    SellerAdminDashboard(
      activeSellers: json['active_sellers'] as int?,
      totalActiveOutlets: json['total_active_outlates'] as int?,
      totalCustomers: json['total_customers'] as String?,
      totalOrders: json['total_orders'] as String?,
      totalOutlets: json['total_outlates'] as int?,
      totalSellers: json['total_sellers'] as int?,
      completedOrders: json['completed_order'] as int?,
      cancelledItems: json['cancelled_items'] as int?,
      cancelledOrder: json['cancelled_orders'] as int?,
      deliverdOrders: json['deliverd_order'] as int?,
      newOrders: json['new_order'] as int?,
      outOfDeliveryOrder: json['out_of_delivery'] as int?,
      paymentPending: json['payment_pending'] as int?,
      returnOrders: json['return_order'] as int?,
      shippedOrders: json['shipped_order'] as int?,
    );

Map<String, dynamic> _$SellerAdminDashboardToJson(
        SellerAdminDashboard instance) =>
    <String, dynamic>{
      'total_sellers': instance.totalSellers,
      'active_sellers': instance.activeSellers,
      'total_outlates': instance.totalOutlets,
      'total_active_outlates': instance.totalActiveOutlets,
      'total_orders': instance.totalOrders,
      'total_customers': instance.totalCustomers,
      'new_order': instance.newOrders,
      'payment_pending': instance.paymentPending,
      'cancelled_orders': instance.cancelledOrder,
      'cancelled_items': instance.cancelledItems,
      'return_order': instance.returnOrders,
      'completed_order': instance.completedOrders,
      'shipped_order': instance.shippedOrders,
      'deliverd_order': instance.deliverdOrders,
      'out_of_delivery': instance.outOfDeliveryOrder,
    };

VerifyUserList _$VerifyUserListFromJson(Map<String, dynamic> json) =>
    VerifyUserList(
      code: json['code'] as String?,
      id: json['id'] as int?,
      isVerified: json['is_verified'] as bool? ?? false,
      docOne: json['document_1'] as String?,
      docTwo: json['document_2'] as String?,
      businessData: json['business_data'] == null
          ? null
          : BusinessData.fromJson(
              json['business_data'] as Map<String, dynamic>),
      status: json['status'] as String?,
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$VerifyUserListToJson(VerifyUserList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': instance.status,
      'document_1': instance.docOne,
      'document_2': instance.docTwo,
      'business_data': instance.businessData,
      'is_active': instance.isActive,
      'is_verified': instance.isVerified,
    };

BusinessData _$BusinessDataFromJson(Map<String, dynamic> json) => BusinessData(
      state: json['state'] as String?,
      email: json['business_mail'] as String?,
      name: json['business_person_name'] as String?,
      phone: json['business_phone'] as String?,
      country: json['country'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      businessName: json['business_name'] as String?,
      city: json['city'] as String?,
      taxNumber: json['tax_numner'] as String?,
    );

Map<String, dynamic> _$BusinessDataToJson(BusinessData instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'address': instance.address,
      'country': instance.country,
      'location': instance.location,
      'password': instance.password,
      'tax_numner': instance.taxNumber,
      'business_mail': instance.email,
      'business_name': instance.businessName,
      'business_phone': instance.phone,
      'business_person_name': instance.name,
    };
