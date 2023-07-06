
import 'package:cluster/presentation/task_operation/create/task_datasource.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/data_response.dart';

class TaskRepo {
  final TaskDataSource _dataSource = TaskDataSource();

  Future<DataResponse> getTaskTypeList() async {
    final apiResponse = await _dataSource.getTaskTypeList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  Future<DataResponse> getTaskList() async {
    final apiResponse = await _dataSource.getTaskList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }
  //pendinglist
  Future<DataResponse> getPendingTaskList() async {
    final apiResponse = await _dataSource.getPendingTaskList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //pinndedlist
  Future<DataResponse> getPinnedTaskList() async {
    final apiResponse = await _dataSource.getPinnedTaskList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //taskRead
  Future<DataResponse> getTaskReadData(int? id) async {
    try {
      final apiResponse = await _dataSource.getTaskReadData(id!);

      if (apiResponse.id != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }

  //readRewards
  Future<DataResponse> getReadRewards(int? id) async {
    try {
      final apiResponse = await _dataSource.getReadRewards(id!);

      if (apiResponse.id != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }


  //readPerformance
  Future<DataResponse> getPerformanceRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getPerformanceRead(id!);

      if (apiResponse != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }

  //toalaPerfomance
  Future<DataResponse> getTotalPerformance() async {
    try {
      final apiResponse = await _dataSource.getTotalPerformance();

      if (apiResponse != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }

  //assignCount
  Future<DataResponse> getAssignCount(int? id) async {
    try {
      final apiResponse = await _dataSource.getAssignCount(id);

      if (apiResponse.assignTask != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }
//createTask
  Future<DataResponse> taskCreatePost({
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
  }) async {
    final restAPIresponse = await _dataSource.taskCreatePost(
      locationUrl: locationUrl,
        reportingPerson: reportingPerson,
        createdBy:createdBy,
        discription: discription,
        isActive: isActive,
        startDate:startDate,
        endDate:endDate,
        priority:priority,
        AssigningCode: AssigningCode,
      AssigningType: AssigningType,
      createdOn: createdOn,
      jobId: jobId,
      lastmodified: lastmodified,
      notas: notas,
      parant: parant,
      priorityLeval: priorityLeval,
      remarks: remarks,
      taskName: taskName,
      taskType: taskType,
      statusStagesId: statusStagesId

    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //taskupdate
  Future<DataResponse> taskUpdatePost({
    required int? parant,
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
    required int? jobid,
    required int? id,
    required String? locationUrl,
  }) async {
    final restAPIresponse = await _dataSource.taskUpdatePost(
      locationUrl: locationUrl,
        reportingPerson: reportingPerson,
        createdBy:createdBy,
        discription: discription,
        isActive: isActive,
        startDate:startDate,
        endDate:endDate,
        priority:priority,
        AssigningCode: AssigningCode,
        AssigningType: AssigningType,
        createdOn: createdOn,
        jobid: jobid,
        lastmodified: lastmodified,
        notas: notas,
        parant: parant,
        priorityLeval: priorityLeval,
        remarks: remarks,
        taskName: taskName,
        taskType: taskType,
        statusStagesId: statusStagesId,
      id:id,

    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //subtasklist
  Future<DataResponse> getSubTaskList() async {
    final apiResponse = await _dataSource.getSubTaskList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //perfomancelist
  Future<DataResponse> getPerformanceList(int taskid,String? code) async {
    final apiResponse = await _dataSource.getPerformanceList(taskid,code);
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }
  //reviewList
  Future<DataResponse> getReviewList(int? taskId) async {
    final apiResponse = await _dataSource.getReviewList(taskId);
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text",data: null);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }


  //createPayment
  Future<DataResponse> paymentCreatePost({
    required int? jobId,
    required int? taskId,
    required String assigningType,
    required double budget,
    required String AssigningCode,
    required String notas,
    required String discription,
    required double expense,
  }) async {
    final restAPIresponse = await _dataSource.paymentCreatePost(

        AssigningCode: AssigningCode,
        assigningType: assigningType,
        jobId: jobId,
        notas: notas,
      expense: expense,
      budget: budget,
      discription: discription,
      taskId: taskId


    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //readPayment
  Future<DataResponse> getPaymentRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getPaymentRead(id!);

      if (apiResponse.id != null) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }

//updatePayment
  Future<DataResponse> paymentUpdatePost({
    required int? jobId,
    required int? taskId,
    required String assigningType,
    required double budget,
    required String AssigningCode,
    required String notas,
    required String discription,
    required double expense,
    required bool isActive,
    required int? payId,
  }) async {
    final restAPIresponse = await _dataSource.paymentUpdatePost(
        isActive: isActive,
        AssigningCode: AssigningCode,
        assigningType: assigningType,
        jobId: jobId,
        notas: notas,
        expense: expense,
        budget: budget,
        discription: discription,
        taskId: taskId,
      payId: payId


    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //createReview
  Future<DataResponse> createReviewTask({
    required int? parant,
    required int? taskId,
    required String reviewedBy,
    required int image,
    required String review,
    required String notes,
  }) async {
    final restAPIresponse = await _dataSource.createReviewTask(

        parant: parant,
        image: image,
        notas: notes,
        review: review,
        reviewdBy: reviewedBy,
        taskId: taskId


    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //createPerfomance
  Future<DataResponse> createPerformanceAppraisalTask({
    required String? userId,
    required int? taskId,
    required int pointId,
    required String name,
    required String discription,
  }) async {
    final restAPIresponse = await _dataSource.createPerformanceAppraisalTask(

        pointId: pointId,
        userId: userId,
        discription: discription,
        name: name,
        taskId: taskId


    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //createRewards
  Future<DataResponse> createReward({
    required String name,
    required int image,
    required String discription,
    required String notes,
    required String type,
    required int typeId,
  }) async {
    final restAPIresponse = await _dataSource.createReward(

      type: type,
        typeId: typeId,
        discription: discription,
        image: image,
        notas: notes,
        name: name,



    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //updaterew
  Future<DataResponse> updateRewards({
    required String name,
    required int image,
    required String discription,
    required String notes,
    required String type,
    required int typeId,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateRewards(
      type: type,
      typeId: typeId,
      discription: discription,
      image: image,
      notas: notes,
      name: name,
      isActive: isActive,
      id: id

    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //pointList
  Future<DataResponse> getPointsList() async {
    final apiResponse = await _dataSource.getPointsList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

}