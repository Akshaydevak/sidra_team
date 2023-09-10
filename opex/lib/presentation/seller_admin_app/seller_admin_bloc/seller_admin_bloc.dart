import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data_&_repo/seller_admin_datasourse.dart';
import '../data_&_repo/seller_admin_repo.dart';
import '../model_seller_admin/seller_admin_models.dart';

part 'seller_admin_event.dart';
part 'seller_admin_state.dart';

class SellerAdminBloc extends Bloc<SellerAdminEvent, SellerAdminState> {
  final SellerAdminRepo _sellerRepo = SellerAdminRepo();
  final SellerAdminDataSource _dataSource = SellerAdminDataSource();
  SellerAdminBloc() : super(CreateSellerLoading()) ;
    @override
    Stream<SellerAdminState> mapEventToState(SellerAdminEvent event) async* {


      if (event is NewSellerCreateEvent) {
        yield* createSeller(
            name: event.name.trim(),
           isActive: event.isActive,
           description: event.discription.trim(),
          address: event.address,
          category: event.category,
          cityOrTown: event.cityorTown,
          country: event.country,
          displayName: event.displayName,
          email: event.email,
          landmark: event.landmark,
          location: event.location,
          phone: event.phone,
          postalcode: event.postalCode,
          searchName: event.searchName,
          state: event.state,
          userId: event.userId
        );
      }
      if (event is NewSellerUpdateEvent) {
        yield* updateSeller(
            name: event.name.trim(),
            id: event.id,
            isActive: event.isActive,
            description: event.discription.trim(),
            address: event.address,
            category: event.category,
            cityOrTown: event.cityorTown,
            country: event.country,
            displayName: event.displayName,
            email: event.email,
            landmark: event.landmark,
            location: event.location,
            phone: event.phone,
            postalcode: event.postalCode,
            searchName: event.searchName,
            state: event.state,
            userId: event.userId
        );
      }
      if (event is CategoryListSellerEvent) {
        yield* categoryList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }

      if (event is SellerListSellerEvent) {
        yield* sellerList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim(),
          filter: event.filter
        );
      }

