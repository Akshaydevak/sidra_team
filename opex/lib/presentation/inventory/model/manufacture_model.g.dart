// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manufacture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManufactureModel _$ManufactureModelFromJson(Map<String, dynamic> json) =>
    ManufactureModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      alternativeEmail: json['alternative_email'] as String?,
      trNumber: json['tr_number'] as int?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ManufactureModelToJson(ManufactureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'alternative_email': instance.alternativeEmail,
      'tr_number': instance.trNumber,
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      buildingNo: json['building no'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'building no': instance.buildingNo,
      'place': instance.place,
    };
