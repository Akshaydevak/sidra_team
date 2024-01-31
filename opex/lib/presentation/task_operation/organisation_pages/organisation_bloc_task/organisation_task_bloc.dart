import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/data_org/repo_org.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/data_org/source_org.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../inventory/model/division_model.dart';
import '../../../inventory/model/inventory_model.dart';
import '../models_org/org_model.dart';

part 'organisation_task_event.dart';
part 'organisation_task_state.dart';

class OrganisationTaskBloc extends Bloc<OrganisationTaskEvent, OrganisationTaskState> {
  final OrgTaskSource _orgDataSource = OrgTaskSource();
  final OrgTaskRepo _orgRepo = OrgTaskRepo();
  OrganisationTaskBloc() : super(DepartmentTaskListLoading());
  @override
  Stream<OrganisationTaskState> mapEventToState(OrganisationTaskEvent event) async* {
    if (event is DepartmentTaskCreateEvent) {
      yield* createdepartment(
          name: event.name.trim(),
      );
    }
    if (event is GetDepartmentTaskListEvent) {
      yield* getdepartmentlist(
          next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is DepartmentTaskReadEvent) {
      yield* getDepartmentTaskRead(event.id);
    }
    if (event is DeleteDepartmentTaskEvent) {
      yield* deleteDepartmentTask(id: event.id);
    }
    if (event is UpdateDepartmentTaskEvent) {
      yield* updateDepartmentTaskPost(
          name: event.name.trim(),
          id: event.id,

      );
    }
    if (event is DepartmentTaskRoleCreateEvent) {
      yield* createDepartmentRole(
        name: event.name.trim(),
      );
    }
    if (event is GetDepartmentTaskRoleListEvent) {
      yield* getdepartmentlistRole(
          next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is DepartmentTaskReadRoleEvent) {
      yield* getDepartmentTaskReadRole(event.id);
    }
    if (event is DeleteDepartmentTaskRoleEvent) {
      yield* deleteDepartmentTaskRole(id: event.id);
    }
    if (event is UpdateDepartmentTaskRoleEvent) {
      yield* updateDepartmentTaskRole(
        name: event.name.trim(),
        id: event.id,

      );
    }
    if (event is RoleUnderDepartmentListEvent) {
      yield* getRoleUnderDepartment(
          next: event.next,
          prev: event.prev,
          search: event.search,
        id: event.id
      );
    }


  }

  Stream<OrganisationTaskState> getdepartmentlist({
    String? search,
    String? next,String? prev
  }) async* {
    yield DepartmentTaskListLoading();
    final dataResponse = await _orgRepo.getdepartmentlist(search,next,prev);
    if (dataResponse.data !=null ) {
      yield DepartmentTaskListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield DepartmentTaskListFailed("failed");
    }
  }

  Stream<OrganisationTaskState> createdepartment(
      {
        required String name,
      }) async* {
    yield CreateDepartmentTaskLoading();

    final dataResponse = await _orgRepo.createdepartment(

        name: name,
    );

    if (dataResponse.data ) {
      yield CreateDepartmentTaskSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateDepartmentTaskFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<OrganisationTaskState> getDepartmentTaskRead(int id) async* {

    yield DepartmentTaskReadLoading();

    final dataResponse = await _orgRepo.getDepartmentTaskRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield DepartmentTaskReadSuccess(readData: dataResponse.data);
    } else {
      yield DepartmentTaskReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<OrganisationTaskState> deleteDepartmentTask({required int id}) async* {
    yield DeleteDepartmentTaskLoading();
    final dataResponse = await _orgDataSource.deleteDepartmentTask(id);
    if (dataResponse == "success") {
      yield DeleteDepartmentTaskSuccess();
    } else {
      yield DeleteDepartmentTaskFailed();
    }
  }

  //updateDiscount
  Stream<OrganisationTaskState> updateDepartmentTaskPost(
      {

        required String name,
        required int id,
      }) async* {
    yield DepartmentTaskUpdateLoading();

    final dataResponse = await _orgRepo.updateDepartmentTaskPost(

        name: name,
        id: id
    );

    if (dataResponse.data ) {
      yield DepartmentTaskUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield DepartmentTaskUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //role
  Stream<OrganisationTaskState> getdepartmentlistRole({
    String? search,
    String? next,String? prev
  }) async* {
    yield DepartmentRoleTaskListLoading();
    final dataResponse = await _orgRepo.getdepartmentlistRole(search,next,prev);
    if (dataResponse.data !=null ) {
      yield DepartmentRoleTaskListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield DepartmentRoleTaskListFailed("failed");
    }
  }

  Stream<OrganisationTaskState> createDepartmentRole(
      {
        required String name,
      }) async* {
    yield CreateDepartmentRoleTaskLoading();

    final dataResponse = await _orgRepo.createDepartmentRole(

      name: name,
    );

    if (dataResponse.data ) {
      yield CreateDepartmentRoleTaskSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateDepartmentRoleTaskFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<OrganisationTaskState> getDepartmentTaskReadRole(int id) async* {

    yield DepartmentRoleTaskReadLoading();

    final dataResponse = await _orgRepo.getDepartmentTaskReadRole(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield DepartmentRoleTaskReadSuccess(readData: dataResponse.data);
    } else {
      yield DepartmentRoleTaskReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<OrganisationTaskState> deleteDepartmentTaskRole({required int id}) async* {
    yield DeleteDepartmentRoleTaskLoading();
    final dataResponse = await _orgDataSource.deleteDepartmentTaskRole(id);
    if (dataResponse == "success") {
      yield DeleteDepartmentRoleTaskSuccess();
    } else {
      yield DeleteDepartmentRoleTaskFailed();
    }
  }

  //updateDiscount
  Stream<OrganisationTaskState> updateDepartmentTaskRole(
      {

        required String name,
        required int id,
      }) async* {
    yield DepartmentRoleTaskUpdateLoading();

    final dataResponse = await _orgRepo.updateDepartmentTaskRole(

        name: name,
        id: id
    );

    if (dataResponse.data ) {
      yield DepartmentRoleTaskUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield DepartmentRoleTaskUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //roleunderdepart
  Stream<OrganisationTaskState> getRoleUnderDepartment({
    String? search,
    String? next,String? prev,
    int? id
  }) async* {
    yield RoleUnderDepartmentListLoading();
    final dataResponse = await _orgRepo.getRoleUnderDepartment(search,next,prev,id);
    if (dataResponse.data !=null ) {
      yield RoleUnderDepartmentListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {

      yield RoleUnderDepartmentListFailed("failed");
    }
  }
}
