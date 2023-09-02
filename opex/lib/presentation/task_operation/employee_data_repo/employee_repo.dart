import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/data_response.dart';

import '../employee_model/employee_model.dart';
import 'employee_datasourse.dart';

class EmployeeRepo {
  final EmployeeDataSource _dataSource = EmployeeDataSource();

  Future<DataResponse> employeeCreate({
    required String email,
    required String orgCode,
    required String lastName,
    required String firstName,
    required String contact,
    required String departCode,
    required String designationCode,
    required String? gender
  }) async {
    final restAPIresponse = await _dataSource.employeeCreate(
      email: email,
      departCode: departCode,
      gender: gender,
      orgCode: orgCode,
      designationCode:designationCode,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //GROUPCREATION
  Future<DataResponse> createGroupPost({
    required String groupName,
    required String discription,
    required List<String> userlist,

  }) async {
    final restAPIresponse = await _dataSource.createGroupPost(
      groupName: groupName,
      discription: discription,
      userList: userlist
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  //
  Future<DataResponse> UpdateGroupToState({
    required String groupName,
    required String discription,
    required List<GetUserList> userList,
    required bool isActive,
    required int id,

  }) async {
    final restAPIresponse = await _dataSource.UpdateGroupToState(
        groupName: groupName,
        discription: discription,
        userList: userList,
      isActive: isActive,
      id: id
    );
    print("res data${restAPIresponse.data}");
    print("res data${restAPIresponse.error}");
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
//groupread
  Future<DataResponse> getGroupRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getGroupRead(id!);

      if (apiResponse.groupCode!=null) {
        print("stateee grouppp herreeee repo");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }
  //readEmplpoyee
  Future<DataResponse> getEmployeeRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getEmployeeRead(id!);

      if (apiResponse.code!="") {
        print("stateee employee herreeee repo");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }

  //updateEmployee
  Future<DataResponse> updateEmployee({
    required String email,
    required String? gender,
    required String orgCode,
    required String lastName,
    required String firstName,
    required String contact,
    required String departCode,
    required String designationCode,
    required bool isActive
  }) async {
    final restAPIresponse = await _dataSource.updateEmployee(
      email: email,
      departCode: departCode,
      gender: gender,
      orgCode: orgCode,
      designationCode:designationCode,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
      isActive:isActive,

    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //listActivity
  Future<DataResponse> getActivityList(int? id) async {
    final apiResponse = await _dataSource.getActivityList(id);
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

}