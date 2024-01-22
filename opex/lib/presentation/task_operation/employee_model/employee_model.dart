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
  @JsonKey(name: 'contact_number')
  final String? primaryMobile;
  @JsonKey(name: 'first_name')
  final String? fname;
  @JsonKey(name: 'last_name')
  final String? lname;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'nationality')
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
  @JsonKey(name: 'network_code')
  final String? netCode;
  @JsonKey(name: 'department_code')
  final String? departmentCode;
  @JsonKey(name: 'alternative_mobile_no')
  final String? altMobile;
  @JsonKey(name: 'alternative_email')
  final String? altEmail;
  @JsonKey(name: 'designation_code')
  final String? designation;
  @JsonKey(name: 'legalentity_code')
  final String? legalentityCode;
  @JsonKey(name: 'acess_site')
  final String? accessSite;
  @JsonKey(name: 'user_login')
  final int? userLogin;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'user_meta')
  final UserMete? userMete;

  const GetEmployeeList( {
      this.gender,
      this.userMete,
      this.userCode,
      this.departmentCode,
      this.orgCode,
      this.id,
      this.isActive,
      this.netCode,
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
  @JsonKey(name: 'first_name')
  final String? fName;
  @JsonKey(name: 'last_name')
  final String? lName;
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
    this.lName,
    this.fName,
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

//emloyeeRead
@JsonSerializable()
class EmployeeCreateRead extends Equatable {

  @JsonKey(name: 'gender')
  final List<String>? gender;
  @JsonKey(name: 'user_roles')
  final List<String>?userRole;
  @JsonKey(name: 'user_data')
  final List<GetEmployeeList>?userData;


  const EmployeeCreateRead( {
    this.userRole, this.gender,this.userData
  });
  @override
  List<Object> get props => [];
  factory EmployeeCreateRead.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCreateReadFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCreateReadToJson(this);
}

@JsonSerializable()
class UserMete extends Equatable {

  @JsonKey(name: 'official_role_name')
  final String? roleName;
  @JsonKey(name: 'official_role')
  final int? roleId;
  @JsonKey(name: 'profile_pic')
  final String? profile;
  @JsonKey(name: 'additional_roles_list')
  final List<String>?roleList;
  @JsonKey(name: 'additional_roles')
  final List<int>?roleListId;



  const UserMete( {
    this.roleName, this.roleList,this.profile,
    this.roleId, this.roleListId,
  });
  @override
  List<Object> get props => [];
  factory UserMete.fromJson(Map<String, dynamic> json) =>
      _$UserMeteFromJson(json);

  Map<String, dynamic> toJson() => _$UserMeteToJson(this);
}


@JsonSerializable()
class CommunicationTaskGroup extends Equatable {

  @JsonKey(name: 'task_name')
  final String? taskName;
  @JsonKey(name: 'task_code')
  final String? taskCode;
  @JsonKey(name: 'createdBy')
  final String? createdBy;
  @JsonKey(name: 'friends')
  final List<FriendListModel>?friendList;



  const CommunicationTaskGroup( {
    this.createdBy, this.friendList,this.taskCode,
    this.taskName,
  });
  @override
  List<Object> get props => [];
  factory CommunicationTaskGroup.fromJson(Map<String, dynamic> json) =>
      _$CommunicationTaskGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicationTaskGroupToJson(this);
}

@JsonSerializable()
class FriendListModel extends Equatable {

  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'fname')
  final String? fName;
  @JsonKey(name: 'lname')
  final String? lName;
  @JsonKey(name: 'email')
  final String? email;



  const FriendListModel( {
    this.email, this.fName,this.lName,
    this.userCode,
  });
  @override
  List<Object> get props => [];
  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      _$FriendListModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendListModelToJson(this);
}