import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../create/model/task_models.dart';
import '../../employee_model/employee_model.dart';
import '../job_datasource.dart';
import '../job_repository.dart';
import '../model/joblist_model.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobDataSource _jobDataSource = JobDataSource();
  final JobRepo _jobRepo = JobRepo();
  JobBloc() : super(GetJobListInitial());

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is GetJobListEvent) {
      yield* getJobListState();
    }
    if (event is GetInstantJobListEvent) {
      yield* getInstantJobListState();
    }
    if (event is GetFilterJobListEvent) {
      yield* getFilterJobListState(event.status);
    }
    if (event is GetNewJobListEvent) {
      yield* getNewJobListState(
        prev: event.prev,
        next: event.next,
        search: event.search
      );
    }
    if (event is GetUserVerifyEvent) {
      yield* getUserVerifyState();
    }
    if (event is GetAdminDataEvent) {
      yield* getAdminDataState();
    }
    if (event is GetEmployeeListEvent) {
      yield* getEmployeeListState();
    }
    if (event is GetReportingPersonListEvent) {
      yield* getReportingPersonList();
    }
    if (event is GetGroupListEvent) {
      yield* getGroupListState();
    }
    if (event is GetUserUderGroupEvent) {
      yield* getUserUderGroupState();
    }
    if (event is GetAssignedMeListEvent) {
      yield* getAssignedMeListState(
          search: event.search,
      next: event.next,
      prev: event.prev);
    }
    if (event is GetDesignationListEvent) {
      yield* getDesignationListState();
    }
    if (event is GetStatusListEvent) {
      yield* getStatusListState();
    }
    if (event is GetRoleListEvent) {
      yield* getRoleListState();
    }
    if (event is FilterAssignTaskCountEvent) {
      yield* _mapTaskCountStateToState(
        startDate: event.startDate.trim(),
        enddate: event.endDate.trim(),
      );
    }
    if (event is PinAJobPostEvent) {
      yield* pinAJobState(
        taskId: event.taskId,
        isPinned: event.isPinned,
        userCode: event.userCode.trim()
      );
    }
     if (event is DeleteJobEvent) {
      yield* deleteJob(jobId: event.jobId);
    }
    if (event is GetJobReadListEvent) {
      yield* getJobRead(event.id);
    }
    if (event is GetJobTypeListEvent) {
      yield* getJobTypeListState();
    }
    if (event is UpdateTaskGroupEvent) {
      yield* updateTaskGroup(
        userGoupId: event.userGroupId,
          userCode: event.userCode.trim(),
          roleId: event.roleId,
          taskGroup: event.taskGroup,
          isActive: event.isActive,
      );
    }
    if (event is CreateJobEvent) {
      yield* _mapCreateJobStateToState(
        startDate: event.startDate.trim(),
        endDate: event.endDate.trim(),
        reportingPerson: event.reportingPerson,
        relatedJob: event.relatedJob,
        priority: event.priority.trim(),
        originfrom: event.originFrom.trim(),
        name: event.name.trim(),
        jobType: event.jobType,
        isActive: event.isActive,
        discription: event.discription.trim(),
        createdBy: event.createdBy,
        assignedBy: event.assignedBy
      );
    }
    else if (event is UpdateJobEvent) {
      yield* updateJobState(
          startDate: event.startDate.trim(),
          endDate: event.endDate.trim(),
          reportingPerson: event.reportingPerson,
          priority: event.priority.trim(),
          originfrom: event.originFrom.trim(),
          name: event.name.trim(),
          jobType: event.jobType,
          isActive: event.isActive,
          discription: event.discription.trim(),
          createdBy: event.createdBy,
          assignedBy: event.assignedBy,
      );
    }

  }
  //jobListState
  Stream<JobState> getJobListState() async* {
    yield GetJobListLoading();

    final dataResponse = await _jobRepo.getJobList();

    if (dataResponse.data.isNotEmpty) {
      yield GetJobListSuccess(dataResponse.data);
    } else {
      yield GetJobListFailed();
    }
  }
  //instatJobList
  Stream<JobState>  getInstantJobListState() async* {
    yield GetInstantJobListLoading();

    final dataResponse = await _jobRepo.getInstantJobList();

    if (dataResponse.data.isNotEmpty) {
      yield GetInstantJobListSuccess(dataResponse.data);
    } else {
      yield GetInstantJobListFailed();
    }
  }
  //filterjoblist
  Stream<JobState> getFilterJobListState(String? status) async* {
    yield GetFilterJobListLoading();

    final dataResponse = await _jobRepo.getFilterJobList(status);

    if (dataResponse.data!=null&&dataResponse.data.isNotEmpty) {
      yield GetFilterJobListSuccess(dataResponse.data);
    } else {
      yield GetFilterJobListFailed();
    }
  }
  //getNewJobList
  // Stream<JobState> getNewJobListState() async* {
  //   yield GetNewJobListLoading();
  //
  //   final dataResponse = await _jobRepo.getNewJobList();
  //
  //   if (dataResponse.data.isNotEmpty) {
  //     yield GetNewJobListSuccess(dataResponse.data);
  //   } else {
  //     yield GetNewJobListFailed();
  //   }
  // }

  Stream<JobState> getNewJobListState({
    String? search,String? next,String? prev
  }) async* {
    yield GetNewJobListLoading();
    final dataResponse = await _jobRepo.getNewJobList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetNewJobListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          jobList:  dataResponse.data);  }

    else {
      yield GetNewJobListFailed("failed");
    }
  }

  //userverify
  Stream<JobState> getUserVerifyState() async* {
    yield GetUserVerifyLoading();

    final dataResponse = await _jobRepo.getUserVerify();

    if (dataResponse.data.isNotEmpty) {
      yield GetUserVerifySuccess(dataResponse.data);
    } else {
      yield GetUserVerifyFailed();
    }
  }
  //admin
  Stream<JobState> getAdminDataState() async* {
    yield GetAdminDataLoading();

    final dataResponse = await _jobRepo.getAdminData();

    if (dataResponse.data.isNotEmpty) {
      yield GetAdminDataSuccess(dataResponse.data);
    } else {
      yield GetAdminDataFailed();
    }
  }

  //employeelist
  Stream<JobState> getEmployeeListState() async* {
    yield GetEmployeeListLoading();

    final dataResponse = await _jobRepo.getEmployeeList();

    if (dataResponse.data.isNotEmpty) {
      yield GetEmployeeListSuccess(dataResponse.data);
    } else {
      yield GetEmployeeListFailed();
    }
  }

  //reporting
  Stream<JobState> getReportingPersonList() async* {
    yield GetReportingPersonListLoading();

    final dataResponse = await _jobRepo.getReportingPersonList();

    if (dataResponse.data.isNotEmpty) {
      yield GetReportingPersonListSuccess(dataResponse.data);
    } else {
      yield GetReportingPersonListFailed();
    }
  }
  //grouplist
  Stream<JobState> getGroupListState() async* {
    yield GetGroupListLoading();

    final dataResponse = await _jobRepo.getGroupList();

    if (dataResponse.data.isNotEmpty) {
      yield GetGroupListSuccess(dataResponse.data);
    } else {
      yield GetGroupListFailed();
    }
  }

  //assignmelist
  // Stream<JobState> getAssignedMeListState() async* {
  //   yield GetAssignedMeListLoading();
  //
  //   final dataResponse = await _jobRepo.getAssignedMeList();
  //
  //   if (dataResponse.data.isNotEmpty) {
  //     yield GetAssignedMeListSuccess(dataResponse.data);
  //   } else {
  //     yield GetAssignedMeListFailed();
  //   }
  // }

  Stream<JobState> getAssignedMeListState({
    String? search,String? next,String? prev
  }) async* {
    yield GetAssignedMeListLoading();
    final dataResponse = await _jobRepo.getAssignedMeList(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetAssignedMeListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          assignMeList:  dataResponse.data);  }

    else {
      yield GetAssignedMeListFailed("failed");
    }
  }

  //counttask
  Stream<JobState> _mapTaskCountStateToState(
      {
        required String startDate,
        required String enddate,
      }) async* {
    yield TaskCountLoading();

    final dataResponse = await _jobRepo.taskCountPost(
      startDate: startDate,
      enddate: enddate,
    );

    if (dataResponse.data1) {
      yield TaskCountSuccess(data: dataResponse.data2);
    } else {
      yield TaskCountFailed(
        dataResponse.data1 ?? "",);
    }
  }

  //pinJob
  Stream<JobState> pinAJobState(
      {
        required String userCode,
        required int taskId,
        required bool isPinned,

      }) async* {
    yield PinCreationLoading();

    final dataResponse = await _jobRepo.pinAJobPost(
       isPinned: isPinned,
      taskId: taskId,
      userCode: userCode
    );

    print("data${dataResponse!=null}");
    if (dataResponse!=null) {
      print("sucsess ");
      yield PinCreationSuccess(data :dataResponse.error??"");
    } else {
      print("failed ");
      yield PinCreationFailed(
        dataResponse.error ?? "",);
    }
  }

  //jobType
  Stream<JobState> getJobTypeListState() async* {
    yield GetJobTypeListLoading();

    final dataResponse = await _jobRepo.getJobTypeList();

    if (dataResponse.data.isNotEmpty) {
      yield GetJobTypeListSuccess(dataResponse.data);
    } else {
      yield GetJobTypeListFailed();
    }
  }
