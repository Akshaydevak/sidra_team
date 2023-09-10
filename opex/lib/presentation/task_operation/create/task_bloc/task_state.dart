part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}
//jobList
class GetTaskTypeListInitial extends TaskState {}

class GetTaskTypeListLoading extends TaskState {}

class GetTaskTypeListSuccess extends TaskState {
  final List<GetTaskTypeList> taskTypeList;

  const GetTaskTypeListSuccess(this.taskTypeList);
}

class GetTaskTypeListFailed extends TaskState {}
//task list
class GetTaskListInitial extends TaskState {}

class GetTaskListLoading extends TaskState {}

class GetTaskListSuccess extends TaskState {
  final List<GetTaskList>? taskList;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetTaskListSuccess({this.taskList, this.prevPageUrl, this.nextPageUrl});
}

class GetTaskListFailed extends TaskState {
  final String msg;
  const GetTaskListFailed( this.msg);
}

//notification
class GetNotificationListLoading extends TaskState {}

class GetNotificationListSuccess extends TaskState {
  final List<NotificationList>? notificationList;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetNotificationListSuccess({this.notificationList, this.prevPageUrl, this.nextPageUrl});
}

class GetNotificationListFailed extends TaskState {
  final String msg;
  const GetNotificationListFailed( this.msg);
}

//pendinglist
class GetPendingTaskListInitial extends TaskState {}

class GetPendingTaskListLoading extends TaskState {}

class GetPendingTaskListSuccess extends TaskState {
  final List<GetTaskList> taskList;

  const GetPendingTaskListSuccess(this.taskList);
}

class GetPendingTaskListFailed extends TaskState {}

//pinnedtask
class GetPinnedTaskListInitial extends TaskState {}

class GetPinnedTaskListLoading extends TaskState {}

class GetPinnedTaskListSuccess extends TaskState {
  final List<GetTaskList> taskList;

  const GetPinnedTaskListSuccess(this.taskList);
}

class GetPinnedTaskListFailed extends TaskState {}


//topic
class GetTopicListLoading extends TaskState {}

class GetTopicListSuccess extends TaskState {
  final List<GetTaskList> taskList;

  const GetTopicListSuccess(this.taskList);
}

class GetTopicListFailed extends TaskState {}


//task read
class GetTaskReadInitial extends TaskState {}


class GetTaskReadLoading extends TaskState {}

class GetTaskReadSuccess extends TaskState {
  final GetTaskList getTaskRead;
  GetTaskReadSuccess({required this.getTaskRead});
  @override
  List<Object> get props => [getTaskRead];
}

class GetTaskReadFailed extends TaskState {
  final String error;GetTaskReadFailed(this.error);
}
//readRewards
class GetReadRewadsInitial extends TaskState {}


class GetReadRewadsLoading extends TaskState {}

class GetReadRewadsSuccess extends TaskState {
  final ReadRewards readRewards;
  GetReadRewadsSuccess({required this.readRewards});
  @override
  List<Object> get props => [readRewards];
}

class GetReadRewadsFailed extends TaskState {
  final String error;GetReadRewadsFailed(this.error);
}
//readPerformance
class GetReadPerformanceInitial extends TaskState {}


class GetReadPerformanceLoading extends TaskState {}

class GetReadPerformanceSuccess extends TaskState {
  final ReadPerformanceAppraisal performanceList;
  GetReadPerformanceSuccess({required this.performanceList});
  @override
  List<Object> get props => [performanceList];
}

class GetReadPerformanceFailed extends TaskState {
  final String error;
  GetReadPerformanceFailed(this.error);
}
//toatlPer
class GetTotalPerformanceInitial extends TaskState {}


class GetTotalPerformanceLoading extends TaskState {}

class GetTotalPerformanceSuccess extends TaskState {
  final int totalMark;
  GetTotalPerformanceSuccess({required this.totalMark});
  @override
  List<Object> get props => [totalMark];
}

class GetTotalPerformanceFailed extends TaskState {
  final String error;GetTotalPerformanceFailed(this.error);
}
//assigntaskCount
class GetAssignCountInitial extends TaskState {}


class GetAssignCountLoading extends TaskState {}

class GetAssignCountSuccess extends TaskState {
  final GetCountTask getCountTask;
  const GetAssignCountSuccess({required this.getCountTask});
  @override
  List<Object> get props => [getCountTask];
}

class GetAssignCountFailed extends TaskState {
  final String error;
  const GetAssignCountFailed(this.error);
}
//createTask
class CreateTaskInitial extends TaskState {}

