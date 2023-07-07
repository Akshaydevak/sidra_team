import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joblist_model.g.dart';

@JsonSerializable()
class GetJobList extends Equatable {
  final int? id;
  @JsonKey(name: 'job_code')
  final String? jobCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'task_name')
  final String? taskName;
  @JsonKey(name: 'task_code')
  final String? taskCode;
  @JsonKey(name: 'related_job')
  final int? relatedJob;
  @JsonKey(name: 'origin_from')
  final String? orginFrom;
  @JsonKey(name: 'status_name')
  final String? statusName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'priority')
  final String? priority;
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @JsonKey(name: 'reporting_person_mail')
  final String? reportingMail;
  @JsonKey(name: 'reporting_person_name')
  final String? reportingName;
  @JsonKey(name: 'reporting_person_code')
  final String? reportingCode;
  @JsonKey(name: 'assigned_by_name')
  final String? assignByName;
  @JsonKey(name: 'assigned_by_code')
  final String? assignCode;
  @JsonKey(name: 'created_person_name')
  final String? createdName;
  @JsonKey(name: 'created_person_code')
  final String? createdCode;
  @JsonKey(name: 'job_type')
  final int? jobType;
  @JsonKey(name: 'payment_id')
  final int? paymentId;
  @JsonKey(name: 'reward_id')
  final int? rewardId;
  @JsonKey(name: 'reporting_person')
   dynamic reportingPerson;
  @JsonKey(name: 'assigned_by')
  final int? assignedBy;
  @JsonKey(name: 'created_by')
  final int? createdBy;
  @JsonKey(name: 'status_stages_id')
  final int? statusStagesId;
  @JsonKey(name: 'job_meta')
  final int? jobMeta;
  @JsonKey(name: 'image_count')
  final int? imgCount;
  @JsonKey(name: 'review_count')
  final int? rewCount;


   GetJobList( {
    this.statusName,
    this.imgCount,
    this.rewCount,
    this.taskName,this.taskCode,
    this.reportingMail,
    this.reportingName,
    this.reportingCode,
    this.assignByName,
    this.assignCode,
    this.createdName,
    this.createdCode,
    this.description,
    this.id,this.rewardId,
    this.paymentId,
    this.assignedBy,
    this.createdBy,
    this.createdOn,
    this.endDate,
    this.name,
    this.isActive,
    this.isDelete,
    this.jobCode,
    this.jobMeta,
    this.jobType,
    this.orginFrom,
    this.priority,
    this.relatedJob,
    this.reportingPerson,
    this.startDate,
    this.statusStagesId,

  });

  @override
  List<Object> get props => [];

  factory GetJobList.fromJson(Map<String, dynamic> json) =>
      _$GetJobListFromJson(json);

  Map<String, dynamic> toJson() => _$GetJobListToJson(this);
}

@JsonSerializable()
class JobTypeList extends Equatable {
  final int? id;
  @JsonKey(name: 'type_name')
  final String? typeName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;



  const JobTypeList( {
    this.description,
    this.id,
    this.isActive,
    this.typeName, this.isDelete,



  });

  @override
  List<Object> get props => [];

  factory JobTypeList.fromJson(Map<String, dynamic> json) =>
      _$JobTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$JobTypeListToJson(this);
}

@JsonSerializable()
class DesignationListing extends Equatable {
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'organization',)
  final int? organization;



  const DesignationListing(  {
    this.description,
    this.id,
    this.isActive,
    this.title,
    this.organization,
  });

  @override
  List<Object> get props => [];

  factory DesignationListing.fromJson(Map<String, dynamic> json) =>
      _$DesignationListingFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationListingToJson(this);
}

//statusList
@JsonSerializable()
class StatusListing extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;



  const StatusListing(  {
    this.description,
    this.id,
    this.isActive,
    this.isDelete,
    this.name,
  });

  @override
  List<Object> get props => [];

  factory StatusListing.fromJson(Map<String, dynamic> json) =>
      _$StatusListingFromJson(json);

  Map<String, dynamic> toJson() => _$StatusListingToJson(this);
}


//rolemodel
@JsonSerializable()
class RoleList extends Equatable {
  final int? id;
  @JsonKey(name: 'role_code')
  final String? roleCode;
  @JsonKey(name: 'role_name')
  final String? roleName;
  @JsonKey(name: 'description',)
  final String? description;
  @JsonKey(name: 'organisation_code',)
  final String? organisationCode;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;



  const RoleList(  {
    this.description,
    this.id,
    this.isActive,
    this.isDelete,
    this.organisationCode,
    this.roleCode,
    this.roleName
  });

  @override
  List<Object> get props => [];

  factory RoleList.fromJson(Map<String, dynamic> json) =>
      _$RoleListFromJson(json);

  Map<String, dynamic> toJson() => _$RoleListToJson(this);
}
//userGroupUpdate
@JsonSerializable()
class UserGroupUpdate extends Equatable {

  @JsonKey(name: 'task_group')
  final int? taskGroup;
  @JsonKey(name: 'user')
  final String? userCode;
  @JsonKey(name: 'role_id',)
  final int? roleId;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;



  const UserGroupUpdate(  {
    this.userCode,
    this.isActive,
    this.roleId,this.taskGroup
  });

  @override
  List<Object> get props => [];

  factory UserGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserGroupUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserGroupUpdateToJson(this);
}