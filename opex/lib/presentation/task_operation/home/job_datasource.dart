import 'package:cluster/core/cluster_urls.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/data_response.dart';
import '../../authentication/authentication.dart';
import '../create/model/task_models.dart';
import '../employee_model/employee_model.dart';
import 'model/joblist_model.dart';

class JobDataSource {
  Dio client = Dio();

  // job list
  Future<List<GetTaskList>> getJobList() async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<GetTaskList> jobList = [];
    print("URL:${ClusterUrls.assignMeListUrl}${authentication.authenticatedUser.code}");

    final response = await client.get(ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("asssign${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      jobList.add(GetTaskList.fromJson(element));
    });
    return jobList;
  }
  //instat
  Future<List<GetJobList>> getInstantJobList() async {
    List<GetJobList> jobList = [];
    print("URL:${ClusterUrls.instantJobListUrl}${authentication.authenticatedUser.code}");

    final response = await client.get(ClusterUrls.instantJobListUrl+authentication.authenticatedUser.code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("instant${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      jobList.add(GetJobList.fromJson(element));
    });
    return jobList;
  }
  //filter
  Future<List<GetJobList>> getFilterJobList(String? status) async {
    List<GetJobList> jobList = [];
    print("URL:${ClusterUrls.filetrListUrl}${authentication.authenticatedUser.code}?status=$status");

    final response = await client.get("${ClusterUrls.filetrListUrl}${authentication.authenticatedUser.code}?status=$status",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("instant${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      jobList.add(GetJobList.fromJson(element));
    });
    return jobList;
  }
  //newJoblist
  // Future<List<GetJobList>> getNewJobList() async {
  //
  //   List<GetJobList> jobList = [];
  //   print("URL NEW JOB:${ClusterUrls.newJoblistUrl}${authentication.authenticatedUser.code.toString()}");
  //
  //   final response = await client.get(ClusterUrls.newJoblistUrl+authentication.authenticatedUser.code.toString(),
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
  //       },
  //     ),
  //   );
  //   print("asssign${response.data}");
  //   (response.data['data']['results'] as List).forEach((element) {
  //     jobList.add(GetJobList.fromJson(element));
  //   });
  //   return jobList;
  // }


  Future<PaginatedResponse<List<GetJobList>>> getNewJobList(
      String? search,String? next,String? prev) async {
    print("URL Job List:${ClusterUrls.newJoblistUrl+authentication.authenticatedUser.code.toString()}");
    List<GetJobList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.newJoblistUrl+authentication.authenticatedUser.code.toString()}?name=$search"
          :ClusterUrls.newJoblistUrl+authentication.authenticatedUser.code.toString();
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api $api");
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
  //repoter
  Future<PaginatedResponse<List<GetJobList>>> getRepoterList(
      String? search,String? next,String? prev) async {
    print("URL Job List:${ClusterUrls.repoterlistUrl+authentication.authenticatedUser.code.toString()}");
    List<GetJobList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.repoterlistUrl+authentication.authenticatedUser.code.toString()}?name=$search"
          :ClusterUrls.repoterlistUrl+authentication.authenticatedUser.code.toString();
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api $api");
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
  //userverfy
  Future<DataResponse> getUserVerify() async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<GetJobList> jobList = [];
    print("URL:${ClusterUrls.userVerifyUrl}");

    final response = await client.get(ClusterUrls.userVerifyUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("userVerify${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //admin
  Future<DataResponse> getAdminData() async {

    List<GetJobList> jobList = [];
    print("URL admin:${ClusterUrls.adminDataUrl}");

    final response = await client.get(ClusterUrls.adminDataUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("admin data${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //employeelist
  // Future<List<GetEmployeeList>> getEmployeeList() async {
  //   List<GetEmployeeList> employeeList = [];
  //   print("URL:${ClusterUrls.employeeListUrl}");
  //
  //   final response = await client.get(
  //     "${ClusterUrls.employeeListUrl}?action=fname_acce",
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'token ${authentication.authenticatedUser.token}',
  //       },
  //     ),
  //   );
  //   (response.data['data']['results'] as List).forEach((element) {
  //     employeeList.add(GetEmployeeList.fromJson(element));
  //   });
  //   return employeeList;
  // }
  //

  //
  Future<PaginatedResponse<List<GetEmployeeList>>> getEmployeeList(
      String? search,String? next,String? prev) async {
    print("URL User List:${ClusterUrls.employeeListUrl}");
    List<GetEmployeeList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.employeeListUrl}?search_key=$search"
          : "${ClusterUrls.employeeListUrl}";
    }

    print("api $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '${authentication.authenticatedUser.token}',
          },
        ));

    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(GetEmployeeList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }


  //report
  Future<List<GetEmployeeList>> getReportingPersonList() async {
    List<GetEmployeeList> employeeList = [];
    print("URL:${ClusterUrls.reportingListUrl}");


    final response = await client.get(ClusterUrls.reportingListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("resss$response");
    (response.data['data']['results'] as List).forEach((element) {
      employeeList.add(GetEmployeeList.fromJson(element));
    });
    return employeeList;
  }

  //groplist
  Future<List<GetTaskGroupList>> getGroupList() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<GetTaskGroupList> groupList = [];
    print("URL:${ClusterUrls.groupListUrl}");

    try {
      final response = await client.get(
        ClusterUrls.groupListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        groupList.add(GetTaskGroupList.fromJson(element));
      });

      return groupList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.groupListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      groupList.add(GetTaskGroupList.fromJson(element));
    });
    return groupList;
  }

  //assignMe
  // Future<List<GetJobList>> getAssignedMeList() async {
  //   List<GetJobList> assignMeList = [];
  //   print("URL:${ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString()}");
  //   final response = await client.get(ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString(),
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
  //       },
  //     ),
  //   );
  //   (response.data['data']['results'] as List).forEach((element) {
  //     assignMeList.add(GetJobList.fromJson(element));
  //   });
  //   return assignMeList;
  // }

  Future<PaginatedResponse<List<GetJobList>>> getAssignedMeList(
      String? search,String? next,String? prev) async {
    print("URL Job List:${ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString()}");
    List<GetJobList> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString()}?name=$search"
          :ClusterUrls.assignMeListUrl+authentication.authenticatedUser.code.toString();
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ));
    print("api $api");
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

  //assignCount
  Future<DoubleResponse> taskCountPost({

    required String startDate,
    required String endDate,

  }) async {
    print("startDDDDD$startDate");
    print("startDDDDD$endDate");
    GetCountTask employeeDetails;

    final response = await client.post(ClusterUrls.taskCountUrl+authentication.authenticatedUser.code.toString(),


      data: {
        "starting_date":startDate,
        "ending_date":endDate,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("filter response${response}");
    employeeDetails = GetCountTask.fromJson(response.data['data']);
print("DATASS${response.data['data']}");
// print("details${employeeDetails.}");
    return DoubleResponse(response.data['status'] == 'success', employeeDetails);

  }
  //pinJob
  Future<DataResponse> pinAJobPost({

    required int taskId,
    required String userCode,
    required bool isPinned,

  }) async {
    print("pinn$taskId");
    print("pinn$isPinned");
    print("pinn$userCode");
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await client.patch(ClusterUrls.pinnJobCreationUrl,

      data: {
        "task_id":taskId,
        "user_code":userCode,
        "is_pinned":isPinned,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );

    print("filter response${response}");
    if (response.data['status'] == 'success') {
      // employeeDetails = GetEmployeeList.fromJson(response.data['data']);

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //jobtypelist
  Future<List<JobTypeList>> getJobTypeList() async {
    List<JobTypeList> jobTyypeList = [];
    print("URL:${ClusterUrls.listJibTypeUrl}");

    try {
      final response = await client.get(
        ClusterUrls.listJibTypeUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      print("typelist${response.data}");
      (response.data['data']['results'] as List).forEach((element) {
        jobTyypeList.add(JobTypeList.fromJson(element));
      });

      return jobTyypeList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.listJibTypeUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print("typelist${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      jobTyypeList.add(JobTypeList.fromJson(element));
    });

    return jobTyypeList;
  }

  //createJob
  Future<DataResponse> jobCreatePost({
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
  }) async {

    print("JOB CREATION$name");
    print("JOB CREATION$jobType");
    print("JOB CREATION$reportingPerson");
    print("JOB CREATION$assignedBy");
    print("JOB CREATION$createdBy");
    print("JOB CREATION$originfrom");
    print("JOB CREATION$discription");
    print("JOB CREATION$isActive");
    print("JOB CREATION$startDate");
    print("JOB CREATION$endDate");
    print("JOB CREATION$priority");
    print("JOB CREATION$relatedJob");
    final response = await client.post(
      ClusterUrls.createJobUrl,
      data: {
        "name":name,
        "job_type":jobType,
        "reporting_person":reportingPerson,
        "assigned_by":assignedBy,
        "created_by":createdBy,
        "origin_from":originfrom,
        "description":discription,
        "is_active":isActive,
        "start_date":startDate,
        "end_date":endDate,
        "priority":priority,
        "related_job":relatedJob,
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
          data: response.data["status"]=="success", error: response.data['job id'].toString());
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }
  //updateTaskGroup
  Future<DataResponse> updateTaskGroup({
    required String userCode,
    required int roleId,
    required bool? isActive,
    required int? taskGroup,
    required int? userGroopId,
  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
print("${ClusterUrls.updateTaskGroupUrl}${userGroopId}");
    final response = await client.patch(
      "${ClusterUrls.updateTaskGroupUrl}${userGroopId}",
      data: {
        "task_group":taskGroup,
        "user":userCode,
        "role_id":roleId,
        "is_active":isActive,
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
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //jobRead
  Future<GetJobList> getJobReadData(int id) async {
    GetJobList selectedItemDetails;
    print("Job Read:${ClusterUrls.jobReadUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.jobReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = GetJobList.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //jobUpdate
  Future<DataResponse> jobUpdatePost({
    required String name,
    required int? jobType,
    required int? id,
    required String reportingPerson,
    required String assignedBy,
    required String createdBy,
    required String originfrom,
    required String discription,
    required bool? isActive,
    required String? startDate,
    required String? endDate,
    required String? priority,
  }) async {
    print("Update JOB:${ClusterUrls.updateUrl+id.toString()}");
    print("NAMESS${name}");
    print("NAMESS${jobType}");
    print("NAMESS${reportingPerson}");
    print("NAMESS${assignedBy}");
    print("NAMESS${createdBy}");
    print("NAMESS${originfrom}");
    print("NAMESS${discription}");
    print("NAMESS${isActive}");
    print("NAMESS${startDate}");
    print("NAMESS${endDate}");
    print("NAMESS${priority}");
    final response = await client.patch(
      ClusterUrls.updateUrl+id.toString(),
      data: {
        "name":name,
        "job_type":jobType,
        "reporting_person":reportingPerson,
        "assigned_by":assignedBy,
        "created_by":createdBy,
        "origin_from":originfrom,
        "description":discription,
        "is_active":isActive,
        "start_date":startDate,
        "end_date":endDate,
        "priority":priority,
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
    return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //usergrouplist
  Future<List<GetUserList>> getUserUderGroupList() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int groupId=sharedPreferences.getInt('groupId')??0;
    String? token = sharedPreferences.getString('token');
    List<GetUserList> userlist = [];
    print("URL:${ClusterUrls.userUnderGroupListUrl+groupId.toString()}");

    try {
      final response = await client.get(
        ClusterUrls.userUnderGroupListUrl+groupId.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
          },
        ),
      );
      (response.data['data']['users'] as List).forEach((element) {
        userlist.add(GetUserList.fromJson(element));
      });

      return userlist;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(ClusterUrls.userUnderGroupListUrl+groupId.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    (response.data['data']['users'] as List).forEach((element) {
      userlist.add(GetUserList.fromJson(element));
    });
    return userlist;
  }

  //deleteJob
  Future<String> deleteJob(int jobid) async {
    String statusCode;
    print("dele${ClusterUrls.updateUrl + jobid.toString()}");
    final response = await client.delete(
      ClusterUrls.updateUrl + jobid.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    statusCode = (response.data['status']);
    print("status${response.data['status']}");
    return statusCode;
  }

  //designatiion
  Future<List<DesignationListing>> getDesignationListingList() async {
    List<DesignationListing> designation = [];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? legalentry=sharedPreferences.getString('legalEntry');
    print( "${ClusterUrls.designationListUrl}${legalentry.toString()}""/designations");

    try {
      final response = await client.get(
        "${ClusterUrls.designationListUrl}${legalentry.toString()}""/designations",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        designation.add(DesignationListing.fromJson(element));
      });

      return designation;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get("${ClusterUrls.designationListUrl}${legalentry.toString()}""/designations",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      designation.add(DesignationListing.fromJson(element));
    });
    return designation;
  }

  //statusList
  Future<List<StatusListing>> getStatusListingList() async {
    List<StatusListing> status = [];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(ClusterUrls.statusListngUrl);

    try {
      final response = await client.get(
        ClusterUrls.statusListngUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}'
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        status.add(StatusListing.fromJson(element));
      });

      return status;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(
      ClusterUrls.statusListngUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      status.add(StatusListing.fromJson(element));
    });
    return status;
  }

  //roleList
  Future<List<RoleList>> getRoleListingList() async {
    List<RoleList> role = [];
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print(ClusterUrls.roleListngUrl);

    final response = await client.get(
      ClusterUrls.roleListngUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=${authentication.authenticatedUser.token}',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      role.add(RoleList.fromJson(element));
    });
    return role;
  }
}
