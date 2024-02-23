
import 'package:cluster/core/utils/data_response.dart';
import 'package:flutter/cupertino.dart';

import 'job_datasource.dart';

class JobRepo {
  final JobDataSource _dataSource = JobDataSource();

  Future<DataResponse> getJobList() async {
    final apiResponse = await _dataSource.getJobList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(data: apiResponse??[]);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }
  //instnt job
  Future<DataResponse> getInstantJobList() async {
    final apiResponse = await _dataSource.getInstantJobList();
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
  //filetr
  Future<DataResponse> getFilterJobList(String? status) async {
    final apiResponse = await _dataSource.getFilterJobList(status);
    try {
      if (apiResponse!=null) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text",data: null);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }
  //newJobList
  // Future<DataResponse> getNewJobList() async {
  //   final apiResponse = await _dataSource.getNewJobList();
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

  Future<PaginatedResponse> getNewJobList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getNewJobList(search,next,prev);
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
  //repoter
  Future<PaginatedResponse> getRepoterList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getRepoterList(search,next,prev);
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
  //userverify
  Future<DataResponse> getUserVerify() async {
    final apiResponse = await _dataSource.getUserVerify();
    if (apiResponse.data) {
      return DataResponse(error: apiResponse.error,data: apiResponse.data);
    } else {
      return DataResponse(error: apiResponse.error ?? "",data: apiResponse.data);
    }
  }
  //admin
  Future<DataResponse> getAdminData() async {
    final apiResponse = await _dataSource.getAdminData();
    if (apiResponse.data) {
      return DataResponse(error: apiResponse.error,data: apiResponse.data);
    } else {
      return DataResponse(error: apiResponse.error ?? "",data: apiResponse.data);
    }
  }
  //employeelist
  // Future<DataResponse> getEmployeeList() async {
  //   final apiResponse = await _dataSource.getEmployeeList();
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


  Future<PaginatedResponse> getEmployeeList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getEmployeeList(search,next,prev);
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

  //
  Future<DataResponse> getReportingPersonList() async {
    final apiResponse = await _dataSource.getReportingPersonList();
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
  //grouplist
  Future<DataResponse> getGroupList() async {
    final apiResponse = await _dataSource.getGroupList();
    try {
      if (apiResponse !=null) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }
  //assignMe
  // Future<DataResponse> getAssignedMeList() async {
  //   final apiResponse = await _dataSource.getAssignedMeList();
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

  Future<PaginatedResponse> getAssignedMeList(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getAssignedMeList(search,next,prev);
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
//taskcount


  Future<DoubleResponse>taskCountPost({
    required String startDate, required String enddate}) async {
    try {
      final restApiresponse = await _dataSource.taskCountPost(startDate: startDate, endDate: enddate,);
      if (restApiresponse.data1) {
        return DoubleResponse(restApiresponse.data1,restApiresponse.data2);
      }
    } catch (e) {
      debugPrint("implement Error conversion Text$e");
    }
    return DoubleResponse("implement Error conversion Text","");
  }

  //pinJob
  Future<DataResponse> pinAJobPost({
    required String userCode,
    required int taskId,
    required bool isPinned

  }) async {
    final restAPIresponse = await _dataSource.pinAJobPost(
        userCode: userCode,
      taskId: taskId,
      isPinned: isPinned

    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }
  //jobtypelist
  Future<DataResponse> getJobTypeList() async {
    final apiResponse = await _dataSource.getJobTypeList();
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
    required String? durationOption,
    required String? startTime,
    required String? endTime,
  }) async {
    final restAPIresponse = await _dataSource.jobCreatePost(
      durationOption: durationOption,
      startTime: startTime,
      endTime: endTime,
      name: name,
      jobType: jobType,
      reportingPerson: reportingPerson,
      assignedBy: assignedBy,
      createdBy:createdBy,
      originfrom: originfrom,
      discription: discription,
      isActive: isActive,
      startDate:startDate,
      endDate:endDate,
      priority:priority,
      relatedJob:relatedJob

    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //updateTaskGroup
  Future<DataResponse> updateTaskGroup({
    required String userCode,
    required int roleId,
    required bool? isActive,
    required int? taskGroup,
    required int? userGoupId,
  }) async {
    final restAPIresponse = await _dataSource.updateTaskGroup(
        userCode: userCode,
        roleId: roleId,
        taskGroup: taskGroup,
        isActive: isActive,
      userGroopId: userGoupId

    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //jobread
  Future<DataResponse> getJobReadData(int? id) async {
    try {
      final apiResponse = await _dataSource.getJobReadData(id!);

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

  //updateJob
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
    required String? durationOption,
    required String? startTime,
    required String? endTime,
  }) async {
    final restAPIresponse = await _dataSource.jobUpdatePost(
        name: name,
        id: id,
        jobType: jobType,
        reportingPerson: reportingPerson,
        assignedBy: assignedBy,
        createdBy:createdBy,
        originfrom: originfrom,
        discription: discription,
        isActive: isActive,
        startDate:startDate,
        endDate:endDate,
        priority:priority,
startTime: startTime,
endTime: endTime,
      durationOption: durationOption
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //userundergrouplist
  Future<DataResponse> getUserUderGroupList() async {
    final apiResponse = await _dataSource.getUserUderGroupList();
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
  //designationList
  Future<DataResponse> getDesignationListingList() async {
    final apiResponse = await _dataSource.getDesignationListingList();
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

  //statusList
  Future<DataResponse> getStatusListingList() async {
    final apiResponse = await _dataSource.getStatusListingList();
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
  //roleList
  Future<DataResponse> getRoleListingList() async {
    final apiResponse = await _dataSource.getRoleListingList();
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