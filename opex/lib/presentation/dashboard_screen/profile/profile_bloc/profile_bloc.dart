import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:equatable/equatable.dart';

import '../../../task_operation/employee_model/employee_model.dart';
import '../data/profile_repo.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo = ProfileRepo();

  ProfileBloc() : super(UpdateProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfileEvent) {
      yield* updateProfile(event.email, event.mobile, event.fname, event.lname,
          event.dob, event.gender,event.country);
    }
    if (event is GetProfileEvent) {
      yield* getProfile();
    }
    if (event is GetProfilePicEvent) {
      yield* getProfilePic();
    }
    if (event is UpdateProfilePicEvent) {
      yield* updateProfilePic(event.profilePic,event.pic);
    }
    if (event is UpdateOrgProfilePicEvent) {
      yield* updateOrgProfilePic(event.profilePic,event.id);
    }

    // else if (event is GetPickListEvent) {
    //   yield* getPicklist(event.isAssign);
    // }
  }

  Stream<ProfileState> updateProfile(String? email, String? mobile,
      String? fname, String? lname, String? dob, String? gender, String? country) async* {
    yield UpdateProfileLoading();

    final dataResponse = await _profileRepo.updateProfile(
        email, mobile, fname, lname, dob, gender,country);

    if (dataResponse.data != null) {
      yield UpdateProfileSuccess(
        dataResponse.error??""
      );
    } else {
      yield UpdateProfileFailed(dataResponse.error??"");
    }
  }

  Stream<ProfileState> getProfile() async* {
    yield ProfileLoading();

    final dataResponse = await _profileRepo.getProfile();
print(dataResponse.data);
    if (dataResponse.data != null) {
      yield ProfileSuccess(
          dataResponse.data
      );
    } else {
      yield ProfileFailed();
    }
  }


  Stream<ProfileState> getProfilePic() async* {
    yield ProfilePicLoading();

    final dataResponse = await _profileRepo.getProfilePic();
print(dataResponse.data);
    if (dataResponse.data != null) {
      yield ProfilePicSuccess(
          dataResponse.data
      );
    } else {
      yield ProfilePicFailed();
    }
  }

  Stream<ProfileState> updateProfilePic(File? profilePic,dynamic? pic) async* {
    yield UpdateProfilePicLoading();

    final dataResponse = await _profileRepo.updateProfilePic(profilePic,pic);
    if (dataResponse.data) {
      yield UpdateProfilePicSuccess(dataResponse.error??"",);
    } else {
      yield UpdateProfilePicFailed();
    }

    // if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
    //   yield UpdateProfilePicSuccess();
    // } else {
    //   yield UpdateProfilePicFailed();
    // }
  }

  Stream<ProfileState> updateOrgProfilePic(File? profilePic,int? id) async* {
    yield UpdateOrgProfilePicLoading();

    final dataResponse = await _profileRepo.updateOrgProfilePic(profilePic,id);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield UpdateOrgProfilePicSuccess();
    } else {
      yield UpdateOrgProfilePicFailed();
    }
  }
  //Nationalities
  // Stream<ProfileState> nationalityGetState() async* {
  //   yield NationalityGetLoading();
  //   final dataResponse = await _profileRepo.getNationality();
  //   if (dataResponse.isNotEmpty) {
  //     yield NationalityGetSuccess(nationalityModel: dataResponse);
  //   } else {
  //     yield NationalityGetFailed();
  //   }
  // }
}
