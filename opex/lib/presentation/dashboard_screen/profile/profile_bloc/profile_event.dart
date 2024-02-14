



part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

}
class UpdateProfileEvent extends ProfileEvent {
  final String? email;
  final String ?mobile;
  final String ?fname;
  final String? lname;
  final String ?dob;
  final String ?gender;
  final String ?country;
  const UpdateProfileEvent({this.email,this.mobile,this.dob,this.fname,this.lname,this.gender,this.country});
}
class GetProfilePicEvent extends ProfileEvent {

  const GetProfilePicEvent();
}
class UpdateProfilePicEvent extends ProfileEvent {
  final File? profilePic;
  final dynamic? pic;
  const UpdateProfilePicEvent({this.profilePic,this.pic});
}

class UpdateProfilePicCommunicationEvent extends ProfileEvent {
  final String? userCode;
  final dynamic? pic;
  final String? token;
  const UpdateProfilePicCommunicationEvent({this.userCode,this.pic,this.token});
}
class UpdateOrgProfilePicEvent extends ProfileEvent {
  final File? profilePic;
  final int? id;
  const UpdateOrgProfilePicEvent({this.profilePic,this.id});
}
class GetProfileEvent extends ProfileEvent {
  // final User? user;
  const GetProfileEvent();
}class NationalityGetEvent extends ProfileEvent {
  // final User? user;
  const NationalityGetEvent();
}