      if (event is BusinessOutletListEvent) {
        yield* outletList(
          id: event.id,
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }

      if (event is NewOutletCreateEvent) {
        yield* createOutlet(
            name: event.name.trim(),
            legalCode: event.legalCode,
            description: event.discription.trim(),
            address: event.address,
            category: event.category,
            cityOrTown: event.cityorTown,
            country: event.country,
            displayName: event.displayName,
            email: event.email,
            landmark: event.landmark,
            location: event.location,
            phone: event.phone,
            postalcode: event.postalCode,
            searchName: event.searchName,
            state: event.state,
            userId: event.userId
        );
      }

      if (event is OutletUpdateEvent) {
        yield* updateOutlet(
            name: event.name.trim(),
            legalCode: event.legalCode,
            description: event.discription.trim(),
            address: event.address,
            category: event.category,
            cityOrTown: event.cityorTown,
            country: event.country,
            displayName: event.displayName,
            email: event.email,
            landmark: event.landmark,
            location: event.location,
            phone: event.phone,
            postalcode: event.postalCode,
            searchName: event.searchName,
            state: event.state,
            userId: event.userId,
          id: event.id
        );
      }

      //org update
      if (event is OrgUpdateEvent) {
        yield* updateOrganisation(
            name: event.name.trim(),
            postalCode: event.postalCode,
            discription: event.discription.trim(),
            address: event.address,
            categoryId: event.categoryId,
            parentId: event.parentId??0,
            country: event.country,
            displayName: event.displayName,
            email: event.email,
            landmark: event.landmark,
            location: event.location,
            phone: event.phone,
            phoneTwo: event.phoneTwo??"",
            searchName: event.searchName,
            state: event.state,
            userId: event.userId,
            id: event.id,
          cityorTown: event.cityorTown
        );
      }

      if (event is GetSellerRead) {
        yield* getSellerRead(event.id);
      }
      if (event is GetOutletRead) {
        yield* getOutletRead(event.id);
      }
      if (event is GetBusinessDetailsRead) {
        yield* getBusinessDetailsRead();
      }
      if (event is GetAdminDashboardRead) {
        yield* getAdminDashboardRead();
      }
      if (event is SellerAdminViewDashboard) {
        yield* getAdminViewDashboard();
      }
      if (event is GetFaqListEvent) {
        yield* getFaqListState(event.search);
      }
      if (event is OfficialRoleListEvent) {
        yield* OfficialRoleList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }
      if (event is UserVerifyListEvent) {
        yield* userVerifyList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }
      if (event is AdditionalRoleListEvent) {
        yield* AdditionalRoleList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }
      if (event is DepartmentListEvent) {
        yield* DepartmentList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }
      if (event is DesignationListEvent) {
        yield* DesignationList(
            code: event.code,
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }

      if (event is CreateDesignationEvent) {
        yield* createDesignation(
          description: event.description,
          department: event.department,
          legalEntity: event.legalEntity,
          title: event.title
        );
      }

      if (event is CreateUserEvent) {
        yield* createUser(
            department: event.department,
            entityCode: event.entityCode,
            additionalRole: event.additionalRole,
          businessCode: event.businessCode,
          designation: event.designation,
          email: event.email,
          fName: event.fName,
          gender: event.gender,
          lName: event.lName,
          nationality: event.nationality,
          officialRole: event.officialRole,
          password: event.password,
          phone: event.phone
        );
      }

      if (event is EmployeeUserListEvent) {
        yield* EmployeeUserList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }

      if (event is DirectorUserListEvent) {
        yield* DirectorUserList(
            search: event.search,
            next: event.next?.trim(),
            prev: event.prev?.trim()
        );
      }

      if (event is CountryListEvent) {
        yield* countryList();
      }

      if (event is StateListEvent) {
        yield* stateList(
           code: event.code
        );
      }

       if (event is UpdateSellerPictureEvent) {
        yield* updatePicture(imag: event.image,sellerId: event.sellerId);
      }
      if (event is GetPolicyEvent) {
        yield* getPolicyStateMap();
      }

      if (event is VerifyUserEvent) {
        yield* verifyUser(
            code: event.code??"",
          reject: event.reject
        );
      }
  }

  Stream<SellerAdminState> createSeller(
      {
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
      }) async* {
    yield CreateSellerLoading();

    final dataResponse = await _sellerRepo.createSeller(
        name: name,
       userId: userId,
      state: state,
      searchName: searchName,
      postalcode: postalcode,
      phone: phone,
      location: location,
      landmark: landmark,
        email: email,
        displayName: displayName,
      country: country,
      cityOrTown: cityOrTown,
      category: category,
      address: address,
      description: description,
      isActive: isActive


    );

    if (dataResponse.data) {
      yield CreateSellerSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield CreateSellerFailed(
        dataResponse.error ?? "",);
    }

  }

  //update
  Stream<SellerAdminState> updateSeller(
      {
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
      }) async* {
    yield UpdateSellerLoading();

    final dataResponse = await _sellerRepo.updateSeller(
        name: name,
        userId: userId,
        state: state,
        searchName: searchName,
        postalcode: postalcode,
        phone: phone,
        location: location,
        landmark: landmark,
        email: email,
        displayName: displayName,
        country: country,
        cityOrTown: cityOrTown,
        category: category,
        address: address,
        description: description,
        isActive: isActive,
      id: id


    );

    if (dataResponse.data) {
      yield UpdateSellerSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield UpdateSellerFailed(
        dataResponse.error ?? "",);
    }

  }


  //cat
  Stream<SellerAdminState> categoryList({
    String? search,
    String? next,String? prev
  }) async* {
    yield CategoryListSellerLoading();
    final dataResponse = await _sellerRepo.categoryList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield CategoryListSellerSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          category:  dataResponse.data);  }

