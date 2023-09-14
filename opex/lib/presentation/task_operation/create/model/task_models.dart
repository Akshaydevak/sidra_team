import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_models.g.dart';

@JsonSerializable()
class GetTaskTypeList extends Equatable {
  final int? id;
  @JsonKey(name: 'type_name')
  final String? typeName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;


  const GetTaskTypeList({
    this.description,
    this.id,
    this.typeName,
    this.isActive,
    this.isDelete,
  });

  @override
  List<Object> get props => [];

  factory GetTaskTypeList.fromJson(Map<String, dynamic> json) =>
      _$GetTaskTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$GetTaskTypeListToJson(this);
}

@JsonSerializable()
class GetTaskList extends Equatable {
  final int? id;
  @JsonKey(name: 'task_name')
  final String? taskName;
  @JsonKey(name: 'topic')
  final String? topic;
  @JsonKey(name: 'task_type_name')
  final String? taskTypeName;
  @JsonKey(name: 'job_title')
  final String? jobTitle;
  @JsonKey(name: 'job_description')
  final String? jobDiscription;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'report_id')
  final int? reportId;
  @JsonKey(name: 'currency_code')
  final String? currency;
  @JsonKey(name: 'is_notify',defaultValue: false)
  final bool? isNotify;
  @JsonKey(name: 'assigned_to')
  final String? assignToEmail;
  @JsonKey(name: 'assigned_to_name')
  final String? assignToName;
  @JsonKey(name: 'task_code')
  final String? taskCode;
  @JsonKey(name: 'reporting_person_code')
  final String? reportingPersonCode;
  @JsonKey(name: 'created_person_code')
  final String? createdPersonCode;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'priority_level')
  final int? priorityLevel;
  @JsonKey(name: 'payment_id')
  final int? paymentId;
  @JsonKey(name: 'reward_id')
  final int? rewardid;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'is_pinned', defaultValue: false)
  final bool? isPinned;
  @JsonKey(name: 'is_reported', defaultValue: false)
  final bool? isReported;
  @JsonKey(name: "assigning_type")
  final String? assigningType;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "status_name")
  final String? statusName;
  @JsonKey(name: "reporting_person_name")
  final String? reportingName;
  @JsonKey(name: "assigned_by_name")
  final String? assignName;
  @JsonKey(name: "assigning_code")
  final String? assigningCode;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "remarks")
  final String? remarks;
  @JsonKey(name: "priority")
  final String? priority;
  @JsonKey(name: "created_on")
  final String? createdOn;
  @JsonKey(name: "last_modified")
  final String? lastModified;
  @JsonKey(name: "task_meta")
  final CostingMeta? metaData;
  @JsonKey(name: "payment_data")
  final CostingMeta? paymentMeta;
  @JsonKey(name: "rewards_data")
  final CostingMeta? rewardsData;
  @JsonKey(name: "lft")
  final int? left;
  @JsonKey(name: "rght")
  final int? right;
  @JsonKey(name: "tree_id")
  final int? treeId;
  @JsonKey(name: "level")
  final int? level;
  @JsonKey(name: "parent")
  final int? parent;
  @JsonKey(name: "job_id")
  final int? jobId;
  @JsonKey(name: "image_count")
  final int? imgCount;
   @JsonKey(name: "review_count")
  final int? reviewCount;
  @JsonKey(name: "task_type")
  final int? taskType;
  @JsonKey(name: "status_stages_id")
  final int? statusStagesId;
  @JsonKey(name: "reporting_person")
  final String? reportingPerson;
  @JsonKey(name: "location_url")
  final String? locayionUrl;
  @JsonKey(name: "created_by")
  final int? createdBy;

  const GetTaskList({
    this.name,
    this.reviewCount,
    this.topic,
    this.imgCount,
    this.taskTypeName,
    this.paymentMeta,
    this.rewardsData,
    this.reportId,
    this.currency,
    this.isReported,
    this.locayionUrl,
    this.jobTitle,this.jobDiscription,
    this.assignToEmail,
    this.assignToName,
    this.description,this.paymentId,
    this.id,this.rewardid,
    this.reportingPersonCode,
    this.isNotify,
    this.createdPersonCode,
    this.createdOn,
    this.longitude,
    this.latitude,
    this.isActive,
    this.isDelete,
    this.priority,
    this.endDate,
    this.isPinned,
    this.startDate,
    this.statusName,
    this.reportingPerson,
    this.statusStagesId,
    this.createdBy,
    this.assigningCode,
    this.assigningType,
    this.jobId,
    this.assignName,
    this.reportingName,
    this.lastModified,
    this.left,
    this.level,
    this.notes,
    this.parent,
    this.priorityLevel,
    this.remarks,
    this.right,
    this.taskCode,
    this.metaData,
    this.taskName,
    this.taskType,
    this.treeId
  });

  @override
  List<Object> get props => [];

  factory GetTaskList.fromJson(Map<String, dynamic> json) =>
      _$GetTaskListFromJson(json);

  Map<String, dynamic> toJson() => _$GetTaskListToJson(this);
}

