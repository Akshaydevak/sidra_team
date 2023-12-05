// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_user_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDummyList _$UserDummyListFromJson(Map<String, dynamic> json) =>
    UserDummyList(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$UserDummyListToJson(UserDummyList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'photo': instance.photo,
    };
