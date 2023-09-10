part of 'seller_admin_bloc.dart';

abstract class SellerAdminState extends Equatable {
  const SellerAdminState();

  @override
  List<Object> get props => [];
}
class CreateSellerLoading extends SellerAdminState {}

class CreateSellerSuccess extends SellerAdminState {
  final String?  successMessage;

  const CreateSellerSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateSellerFailed extends SellerAdminState {
  final String error;

  const CreateSellerFailed(this.error);
  @override
  List<Object> get props => [];
}

//

class UpdateSellerLoading extends SellerAdminState {}

class UpdateSellerSuccess extends SellerAdminState {
  final String?  successMessage;

  const UpdateSellerSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class UpdateSellerFailed extends SellerAdminState {
  final String error;

  const UpdateSellerFailed(this.error);
  @override
  List<Object> get props => [];
}

//
class CategoryListSellerLoading extends SellerAdminState {}

class CategoryListSellerSuccess extends SellerAdminState  {
  final List<CategoryListSeller>? category;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const CategoryListSellerSuccess(
      {this.category, this.prevPageUrl, this.nextPageUrl});
}

class CategoryListSellerFailed extends SellerAdminState {
  final String msg;
  CategoryListSellerFailed(this.msg);
}


//sellerlist
class SellerListSellerLoading extends SellerAdminState {}

class SellerListSellerSuccess extends SellerAdminState  {
  final List<SellerListAdmin>? category;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const SellerListSellerSuccess(
      {this.category, this.prevPageUrl, this.nextPageUrl});
}

class SellerListSellerFailed extends SellerAdminState {
  final String msg;
  SellerListSellerFailed(this.msg);
}


//outletlist
class BusinessOutletListLoading extends SellerAdminState {}

class BusinessOutletListSuccess extends SellerAdminState  {
  final List<SellerListAdmin>? category;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const BusinessOutletListSuccess(
      {this.category, this.prevPageUrl, this.nextPageUrl});
}

class BusinessOutletListFailed extends SellerAdminState {
  final String msg;
  BusinessOutletListFailed(this.msg);
}
//createOutlet
class CreateOutletLoading extends SellerAdminState {}

class CreateOutletSuccess extends SellerAdminState {
  final String?  successMessage;

  const CreateOutletSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateOutletFailed extends SellerAdminState {
  final String error;

  const CreateOutletFailed(this.error);
  @override
  List<Object> get props => [];
}

//outletUpdate
class UpdateOutletLoading extends SellerAdminState {}

class UpdateOutletSuccess extends SellerAdminState {
  final String?  successMessage;

  const UpdateOutletSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class UpdateOutletFailed extends SellerAdminState {
  final String error;

  const UpdateOutletFailed(this.error);
  @override
  List<Object> get props => [];
}


//update org
class UpdateOrganisationLoading extends SellerAdminState {}

class UpdateOrganisationSuccess extends SellerAdminState {
  final String?  successMessage;

  const UpdateOrganisationSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class UpdateOrganisationFailed extends SellerAdminState {
  final String error;

  const UpdateOrganisationFailed(this.error);
  @override
  List<Object> get props => [];
}

//readSeller

class GetSellerReadLoading extends SellerAdminState {}

class GetSellerReadSuccess extends SellerAdminState {
  final SellerListAdmin seller;
  GetSellerReadSuccess({required this.seller});
  @override
  List<Object> get props => [seller];
}

class GetSellerReadFailed extends SellerAdminState {
  final String error;
  const GetSellerReadFailed(this.error);
}

//outletRead
class GetOutletReadLoading extends SellerAdminState {}

class GetOutletReadSuccess extends SellerAdminState {
  final SellerListAdmin seller;
  GetOutletReadSuccess({required this.seller});
  @override
  List<Object> get props => [seller];
}

class GetOutletReadFailed extends SellerAdminState {
  final String error;
  const GetOutletReadFailed(this.error);
}


//offial
class OfficialRoleListLoading extends SellerAdminState {}

class OfficialRoleListSuccess extends SellerAdminState  {
  final List<RoleModelList>? role;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const OfficialRoleListSuccess(
      {this.role, this.prevPageUrl, this.nextPageUrl});
}

class OfficialRoleListFailed extends SellerAdminState {
  final String msg;
  OfficialRoleListFailed(this.msg);
}


//userVerify
class UserVerifyListLoading extends SellerAdminState {}

class UserVerifyListSuccess extends SellerAdminState  {
  final List<VerifyUserList>? role;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const UserVerifyListSuccess(
      {this.role, this.prevPageUrl, this.nextPageUrl});
}

class UserVerifyListFailed extends SellerAdminState {
  final String msg;
  UserVerifyListFailed(this.msg);
}


//additioan
class AdditionalRoleListLoading extends SellerAdminState {}

class AdditionalRoleListSuccess extends SellerAdminState  {
  final List<RoleModelList>? role;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const AdditionalRoleListSuccess(
      {this.role, this.prevPageUrl, this.nextPageUrl});
}

class AdditionalRoleListFailed extends SellerAdminState {
  final String msg;
  AdditionalRoleListFailed(this.msg);
}

//depart
class DepartmentListLoading extends SellerAdminState {}

class DepartmentListSuccess extends SellerAdminState  {
  final List<DepartmentModelList>? department;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const DepartmentListSuccess(
      {this.department, this.prevPageUrl, this.nextPageUrl});
}

class DepartmentListFailed extends SellerAdminState {
  final String msg;
  DepartmentListFailed(this.msg);
}

//designatiok
class DesignationListLoading extends SellerAdminState {}

class DesignationListSuccess extends SellerAdminState  {
  final List<DepartmentModelList>? designation;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const DesignationListSuccess(
      {this.designation, this.prevPageUrl, this.nextPageUrl});
}

class DesignationListFailed extends SellerAdminState {
  final String msg;
  DesignationListFailed(this.msg);
}

//createDes
class CreateDesignationLoading extends SellerAdminState {}

class CreateDesignationSuccess extends SellerAdminState {
  final String?  successMessage;

