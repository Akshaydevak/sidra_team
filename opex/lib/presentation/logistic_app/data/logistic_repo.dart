import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/logistic_app/data/logitstic_src.dart';
import 'package:flutter/material.dart';

class LogisticsRepo {
  final LogisticsDataSource _dataSource = LogisticsDataSource();

  Future<DataResponse> listOrdersModel() async {
    final apiResponse = await _dataSource.listOrders();
    try {
      if (apiResponse.data.isNotEmpty) {
        return DataResponse(data: apiResponse.data);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
      data: [],
      error: "error Text");
  }
}