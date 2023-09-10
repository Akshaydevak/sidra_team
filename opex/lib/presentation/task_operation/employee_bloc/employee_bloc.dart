import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../employee_data_repo/employee_datasourse.dart';
import '../employee_data_repo/employee_repo.dart';
import '../employee_model/employee_model.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeDataSource _employeeDataSource = EmployeeDataSource();
  final EmployeeRepo _employeeRepo = EmployeeRepo();
  EmployeeBloc() : super(EmployeeInitial());

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event,) async* {
    if (event is RegisterEmployeeEvent) {
      yield* _mapEmployeeStateToState(
        email: event.emailID.trim(),
        orgCode: event.orgCode.trim(),
        departCode: event.depatCode.trim(),
        firstName: event.firstName.trim(),
        lastName: event.lastName.trim(),
        designationCode: event.designationCode.trim(),
        gender: event.gender,
        contact: event.contact.trim(),
        additionalRole: event.additionalRole,
        nationality: event.nationality,
        officialRole: event.officialRole,
        password: event.password,
        netCode: event.netCode,
        userRole: event.userRole,
        roleName: event.roleName,
        roleNameList: event.roleNameList
      );
    }
    if (event is ChangeUserPasswordEvent) {
      yield* chagePasswordState(
        employeeCode: event.employeeCode,
        newPassword: event.newPassword

      );
    }
    if (event is GetReadTypeEvent) {
      yield* getReadType();
    }
     if (event is UpdateEmployeeEvent) {
      yield* updateEmployeeState(
        roleName: event.roleName,
        roleNameList: event.roleNameList,
        id: event.id,
        additionalRole: event.additionalRole,
        nationality: event.nationality,
        netCode: event.netCode,
        officialRole: event.officialRole,
        userRole: event.userRole,
        isActive: event.isActive,
        email: event.emailID.trim(),
        orgCode: event.orgCode.trim(),
        departCode: event.depatCode.trim(),
        firstName: event.firstName.trim(),
        lastName: event.lastName.trim(),
        designationCode: event.designationCode.trim(),
        gender: event.gender,
        contact: event.contact.trim(),
      );
    }

    if (event is CreateGroupEvent) {
      yield* _mapCreateGroupToState(
          groupName: event.groupName.trim(),
          discription: event.discription.trim(),
          userList: event.userlist
      );
    }

    if (event is UpdateGroupEvent) {
      yield* UpdateGroupToState(
          groupName: event.groupName.trim(),
          discription: event.discription.trim(),
          userList: event.userList,
        id: event.id,
        isActive: event.isActive
      );
    }
    else if (event is PostImageEvent) {
      yield* postImageInTaskState(img: event.image);}
    else if (event is PostImageAllEvent) {
      yield* postImageInAll(img: event.image);}
    else if (event is DeleteEmployeeEvent) {
      yield* deleteEmployee(reviewId: event.employeId);
    }
    else if (event is GetGroupTReadEvent) {
      yield* getGroupRead(event.id);
    }
    else if (event is GetEmployeeReadEvent) {
      yield* getEmployeeRead(event.id);
    }
    if (event is GetActivityLogListingEvent) {
      yield* getActivityLogsList(event.id);
    }
    if (event is ChangePasswordEvent) {
      yield* _mapChangePasswordToState(
          current: event.current.trim(),
          newPass: event.newPass.trim(),
          userName: event.userName.trim(),
          otp: event.otp
      );
    }
  }
  Stream<EmployeeState> _mapEmployeeStateToState(
      {
        required String email,
        required String orgCode,
        required String lastName,
        required String firstName,
        required String contact,
        required String departCode,
        required String designationCode,
        required String? gender,
        required String netCode,
        required String nationality,
        required String password,
        required int officialRole,
        required String userRole,
        required List<int> additionalRole,
        required List<String> roleNameList,
        required String roleName
      }) async* {
    yield EmployeeLoading();

    final dataResponse = await _employeeRepo.employeeCreate(
      email: email,
      departCode: departCode,
      gender: gender,
      orgCode: orgCode,
      designationCode:designationCode,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
      additionalRole: additionalRole,
      nationality: nationality,
      officialRole: officialRole,
      password: password,
      netCode: netCode,
      userRole: userRole,
      roleNameList: roleNameList,
      roleName: roleName
    );

    if (dataResponse.data) {
      yield EmployeeSuccess(dataResponse.error??"");
    } else {
      yield EmployeeFailed(
        dataResponse.error ?? "",);
    }
  }

  //chage.
  Stream<EmployeeState> chagePasswordState(
      {
        required String employeeCode,
        required String newPassword,

      }) async* {
    yield ChagePasswordLoading();

    final dataResponse = await _employeeRepo.chagePassword(
      newPassword: newPassword,
      employeeCode: employeeCode
    );

    print("respoces bloc${dataResponse.data}");
    if (dataResponse.data) {
      yield ChagePasswordSuccess(dataResponse.error??"");
    } else {
      yield ChagePasswordFailed(
        dataResponse.error ?? "");
    }
  }
  //readType
  Stream<EmployeeState> getReadType() async* {

    yield GetReadTypeLoading();

    final dataResponse = await _employeeRepo.getReadType();

    if (dataResponse.hasData) {
      yield GetReadTypeSuccess(readType: dataResponse.data);
    } else {
      yield GetReadTypeFailed(dataResponse.error.toString(),
      );
    }
  }

  //createEmployee
  Stream<EmployeeState> _mapCreateGroupToState(
      {
        required String groupName,
        required String discription,
        required List<String> userList,
      }) async* {
    yield CreateGroupLoading();

    final dataResponse = await _employeeRepo.createGroupPost(
      groupName: groupName,
      discription: discription,
      userlist: userList
    );

    if (dataResponse.data) {
      yield CreateGroupSuccess(dataResponse.error);
    } else {
      yield CreateGroupFailed(dataResponse.error ?? "");
    }
  }
  //
  Stream<EmployeeState> UpdateGroupToState(
      {
        required String groupName,
        required String discription,
        required List<GetUserList> userList,
        required bool isActive,
        required int id,
      }) async* {
    yield UpdateGroupLoading();

    final dataResponse = await _employeeDataSource.UpdateGroupToState(
        groupName: groupName,
        discription: discription,
        userList: userList,
      id: id,
      isActive: isActive
    );

    print("bloc res${dataResponse.data}");
    print("bloc res${dataResponse.error}");
    if (dataResponse.data) {
      yield UpdateGroupSuccess(dataResponse.error??"");
    } else {
      yield UpdateGroupFailed(dataResponse.error ?? "");
    }
  }
