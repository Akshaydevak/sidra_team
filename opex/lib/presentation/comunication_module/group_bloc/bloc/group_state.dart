part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GetAllRegisteredUsersLoading extends GroupState {}

class GetAllRegisteredUsersSuccess extends GroupState {
  final List<UserModelInventory> registeresUsers;
  const GetAllRegisteredUsersSuccess({required this.registeresUsers});
}

class GetAllRegisteredUsersFailed extends GroupState {}

class CreateGroupLoading extends GroupState {}

class CreateGroupSuccess extends GroupState {
  final String successMessage;
  const CreateGroupSuccess({required this.successMessage});
}

class CreateGroupFailed extends GroupState {
  final String error;
  const CreateGroupFailed({required this.error});
}

class GetGroupProfileDetailsLoading extends GroupState {}

class GetGroupProfileDetailsSuccess extends GroupState {
  final ProfileGetModel profileGetModel;
  const GetGroupProfileDetailsSuccess({required this.profileGetModel});
}

class GetGroupProfileDetailsFailed extends GroupState {}

class GroupLeaveLoading extends GroupState {}

class GroupLeaveSuccess extends GroupState {
  final String successMessage;
  const GroupLeaveSuccess({required this.successMessage});
}

class GroupLeaveFailed extends GroupState {
  final String error;
  const GroupLeaveFailed({required this.error});
}

