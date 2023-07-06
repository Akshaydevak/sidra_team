

import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/order_app/data/order_src.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:flutter/material.dart';

import 'organisation_src.dart';

class OrganisationRepo {
  final OrganisationSource _dataSource = OrganisationSource();

  Future<DataResponse> listOrgModel() async {
    final apiResponse = await _dataSource.organisationList();
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
  Future<DataResponse> listBusinessModel() async {
    final apiResponse = await _dataSource.bussinessUnitList();
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
  Future<DataResponse> listOperationalModel() async {
    final apiResponse = await _dataSource.operationalUnitList();
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