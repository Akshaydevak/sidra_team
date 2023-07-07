// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      loginId: json['login_id'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      roleList: json['role_list'] as List<dynamic>?,
      code: json['code'] as String?,
      organisationType: json['organization_type'] as String?,
      organisationCode: json['organization_code'] as String?,
      legalEntity: json['legalentity_code'] as String?,
      isEmployee: json['is_employee'] as bool?,
      username: json['username'] as String?,
      designation: json['designation'] as String?,
      prflImage: json['profile_pic'] as String?,
      emailId: json['email_id'] as String?,
      token: json['token'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'mobile': instance.mobile,
      'country': instance.country,
      'gender': instance.gender,
      'login_id': instance.loginId,
      'username': instance.username,
      'email_id': instance.emailId,
      'email': instance.email,
      'token': instance.token,
      'fname': instance.fname,
      'profile_pic': instance.prflImage,
      'lname': instance.lname,
      'role_list': instance.roleList,
      'code': instance.code,
      'organization_type': instance.organisationType,
      'organization_code': instance.organisationCode,
      'designation': instance.designation,
      'legalentity_code': instance.legalEntity,
      'is_employee': instance.isEmployee,
    };
