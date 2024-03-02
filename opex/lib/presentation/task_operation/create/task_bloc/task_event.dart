part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];

}
class GetTaskTypeListEvent extends TaskEvent {
  const GetTaskTypeListEvent();
}
class GetTaskListEvent extends TaskEvent {
  final int? id;
  final String? search;
  final String? next;
  final String? prev;
  final bool? filter;
  final String? status;
  final   String? priority;
  const GetTaskListEvent(this.id, this.search, this.next, this.prev,this.filter, this.status, this.priority);
}

class GetAllJobsListEvent extends TaskEvent {
  final String? search;
  final String? next;
  final String? prev;
  final bool? filter;
  final String? status;
  final   String? priority;
  final   String? reportingPersonFilter;
  const GetAllJobsListEvent(this.search, this.next, this.prev, this.filter, this.status, this.priority, this.reportingPersonFilter);
}

class GetOrganisationPerformanceList extends TaskEvent {
  final int? year;
  final int? month;

  const GetOrganisationPerformanceList(this.month, this.year,);
}

class GetNotificationListEvent extends TaskEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetNotificationListEvent( this.search, this.next, this.prev);
}

class NotificationIconEvent extends TaskEvent {
  const NotificationIconEvent();
}

class GetPendingTaskListEvent extends TaskEvent {
  const GetPendingTaskListEvent();
}
class GetPinnedTaskListEvent extends TaskEvent {
  const GetPinnedTaskListEvent();
}
class GetTopicListEvent extends TaskEvent {
  const GetTopicListEvent();
}
class GetPerformanceListEvent extends TaskEvent {
  final int taskid;
  final String code;
  const GetPerformanceListEvent(this.taskid, this.code);
}
//gettaskRead

class GetTaskReadListEvent extends TaskEvent {
  final int id;
  const GetTaskReadListEvent(this.id);
  @override
  List<Object> get props => [this.id];
}

class GetTaskReadCreateEvent extends TaskEvent {
  // final int id;
  const GetTaskReadCreateEvent();
  // @override
  // List<Object> get props => [this.id];
}
class GetJobReadCreateEvent extends TaskEvent {
  // final int id;
  const GetJobReadCreateEvent();
  // @override
  // List<Object> get props => [this.id];
}

//readReward
class GetReadRewardsEvent extends TaskEvent {
  final int id;
  final bool isTask;
  const GetReadRewardsEvent(this.id,this.isTask);
  @override
  List<Object> get props => [this.id];
}

//readperformance
class GetPerformanceReadEvent extends TaskEvent {
  final int id;
  const GetPerformanceReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//perfomanceTotal
class GetTotalPerformanceEvent extends TaskEvent {
  final String employeeCode;
  final int? id;
  const GetTotalPerformanceEvent(this.id, {required this.employeeCode});
  @override
  List<Object> get props => [];
}
//deleteTask
class DeleteTaskEvent extends TaskEvent {
  final int taskId;
  const DeleteTaskEvent(this.taskId);
}
//deleteReview
class DeleteReviewEvent extends TaskEvent {
  final int reviewId;
  const DeleteReviewEvent(this.reviewId);
}
//getassignedTask
class GetAssignCountEvent extends TaskEvent {
  final int id;
  const GetAssignCountEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//taskCreation
class CreateTaskEvent extends TaskEvent {
  final int? parant;
  final int jobId;
  final String durationOption;
  final int taskType;
  final int? statusStagesId;
  final String reportingPerson;
  final String createdBy;
  final String taskName;
  final String discription;
  final int priorityLeval;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String AssigningType;
  final String AssigningCode;
  final String notas;
  final String remarks;
  final String priority;
  final String createdOn;
  final String? lastmodified;
  final String? longitude;
  final String? latitude;
  final String? startTime;
  final String? endTime;
  const CreateTaskEvent(  {
    required this.longitude,
    required this.latitude,
    required this.endTime,
    required this.startTime,
    required this.durationOption,
    this.parant,
    required this.jobId,
    required this.taskType,
    this.statusStagesId,
    required this.reportingPerson,
    required this.createdBy,
    required this.taskName,
    required this.discription,
    required this.priorityLeval,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.AssigningType,
    required this.AssigningCode,
    required this.notas,
    required this.remarks,
    required this.priority,
    required this.createdOn,
    this.lastmodified,

  });
  @override
  List<Object> get props => [
    taskName,
  ];
}
//createreport
class CreateReportEvent extends TaskEvent {
  final int? taskId;
  final String? userId;
  final int? toipicId;
  final String? notes;

