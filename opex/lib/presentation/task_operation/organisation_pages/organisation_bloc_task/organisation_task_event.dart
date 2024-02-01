part of 'organisation_task_bloc.dart';

abstract class OrganisationTaskEvent extends Equatable {
  const OrganisationTaskEvent();

  @override
  List<Object> get props => [];

}

class DepartmentTaskCreateEvent extends OrganisationTaskEvent {
  final String name;

  DepartmentTaskCreateEvent( {
    required this.name,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetDepartmentTaskListEvent extends OrganisationTaskEvent {
  final String? search;
  final String? next;
  final String? prev;
  // final User? user;
  const GetDepartmentTaskListEvent(this.search, this.next, this.prev);
}

class DepartmentTaskReadEvent extends OrganisationTaskEvent {
  final int id;
  const DepartmentTaskReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteDepartmentTaskEvent extends OrganisationTaskEvent {
  final int id;
  const DeleteDepartmentTaskEvent(this.id);
}
//updateDiscount
class UpdateDepartmentTaskEvent extends OrganisationTaskEvent {
  final String name;
  final int id;
  const UpdateDepartmentTaskEvent( {
    required this.name,
    required this.id,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

class DepartmentTaskRoleCreateEvent extends OrganisationTaskEvent {
  final String name;

  DepartmentTaskRoleCreateEvent( {
    required this.name,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetDepartmentTaskRoleListEvent extends OrganisationTaskEvent {
  final String? search;
  final String? next;
  final String? prev;
  // final User? user;
  const GetDepartmentTaskRoleListEvent(this.search, this.next, this.prev);
}

class DepartmentTaskReadRoleEvent extends OrganisationTaskEvent {
  final int id;
  const DepartmentTaskReadRoleEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteDepartmentTaskRoleEvent extends OrganisationTaskEvent {
  final int id;
  const DeleteDepartmentTaskRoleEvent(this.id);
}
//updateDiscount
class UpdateDepartmentTaskRoleEvent extends OrganisationTaskEvent {
  final String name;
  final int id;
  const UpdateDepartmentTaskRoleEvent( {
    required this.name,
    required this.id,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//role unser deprt
class RoleUnderDepartmentListEvent extends OrganisationTaskEvent {
  final String? search;
  final String? next;
  final String? prev;
  final int? id;
  const RoleUnderDepartmentListEvent(this.search, this.next, this.prev,this.id);
}
