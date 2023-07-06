// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmployeeList _$GetEmployeeListFromJson(Map<String, dynamic> json) =>
    GetEmployeeList(
      gender: json['gender'] as String?,
      orgCode: json['organization_code'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      primaryMail: json['primary_mail'] as String?,
      primaryMobile: json['primary_mobile'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      country: json['country'] as String?,
      dob: json['date_of_birth'] as String?,
      profile: json['profile_pic'] as String?,
      dateJoined: json['date_joined'] as String?,
      roleName: json['role_name'] as String?,
      code: json['employee_code'] as String?,
      orgType: json['organization_type'] as String?,
      altMobile: json['alternative_mobile_no'] as String?,
      altEmail: json['alternative_email'] as String?,
      designation: json['designation'] as String?,
      legalentityCode: json['legalentity_code'] as String?,
      accessSite: json['acess_site'] as String?,
      userLogin: json['user_login'] as int?,
      role: json['role'] as int?,
    );

Map<String, dynamic> _$GetEmployeeListToJson(GetEmployeeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'primary_mail': instance.primaryMail,
      'primary_mobile': instance.primaryMobile,
      'fname': instance.fname,
      'lname': instance.lname,
      'gender': instance.gender,
      'is_active': instance.isActive,
      'country': instance.country,
      'date_of_birth': instance.dob,
      'profile_pic': instance.profile,
      'date_joined': instance.dateJoined,
      'role_name': instance.roleName,
      'employee_code': instance.code,
      'organization_type': instance.orgType,
      'organization_code': instance.orgCode,
      'alternative_mobile_no': instance.altMobile,
      'alternative_email': instance.altEmail,
      'designation': instance.designation,
      'legalentity_code': instance.legalentityCode,
      'acess_site': instance.accessSite,
      'user_login': instance.userLogin,
      'role': instance.role,
    };

GetTaskGroupList _$GetTaskGroupListFromJson(Map<String, dynamic> json) =>
    GetTaskGroupList(
      groupCode: json['group_code'] as String?,
      userId:
          (json['user_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      gName: json['group_name'] as String?,
      description: json['description'] as String?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      isDelete: json['is_delete'] as bool? ?? false,
      userList: (json['users'] as List<dynamic>?)
          ?.map((e) => GetUserList.fromJson(e as Map<String, dynamic>))
          .toList(),
      menberCount: json['members_count'] as int?,
    );

Map<String, dynamic> _$GetTaskGroupListToJson(GetTaskGroupList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_code': instance.groupCode,
      'members_count': instance.menberCount,
      'group_name': instance.gName,
      'description': instance.description,
      'users': instance.userList,
      'user_id': instance.userId,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

GetUserList _$GetUserListFromJson(Map<String, dynamic> json) => GetUserList(
      email: json['email'] as String?,
      userId: json['user_id'] as int?,
      code: json['code'] as String?,
      role: json['role'] as String?,
      userGroupId: json['user_group_id'] as int?,
    );

Map<String, dynamic> _$GetUserListToJson(GetUserList instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'code': instance.code,
      'email': instance.email,
      'role': instance.role,
      'user_group_id': instance.userGroupId,
    };

ActivityList _$ActivityListFromJson(Map<String, dynamic> json) => ActivityList(
      description: json['description'] as String?,
      userId: json['user_id'] as int?,
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      createdOn: json['created_on'] as String?,
      endDate: json['end_date'] as String?,
      startDate: json['start_date'] as String?,
      typeName: json['type_name'] as String?,
      isDelete: json['is_delete'] as bool? ?? false,
      title: json['title'] as String?,
      typeId: json['type_id'] as int?,
    );

Map<String, dynamic> _$ActivityListToJson(ActivityList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type_id': instance.typeId,
      'type_name': instance.typeName,
      'description': instance.description,
      'title': instance.title,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'created_on': instance.createdOn,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };

LogInData _$LogInDataFromJson(Map<String, dynamic> json) => LogInData(
      logInId: json['login_id'] as int?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      employeeCode: json['code'] as String?,
      token: json['token'] as String?,
      role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
      legalEntry: json['legal_entiry'] as String?,
      orgType: json['organization_type'] as String?,
      orgCode: json['organization_code'] as String?,
    );

Map<String, dynamic> _$LogInDataToJson(LogInData instance) => <String, dynamic>{
      'login_id': instance.logInId,
      'email': instance.email,
      'mobile': instance.mobile,
      'username': instance.username,
      'fname': instance.fname,
      'lname': instance.lname,
      'code': instance.employeeCode,
      'token': instance.token,
      'role': instance.role,
      'legal_entiry': instance.legalEntry,
      'organization_type': instance.orgType,
      'organization_code': instance.orgCode,
    };
