import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dummy_user_list_model.g.dart';

@JsonSerializable()
class UserDummyList extends Equatable {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "photo")
  final String? photo;
  const UserDummyList({this.id,this.username,this.email,this.photo});
  @override
  List<Object> get props => [];

  factory UserDummyList.fromJson(Map<String, dynamic> json) =>
      _$UserDummyListFromJson(json);
  Map<String, dynamic> toJson () => _$UserDummyListToJson(this);
}

