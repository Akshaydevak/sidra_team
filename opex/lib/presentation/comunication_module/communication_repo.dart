import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:flutter/material.dart';

class CommunicationRepository {
  final CommunicationDatasource _dataSource = CommunicationDatasource();
  Future<DataResponse> getSearchUserRepo(
      String searchQuery, String token) async {
    try {
      final restAPIresponse =
          await _dataSource.getSearchedUsers(searchQuery, token);

      if (restAPIresponse.isNotEmpty) {
        return DataResponse(
          data: restAPIresponse,
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

  // Future<DataResponse> addAFriendUser(String token, String id) async {
  //   try {
  //     final restAPIresponse = await _dataSource.addAFriendUser(token, id);

  //     if (restAPIresponse.data1) {
  //       return DataResponse(
  //         data: restAPIresponse,
  //       );
  //     } else {
  //       return DataResponse(
  //         error: "implement Error conersion Text",
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint("implement Error conersion Text$e");
  //   }
  //   return DataResponse(
  //     error: "implement Error conersion Text",
  //   );
  // }

  Future<DataResponse> getChatList(String token) async {
    try {
      final restAPIresponse = await _dataSource.getChatListData(token);

      if (restAPIresponse.isNotEmpty) {
        return DataResponse(
          data: restAPIresponse,
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
}
