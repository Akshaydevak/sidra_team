part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];

}
class GetJobListEvent extends JobEvent {
  const GetJobListEvent();
}
class GetRoleListEvent extends JobEvent {
  const GetRoleListEvent();
}
class GetNewJobListEvent extends JobEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetNewJobListEvent(this.search, this.next, this.prev);
}
class GetReorterListEvent extends JobEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetReorterListEvent(this.search, this.next, this.prev);
}
class GetInstantJobListEvent extends JobEvent {
  const GetInstantJobListEvent();
}
class GetFilterJobListEvent extends JobEvent {
  String? status;
   GetFilterJobListEvent(this.status);
}
class GetUserVerifyEvent extends JobEvent {
  const GetUserVerifyEvent();
}
class GetAdminDataEvent extends JobEvent {
  const GetAdminDataEvent();
}
class GetEmployeeListEvent extends JobEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetEmployeeListEvent(this.search, this.next, this.prev);
}

class GetReportingPersonListEvent extends JobEvent {
  const GetReportingPersonListEvent();
}
class GetGroupListEvent extends JobEvent {
  const GetGroupListEvent();
}
class GetUserUderGroupEvent extends JobEvent {
  const GetUserUderGroupEvent();
}
class GetAssignedMeListEvent extends JobEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetAssignedMeListEvent(this.search, this.next, this.prev);
}
class PinAJobPostEvent extends JobEvent {
  final int taskId;
  final String userCode;
  final bool isPinned;

  PinAJobPostEvent({
    required this.userCode,
    required this.taskId,
    required this.isPinned,

  });
  @override
  List<Object> get props => [
    userCode,
  ];
}
class FilterAssignTaskCountEvent extends JobEvent {
  final String startDate;
  final String endDate;

  FilterAssignTaskCountEvent({
    required this.startDate,
    required this.endDate,

  });
  @override
  List<Object> get props => [
    startDate,
  ];
}
class GetJobTypeListEvent extends JobEvent {
  const GetJobTypeListEvent();
}
class CreateJobEvent extends JobEvent {
  final String name;
  final int jobType;
  final String reportingPerson;
  final String createdBy;
  final String assignedBy;
  final String originFrom;
  final String discription;
  final bool isActive;
  final String startDate;
  final String endDate;
  final String priority;
  final int? relatedJob;


  CreateJobEvent({

    required this.name,
    required this.jobType,
    required this.reportingPerson,
    required this.createdBy,
    required this.assignedBy,
    required this.originFrom,
    required this.discription,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.priority,
       this.relatedJob,

  });
  @override
  List<Object> get props => [
    name,
  ];
}
//updateTaskGoup
class UpdateTaskGroupEvent extends JobEvent {
  final String userCode;
  final int taskGroup;
  final int roleId;
  final int userGroupId;
  final bool isActive;
  UpdateTaskGroupEvent({
    required this.taskGroup,
    required this.roleId,
    required this.userCode,
    required this.isActive,
    required this.userGroupId,
  });
  @override
  List<Object> get props => [
    userCode,
  ];
}

//jobRead
class GetJobReadListEvent extends JobEvent {
  final int id;
  const GetJobReadListEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//updateJob
class UpdateJobEvent extends JobEvent {
  final String name;
  final int? jobType;
  final int? id;
  final String reportingPerson;
  final String createdBy;
  final String assignedBy;
  final String originFrom;
  final String discription;
  final bool isActive;
  final String startDate;
  final String endDate;
  final String priority;
  const UpdateJobEvent(
      {
        required this.name,
        required this.id,
        required this.jobType,
        required this.reportingPerson,
        required this.createdBy,
        required this.assignedBy,
        required this.originFrom,
        required this.discription,
        required this.isActive,
        required this.startDate,
        required this.endDate,
        required this.priority,
});
}
class DeleteJobEvent extends JobEvent {
  final int jobId;
  const DeleteJobEvent(this.jobId);
}
class GetDesignationListEvent extends JobEvent {
  const GetDesignationListEvent();
}
class GetStatusListEvent extends JobEvent {
  const GetStatusListEvent();
}
