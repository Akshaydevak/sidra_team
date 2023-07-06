

import 'dart:io';

import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/dashboard_screen/profile/data/profile_src.dart';
import 'package:cluster/presentation/order_app/data/order_src.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:flutter/material.dart';

class ProfileRepo {
  final ProfileDataSource _dataSource = ProfileDataSource();

  Future<DataResponse> updateProfile(String? email,String? mobile, String? fname, String? lname, String? dob, String? gender, String? country)async {
    final apiResponse = await _dataSource.ProfileUpdate(email,mobile,fname,lname,dob,gender,country);
    try {
      if (apiResponse.data1) {
        return DataResponse(data: apiResponse.data2,error: apiResponse.data2);
      } else {
        return DataResponse(data:null, error: apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: apiResponse.data2,
        error: "error Text");
  }


  //getProfile
  Future<DataResponse> getProfile()async {
    final apiResponse = await _dataSource.getProfile();
    try {
      if (apiResponse!=null) {
        return DataResponse(data: apiResponse,error: "error Text");
      } else {
        return DataResponse(data:null, error: "");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: apiResponse,
        error: "error Text");
  }
  //getProfilePic
  Future<DataResponse> getProfilePic()async {
    final apiResponse = await _dataSource.ProfilePic();
    try {
      if (apiResponse!=null&&apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse,error: "error Text");
      } else {
        return DataResponse(data:null, error: "");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: apiResponse,
        error: "error Text");
  }


  //updateProfilePic
  Future<DataResponse> updateProfilePic(File? profilePic)async {
    final apiResponse = await _dataSource.UpdateProfilePic(profilePic);
    try {
      if (apiResponse.data1) {
        return DataResponse(data: apiResponse.data2,error: "error Text");
      } else {
        return DataResponse(data:null, error: apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: apiResponse.data2,
        error: "error Text");
  }

}