@JsonSerializable()
class GetCountTask extends Equatable {

  @JsonKey(name: 'Assigned Task')
  final int? assignTask;
  @JsonKey(name: 'Task Completed')
  final int? taskCompleted;
  @JsonKey(name: 'Task on Progress')
  final int? taskOnProgress;
  @JsonKey(name: 'Task Pending')
  final int? taskPending;

  const GetCountTask({
    this.assignTask,
    this.taskCompleted,
    this.taskOnProgress,
    this.taskPending,
  });

  @override
  List<Object> get props => [];

  factory GetCountTask.fromJson(Map<String, dynamic> json) =>
      _$GetCountTaskFromJson(json);

  Map<String, dynamic> toJson() => _$GetCountTaskToJson(this);
}


//payment
@JsonSerializable()
class PaymentModel extends Equatable {

  final int? id;
  @JsonKey(name: 'job_id')
  final int? jobId;
  @JsonKey(name: 'task_id')
  final int? taskId;
  @JsonKey(name: 'assigning_type')
  final String? assigningType;
  @JsonKey(name: 'budget')
  final double? budget;
  @JsonKey(name: 'assigning_code')
  final String? assigningCode;
  @JsonKey(name: 'assigning_name')
  final String? assigningName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'expense')
  final double? expense;
  @JsonKey(name: 'cost_code')
  final String? costCode;
  @JsonKey(name: 'costing_meta')
  final CostingMeta? costingMeta;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;

  const PaymentModel({
    this.taskId,
    this.assigningName,
    this.costingMeta,
    this.jobId,
    this.description,
    this.assigningCode,
    this.assigningType,
    this.budget,
    this.expense,
    this.notes,
    this.id,
    this.isDelete,
    this.isActive,
    this.costCode
  });

  @override
  List<Object> get props => [];

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
//costMeta
@JsonSerializable()
class CostingMeta extends Equatable {

  @JsonKey(name: 'image1')
  final String? image1;
  @JsonKey(name: 'image2')
  final String? image2;
  @JsonKey(name: 'image3')
  final String? image3;
  @JsonKey(name: 'image4')
  final String? image4;
  @JsonKey(name: 'image5')
  final String? image5;
  @JsonKey(name: 'attachment_note')
  final String? note;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? descriptionreward;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'attachment_description')
  final String? description;


  const CostingMeta({
    this.image1,
    this.note,
    this.name,
    this.notes,
    this.descriptionreward,
    this.description,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
  });

  @override
  List<Object> get props => [];

  factory CostingMeta.fromJson(Map<String, dynamic> json) =>
      _$CostingMetaFromJson(json);

  Map<String, dynamic> toJson() => _$CostingMetaToJson(this);
}

//rewards
@JsonSerializable()
class PointsList extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'points')
  final int? points;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;

  const PointsList({
    this.id,
    this.isDelete,
    this.name,
    this.isActive,
    this.points,
  });

  @override
  List<Object> get props => [];

  factory PointsList.fromJson(Map<String, dynamic> json) =>
      _$PointsListFromJson(json);

  Map<String, dynamic> toJson() => _$PointsListToJson(this);
}
//readRewards
@JsonSerializable()
class ReadRewards extends Equatable {
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'rewards_meta')
  final CostingMeta? rewardsMeta;
  @JsonKey(name: 'types')
  final String? types;
  @JsonKey(name: 'type_id')
  final int? typeId;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;

  const ReadRewards( {
    this.id,
    this.rewardsMeta,
    this.isDelete,
    this.name,
    this.isActive,
    this.description, this.notes, this.types, this.typeId,
  });

  @override
  List<Object> get props => [];

  factory ReadRewards.fromJson(Map<String, dynamic> json) =>
      _$ReadRewardsFromJson(json);

  Map<String, dynamic> toJson() => _$ReadRewardsToJson(this);
}

