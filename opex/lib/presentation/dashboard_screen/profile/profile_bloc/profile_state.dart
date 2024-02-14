part of 'profile_bloc.dart';



abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}
//jobList
class UpdateProfileInitial extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final String msg;

  const UpdateProfileSuccess(
      this.msg
      );
}

class UpdateProfileFailed extends ProfileState {
  final String msg;
  UpdateProfileFailed(this.msg);
}
class UpdateProfilePicLoading extends ProfileState {}

class UpdateProfilePicSuccess extends ProfileState {
  final String success;
  // final List<ListOrdersModel> ordersList;

  const UpdateProfilePicSuccess(
      this.success
      );
}

class UpdateProfilePicFailed extends ProfileState {}

class UpdateOrgProfilePicLoading extends ProfileState {}

class UpdateOrgProfilePicSuccess extends ProfileState {
  // final List<ListOrdersModel> ordersList;

  const UpdateOrgProfilePicSuccess(
      // this.ordersList
      );
}

class UpdateOrgProfilePicFailed extends ProfileState {}


class ProfilePicLoading extends ProfileState {}

class ProfilePicSuccess extends ProfileState {
  final String profilePic;

  const ProfilePicSuccess(
      this.profilePic
      );
}

class ProfilePicFailed extends ProfileState {}
class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final GetEmployeeList user;

  const ProfileSuccess(
      this.user
      );
}

class ProfileFailed extends ProfileState {}
//nationality
class NationalityGetInitial extends ProfileState {}

class NationalityGetLoading extends ProfileState {}

class NationalityGetSuccess extends ProfileState {
  // final List<ContractUserModel> nationalityModel;
  NationalityGetSuccess();
}

class NationalityGetFailed extends ProfileState {
  // final String error;
  // NationalityGetFailed(this.error);
}