//readgroup
    Stream<EmployeeState> getGroupRead(int id) async* {

      yield GetReadGroupLoading();

      final dataResponse = await _employeeRepo.getGroupRead(id);

      if (dataResponse.hasData) {
        yield GetReadGroupSuccess(getGroupRead: dataResponse.data);
      } else {
        yield GetReadGroupFailed(dataResponse.error.toString(),
        );
      }
    }

    //readEmployee
  Stream<EmployeeState> getEmployeeRead(int id) async* {

    yield GetEmployeeReadLoading();

    final dataResponse = await _employeeRepo.getEmployeeRead(id);

    if (dataResponse.hasData) {
      yield GetEmployeeReadSuccess(getEmployee: dataResponse.data);
    } else {
      yield GetEmployeeReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //updateEmployee
  Stream<EmployeeState> updateEmployeeState(
      {
        required String email,
        required String orgCode,
        required String lastName,
        required String firstName,
        required String contact,
        required String departCode,
        required String designationCode,
        required String? gender,
        required String netCode,
        required String nationality,
        required int officialRole,
        required String userRole,
        required List<int> additionalRole,
        required List<String> roleNameList,
        required String roleName,
        required bool isActive,
        required int id,
      }) async* {
    yield UpdateEmployeeLoading();

    final dataResponse = await _employeeRepo.updateEmployee(
      email: email,
      isActive: isActive,
      departCode: departCode,
      gender: gender,
      orgCode: orgCode,
      designationCode:designationCode,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
      id: id,
      additionalRole: additionalRole,
      nationality: nationality,
      officialRole: officialRole,
      userRole: userRole,
      netCode: netCode,
      roleName: roleName,
      roleNameList: roleNameList

    );

    if (dataResponse.data) {
      yield UpdateEmployeeSuccess(dataResponse.error??"",);
    } else {
      yield UpdateEmployeeFailed(
        dataResponse.error ?? "",);
    }
  }
  //deleteEmployee
  Stream<EmployeeState> deleteEmployee({required int reviewId}) async* {
    yield DeleteEmployeeLoading();
    final dataResponse = await _employeeDataSource.deleteEmployee(reviewId);
    if (dataResponse == "success") {
      yield DeleteEmployeeSuccess();
    } else {
      yield DeleteEmployeeFailed();
    }
  }
  //listActivity
  Stream<EmployeeState> getActivityLogsList(int? id) async* {
    yield GetActivityLogListLoading();

    final dataResponse = await _employeeRepo.getActivityList(id);

    if (dataResponse.data.isNotEmpty) {
      yield GetActivityLogListSuccess(dataResponse.data);
    } else {
      yield GetActivityLogListFailed();
    }
  }
  //postImage
  Stream<EmployeeState> postImageInTaskState(
      {required File img}) async* {
    yield PostImageLoading();
    final dataResponse = await _employeeDataSource.PostImage(img: img);
    if (dataResponse.data1) {
      yield PostImageSuccess(id: dataResponse.data2);
    } else {
      yield PostImageFailed(error: dataResponse.data2);
    }
  }
  //
  Stream<EmployeeState> postImageInAll(
      {required File img}) async* {
    yield PicLoading();
    final dataResponse = await _employeeDataSource.postImageInAll(img: img);
    if (dataResponse.data1 != null) {
      yield PicSuccess(dataResponse.data1,dataResponse.data2);
    } else {
      yield PicFailed();
    }
  }

  //chane
  Stream<EmployeeState> _mapChangePasswordToState({
    required String newPass,
    required String current,
    required String userName,
    String? otp,
  }) async* {
    yield ChangePasswordLoading();

    final dataResponse = await _employeeRepo.changePassword(userName: userName,
        newPass: newPass,
        otp: otp,
        current: current
    );

    print("BLOC${dataResponse.data}");
    print("BLOC${dataResponse.hasData}");
    if (dataResponse.data) {
      yield ChangePasswordSuccess(
          message: dataResponse.error??""
      );
    } else {
      yield ChangePasswordFailed(
        message: dataResponse.error ?? "",
      );
    }
  }

}