//review
@JsonSerializable()
class ReviewModel extends Equatable {

  final int? id;
  @JsonKey(name: 'parent')
  final int? parent;
  @JsonKey(name: 'reviewed_by')
  final int? reviewdBy;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'review')
  final String? review;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'task_id')
  final int? taskId;
  @JsonKey(name: 'reviewed_on')
  final String? reviewOn;
  @JsonKey(name: 'review_meta')
  final CostingMeta? reviewMeta;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'reviewed_person_code')
  final String? reviewedPersonCode;
  @JsonKey(name: 'reviewed_person_name')
  final String? reviewedPersonName;

  const ReviewModel({
    this.notes,
    this.reviewMeta,
    this.review,
    this.parent,
    this.taskId,
    this.image,
    this.reviewdBy,
    this.id,
    this.isActive,
    this.isDelete,
    // this.imageRead,
    this.reviewedPersonCode,
    this.reviewedPersonName,
    this.reviewOn

  });

  @override
  List<Object> get props => [];

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

//reviewReviewList
@JsonSerializable()
class ReviewModelList extends Equatable {

  final int? id;
  @JsonKey(name: 'parent')
  final int? parent;
  @JsonKey(name: 'reviewed_by')
  final int? reviewdBy;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'review')
  final String? review;
  @JsonKey(name: 'image')
  final int? image;
  @JsonKey(name: 'task_id')
  final int? taskId;
  @JsonKey(name: 'reviewed_on')
  final String? reviewOn;
  // @JsonKey(name: 'image')
  // final String? imageRead;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'reviewed_person_code')
  final String? reviewedPersonCode;
  @JsonKey(name: 'reviewed_person_name')
  final String? reviewedPersonName;

  const ReviewModelList({
    this.notes,
    this.review,
    this.parent,
    this.taskId,
    this.image,
    this.reviewdBy,
    this.id,
    this.isActive,
    this.isDelete,
    // this.imageRead,
    this.reviewedPersonCode,
    this.reviewedPersonName,
    this.reviewOn

  });

  @override
  List<Object> get props => [];

  factory ReviewModelList.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelListFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelListToJson(this);
}

//performanceAppraisal
@JsonSerializable()
class ReadPerformanceAppraisal extends Equatable {

  @JsonKey(name: 'performance_appraisal')
  final List<PerformanceList>? performanceList;


  const ReadPerformanceAppraisal({
    this.performanceList

  });

  @override
  List<Object> get props => [];

  factory ReadPerformanceAppraisal.fromJson(Map<String, dynamic> json) =>
      _$ReadPerformanceAppraisalFromJson(json);

  Map<String, dynamic> toJson() => _$ReadPerformanceAppraisalToJson(this);
}

@JsonSerializable()
class PerformanceList extends Equatable {

  final int? id;
  @JsonKey(name: 'points_id')
  final PointId? pointId;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'points')
  final int? points;
  @JsonKey(name: 'user')
  final int? user;
  @JsonKey(name: 'task_id')
  final int? taskId;
  @JsonKey(name: 'task_id_id')
  final int? taskIdId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;
  const PerformanceList({
    this.id,
    this.pointId,
    this.userId,
    this.name,
    this.taskId,
    this.points,
    this.user,
    this.taskIdId,
    this.isActive,
    this.isDelete,
    this.description,
  });
  @override
  List<Object> get props => [];

  factory PerformanceList.fromJson(Map<String, dynamic> json) =>
      _$PerformanceListFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceListToJson(this);
}

@JsonSerializable()
class PointId extends Equatable {

  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'points')
  final int? points;

  const PointId({
    this.id,
    this.name,
    this.points

  });
  @override
  List<Object> get props => [];

  factory PointId.fromJson(Map<String, dynamic> json) =>
      _$PointIdFromJson(json);

  Map<String, dynamic> toJson() => _$PointIdToJson(this);
}