//updateTaskGorpUpdate
  Stream<JobState> updateTaskGroup(
      {
        required String userCode,
        required int roleId,
        required bool? isActive,
        required int? taskGroup,
        required int? userGoupId,
      }) async* {
    yield UpdateTaskGroupLoading();

    final dataResponse = await _jobRepo.updateTaskGroup(
        userCode: userCode,
        taskGroup: taskGroup,
        userGoupId: userGoupId,
        roleId: roleId,
        isActive: isActive,

    );

    print("data${dataResponse!=null}");
    if (dataResponse!=null) {
      print("sucsess ");
      yield UpdateTaskGroupSuccess();
    } else {
      print("failed ");
      yield UpdateTaskGroupFailed(
        dataResponse.error ?? "",);
    }
  }

  //createJob
  Stream<JobState> _mapCreateJobStateToState(
      {
        required String name,
        required int jobType,
        required String reportingPerson,
        required String assignedBy,
        required String createdBy,
        required String originfrom,
        required String discription,
        required bool? isActive,
        required String? startDate,
        required String? endDate,
        required String? priority,
        required int? relatedJob,
      }) async* {
    yield CreateJobLoading();

    final dataResponse = await _jobRepo.jobCreatePost(
      startDate: startDate,
      endDate: endDate,
      assignedBy: assignedBy,
      createdBy: createdBy,
      discription: discription,
      isActive: isActive,
      jobType: jobType,
      name: name,
      originfrom: originfrom,
      priority: priority,
      relatedJob: relatedJob,
      reportingPerson: reportingPerson

    );

    print("data${dataResponse!=null}");
    if (dataResponse!=null) {
      print("sucsess ");
      yield CreateJobSuccess(dataResponse.error??"");
    } else {
      print("failed ");
      yield CreateJobFailed(
        dataResponse.error ?? "",);
    }
  }
  //jobRaed

  Stream<JobState> getJobRead(int id) async* {

    yield GetJobReadLoading();

    final dataResponse = await _jobRepo.getJobReadData(id);

    if (dataResponse.hasData) {
      yield GetJobReadSuccess(getjobRead: dataResponse.data);
    } else {
      yield GetJobReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //editJob
  Stream<JobState> updateJobState(
      {
        required String name,
        required int? jobType,
        required String reportingPerson,
        required String assignedBy,
        required String createdBy,
        required String originfrom,
        required String discription,
        required bool? isActive,
        required String? startDate,
        required String? endDate,
        required String? priority,
      }) async* {
    yield CreateJobLoading();

    final dataResponse = await _jobRepo.jobUpdatePost(
        startDate: startDate,
        endDate: endDate,
        assignedBy: assignedBy,
        createdBy: createdBy,
        discription: discription,
        isActive: isActive,
        jobType: jobType,
        name: name,
        originfrom: originfrom,
        priority: priority,
        reportingPerson: reportingPerson

    );

    if (dataResponse.data) {
      print("sucsess ");
      yield UpdateJobSuccess(dataResponse.error);
    } else {
      print("failed ");
      yield UpdateJobFailed(
        dataResponse.error ?? "",);
    }
  }

  //userUderGroup
  Stream<JobState> getUserUderGroupState() async* {
    yield GetUserUderGroupLoading();

    final dataResponse = await _jobRepo.getUserUderGroupList();

    if (dataResponse.data.isNotEmpty) {
      yield GetUserUderGroupSuccess(dataResponse.data);
    } else {
      yield GetUserUderGroupFailed();
    }
  }
  //deleteJob
  Stream<JobState> deleteJob({required int jobId}) async* {
    yield DeleteJobLoading();
    final dataResponse = await _jobDataSource.deleteJob(jobId);
    if (dataResponse == "success") {
      yield DeleteJobSuccess();
    } else {
      yield DeleteJobFailed();
    }
  }

  //designationList
  Stream<JobState> getDesignationListState() async* {
    yield GetDesignationListLoading();

    final dataResponse = await _jobRepo.getDesignationListingList();

    if (dataResponse.data.isNotEmpty) {
      yield GetDesignationListSuccess(dataResponse.data);
    } else {
      yield GetDesignationListFailed();
    }
  }

  //statusList
  Stream<JobState> getStatusListState() async* {
    yield GetStatusListLoading();

    final dataResponse = await _jobRepo.getStatusListingList();

    if (dataResponse.data.isNotEmpty) {
      yield GetStatusListSuccess(dataResponse.data);
    } else {
      yield GetStatusListFailed();
    }
  }
  //roleList
  Stream<JobState> getRoleListState() async* {
    yield GetRoleListLoading();

    final dataResponse = await _jobRepo.getRoleListingList();

    if (dataResponse.data.isNotEmpty) {
      yield GetRoleListSuccess(dataResponse.data);
    } else {
      yield GetRoleListFailed();
    }
  }
}


