// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentTaskModel _$DepartmentTaskModelFromJson(Map<String, dynamic> json) =>
    DepartmentTaskModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      departmentId: json['department_id'] as int?,
      createdOn: json['created_on'] as String?,
      isDelete: json['is_delete'] as bool? ?? false,
    );

Map<String, dynamic> _$DepartmentTaskModelToJson(
        DepartmentTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'created_on': instance.createdOn,
      'department_id': instance.departmentId,
      'is_active': instance.isActive,
      'is_delete': instance.isDelete,
    };
