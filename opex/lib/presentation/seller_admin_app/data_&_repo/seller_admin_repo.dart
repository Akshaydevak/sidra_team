import 'package:cluster/presentation/seller_admin_app/data_&_repo/seller_admin_datasourse.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/data_response.dart';

class SellerAdminRepo {
  final SellerAdminDataSource _dataSource = SellerAdminDataSource();

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
    final restAPIresponse = await _dataSource.createSeller(
        name: name,
        isActive: isActive,
      description: description,
      address: address,
      category: category,
      cityOrTown: cityOrTown,
      country: country,
      displayName: displayName,
      email: email,
      landmark: landmark,
      location: location,
      phone: phone,
      postalcode: postalcode,
       searchName: searchName,
      state: state,
      userId: userId


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
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
    required int id

  }) async {
    final restAPIresponse = await _dataSource.updateSeller(
        name: name,
        isActive: isActive,
        description: description,
        address: address,
        category: category,
        cityOrTown: cityOrTown,
        country: country,
        displayName: displayName,
        email: email,
        landmark: landmark,
        location: location,
        phone: phone,
        postalcode: postalcode,
        searchName: searchName,
        state: state,
        userId: userId,id: id



    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  //
  Future<PaginatedResponse> categoryList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.categoryList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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

  //sellerlist
  Future<PaginatedResponse> sellerList(String? search,String? next,String? prev,String? filter) async {
    print("hi hello ${filter}");
    final apiResponse = await _dataSource.sellerList(search,next,prev,filter);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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

  //outlet
  Future<PaginatedResponse> outletList(String? id,String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.outletList(id,search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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
  //outletcreate
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
    final restAPIresponse = await _dataSource.createOutlet(
        name: name,
        legalCode: legalCode,
        description: description,
        address: address,
        category: category,
        cityOrTown: cityOrTown,
        country: country,
        displayName: displayName,
        email: email,
        landmark: landmark,
        location: location,
        phone: phone,
        postalcode: postalcode,
        searchName: searchName,
        state: state,
        userId: userId


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
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
    final restAPIresponse = await _dataSource.updateOutlet(
        name: name,
        legalCode: legalCode,
        description: description,
        address: address,
        category: category,
        cityOrTown: cityOrTown,
        country: country,
        displayName: displayName,
        email: email,
        landmark: landmark,
        location: location,
        phone: phone,
        postalcode: postalcode,
        searchName: searchName,
        state: state,
        userId: userId,
      id: id


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //update
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
    final restAPIresponse = await _dataSource.updateOrganisation(
        name: name,
        postalCode: postalCode,
        categoryId: categoryId,
        address: address,
        discription: discription,
        parentId: parentId,
        country: country,
        displayName: displayName,
        email: email,
        landmark: landmark,
        location: location,
        phone: phone,
        phoneTwo: phoneTwo,
        cityorTown: cityorTown,
        searchName: searchName,
        state: state,
        userId: userId,
        id: id


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //readSeller
  Future<DataResponse> getSellerRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getSellerRead(id!);

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
      error: "implement Error conersion Text",
    );
  }

  //readOutlet
  Future<DataResponse> getOutletRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getOutletRead(id!);

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
      error: "implement Error conersion Text",
    );
  }

  //offficial
  Future<PaginatedResponse> OfficialRoleList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.OfficialRoleList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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
  //userVerify
  Future<PaginatedResponse> userVerifyList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.userVerifyList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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
  //additional
  Future<PaginatedResponse> AdditionalRoleList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.AdditionalRoleList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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
  //depart
  Future<PaginatedResponse> DepartmentList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.DepartmentList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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
  //design
  Future<PaginatedResponse> DesignationList(String? code,String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.DesignationList(code,search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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

  //createdesig
  Future<DataResponse> createDesignation({
    required String title,
    required String description,
    required String department,
    required String legalEntity,

  }) async {
    final restAPIresponse = await _dataSource.createDesignation(

        description: description,
        department: department,
      legalEntity: legalEntity,
      title: title


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
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
    final restAPIresponse = await _dataSource.createUser(
        department: department,
       additionalRole: additionalRole,
      businessCode: businessCode,
      designation: designation,
      email: email,
      fName: fName,
      gender: gender,
      lName: lName,
      entityCode: entityCode,
      nationality: nationality,
      officialRole: officialRole,
      password: password,
       phone: phone

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      print("object");
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  //emplist
  Future<PaginatedResponse> EmployeeUserList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.EmployeeUserList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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

  //dirlist
  Future<PaginatedResponse> DirectorUserList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.DirectorUserList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
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

  //coutry
  Future<DataResponse> countryList() async {
    final apiResponse = await _dataSource.countryList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //state

  Future<DataResponse> stateList(String? code) async {
    final apiResponse = await _dataSource.stateList(code);
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //
  Future<DataResponse> getFaqList(String? search) async {
    final apiResponse = await _dataSource.getFaqList(search);
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }


  //business
  Future<DataResponse> getBusinessDetailsRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getBusinessDetailsRead();

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
      error: "implement Error conersion Text",
    );
  }

  //dash
  Future<DataResponse> getAdminDashboardRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getAdminDashboardRead();

      if (apiResponse.totalSellers != null) {
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
      error: "implement Error conersion Text",
    );
  }

  //
  Future<DataResponse> getAdminViewDashboard() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getAdminViewDashboard();

      if (apiResponse.newOrders != null) {
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
      error: "implement Error conersion Text",
    );
  }

  //verify
  Future<DataResponse> verifyUser({required String code,required bool? reject}) async {
    print("object");
    try {
      final apiResponse = await _dataSource.verifyUser(code: code,reject: reject);

      if (apiResponse.newOrders != null) {
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
      error: "implement Error conersion Text",
    );
  }

}
