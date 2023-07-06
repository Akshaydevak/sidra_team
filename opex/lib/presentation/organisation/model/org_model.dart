import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_model.g.dart';

@JsonSerializable()
class OrgModel extends Equatable {
  int? id;
  @JsonKey(name: 'entity_code')
  String? entityCode;
  String? name;
  @JsonKey(name: 'search_name')
  String? searchName;
  @JsonKey(name: 'display_name')
  String? displayName;
  String? description;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'legal_address')
  int? legalAddress;
  // String? category;
  @JsonKey(name: 'address_one')
  String? addressOne;
  @JsonKey(name: 'address_two')
  String? addressTwo;
  String? location;
  @JsonKey(name: 'city_or_town')
  String? cityOrTown;
  String? pin;
  @JsonKey(name: 'land_mark')
  String? landMark;
  String? state;
  String? country;
  // Null? addressTypeId;
  Contact? contact;
  bool? status;
  String? email;


  OrgModel({this.id,
    this.entityCode,
    this.name,
    this.searchName,
    this.displayName,
    this.description,
    this.isActive,
    this.legalAddress,
    // this.category,
    this.addressOne,
    this.addressTwo,
    this.location,
    this.cityOrTown,
    this.pin,
    this.landMark,
    this.state,
    this.country,

    this.contact,
    this.status,
    this.email});

  @override
  List<Object> get props => [];

  factory OrgModel.fromJson(Map<String, dynamic> json) =>
      _$OrgModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrgModelToJson(this);
}
@JsonSerializable()
class Contact {
  String? primary;

  Contact({this.primary});
  @override
  List<Object> get props => [];

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}