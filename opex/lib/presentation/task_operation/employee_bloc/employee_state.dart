part of 'employee_bloc.dart';


abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object> get props => [];
}
class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeSuccess extends EmployeeState {
  final String user;

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

///change password
class ChagePasswordLoading extends EmployeeState {}

class ChagePasswordSuccess extends EmployeeState {
  final String user;

  const ChagePasswordSuccess(this.user);

  @override
  List<Object> get props => [];
}

class ChagePasswordFailed extends EmployeeState {
  final String error;

  const ChagePasswordFailed(this.error);
  @override
  List<Object> get props => [];
}
//groupcreation
class CreateGroupInitial extends EmployeeState {}

class CreateGroupLoading extends EmployeeState {}


class CreateGroupSuccess extends EmployeeState {
  final String? group;

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


//readType
class GetReadTypeLoading extends EmployeeState {}

class GetReadTypeSuccess extends EmployeeState {
  final EmployeeCreateRead readType;
  GetReadTypeSuccess({required this.readType});
  @override
  List<Object> get props => [readType];
}

class GetReadTypeFailed extends EmployeeState {
  final String error;
  GetReadTypeFailed(this.error);
}

//updateEmployee

class UpdateEmployeeInitial extends EmployeeState {}

class UpdateEmployeeLoading extends EmployeeState {}

class UpdateEmployeeSuccess extends EmployeeState {
  final String user;

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

//
class DeleteGroupLoading extends EmployeeState {}

class DeleteGroupSuccess extends EmployeeState {}

class DeleteGroupFailed extends EmployeeState {}

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
//
class PicOnlyProfileLoading extends EmployeeState {}

class PicOnlyProfileSuccess extends EmployeeState {
  final int data;
  final String url;
  // final List<ListOrdersModel> ordersList;

  const PicOnlyProfileSuccess(this.data,this.url);
}

class PicOnlyProfileFailed extends EmployeeState {}

//
class Pic2Loading extends EmployeeState {}

class Pic2Success extends EmployeeState {
  final int data;
  final String url;
  // final List<ListOrdersModel> ordersList;

  const Pic2Success(this.data,this.url);
}

class Pic2Failed extends EmployeeState {}

//
class ChangePasswordLoading extends EmployeeState {}

class ChangePasswordSuccess extends EmployeeState {
  final String message;
  const ChangePasswordSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ChangePasswordFailed extends EmployeeState {
  final String message;

  const ChangePasswordFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}


class TaskGroupCreationLoading extends EmployeeState {}

class TaskGroupCreationSuccess extends EmployeeState {
  final createTaskGroupChat chatlist;
  const TaskGroupCreationSuccess({
    required this.chatlist,
  });

  @override
  List<Object> get props => [chatlist];
}

class TaskGroupCreationFailed extends EmployeeState {
  final String message;

  const TaskGroupCreationFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}


class FcmLoading extends EmployeeState {}

class FcmSuccess extends EmployeeState {}

class FcmFailed extends EmployeeState {}

class FcmLogoutLoading extends EmployeeState {}

class FcmLogoutSuccess extends EmployeeState {}

class FcmLogoutFailed extends EmployeeState {}
