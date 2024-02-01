import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dummy_user_list_model.g.dart';

@JsonSerializable()
class UserDummyList extends Equatable {
  @JsonKey(name: "userId")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "connected")
  final bool? connect;
  @JsonKey(name: "photoUrl")
  final String? photo;
  @JsonKey(name: "chatId")
  final String? chatid;
  @JsonKey(name: "isGroupChat")
  final bool? isgrp;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "groupname")
  final String? isgrpname;
  @JsonKey(name: "groupId")
  final String? isgrpid;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "latestMessage")
  final String? latestMessage;
  @JsonKey(name: "latestMessageCreatedAt")
  final String? latestMessagecreated;
  @JsonKey(name: "isDeleted")
  final bool? isDeleted;
  @JsonKey(name: "deletedAt")
  final String? deletedAt;
  @JsonKey(name: "createdBy")
  final String? createdBy;
  @JsonKey(name: "unreadMessages")
  final int? unreadMessages;
  const UserDummyList({this.id,this.name,this.connect,this.photo,this.chatid,this.isgrp,this.type,this.isgrpname,this.isgrpid,this.latestMessage,this.latestMessagecreated,this.isDeleted,this.deletedAt,this.createdBy,this.unreadMessages,this.description});
  @override
  List<Object> get props => [];

  factory UserDummyList.fromJson(Map<String, dynamic> json) =>
      _$UserDummyListFromJson(json);
  Map<String, dynamic> toJson () => _$UserDummyListToJson(this);
}

@JsonSerializable()
class GroupUserList extends Equatable {
  @JsonKey(name: "userId")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "connected")
  final bool? connect;
  @JsonKey(name: "PhotoUrl")
  final String? photo;
  @JsonKey(name: "createdBy")
  final String? createdBy;

  const GroupUserList({this.id,this.name,this.photo,this.connect,this.createdBy});
  @override
  List<Object> get props => [];

  factory GroupUserList.fromJson(Map<String, dynamic> json) =>
      _$GroupUserListFromJson(json);
  Map<String, dynamic> toJson () => _$GroupUserListToJson(this);
}

@JsonSerializable()
class GroupList extends Equatable {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? msg;
  @JsonKey(name: "chatid")
  final String? chatid;
  @JsonKey(name: "groupName")
  final String? gname;
  @JsonKey(name: "groupPhotoUrl")
  final String? gphoto;
  @JsonKey(name: "createdBy")
  final String? createdBy;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "addedUsers")
  final List<dynamic>? addedUsers;

  GroupList({this.status,this.msg,this.chatid,this.gname,this.gphoto, this.createdBy,this.description,this.addedUsers});
  @override
  List<Object> get props => [];

  factory GroupList.fromJson(Map<String, dynamic> json) =>
      _$GroupListFromJson(json);
  Map<String, dynamic> toJson () => _$GroupListToJson(this);
}

@JsonSerializable()
class UserSeenList extends Equatable {
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "timestamp")
  final String? timestamp;
  @JsonKey(name: "messagesCount")
  final String? messageCount;


  const UserSeenList({this.username,this.timestamp,this.messageCount});
  @override
  List<Object> get props => [];

  factory UserSeenList.fromJson(Map<String, dynamic> json) =>
      _$UserSeenListFromJson(json);
  Map<String, dynamic> toJson () => _$UserSeenListToJson(this);
}

@JsonSerializable()
class messageSeenList extends Equatable {
  @JsonKey(name: "id")
  final String? userid;
  @JsonKey(name: "username")
  final String? username;

  
  const messageSeenList({this.userid,this.username});
  @override
  List<Object> get props => [];

  factory messageSeenList.fromJson(Map<String, dynamic> json) =>
      _$messageSeenListFromJson(json);
  Map<String, dynamic> toJson () => _$messageSeenListToJson(this);
}