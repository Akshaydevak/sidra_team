

import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/order_app/data/order_src.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:flutter/material.dart';

class OredrRepo {
  final OrderDataSource _dataSource = OrderDataSource();

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
  Future<DataResponse> login(String? email, String? password, String? code)async {
    final apiResponse = await _dataSource.login(email,password,code);
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
  Future<DataResponse> getEmployeeList() async {
    final apiResponse = await _dataSource.getEmployeeList();
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

  Future<DataResponse> moveToPicking(CreatePickingModel? updateOrder) async {
    final apiResponse = await _dataSource.moveToPicking(updateOrder);
    try {
      if (apiResponse.data1) {
        return DataResponse(data: apiResponse.data1,error: apiResponse.data2);
      } else {
        return DataResponse(error: apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: [],
        error: "error Text");
  }
  Future<DataResponse> moveToPacking(String? orderCode, List<int>? orderLineIds,bool? isPacking,bool? isAssignment,String? organizationCode,String? employeeCode)async {
    final apiResponse = await _dataSource.moveToPacking(orderCode,orderLineIds,isPacking,isAssignment,organizationCode??"",employeeCode);
    try {
      if (apiResponse.data1) {
        return DataResponse(data: apiResponse.data1,error: apiResponse.data2);
      } else {
        return DataResponse(error: apiResponse.data2,data: false);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(
        data: [],
        error: "error Text");
  }

  Future<DataResponse> getPicklist(bool? isAssign) async {
    final apiResponse = await _dataSource.getPicklist(isAssign);
    try {
      if (apiResponse.data.isNotEmpty) {
        return DataResponse(data: apiResponse.data);
      } else {
        return DataResponse(
            data: [],
            error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //taskRead
  Future<DataResponse> getPacklist() async {
    try {
      final apiResponse = await _dataSource.getPacklist();

      if (apiResponse.data.isNotEmpty) {
        return DataResponse(
          data: apiResponse.data,
        );
      } else {
        return DataResponse(
          data: [],
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

  //assignCount
  Future<DataResponse> getAssignCount(int? id) async {
    try {
      final apiResponse = await _dataSource.getAssignCount(id);

      if (apiResponse.id != null) {
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


}