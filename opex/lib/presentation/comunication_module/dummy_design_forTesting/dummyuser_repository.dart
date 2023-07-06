// user login
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummyuser_datasource.dart';
import 'package:flutter/material.dart';

class DummyUserProvider {
  final DummyUserDataSource _dataSource = DummyUserDataSource();

  Future<DataResponse> userLogIn({
    required String password,
    required String email,
  }) async {
    final restAPIresponse = await _dataSource.dummyUserLoginDataSource(
      password: password,
      email: email,
    );
    try {
      if (restAPIresponse.data.isNotEmpty) {
        return DataResponse(data: restAPIresponse);
      } else {
        return DataResponse(error: restAPIresponse.error ?? "");
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: restAPIresponse.data ?? "",
    );
  }
}