  const CreateDesignationSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateDesignationFailed extends SellerAdminState {
  final String error;

  const CreateDesignationFailed(this.error);
  @override
  List<Object> get props => [];
}

//createuser
class CreateUserLoading extends SellerAdminState {}

class CreateUserSuccess extends SellerAdminState {
  final String?  successMessage;

  const CreateUserSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateUserFailed extends SellerAdminState {
  final String error;

  const CreateUserFailed(this.error);
  @override
  List<Object> get props => [];
}

//empList
class EmployeeUserListLoading extends SellerAdminState {}

class EmployeeUserListSuccess extends SellerAdminState  {
  final List<SellerUserModel>? employee;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const EmployeeUserListSuccess(
      {this.employee, this.prevPageUrl, this.nextPageUrl});
}

class EmployeeUserListFailed extends SellerAdminState {
  final String msg;
  EmployeeUserListFailed(this.msg);
}

//dirList
class DirectorUserListLoading extends SellerAdminState {}

class DirectorUserListSuccess extends SellerAdminState  {
  final List<SellerUserModel>? director;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const DirectorUserListSuccess(
      {this.director, this.prevPageUrl, this.nextPageUrl});
}

class DirectorUserListFailed extends SellerAdminState {
  final String msg;
  DirectorUserListFailed(this.msg);
}

//country
class GetCountryListLoading extends SellerAdminState {}

class GetCountryListSuccess extends SellerAdminState {
  final List<CountryStateModel> country;

  const GetCountryListSuccess(this.country);
}

class GetCountryListFailed extends SellerAdminState {}

//state
class GetStateListLoading extends SellerAdminState {}

class GetStateListSuccess extends SellerAdminState {
  final List<StateModel> state;

  const GetStateListSuccess(this.state);
}

class GetStateListFailed extends SellerAdminState {}



class UpdatePictureLoading extends SellerAdminState {}

class UpdatePictureSuccess extends SellerAdminState {
  // final String? profilePic;
  // const UpdatePictureSuccess({this.profilePic});
}

class UpdatePictureFailed extends SellerAdminState {}

//

class GetFaqListLoading extends SellerAdminState {}

class GetFaqListSuccess extends SellerAdminState {
  final List<FaqList> faqList;

  const GetFaqListSuccess(this.faqList);
}

class GetFaqListFailed extends SellerAdminState {}

//

class PolicyLoading extends SellerAdminState {}

class PolicySuccess extends SellerAdminState {
  final List<PolicyModel> policyList;

  const PolicySuccess(this.policyList);
}

class PolicyFailed extends SellerAdminState {}

//
class GetBusinessDetailsReadLoading extends SellerAdminState {}

class GetBusinessDetailsReadSuccess extends SellerAdminState {
  final SellerListAdmin seller;
  GetBusinessDetailsReadSuccess({required this.seller});
  @override
  List<Object> get props => [seller];
}

class GetBusinessDetailsReadFailed extends SellerAdminState {
  final String error;
  const GetBusinessDetailsReadFailed(this.error);
}

//dash
class GetAdminDashboardReadLoading extends SellerAdminState {}

class GetAdminDashboardReadSuccess extends SellerAdminState {
  final SellerAdminDashboard seller;
  GetAdminDashboardReadSuccess({required this.seller});
  @override
  List<Object> get props => [seller];
}

class GetAdminDashboardReadFailed extends SellerAdminState {
  final String error;
  const GetAdminDashboardReadFailed(this.error);
}


//
class AdminViewDashboardReadLoading extends SellerAdminState {}

class AdminViewDashboardReadSuccess extends SellerAdminState {
  final SellerAdminDashboard seller;
  AdminViewDashboardReadSuccess({required this.seller});
  @override
  List<Object> get props => [seller];
}

class AdminViewDashboardReadFailed extends SellerAdminState {
  final String error;
  const AdminViewDashboardReadFailed(this.error);
}

//verify
class GetVerifyUserLoading extends SellerAdminState {}

class GetVerifyUserSuccess extends SellerAdminState {
  // final SellerAdminDashboard seller;
  GetVerifyUserSuccess();
  @override
  List<Object> get props => [];
}

class GetVerifyUserFailed extends SellerAdminState {
  final String error;
  const GetVerifyUserFailed(this.error);
}