    else {
      yield CategoryListSellerFailed("failed");
    }
  }

  //seller
  Stream<SellerAdminState> sellerList({
    String? search,
    String? next,String? prev,String? filter
  }) async* {
    yield SellerListSellerLoading();
    final dataResponse = await _sellerRepo.sellerList(search,next,prev,filter);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield SellerListSellerSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          category:  dataResponse.data);
    }

    else {
      yield SellerListSellerFailed("failed");
    }
  }

  //outlet
  Stream<SellerAdminState> outletList({
    String? id,
    String? search,
    String? next,String? prev
  }) async* {
    yield BusinessOutletListLoading();
    final dataResponse = await _sellerRepo.outletList(id,search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield BusinessOutletListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          category:  dataResponse.data);
    }

    else {
      yield BusinessOutletListFailed("failed");
    }
  }
  //crete outlet
  Stream<SellerAdminState> createOutlet(
      {
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
      }) async* {
    yield CreateOutletLoading();

    final dataResponse = await _sellerRepo.createOutlet(
        name: name,
        userId: userId,
        state: state,
        searchName: searchName,
        postalcode: postalcode,
        phone: phone,
        location: location,
        landmark: landmark,
        email: email,
        displayName: displayName,
        country: country,
        cityOrTown: cityOrTown,
        category: category,
        address: address,
        description: description,
        legalCode: legalCode


    );

    if (dataResponse.data) {
      yield CreateOutletSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield CreateOutletFailed(
        dataResponse.error ?? "",);
    }

  }

  //updateOutlet
  Stream<SellerAdminState> updateOutlet(
      {
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
      }) async* {
    yield UpdateOutletLoading();

    final dataResponse = await _sellerRepo.updateOutlet(
        name: name,
        userId: userId,
        state: state,
        searchName: searchName,
        postalcode: postalcode,
        phone: phone,
        location: location,
        landmark: landmark,
        email: email,
        displayName: displayName,
        country: country,
        cityOrTown: cityOrTown,
        category: category,
        address: address,
        description: description,
        legalCode: legalCode,
      id: id


    );
    if (dataResponse.data) {
      yield UpdateOutletSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield UpdateOutletFailed(
        dataResponse.error ?? "",);
    }

  }


  //org update
  Stream<SellerAdminState> updateOrganisation(
      {
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
      }) async* {
    yield UpdateOrganisationLoading();

    final dataResponse = await _sellerRepo.updateOrganisation(
        name: name,
        userId: userId,
        state: state,
        searchName: searchName,
        cityorTown: cityorTown,
        phone: phone,
        location: location,
        landmark: landmark,
        email: email,
        displayName: displayName,
        country: country,
        phoneTwo: phoneTwo,
        parentId: parentId,
        address: address,
        discription: discription,
        categoryId: categoryId,
        postalCode: postalCode,
        id: id


    );
    if (dataResponse.data) {
      yield UpdateOrganisationSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield UpdateOrganisationFailed(
        dataResponse.error ?? "",);
    }

  }



  //readSeller
  Stream<SellerAdminState> getSellerRead(int id) async* {

    yield GetSellerReadLoading();

    final dataResponse = await _sellerRepo.getSellerRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetSellerReadSuccess(seller: dataResponse.data);
    } else {
      yield GetSellerReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //outletread
  Stream<SellerAdminState> getOutletRead(int id) async* {

    yield GetOutletReadLoading();

    final dataResponse = await _sellerRepo.getOutletRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetOutletReadSuccess(seller: dataResponse.data);
    } else {
      yield GetOutletReadFailed(dataResponse.error.toString(),
      );
    }
  }



  //officai
  Stream<SellerAdminState> OfficialRoleList({

    String? search,
    String? next,String? prev
  }) async* {
    yield OfficialRoleListLoading();
    final dataResponse = await _sellerRepo.OfficialRoleList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield OfficialRoleListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          role:  dataResponse.data);
    }

    else {
      yield OfficialRoleListFailed("failed");
    }
  }

  //userVerify
  Stream<SellerAdminState> userVerifyList({

    String? search,
    String? next,String? prev
  }) async* {
    yield UserVerifyListLoading();
    final dataResponse = await _sellerRepo.userVerifyList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield UserVerifyListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          role:  dataResponse.data);
    }

    else {
      yield UserVerifyListFailed("failed");
    }
  }

  //additional
  Stream<SellerAdminState> AdditionalRoleList({
    String? search,
    String? next,String? prev
  }) async* {
    yield AdditionalRoleListLoading();
    final dataResponse = await _sellerRepo.AdditionalRoleList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield AdditionalRoleListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          role:  dataResponse.data);
    }

    else {
      yield AdditionalRoleListFailed("failed");
    }
  }
  //depart
  Stream<SellerAdminState> DepartmentList({
    String? search,
    String? next,String? prev
  }) async* {
    yield DepartmentListLoading();
    final dataResponse = await _sellerRepo.DepartmentList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield DepartmentListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          department:  dataResponse.data);
    }

    else {
      yield DepartmentListFailed("failed");
    }
  }
  //designation
  Stream<SellerAdminState> DesignationList({
    String? code,
    String? search,
    String? next,String? prev
  }) async* {
    yield DesignationListLoading();
    final dataResponse = await _sellerRepo.DesignationList(code,search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield DesignationListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          designation:  dataResponse.data);
    }

    else {
      yield DesignationListFailed("failed");
    }
  }

  //createdesignation
  Stream<SellerAdminState> createDesignation(
      {
        required String title,
        required String description,
        required String department,
        required String legalEntity,

      }) async* {
    yield CreateDesignationLoading();

    final dataResponse = await _sellerRepo.createDesignation(
       title: title,
      legalEntity: legalEntity,
      department: department,
      description: description

    );

    if (dataResponse.data) {
      yield CreateDesignationSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield CreateDesignationFailed(
        dataResponse.error ?? "",);
    }

  }

  //createuSSER
  Stream<SellerAdminState> createUser(
      {
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

      }) async* {
    yield CreateUserLoading();

    final dataResponse = await _sellerRepo.createUser(
entityCode: entityCode,
        department: department,
        phone: phone,
      password: password,
      officialRole: officialRole,
      nationality: nationality,
      lName: lName,
      gender: gender,
      fName: fName,
      email: email,
      designation: designation,
      businessCode: businessCode,
      additionalRole: additionalRole


    );

    if (dataResponse.data) {
      yield CreateUserSuccess(successMessage: dataResponse.error);
    } else {
      print("BBBBB");
      yield CreateUserFailed(
        dataResponse.error ?? "",);
    }

  }

  //empList
  Stream<SellerAdminState> EmployeeUserList({
    String? search,
    String? next,String? prev
  }) async* {
    yield EmployeeUserListLoading();
    final dataResponse = await _sellerRepo.EmployeeUserList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield EmployeeUserListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          employee:  dataResponse.data);
    }

    else {
      yield EmployeeUserListFailed("failed");
    }
  }

  //dirList
  Stream<SellerAdminState> DirectorUserList({
    String? search,
    String? next,String? prev
  }) async* {
    yield DirectorUserListLoading();
    final dataResponse = await _sellerRepo.DirectorUserList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield DirectorUserListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          director:  dataResponse.data);
    }

    else {
      yield DirectorUserListFailed("failed");
    }
  }

  //country
  Stream<SellerAdminState> countryList() async* {
    yield GetCountryListLoading();

    final dataResponse = await _sellerRepo.countryList();

    if (dataResponse.data.isNotEmpty) {
      print("sub tast is a success");
      yield GetCountryListSuccess(dataResponse.data);
    } else {
      yield GetCountryListFailed();
    }
  }

  //statelist
  Stream<SellerAdminState> stateList({
    String? code,
  }) async* {
    yield GetStateListLoading();

    final dataResponse = await _sellerRepo.stateList(code);

    if (dataResponse.data.isNotEmpty) {
      print("sub tast is a success");
      yield GetStateListSuccess(dataResponse.data);
    } else {
      yield GetStateListFailed();
    }
  }

  //
  Stream<SellerAdminState> updatePicture({
    required File imag,
    required int? sellerId,

    // required CroppedFile? imag,
  }) async* {
    yield UpdatePictureLoading();
    final dataResponse = await _dataSource.updatePicture(img: imag,sellerId: sellerId);
    if (dataResponse == "success") {
      yield UpdatePictureSuccess();
    } else {
      yield UpdatePictureFailed();
    }
  }