class CreateTaskLoading extends TaskState {}

class CreateTaskSuccess extends TaskState {
  final String taskId;

  const CreateTaskSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreateTaskFailed extends TaskState {
  final String error;

  const CreateTaskFailed(this.error);
  @override
  List<Object> get props => [];
}
//report task
class CreateReportLoading extends TaskState {}

class CreateReportSuccess extends TaskState {
  final String taskId;

  const CreateReportSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreateReportFailed extends TaskState {
  final String error;

  const CreateReportFailed(this.error);
  @override
  List<Object> get props => [];
}
//update Tasl
class UpdateTaskInitial extends TaskState {}

class UpdateTaskLoading extends TaskState {}

class UpdateTaskSuccess extends TaskState {
  final String taskId;

  const UpdateTaskSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class UpdateTaskFailed extends TaskState {
  final String error;

  const UpdateTaskFailed(this.error);
  @override
  List<Object> get props => [];
}

class UpdateReportingTaskLoading extends TaskState {}

class UpdateReportingSuccess extends TaskState {
  final String taskId;

  const UpdateReportingSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class UpdateReportingFailed extends TaskState {
  final String error;

  const UpdateReportingFailed(this.error);
  @override
  List<Object> get props => [];
}
//deleteTask
class DeleteTaskInitial extends TaskState {}

class DeleteTaskLoading extends TaskState {}

class DeleteTaskSuccess extends TaskState {}

class DeleteTaskFailed extends TaskState {}

//deleteReview
class DeleteReviewInitial extends TaskState {}

class DeleteReviewLoading extends TaskState {}

class DeleteReviewSuccess extends TaskState {
  final String? status;
  const DeleteReviewSuccess(this.status);
}

class DeleteReviewFailed extends TaskState {}

//subtasklist
class GetSubTaskListInitial extends TaskState {}

class GetSubTaskListLoading extends TaskState {}

class GetSubTaskListSuccess extends TaskState {
  final List<GetTaskList> taskList;

  const GetSubTaskListSuccess(this.taskList);
}

class GetSubTaskListFailed extends TaskState {}
//performancelist
class GetPerformanceListInitial extends TaskState {}

class GetPerformanceListLoading extends TaskState {}

class GetPerformanceListSuccess extends TaskState {
  final List<PerformanceList> performanceList;

  const GetPerformanceListSuccess(this.performanceList);
}

class GetPerformanceListFailed extends TaskState {}
//reviewlist
class GetReviewListInitial extends TaskState {}

class GetReviewListLoading extends TaskState {}

class GetReviewListSuccess extends TaskState {
  final List<ReviewModel> reviewList;

  const GetReviewListSuccess(this.reviewList);
}

class GetReviewListFailed extends TaskState {
  final List<ReviewModel> reviewList;
  const GetReviewListFailed(this.reviewList);
}

//createPayment
class CreatePaymentInitial extends TaskState {}

class CreatePaymentLoading extends TaskState {}

class CreatePaymentSuccess extends TaskState {
  final String taskId;

  const CreatePaymentSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreatePaymentFailed extends TaskState {
  final String error;

  const CreatePaymentFailed(this.error);
  @override
  List<Object> get props => [];
}
//readPayment
class GetPaymentReadInitial extends TaskState {}


class GetPaymentReadLoading extends TaskState {}

class GetPaymentReadSuccess extends TaskState {
  final PaymentModel paymentRead;
  const GetPaymentReadSuccess({required this.paymentRead});
  @override
  List<Object> get props => [paymentRead];
}

class GetPaymentReadFailed extends TaskState {
  final String error;
  const GetPaymentReadFailed(this.error);
}
//readreview
class GetReviewReadLoading extends TaskState {}

class GetReviewReadSuccess extends TaskState {
  final PaymentModel paymentRead;
  const GetReviewReadSuccess({required this.paymentRead});
  @override
  List<Object> get props => [paymentRead];
}

class GetReviewReadFailed extends TaskState {
  final String error;
  const GetReviewReadFailed(this.error);
}

//updatePayment
class UpdatePaymentInitial extends TaskState {}

class UpdatePaymentLoading extends TaskState {}

class UpdatePaymentSuccess extends TaskState {
  final String taskId;

  const UpdatePaymentSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class UpdatePaymentFailed extends TaskState {
  final String error;

  const UpdatePaymentFailed(this.error);
  @override
  List<Object> get props => [];
}
//createReview
class CreateReviewInitial extends TaskState {}

class CreateReviewLoading extends TaskState {}

class CreateReviewSuccess extends TaskState {
  final String taskId;