  const CreateReportEvent(  {

    this.userId,
    required this.notes,
    required this.taskId,
    required this.toipicId,


  });
  @override
  List<Object> get props => [
    notes??"",
  ];
}

//updatetask
class UpdateTaskEvent extends TaskEvent {
  final int? parant;
  final int taskType;
  final int id;
  final int? statusStagesId;
  final String reportingPerson;
  final String startTime;
  final String endTime;
  final String durationOption;
  final String createdBy;
  final String taskName;
  final String discription;
  final int priorityLeval;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String AssigningType;
  final String AssigningCode;
  final String notas;
  final String remarks;
  final String priority;
  final String createdOn;
  final String? lastmodified;
  final int? jobid;
  final String? longitude;
  final String? latitude;
  final String? attachmentNote;
  final String? attachmentDescription;
  final dynamic img1;
  final dynamic img2;
  final dynamic img3;
  final dynamic img4;
  final dynamic img5;

  const UpdateTaskEvent( {
    required this.longitude,
    required this.latitude,
    required this.img4,
    required this.startTime,
    required this.endTime,
    required this.img3,
    required this.durationOption,
    required this.img2,
    required this.img5,
    required this.attachmentDescription,
    required this.img1,
    required this.attachmentNote,
    this.parant,
    required this.taskType,
    this.statusStagesId,
    required this.reportingPerson,
    required this.createdBy,
    required this.taskName,
    required this.discription,
    required this.priorityLeval,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.AssigningType,
    required this.AssigningCode,
    required this.notas,
    required this.remarks,
    required this.priority,
    required this.createdOn,
    this.lastmodified,
    this.jobid,required this.id,

  });
  @override
  List<Object> get props => [
    taskName,
  ];
}


class UpdateReportingTaskEvent extends TaskEvent {
  final int? parant;
  final int taskType;
  final int id;
  final int? statusStagesId;
  final String reportingPerson;
  final String startTime;
  final String endTime;
  final String durationOption;
  final String createdBy;
  final String taskName;
  final String discription;
  final int priorityLeval;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String AssigningType;
  final String AssigningCode;
  final String notas;
  final String remarks;
  final String priority;
  final String createdOn;
  final String? lastmodified;
  final int? jobid;
  final String? longitude;
  final String? latitude;
  final String? attachmentNote;
  final String? attachmentDescription;
  final dynamic img1;
  final dynamic img2;
  final dynamic img3;
  final dynamic img4;
  final dynamic img5;

