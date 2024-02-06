import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/comunication_module/communication_urls.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DummyUserDataSource {
  Dio client = Dio();
  Future<String> tokenCreationCommunicationData() async {
    print("reached datasource  ${authentication.authenticatedUser.token}  ${CommunicationUrls.tokenCreationCommunicationUrl} ");

    String getToken = "";

    final response = await client.post(
      CommunicationUrls.tokenCreationCommunicationUrl,
      data: {
        "token": "${authentication.authenticatedUser.token}"
        },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.data['status'] == "success") {
      getToken = response.data['token'];
    }
    print("get token is this ${getToken}");
    return getToken;
  }

  Future<DataResponse> dummyUserLoginDataSource(
      {required String password, required String email}) async {
    final String? dummyToken;
    final response = await client.post(
      "https://api-communication-application.hilalcart.com/api/user/login",
      data: {"username": email, "password": password},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // "Access-Control-Allow-Credentials": true
        },
      ),
    );
    print(response.data);
    if (response.data['status'] == "success") {
      dummyToken = response.data['token'];

      return DataResponse(data: dummyToken, error: response.data['message']);
    }
    return DataResponse(data: null, error: response.data['message']);
  }

  Future<DoubleResponse> dummyUserSignUpDataSource(
      {required String email,
      required String password,
      required String userName}) async {
    final response = await client.post(
      "https://api-communication-application.hilalcart.com/api/user/register",
      data: {"email": email, "username": userName, "password": password},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // "Access-Control-Allow-Credentials": true
        },
      ),
    );
    return DoubleResponse(response.data['status'], response.data['message']);
  }
}
