part of 'employee_bloc.dart';


abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object> get props => [];
}
class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeSuccess extends EmployeeState {
  final GetEmployeeList user;

  const EmployeeSuccess(this.user);

  @override
  List<Object> get props => [];
}

class EmployeeFailed extends EmployeeState {
  final String error;

  const EmployeeFailed(this.error);
  @override
  List<Object> get props => [];
}
//groupcreation
class CreateGroupInitial extends EmployeeState {}

class CreateGroupLoading extends EmployeeState {}


class CreateGroupSuccess extends EmployeeState {
  final GetTaskGroupList group;

  const CreateGroupSuccess(this.group);

  @override
  List<Object> get props => [];
}

class CreateGroupFailed extends EmployeeState {
  final String error;

  const CreateGroupFailed(this.error);
  @override
  List<Object> get props => [];
}
//update

class UpdateGroupLoading extends EmployeeState {}


class UpdateGroupSuccess extends EmployeeState {
  final String group;

  const UpdateGroupSuccess(this.group);

  @override
  List<Object> get props => [];
}

class UpdateGroupFailed extends EmployeeState {
  final String error;

  const UpdateGroupFailed(this.error);
  @override
  List<Object> get props => [];
}
//readGroup
class GetReadGroupInitial extends EmployeeState {}


class GetReadGroupLoading extends EmployeeState {}

class GetReadGroupSuccess extends EmployeeState {
  final GetTaskGroupList getGroupRead;
  GetReadGroupSuccess({required this.getGroupRead});
  @override
  List<Object> get props => [getGroupRead];
}

class GetReadGroupFailed extends EmployeeState {
  final String error;GetReadGroupFailed(this.error);
}
//readEmployee
class GetEmployeeReadInitial extends EmployeeState {}


class GetEmployeeReadLoading extends EmployeeState {}

class GetEmployeeReadSuccess extends EmployeeState {
  final GetEmployeeList getEmployee;
  GetEmployeeReadSuccess({required this.getEmployee});
  @override
  List<Object> get props => [getEmployee];
}

class GetEmployeeReadFailed extends EmployeeState {
  final String error;
  GetEmployeeReadFailed(this.error);
}

//updateEmployee

class UpdateEmployeeInitial extends EmployeeState {}

class UpdateEmployeeLoading extends EmployeeState {}

class UpdateEmployeeSuccess extends EmployeeState {
  final GetEmployeeList user;

  const UpdateEmployeeSuccess(this.user);

  @override
  List<Object> get props => [];
}

class UpdateEmployeeFailed extends EmployeeState {
  final String error;

  const UpdateEmployeeFailed(this.error);
  @override
  List<Object> get props => [];
}
//deleteEmployee
class DeleteEmployeeInitial extends EmployeeState {}

class DeleteEmployeeLoading extends EmployeeState {}

class DeleteEmployeeSuccess extends EmployeeState {}

class DeleteEmployeeFailed extends EmployeeState {}

//listActivity
class GetActivityLogListInitial extends EmployeeState {}

class GetActivityLogListLoading extends EmployeeState {}

class GetActivityLogListSuccess extends EmployeeState {
  final List<ActivityList> activity;

  const GetActivityLogListSuccess(this.activity);
}

class GetActivityLogListFailed extends EmployeeState {}

//postImage
class PostImageInitial extends EmployeeState {}

class PostImageLoading extends EmployeeState {}

class PostImageSuccess extends EmployeeState {
  final int? id;
  const PostImageSuccess({this.id});
}

class PostImageFailed extends EmployeeState {
  final String? error;
  const PostImageFailed({this.error});
}

class PicLoading extends EmployeeState {}

class PicSuccess extends EmployeeState {
  final int data;
  final String url;
  // final List<ListOrdersModel> ordersList;

  const PicSuccess(this.data,this.url);
}

class PicFailed extends EmployeeState {}