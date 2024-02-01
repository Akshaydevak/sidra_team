part of 'organisation_task_bloc.dart';

abstract class OrganisationTaskState extends Equatable {
  const OrganisationTaskState();

  @override
  List<Object> get props => [];
}
class CreateDepartmentTaskLoading extends OrganisationTaskState {}

class CreateDepartmentTaskSuccess extends OrganisationTaskState {
  final String?  successMessage;

  const CreateDepartmentTaskSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateDepartmentTaskFailed extends OrganisationTaskState {
  final String error;

  const CreateDepartmentTaskFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class DepartmentTaskReadLoading extends OrganisationTaskState {}

class DepartmentTaskReadSuccess extends OrganisationTaskState {
  final DepartmentTaskModel readData;
  DepartmentTaskReadSuccess({required this.readData});
  @override
  List<Object> get props => [readData];
}

class DepartmentTaskReadFailed extends OrganisationTaskState {
  final String error;
  const DepartmentTaskReadFailed(this.error);
}
//deleteDiscount

class DeleteDepartmentTaskLoading extends OrganisationTaskState {}

class DeleteDepartmentTaskSuccess extends OrganisationTaskState {}

class DeleteDepartmentTaskFailed extends OrganisationTaskState {}

//updateDiscount

class DepartmentTaskUpdateLoading extends OrganisationTaskState {}

class DepartmentTaskUpdateSuccess extends OrganisationTaskState {
  final String?  successMessage;

  const DepartmentTaskUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class DepartmentTaskUpdateFailed extends OrganisationTaskState {
  final String error;

  const DepartmentTaskUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class DepartmentTaskListLoading extends OrganisationTaskState {}

class DepartmentTaskListSuccess extends OrganisationTaskState  {
  final List<DepartmentTaskModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const DepartmentTaskListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class DepartmentTaskListFailed extends OrganisationTaskState {
  final String msg;
  DepartmentTaskListFailed(this.msg);
}

//role
class CreateDepartmentRoleTaskLoading extends OrganisationTaskState {}

class CreateDepartmentRoleTaskSuccess extends OrganisationTaskState {
  final String?  successMessage;

  const CreateDepartmentRoleTaskSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateDepartmentRoleTaskFailed extends OrganisationTaskState {
  final String error;

  const CreateDepartmentRoleTaskFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class DepartmentRoleTaskReadLoading extends OrganisationTaskState {}

class DepartmentRoleTaskReadSuccess extends OrganisationTaskState {
  final DepartmentTaskModel readData;
  DepartmentRoleTaskReadSuccess({required this.readData});
  @override
  List<Object> get props => [readData];
}

class DepartmentRoleTaskReadFailed extends OrganisationTaskState {
  final String error;
  const DepartmentRoleTaskReadFailed(this.error);
}
//deleteDiscount

class DeleteDepartmentRoleTaskLoading extends OrganisationTaskState {}

class DeleteDepartmentRoleTaskSuccess extends OrganisationTaskState {}

class DeleteDepartmentRoleTaskFailed extends OrganisationTaskState {}

//updateDiscount

class DepartmentRoleTaskUpdateLoading extends OrganisationTaskState {}

class DepartmentRoleTaskUpdateSuccess extends OrganisationTaskState {
  final String?  successMessage;

  const DepartmentRoleTaskUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class DepartmentRoleTaskUpdateFailed extends OrganisationTaskState {
  final String error;

  const DepartmentRoleTaskUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class DepartmentRoleTaskListLoading extends OrganisationTaskState {}

class DepartmentRoleTaskListSuccess extends OrganisationTaskState  {
  final List<DepartmentTaskModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const DepartmentRoleTaskListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class DepartmentRoleTaskListFailed extends OrganisationTaskState {
  final String msg;
  DepartmentRoleTaskListFailed(this.msg);
}

class RoleUnderDepartmentListLoading extends OrganisationTaskState {}

class RoleUnderDepartmentListSuccess extends OrganisationTaskState  {
  final List<DepartmentTaskModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const RoleUnderDepartmentListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class RoleUnderDepartmentListFailed extends OrganisationTaskState {
  final String msg;
  RoleUnderDepartmentListFailed(this.msg);
}