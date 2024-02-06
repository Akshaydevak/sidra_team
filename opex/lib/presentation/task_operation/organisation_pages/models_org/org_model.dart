import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_model.g.dart';

@JsonSerializable()
class DepartmentTaskModel extends Equatable {

  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @JsonKey(name: 'department_id')
  final int? departmentId;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_delete',defaultValue: false)
  final bool? isDelete;



  const DepartmentTaskModel( {
    this.id, this.name,this.code,
    this.isActive,
    this.departmentId,
    this.createdOn,
    this.isDelete,
  });
  @override
  List<Object> get props => [];
  factory DepartmentTaskModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentTaskModelToJson(this);
}