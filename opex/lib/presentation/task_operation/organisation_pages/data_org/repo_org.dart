
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/data_org/source_org.dart';
import 'package:flutter/cupertino.dart';


class OrgTaskRepo {
  final OrgTaskSource _dataSource = OrgTaskSource();

  Future<DataResponse> createdepartment({
    required String name,


  }) async {
    final restAPIresponse = await _dataSource.createdepartment(
        name: name,

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getDepartmentTaskRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getDepartmentTaskRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
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
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateDepartmentTaskPost({
    required String name,
    required int id,
  }) async {
    final restAPIresponse = await _dataSource.updateDepartmentTaskPost(
        id: id,
        name: name,
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getdepartmentlist(String? search, String? next,String? prev) async {
    final apiResponse = await _dataSource.getdepartmentlist(search,next,prev);
    try {
      if (apiResponse.data!= null ) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //role
  Future<DataResponse> createDepartmentRole({
    required String name,


  }) async {
    final restAPIresponse = await _dataSource.createDepartmentRole(
      name: name,

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getDepartmentTaskReadRole(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getDepartmentTaskReadRole(id!);

      if (apiResponse.name != null) {
        print("sucCess");
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
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateDepartmentTaskRole({
    required String name,
    required int id,
  }) async {
    final restAPIresponse = await _dataSource.updateDepartmentTaskRole(
      id: id,
      name: name,
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getdepartmentlistRole(String? search, String? next,String? prev) async {
    final apiResponse = await _dataSource.getdepartmentlistRole(search,next,prev);
    try {
      if (apiResponse.data!= null ) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //roleunderdepart

  Future<PaginatedResponse> getRoleUnderDepartment(String? search, String? next,String? prev,int? id) async {
    final apiResponse = await _dataSource.getRoleUnderDepartment(search,next,prev,id);
    try {
      if (apiResponse.data!= null ) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

}