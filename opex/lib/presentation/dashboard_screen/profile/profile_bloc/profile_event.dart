



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
  const UpdateProfilePicEvent({this.profilePic});
}
class GetProfileEvent extends ProfileEvent {
  // final User? user;
  const GetProfileEvent();
}class NationalityGetEvent extends ProfileEvent {
  // final User? user;
  const NationalityGetEvent();
}


