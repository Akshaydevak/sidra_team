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
      );
    }
     if (event is UpdateEmployeeEvent) {
      yield* updateEmployeeState(
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
    else if (event is PostImageEvent) {
      yield* postImageInTaskState(img: event.image);}
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
        required String? gender}) async* {
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
    );

    if (dataResponse.hasData) {
      yield EmployeeSuccess(dataResponse.data);
    } else {
      yield EmployeeFailed(
        dataResponse.error ?? "",);
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

    if (dataResponse.hasData) {
      yield CreateGroupSuccess(dataResponse.data);
    } else {
      yield CreateGroupFailed(dataResponse.error ?? "");
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
        required String? gender,
        required String lastName,
        required String firstName,
        required String contact,
        required String departCode,
        required String designationCode,
        required bool isActive,
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

    );

    if (dataResponse.hasData) {
      yield UpdateEmployeeSuccess(dataResponse.data,);
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
}
