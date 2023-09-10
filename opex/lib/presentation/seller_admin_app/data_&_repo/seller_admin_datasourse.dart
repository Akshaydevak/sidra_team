import 'dart:io';

import 'package:cluster/presentation/seller_admin_app/data_&_repo/seller_admin_urls.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../core/utils/data_response.dart';
import '../../authentication/authentication.dart';
import '../../seller_app/seller_models/seller_model_class.dart';
import '../model_seller_admin/seller_admin_models.dart';

class SellerAdminDataSource {
  Dio client = Dio();

  Future<DataResponse> createSeller({
    required String address,
    required String location,
    required String country,
    required String state,
    required String cityOrTown,
    required String landmark,
    required String postalcode,
    required String phone,
    required String email,
    required int? userId,
    required String name,
    required String searchName,
    required String displayName,
    required String description,
    required bool isActive,
    required int category,

  }) async {
    final response = await client.post(
      SellerAdminUrls.createSellerUrl,
      data:
      {
        "address":address,
        "location":location,
        "country":country,
        "state":state,
        "city_or_town":cityOrTown,
        "landmark":landmark,
        "postalcode":postalcode,
        "phone_number":phone,
        "email":email,
        "user_id":userId,
        "name":name,
        "search_name":searchName,
        "display_name":displayName,
        "description":description,
        "is_active":isActive,
        "category":category,
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
          data: response.data["status"]=="success", error: response.data['data']['id'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  //
  Future<DataResponse> updateSeller({
    required String address,
    required String location,
    required String country,
    required String state,
    required String cityOrTown,
    required String landmark,
    required String postalcode,
    required String phone,
    required String email,
    required int? userId,
    required String name,
    required String searchName,
    required String displayName,
    required String description,
    required bool isActive,
    required int category,
    required int id,

  }) async {
    print("BABABAB${SellerAdminUrls.readSellersUrl+id.toString()}");
    print("BABABAB${address}");
    final response = await client.patch(
      SellerAdminUrls.readSellersUrl+id.toString(),
      data:
      {
        "address_one":address,
        "location":location,
        "country":country,
        "state":state,
        "city_or_town":cityOrTown,
        "landmark":landmark,
        "postalcode":postalcode,
        "phone_number":phone,
        "email":email,
        "user_id":userId,
        "name":name,
        "search_name":searchName,
        "display_name":displayName,
        "description":description,
        "is_active":isActive,
        "category":category,
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


  //
  Future<PaginatedResponse<List<CategoryListSeller>>> categoryList(
      String? search,String? next,String? prev) async {
    List<CategoryListSeller> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.categoryListSellerUrl}?search_key=$search"
          : SellerAdminUrls.categoryListSellerUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api!!!! " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(CategoryListSeller.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //selleer
  Future<PaginatedResponse<List<SellerListAdmin>>> sellerList(
      String? search,String? next,String? prev,String? filter) async {
    print("asdfg$filter");
    List<SellerListAdmin> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else if(filter!.isNotEmpty){
     api="${SellerAdminUrls.sellerListUrl}?sort_by=$filter";
     print("asdfg$filter");

    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.sellerListUrl}?search_key=$search"
          : SellerAdminUrls.sellerListUrl;
    }

    print("api!!!! " + api);
    print("api!!!!   ${authentication.authenticatedUser.token}");
    try{
      final response = await client.get(api,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':authentication.authenticatedUser.token
            },
          ));
      print("api!!!! " + api);
      print("response${response.data['data']}");
      (response.data['data']['results'] as List).forEach((element) {
        nationalityModel.add(SellerListAdmin.fromJson(element));
      });
      return PaginatedResponse(
        nationalityModel,
        response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous'],
      );
    }
    catch(dd){
      print("that erroe$dd");
    }
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api!!!! " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(SellerListAdmin.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //outlet
  Future<PaginatedResponse<List<SellerListAdmin>>> outletList(
      String? id,String? search,String? next,String? prev) async {
    List<SellerListAdmin> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.businessOutletListUrl+id.toString()}?name=$search"
          : SellerAdminUrls.businessOutletListUrl+id.toString();
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api!!!!=== $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(SellerListAdmin.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }
//createOutlet
  Future<DataResponse> createOutlet({
    required String address,
    required String location,
    required String country,
    required String state,
    required String cityOrTown,
    required String landmark,
    required String postalcode,
    required String phone,
    required String email,
    required String? userId,
    required String name,
    required String searchName,
    required String displayName,
    required String description,
    required String legalCode,
    required int category,

  }) async {
    print("cate$category");
    print("cate$legalCode");
    final response = await client.post(
      SellerAdminUrls.createOutletUrl,
      data:
      {
        "address": address,
        "location": location,
        "country": country,
        "state": state,
        "city_or_town": cityOrTown,
        "landmark": landmark,
        "postalcode": postalcode,
        "phone_number": phone,
        "email": email,
        "sunday": false,
        "monday": false,
        "tuesday": false,
        "wednesday": false,
        "thursday": false,
        "friday": false,
        "saturday": false,
        "name": name,
        "description": description,
        "user_id": userId,
        "search_name": searchName,
        "display_name": displayName,
        "is_active": true,
        "group_list": null,
        "is_inventory": true,
        "business_address": null,
        "category_id": category,
        "legal_code": legalCode,
        "social_links":{}
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("response update$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['data']['id'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  //updateOutlet
  Future<DataResponse> updateOutlet({
    required String address,
    required String location,
    required String country,
    required String state,
    required String cityOrTown,
    required String landmark,
    required String postalcode,
    required String phone,
    required String email,
    required String? userId,
    required String name,
    required String searchName,
    required String displayName,
    required String description,
    required String legalCode,
    required int category,
    required int id,

  }) async {
    print("cate$category");
    print("cate$legalCode");
    final response = await client.patch(
      SellerAdminUrls.readOutletUrl+id.toString(),
      data:
      {
        "address": address,
        "location": location,
        "country": country,
        "state": state,
        "city_or_town": cityOrTown,
        "landmark": landmark,
        "postalcode": postalcode,
        "phone_number": phone,
        "email": email,
        "sunday": false,
        "monday": false,
        "tuesday": false,
        "wednesday": false,
        "thursday": false,
        "friday": false,
        "saturday": false,
        "name": name,
        "description": description,
        "user_id": userId,
        "search_name": searchName,
        "display_name": displayName,
        "is_active": true,
        "group_list": null,
        "is_inventory": true,
        "business_address": null,
        "category_id": category,
        "legal_code": legalCode,
        "social_links":{}
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

  //update org
  Future<DataResponse> updateOrganisation({
    required String address,
    required String location,
    required String country,
    required String state,
    required String cityorTown,
    required String landmark,
    required String postalCode,
    required String phone,
    required String phoneTwo,
    required String email,
    required String? userId,
    required String name,
    required String searchName,
    required String displayName,
    required String discription,
    required int parentId,
    required int categoryId,
    required int id,

  }) async {
    print("org=${SellerAdminUrls.updateOrganisationUrl+id.toString()}");
    final response = await client.patch(
      SellerAdminUrls.updateOrganisationUrl+id.toString(),
      data:
      {
        "address_one": address,
        "location": location,
        "country": country,
        "state": state,
        "city_or_town": cityorTown,
        "landmark": landmark,
        "pin": postalCode,
        "contact": phone,
        "email": email,
        "name": name,
        "description": discription,
        "user_id": userId,
        "search_name": searchName,
        "display_name": displayName,
        "is_active": true,
        "category_id": categoryId,
        "parent_id": parentId,
        "contact_second":phoneTwo
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


  //readSeller
  Future<SellerListAdmin> getSellerRead(int id) async {
    SellerListAdmin sellerListAdmin;

    print("Seller Read:${SellerAdminUrls.readSellersUrl + id.toString()}");
    final response = await client.get(
      SellerAdminUrls.readSellersUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerListAdmin.fromJson((response.data['data']));

    return sellerListAdmin;
  }

  //outletRead
  Future<SellerListAdmin> getOutletRead(int id) async {
    SellerListAdmin sellerListAdmin;

    print("Outlet Read:${SellerAdminUrls.readOutletUrl + id.toString()}");
    final response = await client.get(
      SellerAdminUrls.readOutletUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerListAdmin.fromJson((response.data['data']));

    return sellerListAdmin;
  }

  //official
  Future<PaginatedResponse<List<RoleModelList>>> OfficialRoleList(String? search,String? next,String? prev) async {
    List<RoleModelList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.officialRoleListUrl}?name=$search"
          : SellerAdminUrls.officialRoleListUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':'token ${authentication.authenticatedUser.token}'
          },
        ));
    print("api!!!! $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(RoleModelList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }
  //userVerify
  Future<PaginatedResponse<List<VerifyUserList>>> userVerifyList(String? search,String? next,String? prev) async {
    List<VerifyUserList> userVerify = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.userVerifyListUrl}?name=$search"
          : SellerAdminUrls.userVerifyListUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':'token ${authentication.authenticatedUser.token}'
          },
        ));
    print("api!!!! $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      userVerify.add(VerifyUserList.fromJson(element));
    });
    return PaginatedResponse(
      userVerify,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //additioanl
  Future<PaginatedResponse<List<RoleModelList>>> AdditionalRoleList(String? search,String? next,String? prev) async {
    List<RoleModelList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.additionalRoleListUrl}?name=$search"
          : SellerAdminUrls.additionalRoleListUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':'token ${authentication.authenticatedUser.token}'
          },
        ));
    print("api!!!! $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(RoleModelList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //depart
  Future<PaginatedResponse<List<DepartmentModelList>>> DepartmentList(String? search,String? next,String? prev) async {
    List<DepartmentModelList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.departmentListUrl}?search_key=$search"
          : SellerAdminUrls.departmentListUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api!!!! $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(DepartmentModelList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //designa
  Future<PaginatedResponse<List<DepartmentModelList>>> DesignationList(
      String? code,String? search,String? next,String? prev) async {
    List<DepartmentModelList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.designationListUrl}?name=$search"
          : "${SellerAdminUrls.designationListUrl}$code/designations";
    }

    print("api!!!! $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api!!!! $api");
    print("api!!!! ${authentication.authenticatedUser.legalEntity}");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(DepartmentModelList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //createDesig
  Future<DataResponse> createDesignation({
    required String title,
    required String description,
    required String department,
    required String legalEntity,
  }) async {
    print("nghhh${"${SellerAdminUrls.createDesignationUrl}$legalEntity/designation-create"}");
    final response = await client.post(
      "${SellerAdminUrls.createDesignationUrl}$legalEntity/designation-create",
      data:
      {
        "title":title,
        "description":description,
        "organization":legalEntity,
        "department_code":department,

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

  //createUser
  Future<DataResponse> createUser({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String gender,
    required String nationality,
    required String department,
    required String password,
    required String designation,
    required int? officialRole,
    required List<int>? additionalRole,
    required String businessCode,
    required String entityCode,
  }) async {
    print("create User Url:${"${SellerAdminUrls.createUser}business_code=$businessCode&organization_code=$entityCode"}");
    print("create User Url:$phone");
    print("create User Url:$officialRole");
    print("create User Url:$additionalRole");
    final response = await client.post(
      "${SellerAdminUrls.createUser}business_code=$businessCode&organization_code=$entityCode",
      data:
      {
        "first_name":fName,
        "last_name":lName,
        "email":email,
        "phone_number":phone,
        "gender":gender,
        "nationality":nationality,
        "department":department,
        "password":password,
        "designation":designation,
        "official_role":officialRole,
        "additional_roles":additionalRole,
        "business_code":businessCode,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':'token ${authentication.authenticatedUser.token}'
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

  //emplist
  Future<PaginatedResponse<List<SellerUserModel>>> EmployeeUserList(String? search,String? next,String? prev) async {
    List<SellerUserModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.employeeUserListUrl}?name=$search"
          : SellerAdminUrls.employeeUserListUrl;
    }

    print("api!!!! $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':"token ${authentication.authenticatedUser.token}"
          },
        ));
    print("api!!!! $api");
    print("api!!!! ${authentication.authenticatedUser.legalEntity}");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(SellerUserModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }


  //dirList
  Future<PaginatedResponse<List<SellerUserModel>>> DirectorUserList(String? search,String? next,String? prev) async {
    List<SellerUserModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${SellerAdminUrls.directorUserListUrl}?name=$search"
          : SellerAdminUrls.directorUserListUrl;
    }

    print("api!!!! $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':"token ${authentication.authenticatedUser.token}"
          },
        ));
    print("api!!!! $api");
    print("api!!!! ${authentication.authenticatedUser.legalEntity}");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(SellerUserModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }



  //contry
  Future<List<CountryStateModel>> countryList() async {
    List<CountryStateModel> perfomanceList = [];

    print("URL:${SellerAdminUrls.countryListUrl}");

    final response = await client.get(SellerAdminUrls.countryListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    (response.data['data'] as List).forEach((element) {
      perfomanceList.add(CountryStateModel.fromJson(element));
    });
    return perfomanceList;
  }


  //state
  Future<List<StateModel>> stateList(String? code) async {
    List<StateModel> perfomanceList = [];

    print("Perfomance URL:${SellerAdminUrls.stateListUrl}$code&value=list");

    final response = await client.get(
      "${SellerAdminUrls.stateListUrl}$code&value=list",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    (response.data['data'] as List).forEach((element) {
      perfomanceList.add(StateModel.fromJson(element));
    });
    return perfomanceList;
  }

  //
  Future<String> updatePicture({
    File? img,
    int? sellerId
    // CroppedFile? img,
  }) async {
    String statusCode;
    String filePath = "";
    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"company_logo": fileData});

    print("UUUU${SellerAdminUrls.profileUpdateSellerUrl + sellerId.toString()}");
    final response = await client.patch(
      SellerAdminUrls.profileUpdateSellerUrl + sellerId.toString(),
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token,
        },
      ),
    );

    print(response.data);
    statusCode = (response.data['status']);

    print(statusCode);
    return statusCode;
  }
//
  Future<List<FaqList>> getFaqList(String? search) async {
    List<FaqList> faqList = [];


    // print("help support:https://api-uat-system-architecture.sidrabazar.com/policy/policies-by-group?key=sidra_teams");
    String api="";
    if(search!=""){
      api="https://api-uat-system-architecture.sidrabazar.com/policy/policies-by-group?key=sidra_teams&search_text=$search";
    }
    else{
      api = "https://api-uat-system-architecture.sidrabazar.com/policy/policies-by-group?key=sidra_teams";
    }
    print(api);
    print(search);
    final response = await client.get(api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("Respoc FAQ${response.data['data']}");
    (response.data['data']as List).forEach((element) {
      faqList.add(FaqList.fromJson(element));
    });
    return faqList;
  }


  //
  Future<List<PolicyModel>> getPolicy() async {
    List<PolicyModel> policyModel = [];

    final response = await client.get(
      "https://api-uat-system-architecture.sidrabazar.com/policy/list-policies-by-category/1",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    (response.data['data'] as List).forEach((element) {
      policyModel.add(
        PolicyModel.fromJson(element),
      );
    });

    return policyModel;
  }

  //business
  Future<SellerListAdmin> getBusinessDetailsRead() async {
    SellerListAdmin sellerListAdmin;

    print("Business Detaiks Read:${SellerAdminUrls.readBusinessDetailsUrl}");
    final response = await client.get(
      SellerAdminUrls.readBusinessDetailsUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerListAdmin.fromJson((response.data['data']));

    return sellerListAdmin;
  }

  //
  Future<SellerAdminDashboard> getAdminDashboardRead() async {
    SellerAdminDashboard sellerListAdmin;

    print("Business Detaiks Read:${SellerAdminUrls.sellerAdminDashboardUrl}");
    final response = await client.get(
      SellerAdminUrls.sellerAdminDashboardUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerAdminDashboard.fromJson((response.data['data']));

    return sellerListAdmin;
  }

  //
  Future<SellerAdminDashboard> getAdminViewDashboard() async {
    SellerAdminDashboard sellerListAdmin;

    print("Business Detaiks Read:${SellerAdminUrls.sellerAdminViewDashboardUrl}");
    final response = await client.get(
      SellerAdminUrls.sellerAdminViewDashboardUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerAdminDashboard.fromJson((response.data['data']));

    return sellerListAdmin;
  }
//verify
  Future<SellerAdminDashboard> verifyUser({required String code,required bool? reject}) async {
    SellerAdminDashboard sellerListAdmin;


    String api='';
    if(reject==true){
      api="${SellerAdminUrls.verfyUserUrl+code.toString()}?verify_key=reject";
    }
    else{
      api=SellerAdminUrls.verfyUserUrl+code.toString();
    }
    print("Verify Get:$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':"token ${authentication.authenticatedUser.token}"
        },
      ),
    );
    print(response.data);
    sellerListAdmin = SellerAdminDashboard.fromJson((response.data['data']));

    return sellerListAdmin;
  }
}
