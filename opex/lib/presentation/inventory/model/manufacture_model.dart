import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'manufacture_model.g.dart';
@JsonSerializable()
class ManufactureModel extends Equatable {
  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'alternative_email')
  final String? alternativeEmail;
  @JsonKey(name: 'tr_number')
  final int? trNumber;

  @JsonKey(name: 'address')
  final Address? address;
  @JsonKey(name: 'base_uom_data')


  ManufactureModel({this.code, this.name, this.alternativeEmail, this.trNumber, this.address,

    this.id,

  });

  @override
  List<Object> get props => [];

  factory ManufactureModel.fromJson(Map<String, dynamic> json) =>
      _$ManufactureModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManufactureModelToJson(this);
}

@JsonSerializable()
class Address extends Equatable {
  final String? email;
  final String? phone;
  @JsonKey(name: 'building no')
  final String? buildingNo;
  final String? place;



  Address({this.email, this.phone, this.buildingNo, this.place,
  });

  @override
  List<Object> get props => [];

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}