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
      unreadMessages: json['unreadMessages'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UserDummyListToJson(UserDummyList instance) =>
    <String, dynamic>{
      'userId': instance.id,
      'name': instance.name,
      'connected': instance.connect,
      'photoUrl': instance.photo,
      'chatId': instance.chatid,
      'isGroupChat': instance.isgrp,
      'type': instance.type,
      'groupname': instance.isgrpname,
      'groupId': instance.isgrpid,
      'description': instance.description,
      'latestMessage': instance.latestMessage,
      'latestMessageCreatedAt': instance.latestMessagecreated,
      'isDeleted': instance.isDeleted,
      'deletedAt': instance.deletedAt,
      'createdBy': instance.createdBy,
      'unreadMessages': instance.unreadMessages,
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
      description: json['description'] as String?,
      addedUsers: json['addedUsers'] as List<dynamic>?,
    );

Map<String, dynamic> _$GroupListToJson(GroupList instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.msg,
      'chatid': instance.chatid,
      'groupName': instance.gname,
      'groupPhotoUrl': instance.gphoto,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'addedUsers': instance.addedUsers,
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

messageSeenList _$messageSeenListFromJson(Map<String, dynamic> json) =>
    messageSeenList(
      userid: json['id'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$messageSeenListToJson(messageSeenList instance) =>
    <String, dynamic>{
      'id': instance.userid,
      'username': instance.username,
    };