  const CreateReviewSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreateReviewFailed extends TaskState {
  final String error;

  const CreateReviewFailed(this.error);
  @override
  List<Object> get props => [];
}
//updatereview
class UpdateReviewInitial extends TaskState {}

class UpdateReviewLoading extends TaskState {}

class UpdateReviewSuccess extends TaskState {
  final String taskId;

  const UpdateReviewSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class UpdateReviewFailed extends TaskState {
  final String error;

  const UpdateReviewFailed(this.error);
  @override
  List<Object> get props => [];
}
//createperfomance
class CreatePerformanceInitial extends TaskState {}

class CreatePerformanceLoading extends TaskState {}

class CreatePerformanceSuccess extends TaskState {
  final String taskId;

  const CreatePerformanceSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreatePerformanceFailed extends TaskState {
  final String error;

  const CreatePerformanceFailed(this.error);
  @override
  List<Object> get props => [];
}
//createrewards
class CreateRewardInitial extends TaskState {}

class CreateRewardLoading extends TaskState {}

class CreateRewardSuccess extends TaskState {
  final String taskId;

  const CreateRewardSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class CreateRewardFailed extends TaskState {
  final String error;

  const CreateRewardFailed(this.error);
  @override
  List<Object> get props => [];
}
//update rewards
class UpdateRewardInitial extends TaskState {}

class UpdateRewardLoading extends TaskState {}

class UpdateRewardSuccess extends TaskState {
  final String taskId;

  const UpdateRewardSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class UpdateRewardFailed extends TaskState {
  final String error;

  const UpdateRewardFailed(this.error);
  @override
  List<Object> get props => [];
}
//pointlist
class GetPointListInitial extends TaskState {}

class GetPointListLoading extends TaskState {}

class GetPointListSuccess extends TaskState {
  final List<PointsList> pointList;

  const GetPointListSuccess(this.pointList);
}

class GetPointListFailed extends TaskState {}
//
class GetTaskAssignedGroupListInitial extends TaskState {}

class GetTaskAssignedGroupListLoading extends TaskState {}

class GetTaskAssignedGroupListSuccess extends TaskState {
  final PaginatedResponse offerPeriod;

  GetTaskAssignedGroupListSuccess({required this.offerPeriod});
  @override
  List<Object> get props => [offerPeriod];
}

class GetTaskAssignedGroupListFailed extends TaskState {
  GetTaskAssignedGroupListFailed();
}


//cretera

class GetCriteriaReadLoading extends TaskState {}

class GetCriteriaReadSuccess extends TaskState {
  final CriteriaRead criteriaRead;
  GetCriteriaReadSuccess({required this.criteriaRead});
  @override
  List<Object> get props => [criteriaRead];
}

class GetCriteriaReadFailed extends TaskState {
  final String error;GetCriteriaReadFailed(this.error);
}

//noti
class NotificationDueLoading extends TaskState {}

class NotificationDueSuccess extends TaskState {

  NotificationDueSuccess();
  @override
  List<Object> get props => [];
}

class NotificationDueFailed extends TaskState {
  final String error;
  NotificationDueFailed(this.error);
}

//noti
class NotificationIconLoading extends TaskState {}

class NotificationIconSuccess extends TaskState {

  NotificationIconSuccess();
  @override
  List<Object> get props => [];
}

class NotificationIconFailed extends TaskState {
  final String error;
  NotificationIconFailed(this.error);
}
//report admin list
class ReportListAdminListLoading extends TaskState {}

class ReportListAdminListSuccess extends TaskState  {
  final List<ReportModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const ReportListAdminListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class ReportListAdminListFailed extends TaskState {
  final String msg;
  ReportListAdminListFailed(this.msg);
}
//report user list
class ReportListUserListLoading extends TaskState {}

class ReportListUserListSuccess extends TaskState  {
  final List<ReportModel>? orders;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const ReportListUserListSuccess(
      {this.orders, this.prevPageUrl, this.nextPageUrl});
}

class ReportListUserListFailed extends TaskState {
  final String msg;
  ReportListUserListFailed(this.msg);
}



//replay report
class ReplayReportLoading extends TaskState {}

class ReplayReportSuccess extends TaskState {
  final String taskId;

  const ReplayReportSuccess(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class ReplayReportFailed extends TaskState {
  final String error;

  const ReplayReportFailed(this.error);
  @override
  List<Object> get props => [];
}