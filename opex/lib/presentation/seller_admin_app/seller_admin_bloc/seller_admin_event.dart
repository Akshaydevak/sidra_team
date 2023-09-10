part of 'seller_admin_bloc.dart';


abstract class SellerAdminEvent extends Equatable {
  const SellerAdminEvent();

  @override
  List<Object> get props => [];

}

class NewSellerCreateEvent extends SellerAdminEvent {
  final String address;
  final String location;
  final String country;
  final String state;
  final String cityorTown;
  final String landmark;
  final String postalCode;
  final String phone;
  final String email;
  final int? userId;
  final String name;
  final String searchName;
  final String displayName;
  final String discription;
  final bool isActive;
  final int category;
  NewSellerCreateEvent( {
    required this.name,
    required this.state,
    required this.discription,
    required this.country,
    required this.email,
    required this.isActive,
    required this.address,
    required this.category,
    required this.cityorTown,
    required this.displayName,
    required this.landmark,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.searchName,
    required this.userId,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

//update
class NewSellerUpdateEvent extends SellerAdminEvent {
  final String address;
  final String location;
  final String country;
  final String state;
  final String cityorTown;
  final String landmark;
  final String postalCode;
  final String phone;
  final String email;
  final int? userId;
  final String name;
  final String searchName;
  final String displayName;
  final String discription;
  final bool isActive;
  final int category;
  final int id;
  NewSellerUpdateEvent( {
    required this.name,
    required this.state,
    required this.discription,
    required this.country,
    required this.email,
    required this.isActive,
    required this.address,
    required this.category,
    required this.cityorTown,
    required this.displayName,
    required this.landmark,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.searchName,
    required this.userId,
    required this.id,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

class CategoryListSellerEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const CategoryListSellerEvent(this.search, this.next, this.prev);
}

class SellerListSellerEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  final String? filter;
  const SellerListSellerEvent(this.search, this.next, this.prev,this.filter);
}

class BusinessOutletListEvent extends SellerAdminEvent {
  final String? id;
  final String? search;
  final String? next;
  final String? prev;
  const BusinessOutletListEvent(this.id,this.search, this.next, this.prev);
}

//newoutlet
class NewOutletCreateEvent extends SellerAdminEvent {
  final String address;
  final String location;
  final String country;
  final String state;
  final String cityorTown;
  final String landmark;
  final String postalCode;
  final String phone;
  final String email;
  final String? userId;
  final String name;
  final String searchName;
  final String displayName;
  final String discription;
  final String legalCode;
  final int category;
  NewOutletCreateEvent( {
    required this.name,
    required this.state,
    required this.discription,
    required this.country,
    required this.email,
    required this.legalCode,
    required this.address,
    required this.category,
    required this.cityorTown,
    required this.displayName,
    required this.landmark,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.searchName,
    required this.userId,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

//outletUpdate
class OutletUpdateEvent extends SellerAdminEvent {
  final String address;
  final String location;
  final String country;
  final String state;
  final String cityorTown;
  final String landmark;
  final String postalCode;
  final String phone;
  final String email;
  final String? userId;
  final String name;
  final String searchName;
  final String displayName;
  final String discription;
  final String legalCode;
  final int category;
  final int id;
  OutletUpdateEvent( {
    required this.id,
    required this.name,
    required this.state,
    required this.discription,
    required this.country,
    required this.email,
    required this.legalCode,
    required this.address,
    required this.category,
    required this.cityorTown,
    required this.displayName,
    required this.landmark,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.searchName,
    required this.userId,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

//updateOrganisation
class OrgUpdateEvent extends SellerAdminEvent {
  final String address;
  final String location;
  final String country;
  final String state;
  final String cityorTown;
  final String landmark;
  final String postalCode;
  final String phone;
  final String? phoneTwo;
  final String email;
  final String? userId;
  final String name;
  final String searchName;
  final String displayName;
  final String discription;
  final int? parentId;
  final int categoryId;
  final int id;
  OrgUpdateEvent( {
    required this.id,
    required this.name,
    required this.state,
    required this.phoneTwo,
    required this.discription,
    required this.country,
    required this.email,
    required this.categoryId,
    required this.address,
    required this.parentId,
    required this.cityorTown,
    required this.displayName,
    required this.landmark,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.searchName,
    required this.userId,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetSellerRead extends SellerAdminEvent {
  final int id;
  const GetSellerRead(this.id);
  @override
  List<Object> get props => [this.id];
}

//outletRead
class GetOutletRead extends SellerAdminEvent {
  final int id;
  const GetOutletRead(this.id);
  @override
  List<Object> get props => [this.id];
}

//
class OfficialRoleListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const OfficialRoleListEvent(this.search, this.next, this.prev);
}

class AdditionalRoleListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const AdditionalRoleListEvent(this.search, this.next, this.prev);
}

class DepartmentListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const DepartmentListEvent(this.search, this.next, this.prev);
}

class DesignationListEvent extends SellerAdminEvent {
  final String? code;
  final String? search;
  final String? next;
  final String? prev;
  const DesignationListEvent(this.code,this.search, this.next, this.prev);
}

class CreateDesignationEvent extends SellerAdminEvent {
  final String title;
  final String description;
  final String department;
  final String legalEntity;

  CreateDesignationEvent( {
    required this.department,
    required this.legalEntity,
    required this.description,
    required this.title,

  });
  @override
  List<Object> get props => [
    title,
  ];
}

//create User
class CreateUserEvent extends SellerAdminEvent {
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String gender;
  final String nationality;
  final String department;
  final String password;
  final String designation;
  final int? officialRole;
  final List<int>? additionalRole;
  final String businessCode;
  final String entityCode;

  CreateUserEvent( {
    required this.department,
    required this.email,
    required this.designation,
    required this.additionalRole,
    required this.businessCode,
    required this.fName,
    required this.gender,
    required this.lName,
    required this.nationality,
    required this.officialRole,
    required this.password,
    required this.phone,
    required this.entityCode,

  });
  @override
  List<Object> get props => [
    fName,
  ];
}


//emplist
class EmployeeUserListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const EmployeeUserListEvent(this.search, this.next, this.prev);
}

//dirUser
class DirectorUserListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const DirectorUserListEvent(this.search, this.next, this.prev);
}

//countrylist
class CountryListEvent extends SellerAdminEvent {

  const CountryListEvent();
}

//statelist
class StateListEvent extends SellerAdminEvent {
  final String? code;
  const StateListEvent(this.code);
}

//
class UpdateSellerPictureEvent extends SellerAdminEvent {
  final File image;
  final int? sellerId;
  const UpdateSellerPictureEvent(this.image, this.sellerId);
}

//
class GetFaqListEvent extends SellerAdminEvent {
  final String? search;
  const GetFaqListEvent(this.search);
}


//
class GetPolicyEvent extends SellerAdminEvent {}

//
class GetBusinessDetailsRead extends SellerAdminEvent {}
//
class GetAdminDashboardRead extends SellerAdminEvent {}

class SellerAdminViewDashboard extends SellerAdminEvent {}

//verifylist
class UserVerifyListEvent extends SellerAdminEvent {
  final String? search;
  final String? next;
  final String? prev;
  const UserVerifyListEvent(this.search, this.next, this.prev);
}

//verfify
class VerifyUserEvent extends SellerAdminEvent {
  final String? code;
  final bool? reject;
  const VerifyUserEvent(this.code, this.reject);
}