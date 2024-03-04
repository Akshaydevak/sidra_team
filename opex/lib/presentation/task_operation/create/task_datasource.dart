import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/cluster_urls.dart';
import '../../../../core/utils/data_response.dart';
import 'model/task_models.dart';

class TaskDataSource {
  Dio client = Dio();

  // tasktype list
  Future<List<GetTaskTypeList>> getTaskTypeList() async {
    List<GetTaskTypeList> tasktypeList = [];
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
  }

  Future<PaginatedResponse<List<GetTaskList>>> getTaskList(
      String? search,
      String? next,
      String? prev,
      int? id,
      bool? filter,
      String? status,
      String? priority) async {
    print("URL Task Under Job List:${ClusterUrls.taskListUrl + id.toString()}");
    List<GetTaskList> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else if (filter == true) {
      api =
          "${ClusterUrls.taskListUrl + id.toString()}?assigned_to=&reporter=&priority=$priority&status=$status";
    } else {
      api = search!.isNotEmpty
          ? "${ClusterUrls.taskListUrl + id.toString()}?name=$search"
          : ClusterUrls.taskListUrl + id.toString();
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(GetTaskList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  ///jobs
  Future<PaginatedResponse<List<GetJobList>>> getAllJobsList(
      String? search,
      String? next,
      String? prev,
      bool? filter,
      String? status,
      String? priority,
      reportingPersonFilter) async {
    print("ALL Job List:${ClusterUrls.adminAllJobListUrl}");
    List<GetJobList> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else if (filter == true) {
      api =
          "${ClusterUrls.adminAllJobListUrl}?creator=&reporter=$reportingPersonFilter&priority=$priority&status=$status";
    } else {
      api = search!.isNotEmpty
          ? "${ClusterUrls.adminAllJobListUrl}?name=$search"
          : ClusterUrls.adminAllJobListUrl;
    }
    print("ALLL JOB API$api");

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(GetJobList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //
  Future<PaginatedResponse<List<PerfomerModel>>> getOrganisationPerformanceList(
      int? year, int? month) async {
    print(
        "URL Task Under Job List:${ClusterUrls.perfonamceTopperUrl}year=${year}&&month=$month");
    List<PerfomerModel> nationalityModel = [];
    String api = "";
    // if(next!=""){
    //   api=next??"";
    // }
    // else if(prev!=""){
    //   api=prev??"";
    // }
    // else{
    //   api = search!.isNotEmpty
    //       ? "${ClusterUrls.taskListUrl+id.toString()}?name=$search"
    //       : ClusterUrls.taskListUrl+id.toString();
    // }

    final response = await client.get(
        "${ClusterUrls.perfonamceTopperUrl}year=${year}&&month=$month",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data'] as List).forEach((element) {
      nationalityModel.add(PerfomerModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      "",
      "",
      previousUrl: "",
    );
  }

  //notification
  Future<PaginatedResponse<List<NotificationList>>> getNotificationList(
      String? search, String? next, String? prev) async {
    print("URL NotificationList List:${ClusterUrls.notificationListUrl}");
    List<NotificationList> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${ClusterUrls.notificationListUrl}?name=$search"
          : ClusterUrls.notificationListUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api noti " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(NotificationList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //pendinglist
  Future<List<GetTaskList>> getPendingTaskList() async {
    List<GetTaskList> taskList = [];
    print(
        "URL Task:${ClusterUrls.pendingtaskUrl + authentication.authenticatedUser.code.toString()}?status=PENDING");
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
    print("reasjkxjk${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //pinnedlist
  Future<List<GetTaskList>> getPinnedTaskList() async {
    List<GetTaskList> taskList = [];
    print(
        "URL Task:${ClusterUrls.pinnedListUrl + authentication.authenticatedUser.code.toString()}");

    final response = await client.get(
      ClusterUrls.pinnedListUrl +
          authentication.authenticatedUser.code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    (response.data['data'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //topic
  Future<List<GetTaskList>> getTopicList() async {
    List<GetTaskList> taskList = [];
    print("URL Task:${ClusterUrls.topicListUrl}");
    final response = await client.get(
      ClusterUrls.topicListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
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

  //CREATIONrEAD
  Future<GetReadCreateTask> getTaskCreationRead() async {
    GetReadCreateTask selectedItemDetails;

    print("Task Read:${ClusterUrls.createTaskUrl}");
    final response = await client.get(
      ClusterUrls.createTaskUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = GetReadCreateTask.fromJson((response.data['data']));

    return selectedItemDetails;
  }
  ////

  Future<GetReadCreateTask> getJobCreationRead() async {
    GetReadCreateTask selectedItemDetails;

    print("Task Read:${ClusterUrls.createJobUrl}");
    final response = await client.get(
      ClusterUrls.createJobUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = GetReadCreateTask.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //readRwards
  Future<ReadRewards> getReadRewards(int id, bool isTask) async {
    ReadRewards selectedItemDetails;
    String? path;
    if (isTask == true) {
      path = "${ClusterUrls.readRewadsUrl}?task=${id.toString()}";
    } else {
      path = "${ClusterUrls.readRewadsUrl}?job=${id.toString()}";
    }
    print("Rewards Read:$path");
    final response = await client.get(
      path,
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
    selectedItemDetails =
        ReadPerformanceAppraisal.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //totalPerfomane
  Future<ReadMarkRead> getTotalPerformance(
      String? employeeCode, int? id) async {
    ReadMarkRead? total;
    print(
        "Perfomance Total:${"${ClusterUrls.totalPerfomanceUrl}$id/$employeeCode"}");
    final response = await client.get(
      "${ClusterUrls.totalPerfomanceUrl}$id/$employeeCode",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    total = ReadMarkRead.fromJson(response.data['data']);
    print("total mark is hrer$total");
    return total;
  }

  //assigntask
  Future<GetCountTask> getAssignCount(int? id) async {
    GetCountTask countTask;
    print("Task Assign Read:${ClusterUrls.taskCountUrl + id.toString()}");
    try {
      final response = await client.post(
        ClusterUrls.taskCountUrl + id.toString(),
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
    } catch (G) {
      print("CatchERROR$G");
    }
    final response = await client.post(
      ClusterUrls.taskCountUrl + id.toString(),
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
    required int priorityLeval,
    required String startDate,
    required String endDate,
    required bool isActive,
    required String AssigningType,
    required String AssigningCode,
    required String notas,
    required String remarks,
    required String priority,
    required String durationOption,
    required String createdOn,
    required String? lastmodified,
    required String? longitude,
    required String startTime,
    required String endTime,
    required String? latitude,
  }) async {
    print("taskdetails parant$startTime");
    print("taskdetails parant$endTime");
    print("taskdetails parant$durationOption");
    print("taskdetails parant$parant");
    print("taskdetails jobId$jobId");
    print("taskdetails taskType$taskType");
    print("taskdetails statusStagesId$statusStagesId");
    print("taskdetails reportingPerson$reportingPerson");
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
    print("priority maari$priority");
    print("taskdetails$createdOn");
    print("taskdetails$lastmodified");
    try{
      final response = await client.post(
        ClusterUrls.createTaskUrl,
        data: {
          "parent": parant,
          "job_id": jobId,
          "task_type": taskType,
          "status_stages_id": statusStagesId,
          "reporting_person": reportingPerson,
          "duration_option": durationOption,
          "created_by": createdBy,
          "task_name": taskName,
          "description": discription,
          "priority_level": priorityLeval,
          "start_date": null,
          "end_date": null,
          "is_active": isActive,
          "assigning_type": AssigningType,
          "assigning_code": AssigningCode,
          "notes": notas,
          "remarks": remarks,
          "priority": priority,
          "created_on": createdOn,
          "last_modified": lastmodified,
          "longitude": longitude,
          "latitude": latitude,
          "start_time":startTime,
          "end_time":endTime
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
            data: response.data["status"] == "success",
            error: response.data['task_id'].toString());
      } else {
        return DataResponse(data: false, error: response.data['message']);
      }
    }catch(u,l){
      print("llll$u$l");
    }
    final response = await client.post(
      ClusterUrls.createTaskUrl,
      data: {
        "parent": parant,
        "job_id": jobId,
        "task_type": taskType,
        "status_stages_id": statusStagesId,
        "reporting_person": reportingPerson,
        "duration_option": durationOption,
        "created_by": createdBy,
        "task_name": taskName,
        "description": discription,
        "priority_level": priorityLeval,
        "start_date": startDate,
        "end_date": endDate,
        "is_active": isActive,
        "assigning_type": AssigningType,
        "assigning_code": AssigningCode,
        "notes": notas,
        "remarks": remarks,
        "priority": priority,
        "created_on": createdOn,
        "last_modified": lastmodified,
        "longitude": longitude,
        "latitude": latitude,
        "start_time":startTime,
        "end_time":endTime
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
          data: response.data["status"] == "success",
          error: response.data['task_id'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

//report task
  Future<DataResponse> createReport(
      {required int? taskId,
      required String? userId,
      required int? toipicId,
      required String? notes}) async {
    final response = await client.post(
      ClusterUrls.reportTaskUrl,
      data: {
        "task_id": taskId,
        "user_id": userId,
        "topic_id": toipicId,
        "notes": notes,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("create response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //updateTask
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
    required int priorityLeval,
    required String startDate,
    required String endDate,
    required String durationOption,
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
    required String startTime,
    required String endTime,
  }) async {
    print("taskdetails$startTime");
    print("taskdetails$endTime");
    print("taskdetails$parant");
    print("location$longitude");
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
    print("taskdetails$img4");
    print("taskdetails$img1");
    print("taskdetails$img5");
    print("latitude$longitude");
    print("latitude$latitude");
    print("latitude$attachdescription");
    print("latitude$attachNote");
    print("update Task:${ClusterUrls.updateTaskUrl + id.toString()}");

    final response = await client.patch(
      ClusterUrls.updateTaskUrl + id.toString(),
      data:
      {
        "parent": parant,
        "job_id": jobid,
        "task_type": taskType,
        "duration_option": durationOption,
        "reporting_person":reportingPerson,
        "created_by": createdBy,
        "task_name": taskName,
        "description": discription,
        "priority_level": priorityLeval,
        "start_date": startDate,
        "end_date": endDate,
        "is_active": true,
        "assigning_type": AssigningType,
        "assigning_code": AssigningCode,
        "notes": notas,
        "remarks": remarks,
        "priority": priority,
        "last_modified": null,
        "image1": img1,
        "image2": img2,
        "image3": img3,
        "image4": img4,
        "image5": img5,
        "attachment_note": attachNote,
        "attachment_description": attachdescription,
        "longitude":longitude,
        "latitude":latitude,
        "status_stages_id":statusStagesId,
        "start_time":startTime,
        "end_time":endTime
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("update response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
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
    print("statusCode${statusCode}");
    return statusCode;
  }

  //subtasklist
  Future<List<GetTaskList>> getSubTaskList(int? taskId) async {
    List<GetTaskList> taskList = [];
    print("sub URL:${ClusterUrls.subtaskListUrl + taskId.toString()}");

    final response = await client.get(
      ClusterUrls.subtaskListUrl + taskId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(" shifas 777777${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      taskList.add(GetTaskList.fromJson(element));
    });
    return taskList;
  }

  //perfomanceList
  Future<List<PerformanceList>> getPerformanceList(
      int taskid, String? code) async {
    List<PerformanceList> perfomanceList = [];

    print(
        "Perfomance URL:${ClusterUrls.perfomenceListUrl}${taskid.toString()}/${code}");

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
    final response = await client.get(
      "${ClusterUrls.perfomenceListUrl}${taskid.toString()}/$code",
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
    print("reviewlist URL:${ClusterUrls.reviewListUrl + taskid.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.reviewListUrl + taskid.toString(),
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
    final response = await client.get(
      ClusterUrls.reviewListUrl + taskid.toString(),
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
    required int img1,
    required int img2,
    required int img3,
    required int img4,
    required int img5,
  }) async {
    print("taskdetails$taskId");
    print("taskdetails$jobId");
    print("taskdetails$discription");
    print("taskdetails$notas");
    print("taskdetails$expense");
    print("taskdetails$assigningType");
    print("taskdetails$AssigningCode");
    print("taskdetails$budget");
    print("taskdetails$img5");
    print("taskdetails$img1");

    final response = await client.post(
      ClusterUrls.payymentCreateUrl,
      data: {
        "job_id": jobId,
        "task_id": taskId,
        "assigning_type": assigningType,
        "budget": budget,
        "assigning_code": AssigningCode,
        "description": discription,
        "notes": notas,
        "expense": expense,
        "image1": img1,
        "image2": img2,
        "image3": img3,
        "image4": img4,
        "image5": img5,
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
          data: response.data["status"] == "success",
          error: response.data['task_id'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //readPayment
  Future<PaymentModel> getPaymentRead(int id, bool isTask) async {
    PaymentModel payment;
    print("Payment Read:${ClusterUrls.paymentReadUrl + id.toString()}");
    String path = '';
    if (isTask == true) {
      path = "${ClusterUrls.paymentReadUrl}?task=${id.toString()}";
    } else {
      path = "${ClusterUrls.paymentReadUrl}?job=${id.toString()}";
    }

    print("Payment Read:${path}");
    final response = await client.get(
      path,
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
    required dynamic img1,
    required dynamic img2,
    required dynamic img3,
    required dynamic img4,
    required dynamic img5,
  }) async {
    print("taskId$taskId");
    print("jobId$jobId");
    print("discription$discription");
    print("notas$notas");
    print("expense$expense");
    print("assigningType$assigningType");
    print("AssigningCode$AssigningCode");
    print("budget$budget");
    print("taskdetails$img1");
    print("taskdetails$img2");

    final response = await client.patch(
      ClusterUrls.paymentUpdateUrl + payId.toString(),
      data: {
        "job_id": jobId,
        "task_id": taskId,
        "assigning_type": assigningType,
        "budget": budget,
        "assigning_code": AssigningCode,
        "description": discription,
        "notes": notas,
        "expense": expense,
        "is_active": isActive,
        "image1": img1,
        "image2": img2,
        "image3": img3,
        "image4": img4,
        "image5": img5,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("update response$response");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
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
    print("taskdetails$parant");
    print("taskdetails$taskId");
    print("taskdetails 1111111$reviewdBy");
    print("taskdetails$review");
    print("taskdetails$image");
    print("taskdetails$notas");
    final response = await client.post(
      ClusterUrls.reviewCreateUrl,
      data: {
        "parent": parant,
        "task_id": taskId,
        "reviewed_by": reviewdBy,
        "image1": image,
        "review": review,
        "notes": notas,
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
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //updateRewiew
  Future<DataResponse> updateReviewTask({
    required int? parant,
    required int? id,
    required bool? isActive,
    required String reviewdBy,
    required dynamic image,
    required String review,
    required String notas,
    required int taskId,
  }) async {
    print("taskdetails$parant");
    print("taskdetails${ClusterUrls.reviewUpdateUrl + id.toString()}");
    print("taskdetails 1111111$reviewdBy");
    print("taskdetails$review");
    print("taskdetails$image");
    print("taskdetails$id");
    print("taskdetails$taskId");
    print("taskdetails$notas");
    final response = await client.post(
      ClusterUrls.reviewUpdateUrl + id.toString(),
      data: {
        "parent": parant,
        "is_active": isActive,
        "reviewed_by": reviewdBy,
        "image1": image,
        "review": review,
        "notes": notas,
        "task_id": taskId
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
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
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
    print("taskdetails$userId");
    print("taskdetails$taskId");
    print("taskdetails 1111111$pointId");
    print("taskdetails$name");
    print("taskdetails$discription");

    final response = await client.post(
      ClusterUrls.createPerformanceUrl,
      data: {
        "name": name,
        "description": discription,
        "user_id": userId,
        "points_id": pointId,
        "task_id": taskId,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("create perfomance$response");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);
      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
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
    required String notas,
    required int typeId,
    required String type,
  }) async {
    print("taskdetails 1111111$name");
    print("taskdetails$discription");
    print("taskdetails$img3");
    print("taskdetails$notas");
    print("taskdetails$type");
    print("taskdetails$typeId");
    final response = await client.post(
      ClusterUrls.createRewadsUrl,
      data: {
        "name": name,
        "description": discription,
        "notes": notas,
        "image1": img1,
        "image2": img2,
        "image3": img3,
        "image4": img4,
        "image5": img5,
        "types": type,
        "type_id": typeId
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
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //updateReward
  Future<DataResponse> updateRewards({
    required String name,
    required dynamic img1,
    required dynamic img2,
    required dynamic img3,
    required dynamic img4,
    required dynamic img5,
    required String discription,
    required String notas,
    required int typeId,
    required String type,
    required int id,
    required bool isActive,
  }) async {
    print("taskdetails 1111111$name");
    print("taskdetails$discription");
    print("taskdetails$img4");
    print("taskdetails$notas");
    print("taskdetails$type");
    print("taskdetails$typeId");

    print("URL rewards update${ClusterUrls.updateRewardsUrl + id.toString()}");
    final response = await client.patch(
      ClusterUrls.updateRewardsUrl + id.toString(),
      data: {
        "name": name,
        "description": discription,
        "notes": notas,
        "image1": img1,
        "image2": img2,
        "image3": img3,
        "image4": img4,
        "image5": img5,
        "types": type,
        "type_id": typeId,
        "is_active": isActive
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
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
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
  }

  //
  Future<PaginatedResponse<List<GetTaskList>>> TaskAssignedGroupListState(
      String code, String? next) async {
    print("VVVVV$next");
    print("VVVVV$code");
    String path = "";
    if (next == "") {
      path = ClusterUrls.listGroupUnderListUrl;
    } else if (next != "") {
      path = next ?? "";
    }
    List<GetTaskList> offerPeriodList = [];
    print("pagiiiiii$path");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token,
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      offerPeriodList.add(GetTaskList.fromJson(element));
    });

    return PaginatedResponse<List<GetTaskList>>(
        offerPeriodList,
        response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  //
  Future<CriteriaRead> getCriteriaRead(String taskCode) async {
    CriteriaRead selectedItemDetails;

    print("Criteria Read:${ClusterUrls.criteraReadUrl + taskCode.toString()}");
    try {
      final response = await client.get(
        ClusterUrls.criteraReadUrl + taskCode.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );

      selectedItemDetails = CriteriaRead.fromJson((response.data['data']));
      print(selectedItemDetails.attittude);
      return selectedItemDetails;
    } catch (g) {
      print("the model data$g");
    }
    final response = await client.get(
      ClusterUrls.criteraReadUrl + taskCode.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    selectedItemDetails = CriteriaRead.fromJson((response.data['data']));
    print(selectedItemDetails.attittude);
    return selectedItemDetails;
  }

  //noti
  Future<String> getNotificationDue(int id) async {
    String status = "";

    print("Criteria Read:${ClusterUrls.dueNotificationUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.dueNotificationUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    // selectedItemDetails = CriteriaRead.fromJson((response.data['status']));

    status = response.data['status'];
    return status;
  }

  //noti icon
  Future<String> NotificationIcon() async {
    String status = "";

    print("Noti Icon Read:${ClusterUrls.notificationIconUrl}");
    final response = await client.get(
      ClusterUrls.notificationIconUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    // selectedItemDetails = CriteriaRead.fromJson((response.data['status']));

    status = response.data['status'];
    return status;
  }

  //report admin list
  Future<PaginatedResponse<List<ReportModel>>> ReportListAdminList(
      String? next, String? prev) async {
    List<ReportModel> nationalityModel = [];
    String api = "";
    // if (next != "") {
    //   api = next ?? "";
    // } else if (prev != "") {
    //   api = prev ?? "";
    // }
    //
    // else {
    //   api = search!.isNotEmpty
    //       ? Variable.isOrderId==true?
    //   "${SellerUrls.newOrdersSellerUrl}?order_id=$search":
    //   "${SellerUrls.newOrdersSellerUrl}?order_line_id=$search"
    //       : SellerUrls.newOrdersSellerUrl;
    // }
    print(
        "api admin ${ClusterUrls.reportedListAdminUrls + authentication.authenticatedUser.code.toString()}");
    final response = await client.get(
        ClusterUrls.reportedListAdminUrls +
            authentication.authenticatedUser.code.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));

    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(ReportModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //report user list
  Future<PaginatedResponse<List<ReportModel>>> ReportListUserList(
      String? next, String? prev) async {
    List<ReportModel> nationalityModel = [];
    String api = "";
    // if (next != "") {
    //   api = next ?? "";
    // } else if (prev != "") {
    //   api = prev ?? "";
    // }
    //
    // else {
    //   api = search!.isNotEmpty
    //       ? Variable.isOrderId==true?
    //   "${SellerUrls.newOrdersSellerUrl}?order_id=$search":
    //   "${SellerUrls.newOrdersSellerUrl}?order_line_id=$search"
    //       : SellerUrls.newOrdersSellerUrl;
    // }
    print(
        "api ${ClusterUrls.reportedListUserUrls + authentication.authenticatedUser.code.toString()}");
    final response = await client.get(
        ClusterUrls.reportedListUserUrls +
            authentication.authenticatedUser.code.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(ReportModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

//replay report
  Future<DataResponse> replayReport({
    required int? id,
    required String? reportStatus,
    required String? replay,
    required String? replayType,
    required String? reAssignCode,
  }) async {
    print("replay Url${ClusterUrls.replayReportUrl + id.toString()}");
    final response = await client.post(
      ClusterUrls.replayReportUrl + id.toString(),
      data: {"report_status": reportStatus, "reply": replay,
      "report_reply_type":replayType,
      "updated_user":reAssignCode},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("replay response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"] == "success",
          error: response.data['message'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  Future<List<SearchMapResultsModel>> searchMapLocation(
      String? searchQuery) async {
    List<SearchMapResultsModel> varientDetails = [];
    print(
        "state is api${"https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchQuery&key=AIzaSyDJavpenypIG-Kd1sTSUeEk6jyJ4NpsAFA"}");
    final response = await client.get(
        "${"https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchQuery&key=AIzaSyDJavpenypIG-Kd1sTSUeEk6jyJ4NpsAFA"}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("respoooooooooooooonsss ${response.data}");
    if (response.data['results'].isNotEmpty) {
      (response.data['results'] as List).forEach((element) {
        varientDetails.add(SearchMapResultsModel.fromJson(element));
      });
      print("respoooooooooooooonsss $varientDetails");
      return varientDetails;
    } else {
      return [];
    }
    // (response.data['data']['results'] as List).forEach((element) {
    //   varientDetails.add(ProductItem.fromJson(element));
    // });
    // return varientDetails;
  }
}
