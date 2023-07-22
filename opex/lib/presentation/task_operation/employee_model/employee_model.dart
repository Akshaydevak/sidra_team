import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class GetEmployeeList extends Equatable {
  final int? id;
  @JsonKey(name: 'primary_mail')
  final String? primaryMail;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'primary_mobile')
  final String? primaryMobile;
  @JsonKey(name: 'fname')
  final String? fname;
  @JsonKey(name: 'lname')
  final String? lname;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'date_of_birth')
  final String? dob;
  @JsonKey(name: 'profile_pic')
  final String? profile;
  @JsonKey(name: 'date_joined')
  final String? dateJoined;
  @JsonKey(name: 'role_name')
  final String? roleName;
  @JsonKey(name: 'employee_code')
  final String? code;
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'organization_type')
  final String? orgType;
  @JsonKey(name: 'organization_code')
  final String? orgCode;
  @JsonKey(name: 'alternative_mobile_no')
  final String? altMobile;
  @JsonKey(name: 'alternative_email')
  final String? altEmail;
  @JsonKey(name: 'designation')
  final String? designation;
  @JsonKey(name: 'legalentity_code')
  final String? legalentityCode;
  @JsonKey(name: 'acess_site')
  final String? accessSite;
  @JsonKey(name: 'user_login')
  final int? userLogin;
  @JsonKey(name: 'role')
  final int? role;

  const GetEmployeeList( {
      this.gender,
      this.userCode,
      this.orgCode,
      this.id,
      this.isActive,
      this.email,
    this.primaryMail,
    this.primaryMobile,
    this.fname,
    this.lname,
    this.country,
    this.dob, this.profile,
    this.dateJoined,
    this.roleName, this.code, this.orgType, this.altMobile,
    this.altEmail,
    this.designation,
    this.legalentityCode,
    this.accessSite,
    this.userLogin,
    this.role,

  });
  @override
  List<Object> get props => [];
  factory GetEmployeeList.fromJson(Map<String, dynamic> json) =>
      _$GetEmployeeListFromJson(json);

  Map<String, dynamic> toJson() => _$GetEmployeeListToJson(this);
}
//tashGroup
@JsonSerializable()
class GetTaskGroupList extends Equatable {
  final int? id;
  @JsonKey(name: 'group_code')
  final String? groupCode;
  @JsonKey(name: 'members_count')
  final int? menberCount;
  @JsonKey(name: 'group_name')
  final String? gName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'users')
  final List<GetUserList>? userList;
  @JsonKey(name: 'user_id')
  final List<String>? userId;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete', defaultValue: false)
  final bool? isDelete;


  const GetTaskGroupList( {
    this.groupCode,
    this.userId,
    this.gName,
    this.description,
    this.id,
    this.isActive,
    this.isDelete,
    this.userList,
    this.menberCount
  });

  @override
  List<Object> get props => [];
  factory GetTaskGroupList.fromJson(Map<String, dynamic> json) =>
      _$GetTaskGroupListFromJson(json);

  Map<String, dynamic> toJson() => _$GetTaskGroupListToJson(this);
}
//
@JsonSerializable()
class GetUserList extends Equatable {

  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'user_group_id')
  final int? userGroupId;

  const GetUserList({
    this.email,
    this.userId,
    this.isActive,
    this.userCode,
    this.code,
    this.role,this.userGroupId
  });

  @override
  List<Object> get props => [];
  factory GetUserList.fromJson(Map<String, dynamic> json) =>
      _$GetUserListFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserListToJson(this);
}

//
@JsonSerializable()
class ActivityList extends Equatable {

  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'type_id')
  final int? typeId;
  @JsonKey(name: 'type_name')
  final String? typeName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;

  const ActivityList({
    this.description,
    this.userId,
    this.id,
    this.isActive,
    this.createdOn,
    this.endDate,
    this.startDate,
    this.typeName,
    this.isDelete,
    this.title,
    this.typeId,
  });

  @override
  List<Object> get props => [];
  factory ActivityList.fromJson(Map<String, dynamic> json) =>
      _$ActivityListFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityListToJson(this);
}

//
@JsonSerializable()
class LogInData extends Equatable {

  @JsonKey(name: 'login_id')
  final int? logInId;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'mobile')
  final String? mobile;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'fname')
  final String? fname;
  @JsonKey(name: 'lname')
  final String? lname;
  @JsonKey(name: 'code')
  final String? employeeCode;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'role')
  final List<String>? role;
  @JsonKey(name: 'legal_entiry')
  final String? legalEntry;
  @JsonKey(name: 'organization_type')
  final String? orgType;
  @JsonKey(name: 'organization_code')
  final String? orgCode;

  const LogInData( {
    this.logInId, this.email, this.mobile, this.username,
    this.fname, this.lname, this.employeeCode, this.token,
    this.role, this.legalEntry, this.orgType, this.orgCode,
  });
  @override
  List<Object> get props => [];
  factory LogInData.fromJson(Map<String, dynamic> json) =>
      _$LogInDataFromJson(json);

  Map<String, dynamic> toJson() => _$LogInDataToJson(this);
}