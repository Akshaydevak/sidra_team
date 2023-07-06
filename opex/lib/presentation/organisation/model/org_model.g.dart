// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgModel _$OrgModelFromJson(Map<String, dynamic> json) => OrgModel(
      id: json['id'] as int?,
      entityCode: json['entity_code'] as String?,
      name: json['name'] as String?,
      searchName: json['search_name'] as String?,
      displayName: json['display_name'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      legalAddress: json['legal_address'] as int?,
      addressOne: json['address_one'] as String?,
      addressTwo: json['address_two'] as String?,
      location: json['location'] as String?,
      cityOrTown: json['city_or_town'] as String?,
      pin: json['pin'] as String?,
      landMark: json['land_mark'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$OrgModelToJson(OrgModel instance) => <String, dynamic>{
      'id': instance.id,
      'entity_code': instance.entityCode,
      'name': instance.name,
      'search_name': instance.searchName,
      'display_name': instance.displayName,
      'description': instance.description,
      'is_active': instance.isActive,
      'legal_address': instance.legalAddress,
      'address_one': instance.addressOne,
      'address_two': instance.addressTwo,
      'location': instance.location,
      'city_or_town': instance.cityOrTown,
      'pin': instance.pin,
      'land_mark': instance.landMark,
      'state': instance.state,
      'country': instance.country,
      'contact': instance.contact,
      'status': instance.status,
      'email': instance.email,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      primary: json['primary'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'primary': instance.primary,
    };
