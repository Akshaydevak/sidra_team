// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_user_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDummyList _$UserDummyListFromJson(Map<String, dynamic> json) =>
    UserDummyList(
      id: json['userId'] as String?,
      name: json['name'] as String?,
      connect: json['connected'] as bool?,
      photo: json['photoUrl'] as String?,
      chatid: json['chatId'] as String?,
      isgrp: json['isGroupChat'] as bool?,
      type: json['type'] as String?,
      isgrpname: json['groupname'] as String?,
      isgrpid: json['groupId'] as String?,
      latestMessage: json['latestMessage'] as String?,
      latestMessagecreated: json['latestMessageCreatedAt'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      deletedAt: json['deletedAt'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$UserDummyListToJson(UserDummyList instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'name': instance.name,
      'connected': instance.connect,
      'photoUrl': instance.photo,
      'chatId': instance.chatid,
      'isGroupChat': instance.isgrp,
      'groupname': instance.isgrpname,
      'groupId': instance.isgrpid,
      'type': instance.type,
      'latestMessage': instance.latestMessage,
      'latestMessageCreatedAt': instance.latestMessagecreated,
      'isDeleted': instance.isDeleted,
      'deletedAt': instance.deletedAt,
      'createdBy': instance.createdBy,
    };

GroupUserList _$GroupUserListFromJson(Map<String, dynamic> json) =>
    GroupUserList(
      id: json['userId'] as String?,
      name: json['name'] as String?,
      photo: json['PhotoUrl'] as String?,
      connect: json['connected'] as bool?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$GroupUserListToJson(GroupUserList instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'name': instance.name,
      'connected': instance.connect,
      'PhotoUrl': instance.photo,
      'createdBy': instance.createdBy,
    };

GroupList _$GroupListFromJson(Map<String, dynamic> json) => GroupList(
      status: json['status'] as String?,
      msg: json['message'] as String?,
      chatid: json['chatid'] as String?,
      gname: json['groupName'] as String?,
      gphoto: json['groupPhotoUrl'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$GroupListToJson(GroupList instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.msg,
      'chatid': instance.chatid,
      'groupName': instance.gname,
      'groupPhotoUrl': instance.gphoto,
      'createdBy': instance.createdBy,
    };

UserSeenList _$UserSeenListFromJson(Map<String, dynamic> json) => UserSeenList(
      username: json['username'] as String?,
      timestamp: json['timestamp'] as String?,
      messageCount: json['messagesCount'] as String?,
    );

Map<String, dynamic> _$UserSeenListToJson(UserSeenList instance) =>
    <String, dynamic>{
      'username': instance.username,
      'timestamp': instance.timestamp,
      'messagesCount': instance.messageCount,
    };
