// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joblist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJobList _$GetJobListFromJson(Map<String, dynamic> json) => GetJobList(
      statusName: json['status_name'] as String?,
      createdPerson: json['created_person'] as String?,
      duration: json['duration'] as String?,
      jobTypeName: json['job_type_name'] as String?,
      imgCount: json['image_count'] as int?,
      currency: json['currency_code'] as String?,
      rewCount: json['review_count'] as int?,
      taskName: json['task_name'] as String?,
      taskCode: json['task_code'] as String?,
      reportingMail: json['reporting_person_mail'] as String?,
      reportingName: json['reporting_person_name'] as String?,
      reportingCode: json['reporting_person_code'] as String?,
      assignByName: json['assigned_by_name'] as String?,
      assignCode: json['assigned_by_code'] as String?,
      createdName: json['created_person_name'] as String?,
      createdCode: json['created_person_code'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      rewardId: json['reward_id'] as int?,
      paymentId: json['payment_id'] as int?,
      assignedBy: json['assigned_by'] as int?,
      createdBy: json['created_by'] as int?,
      createdOn: json['created_on'] as String?,
      endDate: json['end_date'] as String?,
      name: json['name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
      jobCode: json['job_code'] as String?,
      jobMeta: json['job_meta'] as int?,
      jobType: json['job_type'] as int?,
      orginFrom: json['origin_from'] as String?,
      priority: json['priority'] as String?,
      relatedJob: json['related_job'] as int?,
      reportingPerson: json['reporting_person'],
      startDate: json['start_date'] as String?,
      statusStagesId: json['status_stages_id'] as int?,
    );

Map<String, dynamic> _$GetJobListToJson(GetJobList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_code': instance.jobCode,
      'name': instance.name,
      'duration': instance.duration,
      'currency_code': instance.currency,
      'job_type_name': instance.jobTypeName,
      'task_name': instance.taskName,
      'task_code': instance.taskCode,
      'related_job': instance.relatedJob,
      'origin_from': instance.orginFrom,
      'status_name': instance.statusName,
      'description': instance.description,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'priority': instance.priority,
      'created_on': instance.createdOn,
      'reporting_person_mail': instance.reportingMail,
      'reporting_person_name': instance.reportingName,
      'reporting_person_code': instance.reportingCode,
      'assigned_by_name': instance.assignByName,
      'assigned_by_code': instance.assignCode,
      'created_person_name': instance.createdName,
      'created_person': instance.createdPerson,
      'created_person_code': instance.createdCode,
      'job_type': instance.jobType,
      'payment_id': instance.paymentId,
      'reward_id': instance.rewardId,
      'reporting_person': instance.reportingPerson,
      'assigned_by': instance.assignedBy,
      'created_by': instance.createdBy,
      'status_stages_id': instance.statusStagesId,
      'job_meta': instance.jobMeta,
      'image_count': instance.imgCount,
      'review_count': instance.rewCount,
    };

JobTypeList _$JobTypeListFromJson(Map<String, dynamic> json) => JobTypeList(
      description: json['description'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      typeName: json['type_name'] as String?,
      isDelete: json['is_delete'] as bool? ?? false,
    );

Map<String, dynamic> _$JobTypeListToJson(JobTypeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_name': instance.typeName,
      'description': instance.description,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

DesignationListing _$DesignationListingFromJson(Map<String, dynamic> json) =>
    DesignationListing(
      description: json['description'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      title: json['title'] as String?,
      organization: json['organization'] as int?,
    );

Map<String, dynamic> _$DesignationListingToJson(DesignationListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
      'organization': instance.organization,
    };

StatusListing _$StatusListingFromJson(Map<String, dynamic> json) =>
    StatusListing(
      description: json['description'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StatusListingToJson(StatusListing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

RoleList _$RoleListFromJson(Map<String, dynamic> json) => RoleList(
      description: json['description'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
      organisationCode: json['organisation_code'] as String?,
      roleCode: json['role_code'] as String?,
      roleName: json['role_name'] as String?,
    );

Map<String, dynamic> _$RoleListToJson(RoleList instance) => <String, dynamic>{
      'id': instance.id,
      'role_code': instance.roleCode,
      'role_name': instance.roleName,
      'description': instance.description,
      'organisation_code': instance.organisationCode,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

UserGroupUpdate _$UserGroupUpdateFromJson(Map<String, dynamic> json) =>
    UserGroupUpdate(
      userCode: json['user'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      roleId: json['role_id'] as int?,
      taskGroup: json['task_group'] as int?,
    );

Map<String, dynamic> _$UserGroupUpdateToJson(UserGroupUpdate instance) =>
    <String, dynamic>{
      'task_group': instance.taskGroup,
      'user': instance.userCode,
      'role_id': instance.roleId,
      'is_active': instance.isActive,
    };
