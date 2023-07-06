import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_models.g.dart';

@JsonSerializable()
class User extends Equatable {

  @JsonKey(name: 'mobile')
  final String? mobile;
  final String? country;
  final String? gender;

  @JsonKey(name: 'login_id')
  final int? loginId;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email_id')
  final String? emailId;

  final String? email;

  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: "fname")
  final String? fname;
  @JsonKey(name: 'profile_pic')
  final String? prflImage;
  @JsonKey(name: 'lname')
  final String? lname;
  @JsonKey(name: 'role_list')
  final List<dynamic>? roleList;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'organization_type')
  final String? organisationType;
  @JsonKey(name: 'organization_code')
  final String? organisationCode;
  @JsonKey(name: 'designation')
  final String? designation;
  @JsonKey(name: 'legalentity_code')
  final String? legalEntity;
  @JsonKey(name: 'is_employee')
  final bool? isEmployee;
  User( {
    this.loginId,
    this.fname,
    this.lname,
    this.roleList,
    this.code,
    this.organisationType,
    this.organisationCode,
    this.legalEntity,
    this.isEmployee,
    this.username,
    this.designation,
    this.prflImage,
    this.emailId,
    this.token,

this.mobile,
    this.email,
    this.gender,
    this.country


  });

  @override
  List<Object> get props => [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}