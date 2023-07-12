part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}
//jobList
class GetJobListInitial extends JobState {}

class GetJobListLoading extends JobState {}

class GetJobListSuccess extends JobState {
  final List<GetTaskList> jobList;

  const GetJobListSuccess(this.jobList);
}

class GetJobListFailed extends JobState {}
//getNewJobList
class GetNewJobListInitial extends JobState {}

class GetNewJobListLoading extends JobState {}

class GetNewJobListSuccess extends JobState {
  final List<GetJobList>? jobList;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetNewJobListSuccess(
      {this.jobList, this.prevPageUrl, this.nextPageUrl});
}

class GetNewJobListFailed extends JobState {
  final String msg;
  const GetNewJobListFailed( this.msg);
}
//instant
class GetInstantJobListInitial extends JobState {}

class GetInstantJobListLoading extends JobState {}

class GetInstantJobListSuccess extends JobState {
  final List<GetJobList> jobList;

  const GetInstantJobListSuccess(this.jobList);
}

class GetInstantJobListFailed extends JobState {}
//filterJob
class GetFilterJobListInitial extends JobState {}

class GetFilterJobListLoading extends JobState {}

class GetFilterJobListSuccess extends JobState {
  final List<GetJobList> jobList;

  const GetFilterJobListSuccess(this.jobList);
}

class GetFilterJobListFailed extends JobState {}

//userVerify
class GetUserVerifyInitial extends JobState {}

class GetUserVerifyLoading extends JobState {}

class GetUserVerifySuccess extends JobState {
  final String jobList;

  const GetUserVerifySuccess(this.jobList);
}

class GetUserVerifyFailed extends JobState {}
//employeelist
class GetEmployeeListInitial extends JobState {}

class GetEmployeeListLoading extends JobState {}

class GetEmployeeListSuccess extends JobState {
  final List<GetEmployeeList> employeeList;

  const GetEmployeeListSuccess(this.employeeList);
}

class GetEmployeeListFailed extends JobState {}
//groupplist
class GetGroupListInitial extends JobState {}

class GetGroupListLoading extends JobState {}

class GetGroupListSuccess extends JobState {
  final List<GetTaskGroupList> groupList;

  const GetGroupListSuccess(this.groupList);
}

class GetGroupListFailed extends JobState {}

//assignme
class GetAssignedMeListInitial extends JobState {}

class GetAssignedMeListLoading extends JobState {}

class GetAssignedMeListSuccess extends JobState {
  final List<GetJobList>? assignMeList;
  final String? prevPageUrl;
  final String? nextPageUrl;

  const GetAssignedMeListSuccess(
      {this.assignMeList, this.prevPageUrl, this.nextPageUrl});
}

class GetAssignedMeListFailed extends JobState {
  final String msg;
  const GetAssignedMeListFailed( this.msg);
}
//assigntaskcount
class TaskCountInitial extends JobState {}

class TaskCountLoading extends JobState {}


class TaskCountSuccess extends JobState {
  final GetCountTask data;
  const TaskCountSuccess({required this.data});
}

class TaskCountFailed extends JobState {
  final String error;

  const TaskCountFailed(this.error);
  @override
  List<Object> get props => [];
}
//pinJob
class PinCreationInitial extends JobState {}

class PinCreationLoading extends JobState {}


class PinCreationSuccess extends JobState {
  final String data;
  const PinCreationSuccess({required this.data});
}

class PinCreationFailed extends JobState {
  final String error;

  const PinCreationFailed(this.error);
  @override
  List<Object> get props => [];
}
//job type list
class GetJobTypeListInitial extends JobState {}

class GetJobTypeListLoading extends JobState {}

class GetJobTypeListSuccess extends JobState {
  final List<JobTypeList> jobTypeList;

  const GetJobTypeListSuccess(this.jobTypeList);
}

class GetJobTypeListFailed extends JobState {}
//create job
class CreateJobInitial extends JobState {}

class CreateJobLoading extends JobState {}

class CreateJobSuccess extends JobState {
  final String jobId;


  const CreateJobSuccess(this.jobId);

  @override
  List<Object> get props => [];
}

class CreateJobFailed extends JobState {
  final String error;

  const CreateJobFailed(this.error);
  @override
  List<Object> get props => [];
}
//updateTaskGroup
class UpdateTaskGroupInitial extends JobState {}

class UpdateTaskGroupLoading extends JobState {}

class UpdateTaskGroupSuccess extends JobState {


  const UpdateTaskGroupSuccess();

  @override
  List<Object> get props => [];
}

class UpdateTaskGroupFailed extends JobState {
  final String error;

  const UpdateTaskGroupFailed(this.error);
  @override
  List<Object> get props => [];
}

//readJob
class GetJobReadInitial extends JobState {}


class GetJobReadLoading extends JobState {}

class GetJobReadSuccess extends JobState {
  final GetJobList getjobRead;
  const GetJobReadSuccess({required this.getjobRead});
  @override
  List<Object> get props => [getjobRead];
}

class GetJobReadFailed extends JobState {
  final String error;
  const GetJobReadFailed(this.error);
}

//updateJob

class UpdateJobInitial extends JobState {}

class UpdateJobLoading extends JobState {}

class UpdateJobSuccess extends JobState {

  const UpdateJobSuccess();

  @override
  List<Object> get props => [];
}

class UpdateJobFailed extends JobState {
  final String error;

  const UpdateJobFailed(this.error);
  @override
  List<Object> get props => [];
}

//userUnderGrouplist
class GetUserUderGroupInitial extends JobState {}

class GetUserUderGroupLoading extends JobState {}

class GetUserUderGroupSuccess extends JobState {
  final List<GetUserList> userlist;

  const GetUserUderGroupSuccess(this.userlist);
}

class GetUserUderGroupFailed extends JobState {}
//deletejob
class DeleteJobInitial extends JobState {}

class DeleteJobLoading extends JobState {}

class DeleteJobSuccess extends JobState {}

class DeleteJobFailed extends JobState {}

//designationList
class GetDesignationListInitial extends JobState {}

class GetDesignationListLoading extends JobState {}

class GetDesignationListSuccess extends JobState {
  final List<DesignationListing> designationList;

  const GetDesignationListSuccess(this.designationList);
}

class GetDesignationListFailed extends JobState {}

//status list
class GetStatusListInitial extends JobState {}

class GetStatusListLoading extends JobState {}

class GetStatusListSuccess extends JobState {
  final List<StatusListing> statusList;

  const GetStatusListSuccess(this.statusList);
}

class GetStatusListFailed extends JobState {}

//roleList
class GetRoleListInitial extends JobState {}

class GetRoleListLoading extends JobState {}

class GetRoleListSuccess extends JobState {
  final List<RoleList> roleList;

  const GetRoleListSuccess(this.roleList);
}

class GetRoleListFailed extends JobState {}


