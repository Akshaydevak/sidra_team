import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dummy_user_model.g.dart';

@JsonSerializable()
class DummyFriendList extends Equatable {
  @JsonKey(name: "username")
  final String? userName;
  @JsonKey(name: "userid")
  final String? userId;
  @JsonKey(name: "connected", defaultValue: false)
  final bool? connected;
  const DummyFriendList({this.userName, this.userId, this.connected});
  @override
  List<Object> get props => [];
  factory DummyFriendList.fromJson(Map<String, dynamic> json) =>
      _$DummyFriendListFromJson(json);
  Map<String, dynamic> toJson() => _$DummyFriendListToJson(this);
}

@JsonSerializable()
class MessageFormat extends Equatable {
  @JsonKey(name: "to")
  final String? to;
  @JsonKey(name: "from")
  final String? from;
  @JsonKey(name: "content")
  final String? content;
  const MessageFormat({this.to, this.from, this.content});
  @override
  List<Object> get props => [];
  factory MessageFormat.fromJson(Map<String, dynamic> json) =>
      _$MessageFormatFromJson(json);
  Map<String, dynamic> toJson() => _$MessageFormatToJson(this);
}


// @JsonSerializable()
// class UserDummyList extends Equatable {
//   @JsonKey(name: "id")
//   final String? id;
//   @JsonKey(name: "username")
//   final String? username;
//   @JsonKey(name: "email")
//   final String? email;
//   @JsonKey(name: "photo")
//   final String? photo;
//   const UserDummyList({this.id,this.username, this.email, this.photo});
//   @override
//   List<Object> get props => [];

//   factory UserDummyList.fromJson(Map<String, dynamic> json) =>
//       _$UserDummyListFromJson(json);
//   Map<String, dynamic> toJson() => _$UserDummyListToJson(this);
// }
