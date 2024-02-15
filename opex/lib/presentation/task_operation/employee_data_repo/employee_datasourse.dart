import 'dart:io';
import 'dart:math';

import 'package:cluster/core/cluster_urls.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../core/utils/data_response.dart';
import '../../../../../core/utils/variables.dart';
import '../../authentication/authentication.dart';
import '../employee_model/employee_model.dart';
import 'package:mime/mime.dart';
class EmployeeDataSource {
  Dio client = Dio();


  Future<DataResponse> employeeCreate({
    required String email,
    required String orgCode,
    required String lastName,
    required String firstName,
    required String contact,
    required String departCode,
    required String designationCode,
    required String? gender,
    required String netCode,
    required String nationality,
    required String password,
    required int officialRole,
    required String userRole,
    required List<int> additionalRole,
    required List<String> roleNameList,
    required String roleName,
    required String whatsapp,
    required dynamic profilePic,
  }) async {
    print("ffff${ClusterUrls.userCreateUrl}");
    final response = await client.post(
      ClusterUrls.userCreateUrl,
      data: {
        "first_name":firstName,
        "last_name":lastName,
        "email":email,
        "contact_number":contact,
        "gender":gender,
        "designation_code":designationCode,
        "department_code":departCode,
        "organisation_code":orgCode,
        "password":password,
        "nationality":nationality,
        "official_role":officialRole,
        "additional_roles":additionalRole,
        "user_role":userRole,
        "network_code":netCode,
        "official_role_name":roleName,
        "additional_roles_list":roleNameList,
        "profile_pic":profilePic,
        "whatsapp_number":whatsapp,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token,
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //chage
  Future<DataResponse> chagePassword({
    required String employeeCode,
    required String newPassword,
  }) async {
    print("AIR${ ClusterUrls.changePawwordUserUrl}");
    final response = await client.post(
      ClusterUrls.changePawwordUserUrl,
      data: {
        "employee_code":employeeCode,
        "password":newPassword,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "token ${authentication.authenticatedUser.token}",
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //creategroup
  Future<DataResponse> createGroupPost({
    required String groupName,
    required String discription,
    required List<String> userList,

  }) async {
   print("LLLLLL${ClusterUrls.groupCreate}");
    final response = await client.post(ClusterUrls.groupCreate,
      data: {
        "group_name":groupName,
        "user_id":userList,
        "description":discription,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //update
  Future<DataResponse> UpdateGroupToState({
    required String groupName,
    required String discription,
    required List<GetUserList> userList,
    required bool isActive,
    required int id,

  }) async {
    print("FAS$groupName");
    print("FAS$discription");
    print("FAS$userList");
    print("FAS$isActive");
    print("FAS$id");
    print("FAS${ClusterUrls.groupUpdateUrl+id.toString()}");

    final response = await client.patch(ClusterUrls.groupUpdateUrl+id.toString(),
      data:
      {
        "group_name":groupName,
        "user_id":userList,
        "description":discription,
        "is_active":isActive

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //readgroup
  Future<GetTaskGroupList> getGroupRead(int id) async {
    GetTaskGroupList groupRead;
    print("group Read:${ClusterUrls.readGroupUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readGroupUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    groupRead = GetTaskGroupList.fromJson((response.data['data']));
print(groupRead.userId);
    return groupRead;
  }

  //readEmplotee
  Future<GetEmployeeList> getEmployeeRead(int id) async {
    GetEmployeeList readEmployee;
    print("Employee Read:${ClusterUrls.readEmployeeUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readEmployeeUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data['data']['user_data']);
    readEmployee = GetEmployeeList.fromJson((response.data['data']['user_data']));
    return readEmployee;
  }

  //readType
  Future<EmployeeCreateRead> getReadType() async {

    EmployeeCreateRead readEmployee;
    print("Type Read:${ClusterUrls.readtypeUrl}");
    final response = await client.get(
      ClusterUrls.readtypeUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data['data']['user_data']);
    print(response.data['data']['user_data']);
    readEmployee = EmployeeCreateRead.fromJson((response.data['data']));
    return readEmployee;
  }

  //updateEmployee
  Future<DataResponse> updateEmployee({
    required String email,
    required String orgCode,
    required String lastName,
    required String firstName,
    required String contact,
    required String departCode,
    required String designationCode,
    required String? gender,
    required String netCode,
    required String nationality,
    required int officialRole,
    required String userRole,
    required List<int> additionalRole,
    required List<String> roleNameList,
    required String roleName,
    required String whatsapp,
    required bool isActive,
    required int id,
    required dynamic profilePic,
  }) async {
    print("Update JOB:${ClusterUrls.updateEmployeeUrl+id.toString()}");
    print("NAMESS${firstName}");
    print("NAMESS${lastName}");
    print("NAMESS${contact}");
    print("NAMESS${departCode}");
    print("NAMESS${designationCode}");
    print("NAMESS${isActive}");
    print("NAMESS${id}");
    print("NAMESS${email}");
    print("NAMESS${gender}");

    final response = await client.patch(
      ClusterUrls.updateEmployeeUrl+id.toString(),
      data: {
        "first_name":firstName,
        "last_name":lastName,
        "email":email,
        "contact_number":contact,
        "gender":gender,
        "designation_code":designationCode,
        "department_code":departCode,
        "organisation_code":orgCode,
        "nationality":nationality,
        "official_role":officialRole,
        "additional_roles":additionalRole,
        "user_role":userRole,
        "network_code":netCode,
        "official_role_name":roleName,
        "additional_roles_list":roleNameList,
        "is_active":isActive,
        "profile_pic":profilePic,
        "whatsapp_number":whatsapp,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("update response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //deleteemployee
  Future<String> deleteEmployee(int empid) async {
    String statusCode;
    print("dele${ClusterUrls.updateEmployeeUrl + empid.toString()}");
    final response = await client.delete(
      ClusterUrls.updateEmployeeUrl + empid.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
    statusCode = (response.data['status']);
    print("statusCode");
    return statusCode;
  }


  //
  Future<String> deleteGroup(int empid) async {
    String statusCode;
    print("delete group${ClusterUrls.groupUpdateUrl + empid.toString()}");
    final response = await client.delete(
      ClusterUrls.groupUpdateUrl + empid.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
    statusCode = (response.data['status']);
    print("statusCode${response.data}");
    return statusCode;
  }

  //listActivity
  Future<List<ActivityList>> getActivityList(int? id) async {
    List<ActivityList> activityList = [];

    print("URL:${ClusterUrls.activityLogsUrl+id.toString()}");

    final response = await client.get(ClusterUrls.activityLogsUrl+id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    (response.data['data'] as List).forEach((element) {
      activityList.add(ActivityList.fromJson(element));
    });
    return activityList;
  }
//postImage
  Future<DoubleResponse> postImageInAll(
      {File? img}) async {
    String filePath = "";
    print("check new at datasource");
    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(filePath,
        contentType: MediaType(mime.first, mime.last));
    final FormData formData = FormData.fromMap({
      "file": fileData,
      "description":"description",
      "notes":"notes",
      "file_type":"Image",
      "attachment_type":"job",
      "attachment_type_id":1,

    });
    final response = await client.post(
      ClusterUrls.imageUploadAttachmentUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    if (response.data != null || response.data != "") {
      return DoubleResponse(response.data['data'], response.data['image_url']);
    }
    return DoubleResponse(response.data, "failed");
  }

  //postAll
  Future<DoubleResponse> PostImage(
      {File? img}) async {
    String filePath = "";
    print("check new at datasource");
    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(filePath,
        contentType: MediaType(mime.first, mime.last));
    final FormData formData = FormData.fromMap({"upload": fileData});
    final response = await client.post(
      ClusterUrls.imageUploadUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("check new response ${response.data}");
    return DoubleResponse(
        response.data['status'] == 'success', response.data['data']['id']);
  }

  //chage
  Future<DataResponse> changePassword({
    required String userName,
    required String current,
    required String newPass,
    String? otp,
  }) async {
    print("tokkk${authentication.authenticatedUser.token}");
    print("tokkk$current");
    print("tokkk$newPass");
    print("tokkk$userName");
    print("tokkk$otp");

    final response = await client.post(
      "https://api-uat-user.sidrabazar.com/user-account_userchangepassword/cluster",
      data: otp == null
          ? {
        "username": userName,
        "cpwd": current,
        "npwd": newPass,
      }
          : {
        "username": userName,
        "cpwd": current,
        "npwd": newPass,
        "otp": otp
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'token ${authentication.authenticatedUser.token}'
        },
      ),
    );

    print("change response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }


  //taskGroupCommu
  Future<createTaskGroupChat> createTaskGroupCommunication({
    required CommunicationTaskGroup taskGroup,
      }) async {
    print("communucation Group${taskGroup.taskName}");
    print("communucation Group${taskGroup.taskCode}");
    print("communucation Group${taskGroup.createdBy}");
    print("communucation Group${taskGroup.friendList!.length}");
    print("communucation Group${authentication.authenticatedUser.token}");

    createTaskGroupChat chatlist = createTaskGroupChat();
    final response = await client.post(
      "https://api-communication-application.hilalcart.com/api/group/create-group",
      // "http://192.168.1.187:5500/api/group/create-group",
      // "https://5z7l1nh4-5500.inc1.devtunnels.ms/api/group/create-group",
      data: taskGroup,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'token ${authentication.authenticatedUser.token}'
        },
      ),
    );

    print("change response$response");
    if (response.data['status'] == 'success') {
      chatlist = createTaskGroupChat.fromJson(response.data);
      // (response.data['data']['results'] as List).forEach((element) {
      // chatlist.add(createTaskGroupChat.fromJson(element));
    // });
    } 
    return chatlist;
  }

  Future<String> fcmRegister({required String fcmToken}) async {
    String statusCode;
    print("delete group${ClusterUrls.registerFCMUrl}");
    final response = await client.post(
      ClusterUrls.registerFCMUrl,
      data: {
        "device_token":fcmToken
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("fcm response${response.data}");
    statusCode = (response.data['message']);
    print("statusCode${response.data}");
    return statusCode;
  }
}