  const UpdateReportingTaskEvent( {
    required this.longitude,
    required this.durationOption,
    required this.latitude,
    required this.img4,
    required this.startTime,
    required this.endTime,
    required this.img3,
    required this.img2,
    required this.img5,
    required this.attachmentDescription,
    required this.img1,
    required this.attachmentNote,
    this.parant,
    required this.taskType,
    this.statusStagesId,
    required this.reportingPerson,
    required this.createdBy,
    required this.taskName,
    required this.discription,
    required this.priorityLeval,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.AssigningType,
    required this.AssigningCode,
    required this.notas,
    required this.remarks,
    required this.priority,
    required this.createdOn,
    this.lastmodified,
    this.jobid,required this.id,

  });
  @override
  List<Object> get props => [
    taskName,
  ];
}

//subtaskList
class GetSubTaskListEvent extends TaskEvent {
  final int? taskId;
  const GetSubTaskListEvent(this.taskId);
}
//reviewlist
class GetReviewListEvent extends TaskEvent {
  final int? taskId;
  const GetReviewListEvent(this.taskId);
}

//PaymentPost
class CreatePaymentEvent extends TaskEvent {
  final int? jobId;
  final int? taskId;
  final String assigningType;
  final double budget;
  final String AssigningCode;
  final String notas;
  final String discription;
  final double expense;
  final int img1;
  final int img2;
  final int img3;
  final int img4;
  final int img5;
  const CreatePaymentEvent( {

    required this.jobId,
    required this.expense,
    required this.budget,
    required this.assigningType,
    required this.taskId,
    required this.discription,
    required this.AssigningCode,
    required this.notas,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,


  });
  @override
  List<Object> get props => [
    budget,
  ];
}
//readpayment
class GetPaymentReadListEvent extends TaskEvent {
  final int id;
  final bool isTask;
  const GetPaymentReadListEvent(this.id,this.isTask);
  @override
  List<Object> get props => [this.id];
}
//updatepayment
class UpdatePaymentEvent extends TaskEvent {
  final int? payId;
  final int? jobId;
  final int? taskId;
  final String assigningType;
  final double budget;
  final String AssigningCode;
  final String notas;
  final String discription;
  final double expense;
  final bool isActive;
  final dynamic img1;
  final dynamic img2;
  final dynamic img3;
  final dynamic img4;
  final dynamic img5;
  const UpdatePaymentEvent( {

    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.img1,
    required this.payId,
    required this.isActive,
    required this.jobId,
    required this.expense,
    required this.budget,
    required this.assigningType,
    required this.taskId,
    required this.discription,
    required this.AssigningCode,
    required this.notas,


  });
  @override
  List<Object> get props => [
    budget,
  ];
}
//createRreview
class CreateReviewTaskEvent extends TaskEvent {
  final int? parant;
  final int taskId;
  final String reviewdBy;
  final int? image;
  final String? review;
  final String? notes;
  const CreateReviewTaskEvent( {
    this.parant,
    required this.taskId,
    required this.reviewdBy,
    required this.review,
    required this.image,
    required this.notes,
  });
  @override
  List<Object> get props => [
    review??"",
  ];
}
//updateReview
class UpdateReviewTaskEvent extends TaskEvent {
  final int? parant;
  final bool isActive;
  final String reviewdBy;
  final dynamic image;
  final int taskId;
  final int id;
  final String? review;
  final String? notes;
  const UpdateReviewTaskEvent( {
    this.parant,
    required this.isActive,
    required this.taskId,
    required this.id,
    required this.reviewdBy,
    required this.review,
    required this.image,
    required this.notes,
  });
  @override
  List<Object> get props => [
    review??'',
  ];
}
//createRewards
class CreateRewardTaskEvent extends TaskEvent {
  final String discription;
  final String name;
  final String notes;
  final int? typeId;
  final String? type;
  final int img1;
  final int img2;
  final int img3;
  final int img4;
  final int img5;
  const CreateRewardTaskEvent(  {
    this.typeId,
    this.type,
    required this.img2,
    required this.img1,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.notes,
    required this.name,
    required this.discription,
  });
  @override
  List<Object> get props => [
    name,
  ];
}
//updateTask
class UpdateRewardTaskEvent extends TaskEvent {
  final String discription;
  final dynamic img1;
  final dynamic img2;
  final dynamic img3;
  final dynamic img4;
  final dynamic img5;
  final int id;
  final String name;
  final String notes;
  final int? typeId;
  final String? type;
  final bool isActive;
  const UpdateRewardTaskEvent(  {
    this.typeId,
    this.type,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.id,
    required this.notes,
    required this.name,
    required this.discription,
    required this.isActive
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//pointListing
class GetPointsListEvent extends TaskEvent {
  const GetPointsListEvent();
}
//createperfrmance
class CreatePerfomanceAppraisalTaskEvent extends TaskEvent {
  final String name;
  final String discription;
  final String userId;
  final int pointId;
  final int taskId;
  const CreatePerfomanceAppraisalTaskEvent( {
    required this.name,
    required this.taskId,
    required this.discription,
    required this.userId,
    required this.pointId,
  });
  @override
  List<Object> get props => [
    name,
  ];
}
//taskPerfom
class TaskAssignedGroupListEvent extends TaskEvent {
  final String code;
  final String? prev;
  const TaskAssignedGroupListEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}

//CriteraiRead
class GetCriteriaReadEvent extends TaskEvent {
  final String taskCode;
  const GetCriteriaReadEvent(this.taskCode);
  @override
  List<Object> get props => [this.taskCode];
}
//
//notification
class NotificationDueEvent extends TaskEvent {
  final int id;
  const NotificationDueEvent(this.id);
  @override
  List<Object> get props => [this.id];
}

//reporetdlist admin
class ReportListAdminEvent extends TaskEvent {
  final String? next;
  final String? prev;
  const ReportListAdminEvent(this.next, this.prev);
}

//reported list user
class ReportListUserEvent extends TaskEvent {
  final String? next;
  final String? prev;
  const ReportListUserEvent(this.next, this.prev);
}

//replayReport
class ReplayReportEvent extends TaskEvent {
  final int? id;
  final String? reportStatus;
  final String? replay;
  final String replayType;
  final String reAssignCode;

  const ReplayReportEvent(  {

    this.id,
    required this.replayType,
    required this.reAssignCode,
    required this.replay,
    required this.reportStatus


  });
  @override
  List<Object> get props => [
    reportStatus??"",
  ];
}

class SearchMapResults extends TaskEvent {
  final String searchQuery;
  const SearchMapResults({required this.searchQuery});
}