//CriteriaRedad
@JsonSerializable()
class CriteriaRead extends Equatable {

  @JsonKey(name: 'Task Quality')
  final List<Punchuality>? punctuality;
  @JsonKey(name: 'Technical Skills and Innovation')
  final List<Punchuality>? attittude;
  @JsonKey(name: 'Team Collaboration and Leadership')
  final List<Punchuality>? projectCompletion;
  @JsonKey(name: 'Business Requirements')
  final List<Punchuality>? teamManagement;
  @JsonKey(name: 'Efficient Time Management')
  final List<Punchuality>? timeMange;

  const CriteriaRead({
    this.attittude,
    this.projectCompletion,
    this.punctuality,
    this.teamManagement,
    this.timeMange

  });
  @override
  List<Object> get props => [];

  factory CriteriaRead.fromJson(Map<String, dynamic> json) =>
      _$CriteriaReadFromJson(json);

  Map<String, dynamic> toJson() => _$CriteriaReadToJson(this);
}


//CriteriaRedad
@JsonSerializable()
class Punchuality extends Equatable {

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'points')
  final int? points;


  const Punchuality({
    this.name,
    this.points,


  });
  @override
  List<Object> get props => [];

  factory Punchuality.fromJson(Map<String, dynamic> json) =>
      _$PunchualityFromJson(json);

  Map<String, dynamic> toJson() => _$PunchualityToJson(this);
}

//report
@JsonSerializable()
class ReportModel extends Equatable {

  final int? id;
  @JsonKey(name: 'task_id')
  final int? taskId;
  @JsonKey(name: 'task_name')
  final String? taskName;
  @JsonKey(name: 'task_description')
  final String? taskDescription;
  @JsonKey(name: 'topic_name')
  final String? topicName;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'reply')
  final String? reply;
  @JsonKey(name: 'report_status')
  final String? reportStatus;



  const ReportModel({
    this.taskId,
    this.reportStatus,
    this.reply,
    this.id,
    this.notes,
    this.taskDescription,
    this.taskName,
    this.topicName,
    this.userName,


  });
  @override
  List<Object> get props => [];

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}


//notification
@JsonSerializable()
class NotificationList extends Equatable {
  final int? id;
  @JsonKey(name: 'notification_count')
  final int? count;
  @JsonKey(name: 'app_notification_code')
  final String? appNotificationCode;
  @JsonKey(name: 'notification_type')
  final String? notificationType;
  @JsonKey(name: 'notification_type_id')
  final String? notificationTypeId;
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_on')
  final String? createOn;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;
  @JsonKey(name: 'is_new', defaultValue: false)
  final bool? isNew;


  const NotificationList({
    this.description,
    this.count,
    this.id,
    this.userCode,
    this.appNotificationCode,
    this.createOn,
    this.isNew,
    this.notificationType,
    this.notificationTypeId,
    this.isActive,
    this.isDelete,
  });

  @override
  List<Object> get props => [];

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListToJson(this);
}

//
@JsonSerializable()
class ReadMarkRead extends Equatable {
 
  @JsonKey(name: 'key')
  final String? key;
  @JsonKey(name: 'value')
  final String? value;

  const ReadMarkRead({
    this.key,
    this.value,
  
   
  });

  @override
  List<Object> get props => [];

  factory ReadMarkRead.fromJson(Map<String, dynamic> json) =>
      _$ReadMarkReadFromJson(json);

  Map<String, dynamic> toJson() => _$ReadMarkReadToJson(this);
}


//perfomerModel
@JsonSerializable()
class PerfomerModel extends Equatable {
 
  @JsonKey(name: 'first_name')
  final String? fName;
  @JsonKey(name: 'last_name')
  final String? lName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'highest_average_points')
  final double? points;

  const PerfomerModel({
    this.fName,
    this.lName,
  this.email,
  this.points,
   
  });

  @override
  List<Object> get props => [];

  factory PerfomerModel.fromJson(Map<String, dynamic> json) =>
      _$PerfomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PerfomerModelToJson(this);
}