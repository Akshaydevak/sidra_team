import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/cluster_urls.dart';
import '../../../../core/utils/data_response.dart';
import 'model/task_models.dart';

class TaskDataSource {
  Dio client = Dio();

  // tasktype list
  Future<List<GetTaskTypeList>> getTaskTypeList() async {
    List<GetTaskTypeList> tasktypeList = [];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("URL:${ClusterUrls.taskLisTypetUrl}");

    try {
      final response = await client.get(
        ClusterUrls.taskLisTypetUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        tasktypeList.add(GetTaskTypeList.fromJson(element));
      });

      return tasktypeList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.taskLisTypetUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(GetTaskTypeList.fromJson(element));
    });
    return tasktypeList;
  }

  //task list
  Future<List<GetTaskList>> getTaskList() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<GetTaskList> taskList = [];
    print("URL Task:${ClusterUrls.taskListUrl+Variable.jobReadId.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.taskListUrl+Variable.jobReadId.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        taskList.add(GetTaskList.fromJson(element));
      });

      return taskList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.taskListUrl+Variable.jobReadId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //pendinglist
  Future<List<GetTaskList>> getPendingTaskList() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<GetTaskList> taskList = [];
    print("URL Task:${ClusterUrls.pendingtaskUrl+authentication.authenticatedUser.code.toString()}?status=PENDING");

    try {
      final response = await client.get(
        "${ClusterUrls.pendingtaskUrl}${authentication.authenticatedUser.code.toString()}?status=PENDING",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        taskList.add(GetTaskList.fromJson(element));
      });

      return taskList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get("${ClusterUrls.pendingtaskUrl}${authentication.authenticatedUser.code.toString()}?status=PENDING",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //pinnedlist
  Future<List<GetTaskList>> getPinnedTaskList() async {
    List<GetTaskList> taskList = [];
    print("URL Task:${ClusterUrls.pinnedListUrl+authentication.authenticatedUser.code.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.pinnedListUrl+authentication.authenticatedUser.code.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        taskList.add(GetTaskList.fromJson(element));
      });

      return taskList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.pinnedListUrl+authentication.authenticatedUser.code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //taskread
  Future<GetTaskList> getTaskReadData(int id) async {
    GetTaskList selectedItemDetails;

    print("Task Read:${ClusterUrls.taskread + id.toString()}");
    final response = await client.get(
      ClusterUrls.taskread + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = GetTaskList.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //readRwards
  Future<ReadRewards> getReadRewards(int id) async {
    ReadRewards selectedItemDetails;
    print("Task Read:${ClusterUrls.readRewadsUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readRewadsUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = ReadRewards.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //readPerformance
  Future<ReadPerformanceAppraisal> getPerformanceRead(int id) async {
    ReadPerformanceAppraisal selectedItemDetails;
    print("Task Read:${ClusterUrls.readPerformanceUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.readPerformanceUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = ReadPerformanceAppraisal.fromJson((response.data['data']));

    return selectedItemDetails;
  }
  //totalPerfomane
  Future<int> getTotalPerformance() async {
    int Total;
    print("Task Total:${ClusterUrls.totalPerfomanceUrl+authentication.authenticatedUser.code.toString().toString()}");
    final response = await client.get(
      ClusterUrls.totalPerfomanceUrl+authentication.authenticatedUser.code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    Total = response.data['data'];

    return Total;
  }

  //assigntask
  Future<GetCountTask> getAssignCount(int? id) async {
    GetCountTask countTask;
    print("Task Assign Read:${ClusterUrls.taskCountUrl + id.toString()}");
    try{
      final response = await client.post(ClusterUrls.taskCountUrl + id.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      print("read response${response.data}");
      countTask = GetCountTask.fromJson((response.data['data']));

      return countTask;
    }
    catch(G){
      print("CatchERROR$G");
    }
    final response = await client.post(ClusterUrls.taskCountUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("read response${response.data}");
    countTask = GetCountTask.fromJson((response.data['data']));

    return countTask;
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
    print("taskdetails$parant");
    print("taskdetails$jobId");
    print("taskdetails$taskType");
    print("taskdetails$statusStagesId");
    print("taskdetails$reportingPerson");
    print("taskdetails$createdBy");
    print("taskdetails$taskName");
    print("taskdetails$discription");
    print("taskdetails$priorityLeval");
    print("taskdetails$startDate");
    print("taskdetails$endDate");
    print("taskdetails$isActive");
    print("taskdetails$AssigningType");
    print("taskdetails$AssigningCode");
    print("taskdetails$notas");
    print("taskdetails$remarks");
    print("taskdetails$priority");
    print("taskdetails$createdOn");
    print("taskdetails$lastmodified");
    final response = await client.post(
      ClusterUrls.createTaskUrl,
      data: {
        "parent":parant,
        "job_id":jobId,
        "task_type":taskType,
        "status_stages_id":statusStagesId,
        "reporting_person":reportingPerson,
        "created_by":createdBy,
        "task_name":taskName,
        "description":discription,
        "priority_level":priorityLeval,
        "start_date":startDate,
        "end_date":endDate,
        "is_active":isActive,
        "assigning_type":AssigningType,
        "assigning_code":AssigningCode,
        "notes":notas,
        "remarks":remarks,
        "priority":priority,
        "created_on":createdOn,
        "last_modified":lastmodified,
        "location_url":locationUrl
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['task_id'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //updateTask
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
    print("taskdetails$parant");
    print("location$locationUrl");
    print("taskdetails$jobid");
    print("taskdetails$taskType");
    print("taskdetails$statusStagesId");
    print("taskdetails$reportingPerson");
    print("taskdetails$createdBy");
    print("taskdetails$taskName");
    print("taskdetails$discription");
    print("taskdetails$priorityLeval");
    print("taskdetails$startDate");
    print("taskdetails$endDate");
    print("taskdetails$isActive");
    print("taskdetails$AssigningType");
    print("taskdetails$AssigningCode");
    print("taskdetails$notas");
    print("taskdetails$remarks");
    print("taskdetails$priority");
    print("taskdetails$createdOn");
    print("taskdetails$lastmodified");
    print("update Task:${ClusterUrls.updateTaskUrl+id.toString()}");
    try{
      final response = await client.patch(
        ClusterUrls.updateTaskUrl+id.toString(),
        data: {
          "parent":parant,
          "job_id":jobid,
          "task_type":taskType,
          "status_stages_id":statusStagesId,
          "reporting_person":reportingPerson,
          "created_by":createdBy,
          "task_name":taskName,
          "description":discription,
          "priority_level":priorityLeval,
          "start_date":startDate,
          "end_date":endDate,
          "is_active":isActive,
          "assigning_type":AssigningType,
          "assigning_code":AssigningCode,
          "notes":notas,
          "remarks":remarks,
          "priority":priority,
          "created_on":createdOn,
          "last_modified":lastmodified,
          "location_url":locationUrl
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );

      print("create response${response}");
      if (response.data['status'] == 'success') {
        // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

        return DataResponse(
            data: response.data["status"]=="success", error: response.data['task_id'].toString());
      } else {
        return DataResponse(data: null, error: response.data['message']);
      }
    }
    catch(e){
      print("EWA$e");
    }
    final response = await client.post(
      ClusterUrls.updateTaskUrl+id.toString(),
      data: {
        "parent":parant,
        "job_id":jobid,
        "task_type":taskType,
        "status_stages_id":statusStagesId,
        "reporting_person":reportingPerson,
        "created_by":createdBy,
        "task_name":taskName,
        "description":discription,
        "priority_level":priorityLeval,
        "start_date":startDate,
        "end_date":endDate,
        "is_active":isActive,
        "assigning_type":AssigningType,
        "assigning_code":AssigningCode,
        "notes":notas,
        "remarks":remarks,
        "priority":priority,
        "created_on":createdOn,
        "last_modified":lastmodified,
        "location_url":locationUrl
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['task_id'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //delteTASK
  Future<String> deleteTask(int taskId) async {
    String statusCode;
    print("dele${ClusterUrls.updateTaskUrl + taskId.toString()}");
    final response = await client.delete(
      ClusterUrls.updateTaskUrl + taskId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    statusCode = (response.data['status']);
    print("statusCode");
    return statusCode;
  }
  //deleteReview
  Future<String> deleteReview(int reviewId) async {
    String statusCode;
    print("dele${ClusterUrls.reviewUpdateUrl + reviewId.toString()}");
    final response = await client.delete(
      ClusterUrls.reviewUpdateUrl + reviewId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    statusCode = (response.data['status']);
    print("statusCode");
    return statusCode;
  }

  //subtasklist
  Future<List<GetTaskList>> getSubTaskList() async {
    List<GetTaskList> taskList = [];
    print("sub URL:${ClusterUrls.subtaskListUrl+Variable.taskIdForSubtask.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.subtaskListUrl+Variable.taskIdForSubtask.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        taskList.add(GetTaskList.fromJson(element));
      });

      return taskList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.subtaskListUrl+Variable.taskIdForSubtask.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //perfomanceList
  Future<List<PerformanceList>> getPerformanceList(int taskid,String? code) async {
    List<PerformanceList> perfomanceList = [];

    print("Perfomance URL:${ClusterUrls.perfomenceListUrl}${taskid.toString()}/${code}");

    try {
      final response = await client.get(
        "${ClusterUrls.perfomenceListUrl}${taskid.toString()}/${code}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data'] as List).forEach((element) {
        perfomanceList.add(PerformanceList.fromJson(element));
      });

      return perfomanceList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get("${ClusterUrls.perfomenceListUrl}${taskid.toString()}/$code",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data'] as List).forEach((element) {
      perfomanceList.add(PerformanceList.fromJson(element));
    });
    return perfomanceList;
  }

  //reviewlist
  Future<List<ReviewModel>> getReviewList(int? taskid) async {
    List<ReviewModel> reviewList = [];
    print("reviewlist URL:${ClusterUrls.reviewListUrl+taskid.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.reviewListUrl+taskid.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      print("reas$response");
      (response.data['data']['results'] as List).forEach((element) {
        reviewList.add(ReviewModel.fromJson(element));
      });

      return reviewList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.reviewListUrl+taskid.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      reviewList.add(ReviewModel.fromJson(element));
    });
    return reviewList;
  }

  //craetePayment
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
    GetTaskList taskDetails;
    print("taskdetails$taskId");
    print("taskdetails$jobId");
    print("taskdetails$discription");
    print("taskdetails$notas");
    print("taskdetails$expense");
    print("taskdetails$assigningType");
    print("taskdetails$AssigningCode");
    print("taskdetails$budget");

    final response = await client.post(
      ClusterUrls.payymentCreateUrl,
      data: {
        "job_id":jobId,
        "task_id":taskId,
        "assigning_type":assigningType,
        "budget":budget,
        "assigning_code":AssigningCode,
        "description":discription,
        "notes":notas,
        "expense":expense,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['task_id'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //readPayment
  Future<PaymentModel> getPaymentRead(int id) async {
    PaymentModel payment;
    print("Payment Read:${ClusterUrls.paymentReadUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.paymentReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    payment = PaymentModel.fromJson((response.data['data']));

    return payment;
  }

  //updatePayment
  Future<DataResponse> paymentUpdatePost({
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
  }) async {
    GetTaskList taskDetails;
    print("taskdetails$taskId");
    print("taskdetails$jobId");
    print("taskdetails$discription");
    print("taskdetails$notas");
    print("taskdetails$expense");
    print("taskdetails$assigningType");
    print("taskdetails$AssigningCode");
    print("taskdetails$budget");


    final response = await client.patch(
      ClusterUrls.paymentUpdateUrl+payId.toString(),
      data: {
        "job_id":jobId,
        "task_id":taskId,
        "assigning_type":assigningType,
        "budget":budget,
        "assigning_code":AssigningCode,
        "description":discription,
        "notes":notas,
        "expense":expense,
        "is_active":isActive

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("update response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }
  //createreview
  Future<DataResponse> createReviewTask({
    required int? parant,
    required int? taskId,
    required String reviewdBy,
    required int image,
    required String review,
    required String notas,
  }) async {
    GetTaskList taskDetails;
    print("taskdetails$parant");
    print("taskdetails$taskId");
    print("taskdetails 1111111$reviewdBy");
    print("taskdetails$review");
    print("taskdetails$image");
    print("taskdetails$notas");
    final response = await client.post(
      ClusterUrls.reviewCreateUrl,
      data:
      {
        "parent":parant,
        "task_id":taskId,
        "reviewed_by":reviewdBy,
        "image":image,
        "review":review,
        "notes":notas,


      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }
  //createPerformance
  Future<DataResponse> createPerformanceAppraisalTask({
    required String? userId,
    required int? taskId,
    required int pointId,
    required String name,
    required String discription,
  }) async {
    GetTaskList taskDetails;
    print("taskdetails$userId");
    print("taskdetails$taskId");
    print("taskdetails 1111111$pointId");
    print("taskdetails$name");
    print("taskdetails$discription");

    final response = await client.post(
      ClusterUrls.createPerformanceUrl,
      data:
      {
        "name":name,
        "description":discription,
        "user_id":userId,
        "points_id":pointId,
        "task_id":taskId,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }
  //createRewards
  Future<DataResponse> createReward({
    required String name,
    required int image,
    required String discription,
    required String notas,
    required int typeId,
    required String type,
  }) async {
    GetTaskList taskDetails;

    print("taskdetails 1111111$name");
    print("taskdetails$discription");
    print("taskdetails$image");
    print("taskdetails$notas");
    print("taskdetails$type");
    print("taskdetails$typeId");

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await client.post(
      ClusterUrls.createRewadsUrl,
      data:
      {
        "name":name,
        "description":discription,
        "notes":notas,
        "image":image,
        "types":type,
        "type_id":typeId
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response$response");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //updateReward
  Future<DataResponse> updateRewards({
    required String name,
    required int image,
    required String discription,
    required String notas,
    required int typeId,
    required String type,
    required int id,
    required bool isActive,
  }) async {
    GetTaskList taskDetails;

    print("taskdetails 1111111$name");
    print("taskdetails$discription");
    print("taskdetails$image");
    print("taskdetails$notas");
    print("taskdetails$type");
    print("taskdetails$typeId");

    print("URL rewards update${ ClusterUrls.updateRewardsUrl+id.toString()}");
    final response = await client.patch(
      ClusterUrls.updateRewardsUrl+id.toString(),
      data:
      {
        "name":name,
        "description":discription,
        "notes":notas,
        "image":image,
        "types":type,
        "type_id":typeId,
        "is_active":isActive
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response$response");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //pointList
  Future<List<PointsList>> getPointsList() async {
    List<PointsList> pointList = [];
    print("Point URL:${ClusterUrls.pointListUrl}");

    try {
      final response = await client.get(
        ClusterUrls.pointListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        pointList.add(PointsList.fromJson(element));
      });

      return pointList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.pointListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      pointList.add(PointsList.fromJson(element));
    });
    return pointList;
  }
}