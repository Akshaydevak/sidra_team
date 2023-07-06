
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:cluster/core/cluster_urls.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:cluster/presentation/authentication/authentication.dart';

import 'package:cluster/presentation/dashboard_screen/profile/data/profile_urls.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:cluster/presentation/order_app/utils/order_app_urls.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:dio/dio.dart';


class ProfileDataSource {
  Dio client = Dio();


  Future<DoubleResponse> ProfileUpdate(
      String? email,String? mobile, String? fname, String? lname, String? dob, String? gender, String? country) async {
    User authenticatedUser;
    print(
        "heyyyy login url  ${ProfileUrls.updateUrl}${authentication.authenticatedUser.loginId}");
    print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,$gender");
    final response = await client.post(
      ProfileUrls.updateUrl,
      data: {
        "email": email,
        "mobile": mobile,
        "fname": fname,
        "lname": lname,
        "date_of_birth": dob,
        "gender": gender,
        "country":country
      },

      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "token ${authentication.authenticatedUser.token}",
        },
      ),
    );
    print(response.data);
    if (response.data['status'] == "success") {
      print(response.data);
      return DoubleResponse(
          response.data['status'] == "success", response.data['message']);
    }
    return DoubleResponse(
        response.data['status'] == "success", response.data['message']);
  }
  //profile get
  Future<User> getProfile() async {
    User authenticatedUser;
    print(
        "heyyyy login url  ${ProfileUrls.updateUrl}");
    final response = await client.get(
      ProfileUrls.updateUrl,

      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "token ${authentication.authenticatedUser.token}",
        },
      ),
    );
print(response);
    return User.fromJson((response.data['data']));
  }


  //getProfilePic
  Future<String> ProfilePic() async {
    User authenticatedUser;
    print(
        "heyyyy login url  ${ProfileUrls.profilePicUrl+authentication.authenticatedUser.loginId.toString()}");
    final response = await client.get(
      ProfileUrls.profilePicUrl+authentication.authenticatedUser.loginId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "token ${authentication.authenticatedUser.token}",
        },
      ),
    );
    print(",,,,,,,,,,,,,,,,,," +response.toString());




      return response.data['profile_pic'];

  }



 Future<DoubleResponse> UpdateProfilePic(
     File? profilePic) async {
    User authenticatedUser;
    String filePath = "";
    print(
        "heyyyy login url  ${ProfileUrls.updateUrl}");
    if (profilePic != null) filePath = profilePic.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"profile_pic": fileData});
    print("////////$formData");
    final response = await client.put(
      ProfileUrls.profilePicUrl+authentication.authenticatedUser.loginId.toString(),
      data: formData,

      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "token ${authentication.authenticatedUser.token}",
        },
      ),
    );
    print(response.data);
    if (response.data['profile_pic']!=null||response.data['profile_pic']!="") {
      print(response.data);


      return DoubleResponse(
          response.data['profile_pic'], "Success");
    }
    return DoubleResponse(
        response.data['profile_pic'],"failed");
  }

}
