
import 'package:cluster/core/cluster_urls.dart';
import 'package:dio/dio.dart';
import '../../../../../core/utils/data_response.dart';
import '../../../authentication/authentication.dart';
import '../../../inventory/model/division_model.dart';
import '../../../inventory/model/inventory_model.dart';
import '../models_org/org_model.dart';

class OrgTaskSource {
  Dio client = Dio();


  Future<DataResponse> createdepartment({

    required String name,

  }) async {

    final response = await client.post(
      ClusterUrls.createDepartmentUrl,
      data: {
        "name":name
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DepartmentTaskModel> getDepartmentTaskRead(int id) async {
    DepartmentTaskModel divisionModel;

    print("method type:${ClusterUrls.readDepartmentUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readDepartmentUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DepartmentTaskModel.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteDepartmentTask(int id) async {
    String statusCode;
    print("dele${ClusterUrls.readDepartmentUrl + id.toString()}");
    final response = await client.delete(
      ClusterUrls.readDepartmentUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateDepartmentTaskPost({
    required String name,
    required int id,
  }) async {
    print("DATA IDD$name");
    final response = await client.patch(
      ClusterUrls.readDepartmentUrl+id.toString(),
      data: {
        "name":name,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<DepartmentTaskModel>>> getdepartmentlist(
      String? search, String? next,String? prev) async {
    List<DepartmentTaskModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.listdepartmentUrl}?name=$search"
          : ClusterUrls.listdepartmentUrl;

    }
    print("api " + api);
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(DepartmentTaskModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }


  //role
  Future<DataResponse> createDepartmentRole({

    required String name,

  }) async {

    final response = await client.post(
      ClusterUrls.createDepartmentRoleUrl,
      data: {
        "name":name
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DepartmentTaskModel> getDepartmentTaskReadRole(int id) async {
    DepartmentTaskModel divisionModel;

    print("method type:${ClusterUrls.readDepartmentRoleUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readDepartmentRoleUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DepartmentTaskModel.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteDepartmentTaskRole(int id) async {
    String statusCode;
    print("dele${ClusterUrls.readDepartmentRoleUrl + id.toString()}");
    final response = await client.delete(
      ClusterUrls.readDepartmentRoleUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateDepartmentTaskRole({
    required String name,
    required int id,
  }) async {
    print("DATA IDD$name");
    final response = await client.patch(
      ClusterUrls.readDepartmentRoleUrl+id.toString(),
      data: {
        "name":name,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<DepartmentTaskModel>>> getdepartmentlistRole(
      String? search, String? next,String? prev) async {
    List<DepartmentTaskModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.listDepartmentRolesUrl}?name=$search"
          : ClusterUrls.listDepartmentRolesUrl;

    }
    print("api " + api);
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(DepartmentTaskModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //roleUnderDepartment
  Future<PaginatedResponse<List<DepartmentTaskModel>>> getRoleUnderDepartment(
      String? search, String? next,String? prev,int? id) async {
    List<DepartmentTaskModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.roleUderDepartmentUrl}${id.toString()}?name=$search"
          : ClusterUrls.roleUderDepartmentUrl+id.toString();

    }
    print("api " + api);
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(DepartmentTaskModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

}
