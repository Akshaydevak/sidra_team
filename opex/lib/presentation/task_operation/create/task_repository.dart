
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_datasource.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/data_response.dart';
import '../../../core/utils/failure.dart';
import '../../../core/utils/repo.dart';
import 'package:dartz/dartz.dart';

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

  // Future<DataResponse> getTaskList(int? id) async {
  //   final apiResponse = await _dataSource.getTaskList(id);
  //   try {
  //     if (apiResponse.isNotEmpty) {
  //       return DataResponse(data: apiResponse);
  //     } else {
  //       return DataResponse(error: "error Text");
  //     }
  //   } catch (e) {
  //     debugPrint("error Text$e");
  //   }
  //   return DataResponse(error: "error Text");
  // }

  Future<PaginatedResponse> getTaskList(String? search,String? next,String? prev,int? id,bool? filter,String? status,String? priority) async {
    final apiResponse = await _dataSource.getTaskList(search,next,prev,id,filter,status,priority);
    try {
      if (apiResponse.data!= null ) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //jobs
  Future<PaginatedResponse> getAllJobsList(String? search,String? next,String? prev,bool? filter,String? status,String? priority,String? reportingPersonFilter) async {
    final apiResponse = await _dataSource.getAllJobsList(search,next,prev,filter,status,priority,reportingPersonFilter);
    try {
      if (apiResponse.data!= null ) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //orgPerf
  Future<PaginatedResponse> getOrganisationPerformanceList(int? year,int? month) async {
    final apiResponse = await _dataSource.getOrganisationPerformanceList(year,month);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //notificatu

  Future<PaginatedResponse> getNotificationList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getNotificationList(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  //pendinglist
  Future<DataResponse> getPendingTaskList() async {
    final apiResponse = await _dataSource.getPendingTaskList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(data: []);
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
        return DataResponse(data: []);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }


  //topic
  Future<DataResponse> getTopicList() async {
    final apiResponse = await _dataSource.getTopicList();
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
  Future<DataResponse> getReadRewards(int? id,bool isTask) async {
    try {
      final apiResponse = await _dataSource.getReadRewards(id!,isTask);

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
  Future<DataResponse> getTotalPerformance(String? employeeCode,int? id) async {
    try {
      final apiResponse = await _dataSource.getTotalPerformance(employeeCode,id);

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
    required String? longitude,
    required String? latitude,
  }) async {
    final restAPIresponse = await _dataSource.taskCreatePost(
    longitude: longitude,
        latitude: latitude,
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
  //report task
  Future<DataResponse> createReport({
    required int? taskId,
    required String? userId,
    required int? toipicId,
    required String? notes
  }) async {
    final restAPIresponse = await _dataSource.createReport(

      notes: notes,
      taskId: taskId,
      toipicId: toipicId,
      userId: userId

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
    required dynamic img1,
    required dynamic img2,
    required dynamic img3,
    required dynamic img4,
    required dynamic img5,
    required String? attachdescription,
    required String? attachNote,
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
    required String? longitude,
    required String? latitude,
  }) async {
    final restAPIresponse = await _dataSource.taskUpdatePost(
     latitude: latitude,
        longitude: longitude,
        img4: img4,
        img3: img3,
        img2: img2,
        img1: img1,
        img5: img5,
        attachdescription: attachdescription,
        attachNote: attachNote,
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
  Future<DataResponse> getSubTaskList(int? taskId) async {
    final apiResponse = await _dataSource.getSubTaskList(taskId);
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
        return DataResponse(error: "error Text",data: []);
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
    required int img1,
    required int img2,
    required int img3,
    required int img4,
    required int img5,
  }) async {
    final restAPIresponse = await _dataSource.paymentCreatePost(

        AssigningCode: AssigningCode,
        assigningType: assigningType,
        jobId: jobId,
        notas: notas,
      expense: expense,
      budget: budget,
      discription: discription,
      taskId: taskId,
      img1: img1,
      img2: img2,
      img3: img3,
      img4: img4,
      img5: img5


    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //readPayment
  Future<DataResponse> getPaymentRead(int? id,bool isTask) async {
    try {
      final apiResponse = await _dataSource.getPaymentRead(id!,isTask);

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
    required dynamic img1,
    required dynamic img2,
    required dynamic img3,
    required dynamic img4,
    required dynamic img5,
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
      payId: payId,
      img2: img2,
      img3: img3,
      img4: img4,
      img5: img5,
      img1: img1


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
  //update review
  Future<DataResponse> updateReviewTask({
    required int? parant,
    required int? id,
    required bool? isActive,
    required int taskId,
    required String reviewdBy,
    required dynamic image,
    required String review,
    required String notas,
  }) async {
    final restAPIresponse = await _dataSource.updateReviewTask(

        parant: parant,
        taskId: taskId,
        image: image,
        notas: notas,
        review: review,
        reviewdBy: reviewdBy,
        isActive: isActive,
      id: id


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
    required int img1,
    required int img2,
    required int img3,
    required int img4,
    required int img5,
    required String discription,
    required String notes,
    required String type,
    required int typeId,
  }) async {
    final restAPIresponse = await _dataSource.createReward(

      type: type,
        typeId: typeId,
        discription: discription,
        img5: img5,
        img4: img4,
        img3: img3,
        img2: img2,
        img1: img1,
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
    required dynamic img1,
    required dynamic img2,
    required dynamic img3,
    required dynamic img4,
    required dynamic img5,
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
     img1: img1,
      img2: img2,
        img5: img5,
      img3: img3,
      img4: img4,
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

  //
  Future<Either<Failure, PaginatedResponse<List<GetTaskList>>>> TaskAssignedGroupListState(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<GetTaskList>>>(
            () async => _dataSource.TaskAssignedGroupListState(code, next));
  }
  //
  Future<DataResponse> getCriteriaRead(String? taskCode) async {
    try {
      final apiResponse = await _dataSource.getCriteriaRead(taskCode!);

      if (apiResponse!=null) {
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

  //report admin list
  Future<PaginatedResponse> ReportListAdminList(String? next,String? prev) async {
    final apiResponse = await _dataSource.ReportListAdminList(next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //report user list
  Future<PaginatedResponse> ReportListUserList(String? next,String? prev) async {
    final apiResponse = await _dataSource.ReportListUserList(next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //replayreport
  Future<DataResponse> replayReport({
    required int? id,
    required String? reportStatus,
    required String? replay,
  }) async {
    final restAPIresponse = await _dataSource.replayReport(

      id: id,
      replay: replay,
      reportStatus: reportStatus

    );
    if (restAPIresponse.data) {
      return DataResponse(data:restAPIresponse.data, error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }



}