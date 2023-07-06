// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DummyFriendList _$DummyFriendListFromJson(Map<String, dynamic> json) =>
    DummyFriendList(
      userName: json['username'] as String?,
      userId: json['userid'] as String?,
      connected: json['connected'] as bool? ?? false,
    );

Map<String, dynamic> _$DummyFriendListToJson(DummyFriendList instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'userid': instance.userId,
      'connected': instance.connected,
    };

MessageFormat _$MessageFormatFromJson(Map<String, dynamic> json) =>
    MessageFormat(
      to: json['to'] as String?,
      from: json['from'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$MessageFormatToJson(MessageFormat instance) =>
    <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
      'content': instance.content,
    };
