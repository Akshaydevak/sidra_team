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
  const GetTaskListEvent();
}

class GetPendingTaskListEvent extends TaskEvent {
  const GetPendingTaskListEvent();
}
class GetPinnedTaskListEvent extends TaskEvent {
  const GetPinnedTaskListEvent();
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

//readReward
class GetReadRewardsEvent extends TaskEvent {
  final int id;
  const GetReadRewardsEvent(this.id);
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
  const GetTotalPerformanceEvent();
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
  final int taskType;
  final int? statusStagesId;
  final String reportingPerson;
  final String createdBy;
  final String taskName;
  final String discription;
  final String priorityLeval;
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
  final String locationUrl;
  const CreateTaskEvent(  {
    required this.locationUrl,
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
//updatetask
class UpdateTaskEvent extends TaskEvent {
  final int? parant;
  final int taskType;
  final int id;
  final int? statusStagesId;
  final String reportingPerson;
  final String createdBy;
  final String taskName;
  final String discription;
  final String priorityLeval;
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
  final String locationUrl;
  const UpdateTaskEvent( {
    required this.locationUrl,
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
  const GetSubTaskListEvent();
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
  const CreatePaymentEvent( {

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
//readpayment
class GetPaymentReadListEvent extends TaskEvent {
  final int id;
  const GetPaymentReadListEvent(this.id);
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
  const UpdatePaymentEvent( {

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
  final int image;
  final String review;
  final String notes;
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
    review,
  ];
}
//createRewards
class CreateRewardTaskEvent extends TaskEvent {
  final String discription;
  final int image;
  final String name;
  final String notes;
  final int? typeId;
  final String? type;
  const CreateRewardTaskEvent(  {
    this.typeId,
    this.type,
    required this.image,
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
  final int image;
  final int id;
  final String name;
  final String notes;
  final int? typeId;
  final String? type;
  final bool isActive;
  const UpdateRewardTaskEvent(  {
    this.typeId,
    this.type,
    required this.image,
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