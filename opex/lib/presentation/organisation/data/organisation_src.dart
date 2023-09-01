

import 'package:cluster/core/cluster_urls.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:cluster/presentation/order_app/utils/order_app_urls.dart';
import 'package:cluster/presentation/organisation/model/org_model.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:dio/dio.dart';

import 'organisation_url.dart';

class OrganisationSource {
  Dio client = Dio();

  // order list
  Future<PaginatedResponse> organisationList() async {
    List<OrgModel> tasktypeList = [];
    print(OrganisationUrls.legalUnitUrl);
    final response = await client.get(
      OrganisationUrls.legalUnitUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '241d4889da5d5b6a68e4c170907b724fa9d5e84d',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(OrgModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }
  Future<PaginatedResponse> bussinessUnitList() async {
    List<OrgModel> tasktypeList = [];
    print(OrganisationUrls.businessUnitUrl);
    final response = await client.get(
      OrganisationUrls.businessUnitUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '241d4889da5d5b6a68e4c170907b724fa9d5e84d',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(OrgModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }
  Future<PaginatedResponse> operationalUnitList() async {
    List<OrgModel> tasktypeList = [];
    print(OrganisationUrls.operationalUnitUrl);
    final response = await client.get(
      OrganisationUrls.operationalUnitUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '241d4889da5d5b6a68e4c170907b724fa9d5e84d',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(OrgModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }


}