//
  Stream<SellerAdminState> getFaqListState(String? search) async* {
    yield GetFaqListLoading();

    final dataResponse = await _sellerRepo.getFaqList(search);

    if (dataResponse.data.isNotEmpty) {
      yield GetFaqListSuccess(dataResponse.data);
    } else {
      yield GetFaqListFailed();
    }
  }

  //
  Stream<SellerAdminState> getPolicyStateMap() async* {
    yield PolicyLoading();
    final dataResponse = await _dataSource.getPolicy();

    if (dataResponse.isNotEmpty) {
      yield PolicySuccess(dataResponse);
    } else {
      yield PolicyFailed();
    }
  }
  //
  Stream<SellerAdminState> getBusinessDetailsRead() async* {

    yield GetBusinessDetailsReadLoading();

    final dataResponse = await _sellerRepo.getBusinessDetailsRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetBusinessDetailsReadSuccess(seller: dataResponse.data);
    } else {
      yield GetBusinessDetailsReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //
  Stream<SellerAdminState> getAdminDashboardRead() async* {

    yield GetAdminDashboardReadLoading();

    final dataResponse = await _sellerRepo.getAdminDashboardRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetAdminDashboardReadSuccess(seller: dataResponse.data);
    } else {
      yield GetAdminDashboardReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //
  Stream<SellerAdminState> getAdminViewDashboard() async* {

    yield AdminViewDashboardReadLoading();

    final dataResponse = await _sellerRepo.getAdminViewDashboard();

    if (dataResponse.hasData) {
      yield AdminViewDashboardReadSuccess(seller: dataResponse.data);
    } else {
      yield AdminViewDashboardReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //
  Stream<SellerAdminState> verifyUser({required String code,required bool? reject}) async* {

    yield GetVerifyUserLoading();

    final dataResponse = await _sellerRepo.verifyUser(code: code,reject: reject);

    if (dataResponse.hasData) {
      yield GetVerifyUserSuccess();
    } else {
      yield GetVerifyUserFailed(dataResponse.error.toString(),
      );
    }
  }

}

