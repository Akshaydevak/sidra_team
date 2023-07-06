import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/data_response.dart';
import '../model/task_models.dart';
import '../task_datasource.dart';
import '../task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskDataSource _taskDataSource = TaskDataSource();
  final TaskRepo _taskRepo = TaskRepo();
  TaskBloc() : super(GetTaskTypeListInitial());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is GetTaskTypeListEvent) {
      yield* getTaskTypeListState();
    }
    if (event is GetTaskListEvent) {
      yield* getTaskListState();
    }
    if (event is GetPendingTaskListEvent) {
      yield* getPendingTaskListState();
    }
    if (event is GetPinnedTaskListEvent) {
      yield* getPinnedTaskListState();
    }
    if (event is GetSubTaskListEvent) {
      yield* getSubTaskListState();
    }
    if (event is GetReviewListEvent) {
      yield* getReviewListState(event.taskId);
    }
    if (event is GetPerformanceListEvent) {
      yield* getPerformanceList(event.taskid,event.code);
    }
    else if (event is GetTaskReadListEvent) {
      yield* getTaskRead(event.id);
    }
    if (event is GetReadRewardsEvent) {
      yield* getReadRewards(event.id);
    }
     if (event is GetPerformanceReadEvent) {
      yield* getPerformanceRead(event.id);
    }
     if (event is GetTotalPerformanceEvent) {
      yield* getTotalPerformance();
    }
    if (event is DeleteTaskEvent) {
      yield* deleteTask(jobId: event.taskId);
    }
    if (event is DeleteReviewEvent) {
      yield* deleteReview(reviewId: event.reviewId);
    }
     if (event is GetPaymentReadListEvent) {
      yield* getPaymentRead(event.id);
    }
    else if (event is GetAssignCountEvent) {
      yield* getAssignCount(event.id);
    }
    if (event is CreateTaskEvent) {
      yield* createTaskstate(
        locationUrl: event.locationUrl.trim(),
          startDate: event.startDate.trim(),
          endDate: event.endDate.trim(),
          reportingPerson: event.reportingPerson,
          priority: event.priority.trim(),
          isActive: event.isActive,
          discription: event.discription.trim(),
          createdBy: event.createdBy,
        AssigningCode: event.AssigningCode.trim(),
        AssigningType: event.AssigningType.trim(),
        createdOn: event.createdOn.trim(),
        jobId: event.jobId,
        lastmodified: event.lastmodified?.trim(),
        notas: event.notas.trim(),
        parant: event.parant,
        priorityLeval: event.priorityLeval.trim(),
        remarks: event.remarks.trim(),
        taskName: event.taskName.trim(),
        taskType: event.taskType,
        statusStagesId: event.statusStagesId,

      );
    }
    if (event is UpdateTaskEvent) {
      yield* updateTaskstate(
        locationUrl: event.locationUrl.trim(),
        startDate: event.startDate.trim(),
        endDate: event.endDate.trim(),
        reportingPerson: event.reportingPerson,
        priority: event.priority.trim(),
        isActive: event.isActive,
        discription: event.discription.trim(),
        createdBy: event.createdBy,
        AssigningCode: event.AssigningCode.trim(),
        AssigningType: event.AssigningType.trim(),
        createdOn: event.createdOn.trim(),
        jobid: event.jobid,
        id:event.id,
        lastmodified: event.lastmodified?.trim(),
        notas: event.notas.trim(),
        parant: event.parant,
        priorityLeval: event.priorityLeval.trim(),
        remarks: event.remarks.trim(),
        taskName: event.taskName.trim(),
        taskType: event.taskType,
        statusStagesId: event.statusStagesId,

      );
    }
    if (event is CreateReviewTaskEvent) {
      yield* createReviewTask(
        image: event.image,
        parant: event.parant,
        taskId: event.taskId,
        notes: event.notes.trim(),
        review: event.review.trim(),
        reviewedBy: event.reviewdBy.trim()


      );
    }
    if (event is CreatePerfomanceAppraisalTaskEvent) {
      yield* createPerformanceAppraisalTask(
          name: event.name.trim(),
          discription: event.discription.trim(),
          taskId: event.taskId,
          userId: event.userId,
          pointId: event.pointId,
      );
    }
    if (event is CreateRewardTaskEvent) {
      yield* createReward(
        type: event.type??"",
          typeId: event.typeId??0,
          image: event.image,
          discription: event.discription.trim(),
          name: event.name.trim(),
          notes: event.notes.trim(),
      );
    }
    if (event is UpdateRewardTaskEvent) {
      yield* updateRewards(
        type: event.type??"",
        typeId: event.typeId??0,
        image: event.image,
        discription: event.discription.trim(),
        name: event.name.trim(),
        notes: event.notes.trim(),
        isActive: event.isActive,
        id: event.id,
      );
    }
    if (event is CreatePaymentEvent) {
      yield* createPaymentstate(

        discription: event.discription.trim(),
        AssigningCode: event.AssigningCode.trim(),
        assigningType: event.assigningType.trim(),
        jobId: event.jobId,
        taskId: event.taskId,
        notas: event.notas.trim(),
        budget: event.budget,
        expense: event.expense,

      );
    }
    if (event is UpdatePaymentEvent) {
      yield* updatePaymentstate(
        payId: event.payId,

        discription: event.discription.trim(),
        AssigningCode: event.AssigningCode.trim(),
        assigningType: event.assigningType.trim(),
        jobId: event.jobId,
        taskId: event.taskId,
        notas: event.notas.trim(),
        budget: event.budget,
        expense: event.expense,
        isActive: event.isActive

      );
    }
    if (event is GetPointsListEvent) {
      yield* getPointsList();
    }
  }


  //jobListState
  Stream<TaskState> getTaskTypeListState() async* {
    yield GetTaskTypeListLoading();

    final dataResponse = await _taskRepo.getTaskTypeList();

    if (dataResponse.data.isNotEmpty) {
      yield GetTaskTypeListSuccess(dataResponse.data);
    } else {
      yield GetTaskTypeListFailed();
    }
  }
  //task list
  Stream<TaskState> getTaskListState() async* {
    yield GetTaskListLoading();

    final dataResponse = await _taskRepo.getTaskList();

    if (dataResponse.data.isNotEmpty) {
      yield GetTaskListSuccess(dataResponse.data);
    } else {
      yield GetTaskListFailed();
    }
  }

  //pendinglist
  Stream<TaskState> getPendingTaskListState() async* {
    yield GetPendingTaskListLoading();

    final dataResponse = await _taskRepo.getPendingTaskList();

    if (dataResponse.data.isNotEmpty) {
      yield GetPendingTaskListSuccess(dataResponse.data);
    } else {
      yield GetPendingTaskListFailed();
    }
  }
  //pinnedtask
  Stream<TaskState> getPinnedTaskListState() async* {
    yield GetPinnedTaskListLoading();

    final dataResponse = await _taskRepo.getPinnedTaskList();

    if (dataResponse.data.isNotEmpty) {
      yield GetPinnedTaskListSuccess(dataResponse.data);
    } else {
      yield GetPinnedTaskListFailed();
    }
  }

  //taskRead

  Stream<TaskState> getTaskRead(int id) async* {

    yield GetTaskReadLoading();

    final dataResponse = await _taskRepo.getTaskReadData(id);

    if (dataResponse.hasData) {
      yield GetTaskReadSuccess(getTaskRead: dataResponse.data);
    } else {
      yield GetTaskReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //readRewards
  Stream<TaskState> getReadRewards(int id) async* {

    yield GetReadRewadsLoading();

    final dataResponse = await _taskRepo.getReadRewards(id);

    if (dataResponse.hasData) {
      yield GetReadRewadsSuccess(readRewards: dataResponse.data);
    } else {
      yield GetReadRewadsFailed(dataResponse.error.toString(),
      );
    }
  }

  //readPerformance
  Stream<TaskState> getPerformanceRead(int id) async* {

    yield GetReadPerformanceLoading();

    final dataResponse = await _taskRepo.getPerformanceRead(id);

    if (dataResponse.hasData) {
      yield GetReadPerformanceSuccess(performanceList: dataResponse.data);
    } else {
      yield GetReadPerformanceFailed(dataResponse.error.toString(),
      );
    }
  }

  //totalPerfomane
  Stream<TaskState> getTotalPerformance() async* {

    yield GetTotalPerformanceLoading();

    final dataResponse = await _taskRepo.getTotalPerformance();

    if (dataResponse.hasData) {
      yield GetTotalPerformanceSuccess(totalMark: dataResponse.data);
    } else {
      yield GetTotalPerformanceFailed(dataResponse.error.toString(),
      );
    }
  }

  //assigntaskcount
  Stream<TaskState> getAssignCount(int id) async* {

    yield GetAssignCountLoading();

    final dataResponse = await _taskRepo.getAssignCount(id);

    if (dataResponse.hasData) {
      yield GetAssignCountSuccess(getCountTask: dataResponse.data);
    } else {
      yield GetAssignCountFailed(dataResponse.error.toString());
    }
  }
  //createJob
  Stream<TaskState> createTaskstate(
      {
        required int? parant,
        required int jobId,
        required int taskType,
        final int? statusStagesId,
        required String reportingPerson,
        required String createdBy,
        required String taskName,
        required String discription,
        required String priorityLeval,
        required String startDate,
        required String endDate,
        required bool isActive,
        required String AssigningType,
        required String AssigningCode,
        required String notas,
        required String remarks,
        required String priority,
        required String createdOn,
        required String? lastmodified,
        required String? locationUrl,
      }) async* {
    yield CreateTaskLoading();

    final dataResponse = await _taskRepo.taskCreatePost(
      locationUrl: locationUrl,
      statusStagesId:statusStagesId,
        startDate: startDate,
        endDate: endDate,
        createdBy: createdBy,
        discription: discription,
        isActive: isActive,
        priority: priority,
        reportingPerson: reportingPerson,
      taskType: taskType,
      taskName: taskName,
      remarks: remarks,
      priorityLeval: priorityLeval,
      parant: parant,
      notas: notas,
      lastmodified: lastmodified,
      jobId: jobId,
      createdOn: createdOn,
      AssigningType: AssigningType,
      AssigningCode: AssigningCode,


    );

    if (dataResponse.data) {
      print("sucsess ");
      yield CreateTaskSuccess(dataResponse.error??"");
    } else {
      print("failed ");
      yield CreateTaskFailed(
        dataResponse.error ?? "",);
    }
  }
  //updateTask
  Stream<TaskState> updateTaskstate(
      {
        required int? parant,
        required int taskType,
        required int id,
        final int? statusStagesId,
        required String reportingPerson,
        required String createdBy,
        required String taskName,
        required String discription,
        required String priorityLeval,
        required String startDate,
        required String endDate,
        required bool isActive,
        required String AssigningType,
        required String AssigningCode,
        required String notas,
        required String remarks,
        required String priority,
        required String createdOn,
        required String? lastmodified,
        required int? jobid,
        required String? locationUrl,
      }) async* {
    yield UpdateTaskLoading();

    final dataResponse = await _taskRepo.taskUpdatePost(
      locationUrl: locationUrl,
      statusStagesId:statusStagesId,
      startDate: startDate,
      endDate: endDate,
      createdBy: createdBy,
      discription: discription,
      isActive: isActive,
      priority: priority,
      reportingPerson: reportingPerson,
      taskType: taskType,
      taskName: taskName,
      remarks: remarks,
      id: id,
      priorityLeval: priorityLeval,
      parant: parant,
      notas: notas,
      lastmodified: lastmodified,
      jobid: jobid,
      createdOn: createdOn,
      AssigningType: AssigningType,
      AssigningCode: AssigningCode,

    );

    if (dataResponse.data) {
      print("task succcess atv repo");
      yield UpdateTaskSuccess(dataResponse.error??"",);
    } else {
      yield UpdateTaskFailed(
        dataResponse.error ?? "",);
    }
  }
  //deleteTask
  Stream<TaskState> deleteTask({required int jobId}) async* {
    yield DeleteTaskLoading();
    final dataResponse = await _taskDataSource.deleteTask(jobId);
    if (dataResponse == "success") {
      yield DeleteTaskSuccess();
    } else {
      yield DeleteTaskFailed();
    }
  }
  //deletereview
  Stream<TaskState> deleteReview({required int reviewId}) async* {
    yield DeleteReviewLoading();
    final dataResponse = await _taskDataSource.deleteReview(reviewId);
    if (dataResponse == "success") {
      yield DeleteReviewSuccess();
    } else {
      yield DeleteReviewFailed();
    }
  }
  //subtasklist
  Stream<TaskState> getSubTaskListState() async* {
    yield GetSubTaskListLoading();

    final dataResponse = await _taskRepo.getSubTaskList();

    if (dataResponse.data.isNotEmpty) {
      print("sub tast is a success");
      yield GetSubTaskListSuccess(dataResponse.data);
    } else {
      yield GetSubTaskListFailed();
    }
  }
  //performanceList
  Stream<TaskState> getPerformanceList(int taskid,String? code) async* {
    yield GetPerformanceListLoading();

    final dataResponse = await _taskRepo.getPerformanceList(taskid,code);

    if (dataResponse.data.isNotEmpty) {
      print("sub tast is a success");
      yield GetPerformanceListSuccess(dataResponse.data);
    } else {
      yield GetPerformanceListFailed();
    }
  }
  //reviewlist
  Stream<TaskState> getReviewListState(int? taskId) async* {
    yield GetReviewListLoading();

    final dataResponse = await _taskRepo.getReviewList(taskId);

    if (dataResponse.data!=null &&dataResponse.data?.isNotEmpty) {
      print("sub tast is a success");
      yield GetReviewListSuccess(dataResponse.data);
    } else {
      yield GetReviewListFailed();
    }
  }

  //paymentCreate
  Stream<TaskState> createPaymentstate(
      {
        required int? jobId,
        required int? taskId,
        required String assigningType,
        required double budget,
        required String AssigningCode,
        required String notas,
        required String discription,
        required double expense,
      }) async* {
    yield CreatePaymentLoading();

    final dataResponse = await _taskRepo.paymentCreatePost(
      discription: discription,
      jobId: jobId,
      notas: notas,
      taskId: taskId,
      assigningType: assigningType,
      AssigningCode: AssigningCode,
      budget: budget,
      expense: expense

    );

    if (dataResponse.data) {
      print("task succcess atv repo");
      yield CreatePaymentSuccess(dataResponse.error??"",);
    } else {
      yield CreatePaymentFailed(
        dataResponse.error ?? "");
    }
  }
  //readPayment
  Stream<TaskState> getPaymentRead(int id) async* {

    yield GetPaymentReadLoading();

    final dataResponse = await _taskRepo.getPaymentRead(id);

    if (dataResponse.hasData) {
      yield GetPaymentReadSuccess(paymentRead: dataResponse.data);
    } else {
      yield GetPaymentReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //updatePayment
  Stream<TaskState> updatePaymentstate(
      {
        required int? payId,
        required int? jobId,
        required int? taskId,
        required String assigningType,
        required double budget,
        required String AssigningCode,
        required String notas,
        required String discription,
        required double expense,
        required bool isActive,
      }) async* {
    yield UpdatePaymentLoading();

    final dataResponse = await _taskRepo.paymentUpdatePost(
        discription: discription,
        jobId: jobId,
        notas: notas,
        taskId: taskId,
        assigningType: assigningType,
        AssigningCode: AssigningCode,
        budget: budget,
        expense: expense,
      isActive: isActive,
      payId: payId

    );

    if (dataResponse.data) {
      print("task succcess atv repo");
      yield UpdatePaymentSuccess(dataResponse.error??"",);
    } else {
      yield UpdatePaymentFailed(
          dataResponse.error ?? "");
    }
  }
  //createReview
  Stream<TaskState> createReviewTask(
      {
        required int? parant,
        required int taskId,
        required int image,
        required String reviewedBy,
        required String review,
        required String notes,

      }) async* {
    yield CreateReviewLoading();

    final dataResponse = await _taskRepo.createReviewTask(
      image:image,
      parant: parant,
      taskId: taskId,
      notes: notes,
      review: review,
      reviewedBy: reviewedBy,
    );

    if (dataResponse.data) {
      print("task succcess atv repo");
      yield CreateReviewSuccess(dataResponse.error??"",);
    } else {
      yield CreateReviewFailed(
        dataResponse.error ?? "",);
    }
  }
  //createPerfomance
  Stream<TaskState> createPerformanceAppraisalTask(
      {
        required String? userId,
        required int taskId,
        required int pointId,
        required String name,
        required String discription,

      }) async* {
    yield CreatePerformanceLoading();

    final dataResponse = await _taskRepo.createPerformanceAppraisalTask(
      name:name,
      discription: discription,
      taskId: taskId,
      userId: userId,
      pointId: pointId,

    );

    if (dataResponse.data) {
      print("task succcess atv repo");
      yield CreatePerformanceSuccess(dataResponse.error??"",);
    } else {
      yield CreatePerformanceFailed(
        dataResponse.error ?? "",);
    }
  }
  //createRewads
  Stream<TaskState> createReward(
      {

        required int image,
        required String discription,
        required String name,
        required String notes,
        required String type,
        required int typeId,

      }) async* {
    yield CreateRewardLoading();

    final dataResponse = await _taskRepo.createReward(
      image:image,
      typeId: typeId,
      type: type,
      discription: discription,
      name: name,
      notes: notes,
    );

    if (dataResponse!=null) {
      print("sucsess ");
      yield CreateRewardSuccess(dataResponse.error??"");
    } else {
      print("failed ");
      yield CreateRewardFailed(
        dataResponse.error ?? "",);
    }
  }

  //updateRewards
  Stream<TaskState> updateRewards(
      {

        required int image,
        required String discription,
        required String name,
        required String notes,
        required String type,
        required int typeId,
        required int id,
        required bool isActive,

      }) async* {
    yield UpdateRewardLoading();

    final dataResponse = await _taskRepo.updateRewards(
      image:image,
      typeId: typeId,
      type: type,
      discription: discription,
      name: name,
      notes: notes,
      id: id,
      isActive: isActive
    );

    if (dataResponse!=null) {
      print("sucsess ");
      yield UpdateRewardSuccess(dataResponse.error??"");
    } else {
      print("failed ");
      yield UpdateRewardFailed(
        dataResponse.error ?? "",);
    }
  }

  //pointListing
  Stream<TaskState> getPointsList() async* {
    yield GetPointListLoading();

    final dataResponse = await _taskRepo.getPointsList();

    if (dataResponse.data.isNotEmpty) {
      print("sub tast is a success");
      yield GetPointListSuccess(dataResponse.data);
    } else {
      yield GetPointListFailed();
    }
  }
}
