import 'dart:io';

import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/comunication_module/communication_urls.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunicationDatasource {
  Dio client = Dio();
  Future<List<GetEmployeeList>> getSearchedUsers(
      String searchQuery, String token) async {
    List<GetEmployeeList> searchedUserList = [];
    
    final response = await client.get(
      CommunicationUrls.searchUser + searchQuery,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'token ${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      searchedUserList.add(GetEmployeeList.fromJson(element));
    });
    return searchedUserList;
  }

  Future<List<GetEmployeeList>> getAllRegisteredUsers(String? token) async {
    List<GetEmployeeList> allRegisteredUsers = [];
   
   
    final response = await client.get(
      "https://api-task-and-operation.hilalcart.com/task-manage/list-user",
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );
     print("auth ${authentication.authenticatedUser.token}");
    print("got the response ${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      allRegisteredUsers.add(GetEmployeeList.fromJson(element));
    });
    // print("got the final ${allRegisteredUsers}");
    return allRegisteredUsers;
  }

  Future<GroupList> createGroupData(
      {required String token,
      required String groupPicUrl,
      required List<GetEmployeeList>? userIdList,
      required String groupName}) async {
        print("asdd${userIdList![0].userCode}");

        GroupList? grpuserlist=GroupList();
    List<Map<String, dynamic>> map = [];
    for (var i = 0; i < userIdList!.length; i++) {
    print("${userIdList[i].userCode}");
      map.add({
        "fname": userIdList[i].fname,
        "lname": userIdList[i].lname,
        "email": userIdList[i].email,
        "photo": userIdList[i].profile,
        "user_code":userIdList[i].code
      });
    }
    final response = await client.post(
      CommunicationUrls.createGroupUrl,
      data: {"name": groupName, "friends": map, "groupPhotoUrl": groupPicUrl},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print("create a grp ${response.data}");
    grpuserlist = GroupList.fromJson(response.data);
    return grpuserlist;
  //   DoubleResponse(
  //       response.data['status'] == 'success', response.data['chatid']);
  }

  Future<DoubleResponse> groupLeaveData(
      {required String roomId, required String token}) async {
    print("at datasource");
    print(roomId);
    final response = await client.post(
      CommunicationUrls.leaveGroupUrl,
      data: {"chatid": roomId},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print(response.data);
    return DoubleResponse(
        response.data['status'] == 'success', response.data['message']);
  }
  Future<DoubleResponse> addanGroupMember(
      {required String chatId, required String userId, required String token}) async {
    print("at datasource");
    print("....$chatId...$userId");
    final response = await client.post(
      CommunicationUrls.addGroupMember+chatId,
      data: {"userId": userId},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print(response.data);
    return DoubleResponse(
        response.data['status'] == 'success', response.data['message']);
  }
  Future<DoubleResponse> deleteGrpMembers(
      {required String chatId, required String userId, required String token}) async {
    print("at datasource");
    print("....$chatId  $userId");
    final response = await client.delete(
      CommunicationUrls.deleteGroupMember+"$chatId/$userId",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print("response at datasource ${response.data}");
    return DoubleResponse(
        response.data['status'] == 'success', response.data['message']);
  }

  Future<CommunicationUserModel> addAFriendUser(String token, String fname,
      String lname, String mail, String photo,String usercode) async {
        
        CommunicationUserModel chatListData1 = CommunicationUserModel();
    print("token is ${token}");
    print("fname is ${fname}");
    print("lname is ${lname}");
    print("email is ${mail}");
    print("photo is ${photo}");
    print("photo is ${usercode}");
    print(token);
    final response = await client.post(
      CommunicationUrls.addAFriendUser,
      data: {"fname": fname, "lname": lname, "email": mail, "photo": photo,"code":usercode},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print(response.data);
    if(response.data['status']=="success"){
    chatListData1 = CommunicationUserModel.fromJson(response.data['data']);
    }else{
       chatListData1 = CommunicationUserModel.fromJson(response.data['data']);
    }
    return chatListData1;
  }

  Future<List<CommunicationUserModel>> getChatListData(String token) async {
    List<CommunicationUserModel> chatListData = [];
    final response = await client.get(CommunicationUrls.getChatList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
      print(response.data);
      // if(response.data)
    (response.data['data'] as List).forEach((element) {
      chatListData.add(CommunicationUserModel.fromJson(element));
    });
    return chatListData;
  }

  Future<List<CommunicationUserModel>> getFilteredChatListData(
      String token, String chatFilter) async {
    List<CommunicationUserModel> chatListData = [];
    print(CommunicationUrls.getFilteredChatList);
    final response =
        await client.get(CommunicationUrls.getFilteredChatList + chatFilter,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ));
            print("kngwlk... ${response.data}");
    (response.data['data'] as List).forEach((element) {
      chatListData.add(CommunicationUserModel.fromJson(element));
    });
    return chatListData;
  }

  Future<ChatMessagaeData> getChatScreenData(
      String token,String chatId,int pageNo) async {
    ChatMessagaeData chatScreenData =ChatMessagaeData();
    // print(
    //     "got it but just api${CommunicationUrls.getChatScreenUrl}$userId?page=$pageNo}");
    final response = await client.get(
        "${CommunicationUrls.getChatScreenUrl}$chatId?page=$pageNo",
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
    print("got it ${response.data}");
    if(response.data['status']=="success"){
    chatScreenData = ChatMessagaeData.fromJson(response.data['data']);}
    return chatScreenData;
  }

  Future<ProfileGetModel> getGroupProfileGetData(
      String token, String chatId) async {
    ProfileGetModel profileGetModel;
    print("profile get api ${CommunicationUrls.getGroupProfileDetailsUrl + chatId}");
    final response =
        await client.get(CommunicationUrls.getGroupProfileDetailsUrl + chatId,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ));
            print("profile get ${response.data}");
    profileGetModel = ProfileGetModel.fromJson(response.data['data']);
    return profileGetModel;
  }

  Future<ProfileGetModel> getGroupAttachmentsData(
      String token, String chatId) async {
    ProfileGetModel profileGetModel;
    print("get attachment ${CommunicationUrls.getGroupAttachmentsInProfileUrl+chatId }");
    final response = await client.get(
        CommunicationUrls.getGroupAttachmentsInProfileUrl+chatId,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
    profileGetModel = ProfileGetModel.fromJson(response.data['data']);
    return profileGetModel;
  }

  Future<String> uploadImageData({FilePickerResult? img}) async {
    String statusCode;

    print("total result ${img}");
    String filePath = "";

    if (img != null) filePath = img.files[0].path ?? "";
    final mime = lookupMimeType(filePath)!.split("/");

    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"upload": fileData});

    final response = await client.post(
      CommunicationUrls.uploadImageUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("response is here ${response.data}");
    statusCode = (response.data['data']['upload']);
    return statusCode;
  }

  Future<String> uploadLiveAudioData({File? img}) async {
    String statusCode;

    print("total result ${img}");
    String filePath = "";

    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");

    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"upload": fileData});

    final response = await client.post(
      CommunicationUrls.uploadImageUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("response is here ${response.data}");
    statusCode = (response.data['data']['upload']);
    return statusCode;
  }

  Future<DataResponse> updateGroupPicture(
    File? img,
  ) async {
    String? uploadLink;
    String statusCode;
    String filePath = "";
    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"upload": fileData});
    final response = await client.post(
      CommunicationUrls.uploadImageUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    uploadLink = response.data['data']['upload'];
    return DataResponse(data: uploadLink, error: response.data['message']);
  }
}
