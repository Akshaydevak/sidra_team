import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'division_model.g.dart';

@JsonSerializable()
class DivisionModels extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final String? description;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'brand_identifier_url')
  final String? brandIdenUrl;
  @JsonKey(name: 'alternative_name')
  final String? altName;
  @JsonKey(name: 'search_name')
  final String? searchName;
  @JsonKey(name: 'image')
  final String? image;
@JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
@JsonKey(name: 'priority')
  final int? priority;
  @JsonKey(name: 'base_equivalent')
  final String? baseEquvalat;
  @JsonKey(name: 'uomgroup_code')
  final String? uomGroupCode;
  @JsonKey(name: 'uom_code')
  final String? uomCode;
  @JsonKey(name: 'division_code')
  final String? divisionCode;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'standard_code')
  final String? statnderdCode;
  @JsonKey(name: 'parent_code')
  final String? parentCode;
  @JsonKey(name: 'category_code')
  final String? catCode;
  @JsonKey(name: 'conversion_factor')
  final double? conversionFactor;
  @JsonKey(name: 'attribute_data')
  final AttributeDataModel? attributeData;




  DivisionModels( {
    this.description,
    this.brandIdenUrl,
    this.attributeData,
    this.image,
    this.divisionCode,
    this.conversionFactor,
    this.uomCode,
    this.statnderdCode,
    this.uomGroupCode,
    this.altName,
    this.catCode,
    this.shortName,
    this.baseEquvalat,
    this.id,
    this.name,
    this.searchName,
    this.isActive,
    this.code,
    this.parentCode,
    this.displayName,
    this.priority,
  });

  @override
  List<Object> get props => [];

  factory DivisionModels.fromJson(Map<String, dynamic> json) =>
      _$DivisionModelsFromJson(json);

  Map<String, dynamic> toJson() => _$DivisionModelsToJson(this);
}


@JsonSerializable()
class AttributeDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final String? description;
  @JsonKey(name: 'attribute_name')
  final String? attributeName;
  @JsonKey(name: 'attribute_code')
  final String? attributeCode;
  @JsonKey(name: 'attribute_type')
  final String? attributetype;
  @JsonKey(name: 'attribute_id')
  final int? attributeId;
  @JsonKey(name: 'lines')
  final List<AttributeLines>? lines;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  AttributeDataModel( {
    this.description,
    this.attributeCode,
    this.attributeId,
    this.lines,
    this.id,
    this.name,
    this.code,
    this.isActive,
    this.attributeName,
    this.attributetype,

  });

  @override
  List<Object> get props => [];

  factory AttributeDataModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeDataModelToJson(this);
}

@JsonSerializable()
class AttributeLines extends Equatable {
  final int? id;
  final String? code;
  @JsonKey(name: 'attribute_id')
  final int? attributeId;
  @JsonKey(name: 'attribute_name')
  final String? attributeName;
  @JsonKey(name: 'attribute_data')
  final AttributeDataModel? attributeDataModel;
  @JsonKey(name: 'values')
  final List<String>? values;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  AttributeLines( {
    this.attributeId,
    this.values,
    this.attributeDataModel,
    this.id,
    this.attributeName,
    this.isActive,
    this.code,
  });

  @override
  List<Object> get props => [];

  factory AttributeLines.fromJson(Map<String, dynamic> json) =>
      _$AttributeLinesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeLinesToJson(this);
}


@JsonSerializable()
class ItemReadModel extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  @JsonKey(name: 'qrcode_image')
  final String? qrImage;
  @JsonKey(name: 'image1')
  final String? img1;
  @JsonKey(name: 'search_name')
  final String? searchName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'uom_data')
  final UomDataModel? uomDataModel;
  @JsonKey(name: 'uom_group_data')
  final UomGroupDataModel? uomGroupDataModel;
  @JsonKey(name: 'group_data')
  final GroupDataModel? groupDataModel;
  @JsonKey(name: 'brand_data')
  final BrandDataModel? brandDataModel;
  @JsonKey(name: 'material_data')
  final MaterialDataModel? materialDataModel;
  @JsonKey(name: 'static_group_data')
  final StaticGroupDataModel? staticGroupDataModel;
  @JsonKey(name: 'variant_framework_data')
  final VarientFrameworkDataModel? varientFrameworkDataModel;
  @JsonKey(name: 'barcode')
  final BarcodeDataModel? barcodeDataModel;
  @JsonKey(name: 'material_id')
  final int? materialId;
  @JsonKey(name: 'uom_group')
  final int? uomGroupId;
  @JsonKey(name: 'uom_id')
  final int? uomId;
  @JsonKey(name: 'group_id')
  final int? groupId;
  @JsonKey(name: 'brand_id')
  final int? brandId;
  @JsonKey(name: 'static_group')
  final int? staticGroupId;
  @JsonKey(name: 'variant_framework_id')
  final int? variantFrameworkId;
  @JsonKey(name: 'item_meta')
  final ItemMeteDataModel? itemMeteDataModel;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  ItemReadModel( {
    this.id,
    this.itemMeteDataModel,
    this.barcodeDataModel,
    this.varientFrameworkDataModel,
    this.staticGroupDataModel,
    this.materialDataModel,
    this.brandDataModel,
    this.groupDataModel,
    this.uomGroupDataModel,
    this.uomDataModel,
    this.staticGroupId,
    this.materialId,
    this.brandId,
    this.groupId,
    this.uomGroupId,
    this.uomId,
    this.img1,
    this.displayName,
    this.searchName,
    this.name,
    this.qrImage,
    this.variantFrameworkId,
    this.isActive,
    this.code,
  });

  @override
  List<Object> get props => [];

  factory ItemReadModel.fromJson(Map<String, dynamic> json) =>
      _$ItemReadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemReadModelToJson(this);
}


//uomData

@JsonSerializable()
class UomDataModel extends Equatable {

  @JsonKey(name: 'uom_code')
  final String? uomCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'uom_name')
  final String? uomName;
  @JsonKey(name: 'uom_id')
  final int? uomId;
  UomDataModel( {
    this.uomCode,
    this.uomName,
    this.name,
    this.uomId,
  });

  @override
  List<Object> get props => [];

  factory UomDataModel.fromJson(Map<String, dynamic> json) =>
      _$UomDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomDataModelToJson(this);
}

//uomGroupData
@JsonSerializable()
class UomGroupDataModel extends Equatable {

  @JsonKey(name: 'uom_group_code')
  final String? uomGroupCode;
  @JsonKey(name: 'uom_group_name')
  final String? uomGroupName;
  @JsonKey(name: 'uom_group_id')
  final int? uomGroupId;
  UomGroupDataModel( {
    this.uomGroupCode,
    this.uomGroupId,
    this.uomGroupName,
  });

  @override
  List<Object> get props => [];

  factory UomGroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$UomGroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomGroupDataModelToJson(this);
}

//groupData
@JsonSerializable()
class GroupDataModel extends Equatable {

  @JsonKey(name: 'group_code')
  final String? groupCode;
  @JsonKey(name: 'group_name')
  final String? groupName;
  @JsonKey(name: 'group_id')
  final int? groupId;
  GroupDataModel( {
    this.groupCode,
    this.groupId,
    this.groupName,
  });

  @override
  List<Object> get props => [];

  factory GroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataModelToJson(this);
}

//brandData
@JsonSerializable()
class BrandDataModel extends Equatable {

  @JsonKey(name: 'brand_code')
  final String? brandCode;
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @JsonKey(name: 'brand_id')
  final int? brandId;
  BrandDataModel( {
    this.brandCode,
    this.brandName,
    this.brandId,
  });

  @override
  List<Object> get props => [];

  factory BrandDataModel.fromJson(Map<String, dynamic> json) =>
      _$BrandDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDataModelToJson(this);
}

//materialData
@JsonSerializable()
class MaterialDataModel extends Equatable {

  @JsonKey(name: 'material_code')
  final String? materialCode;
  @JsonKey(name: 'material_name')
  final String? materailName;
  @JsonKey(name: 'material_id')
  final int? materialId;
  MaterialDataModel( {
    this.materialCode,
    this.materailName,
    this.materialId,
  });

  @override
  List<Object> get props => [];

  factory MaterialDataModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialDataModelToJson(this);
}

//staticG
@JsonSerializable()
class StaticGroupDataModel extends Equatable {

  @JsonKey(name: 'static_group_code')
  final String? staticGroupCode;
  @JsonKey(name: 'static_group_name')
  final String? staticGroupName;
  @JsonKey(name: 'static_group_id')
  final int? staticGroupId;
  StaticGroupDataModel( {
    this.staticGroupCode,
    this.staticGroupId,
    this.staticGroupName,
  });

  @override
  List<Object> get props => [];

  factory StaticGroupDataModel.fromJson(Map<String, dynamic> json) =>
      _$StaticGroupDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StaticGroupDataModelToJson(this);
}

//variantFrame
@JsonSerializable()
class VarientFrameworkDataModel extends Equatable {

  @JsonKey(name: 'variant_framework_code')
  final String? variantFrameCode;
  @JsonKey(name: 'variant_framework_name')
  final String? variantFrameName;
  @JsonKey(name: 'variant_framework_id')
  final int? variantFrameId;
  VarientFrameworkDataModel( {
    this.variantFrameCode,
    this.variantFrameId,
    this.variantFrameName,
  });

  @override
  List<Object> get props => [];

  factory VarientFrameworkDataModel.fromJson(Map<String, dynamic> json) =>
      _$VarientFrameworkDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$VarientFrameworkDataModelToJson(this);
}

//barCode
@JsonSerializable()
class BarcodeDataModel extends Equatable {

  @JsonKey(name: 'file_name')
  final String? fileName;
  @JsonKey(name: 'barcode_number')
  final String? barcodeNumber;

  BarcodeDataModel( {
    this.fileName,
    this.barcodeNumber,
  });

  @override
  List<Object> get props => [];

  factory BarcodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$BarcodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeDataModelToJson(this);
}

//itmmeta
@JsonSerializable()
class ItemMeteDataModel extends Equatable {

  @JsonKey(name: 'image2')
  final String? img2;
  @JsonKey(name: 'image3')
  final String? img3;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'item_cataloge1')
  final String? cat1;
  @JsonKey(name: 'item_cataloge2')
  final String? cat2;
  @JsonKey(name: 'item_cataloge3')
  final String? cat3;
  @JsonKey(name: 'item_cataloge4')
  final String? cat4;
  @JsonKey(name: 'item_cataloge5')
  final String? cat5;
  @JsonKey(name: 'old_system_code')
  final String? oldSystemCode;

  ItemMeteDataModel( {
    this.oldSystemCode,
    this.img3,
    this.img2,
    this.description,
    this.cat1,
    this.cat2,
    this.cat3,
    this.cat4,
    this.cat5,
  });

  @override
  List<Object> get props => [];

  factory ItemMeteDataModel.fromJson(Map<String, dynamic> json) =>
      _$ItemMeteDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemMeteDataModelToJson(this);
}

//div Confoig
@JsonSerializable()
class DivisionConfigRead extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  @JsonKey(name: 'group_name')
  final List<ItemReadModel>? groupData;
  @JsonKey(name: 'uom_name')
  final List<UomDataModel>? uomNameData;
  @JsonKey(name: 'category_name')
  final List<ItemReadModel>? categoryNameData;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'color_code')
  final String? colorCpode;
  @JsonKey(name: 'segment_available_type')
  final String? segmentAvailableType;
  @JsonKey(name: 'priority')
  final int? priority;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'configuration_meta')
  final ConfigurationMete? configurationMete;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_sales_blocked',defaultValue: false)
  final bool? isSalesBlock;
  @JsonKey(name: 'is_mixed',defaultValue: false)
  final bool? isMixed;
  DivisionConfigRead( {
    this.id,
    this.name,
    this.isActive,
    this.configurationMete,
    this.isMixed,
    this.image,
    this.code,
    this.priority,
    this.description,
    this.createdAt,
    this.isSalesBlock,
    this.categoryNameData,
    this.colorCpode,
    this.groupData,
    this.segmentAvailableType,
    this.uomNameData,
  });

  @override
  List<Object> get props => [];

  factory DivisionConfigRead.fromJson(Map<String, dynamic> json) =>
      _$DivisionConfigReadFromJson(json);

  Map<String, dynamic> toJson() => _$DivisionConfigReadToJson(this);
}

//
@JsonSerializable()
class ConfigurationMete extends Equatable {

  @JsonKey(name: 'include')
  final IncludeData? includeData;
  ConfigurationMete( {
    this.includeData,
  });

  @override
  List<Object> get props => [];

  factory ConfigurationMete.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationMeteFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationMeteToJson(this);
}

//
@JsonSerializable()
class IncludeData extends Equatable {

  @JsonKey(name: 'uom')
  final List<String>? uomData;
  @JsonKey(name: 'group')
  final List<String>? group;
  @JsonKey(name: 'category')
  final List<String>? category;
  IncludeData( {
    this.category,
    this.group,
    this.uomData,
  });

  @override
  List<Object> get props => [];

  factory IncludeData.fromJson(Map<String, dynamic> json) =>
      _$IncludeDataFromJson(json);

  Map<String, dynamic> toJson() => _$IncludeDataToJson(this);
}


//warranty
@JsonSerializable()
class CreateWarrantyModel extends Equatable {

  @JsonKey(name: 'variant_id')
  final int? variantId;
  @JsonKey(name: 'variant_code')
  final String? variantCode;
  @JsonKey(name: 'warranty_details')
  final List<WarrantyDetailsModel>? warrantyDetailsModel;
  CreateWarrantyModel( {
    this.variantCode,
    this.variantId,
    this.warrantyDetailsModel,
  });

  @override
  List<Object> get props => [];

  factory CreateWarrantyModel.fromJson(Map<String, dynamic> json) =>
      _$CreateWarrantyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWarrantyModelToJson(this);
}


@JsonSerializable()
class WarrantyDetailsModel extends Equatable {

  final int? id;
  @JsonKey(name: 'warranty_type_id')
  final int? warrantyTypeId;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'warranty_section')
  final String? warrantySection;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'conditions')
  final List<ConditionList>? conditionList;
  @JsonKey(name: 'is_additional_warranty',defaultValue: false)
  final bool? isAdditionalWarranty;
  @JsonKey(name: 'additional_warranty_details')
  final List<WarrantyDetailsModel>? additionalWarrantyDetails;
  @JsonKey(name: 'is_extended_warranty')
  final bool? isExtendedWarraty;
  @JsonKey(name: 'ex_duration')
  final int? exDuration;
  @JsonKey(name: 'ex_description')
  final String? exdescription;
  @JsonKey(name: 'ex_is_active')
  final bool? exIsActive;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'maximum_occurence')
  final double? maximumOccurence;
  @JsonKey(name: 'ex_conditions')
  final List<ConditionList>? exConditionList;
  WarrantyDetailsModel( {
    this.id,
    this.isActive,
    this.description,
    this.price,
    this.conditionList,
    this.additionalWarrantyDetails,
    this.duration,
    this.exConditionList,
    this.exdescription,
    this.exDuration,
    this.exIsActive,
    this.isAdditionalWarranty,
    this.isExtendedWarraty,
    this.maximumOccurence,
    this.warrantyTypeId,
    this.warrantySection,
  });

  @override
  List<Object> get props => [];

  factory WarrantyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$WarrantyDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantyDetailsModelToJson(this);
}

@JsonSerializable()
class ConditionList extends Equatable {

  final int? id;
  @JsonKey(name: 'data')
  final String? data;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  ConditionList( {
    this.isActive,
    this.id,
    this.title,
    this.data,
  });

  @override
  List<Object> get props => [];

  factory ConditionList.fromJson(Map<String, dynamic> json) =>
      _$ConditionListFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionListToJson(this);
}


//readWarranty
@JsonSerializable()
class WarrantyReadModel extends Equatable {

  final int? id;
  @JsonKey(name: 'warranty_type_code')
  final String? warrantyTypeCode;
  @JsonKey(name: 'warranty_type_name')
  final String? warrantyTypeName;
  @JsonKey(name: 'warranty_conditions')
  final List<ConditionList>? warrantyCoditions;
  @JsonKey(name: 'additional_warranty')
  final List<AdditionalWarrantyList>? additionalWarranty;
  @JsonKey(name: 'extended_warranty')
  final ExtendedWarrantyList? extentedWarrantyList;
  @JsonKey(name: 'warranty_code')
  final String? warrantyCode;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_extended_warranty',defaultValue: false)
  final bool? isExtendedWarranty;
  @JsonKey(name: 'is_additional_warranty',defaultValue: false)
  final bool? isAdditionalWarranty;
  @JsonKey(name: 'warranty_type_id')
  final int? warrantyTypeId;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  WarrantyReadModel( {
    this.isActive,
    this.id,
    this.warrantyCode,
    this.description,
    this.warrantyTypeId,
    this.warrantyTypeCode,
    this.warrantyTypeName,
    this.additionalWarranty,
    this.duration,
    this.extentedWarrantyList,
    this.isAdditionalWarranty ,
    this.isExtendedWarranty,
    this.warrantyCoditions,
  });

  @override
  List<Object> get props => [];

  factory WarrantyReadModel.fromJson(Map<String, dynamic> json) =>
      _$WarrantyReadModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantyReadModelToJson(this);
}


//
@JsonSerializable()
class AdditionalWarrantyList extends Equatable {

  final int? id;
  @JsonKey(name: 'addtional_warranty_conditions')
  final List<ConditionList>? condition;
  @JsonKey(name: 'additional_warranty_code')
  final String? addWarantyCode;
  @JsonKey(name: 'warranty_section')
  final String? warrantySection;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'maximum_occurence')
  final int? maxOccurance;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_enabled',defaultValue: false)
  final bool? isEnabled;
  AdditionalWarrantyList( {
    this.isActive,
    this.id,
    this.warrantySection,
    this.description,
    this.addWarantyCode,
    this.condition,
    this.isEnabled,
    this.maxOccurance,
    this.duration,
  });

  @override
  List<Object> get props => [];

  factory AdditionalWarrantyList.fromJson(Map<String, dynamic> json) =>
      _$AdditionalWarrantyListFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalWarrantyListToJson(this);
}


@JsonSerializable()
class ExtendedWarrantyList extends Equatable {

  final int? id;
  @JsonKey(name: 'extended_warranty_conditions')
  final List<ConditionList>? condition;
  @JsonKey(name: 'extended_warranty_code')
  final String? extWarantyCode;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'maximum_occurence')
  final int? maxOccurance;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'is_enabled',defaultValue: false)
  final bool? isEnabled;
  ExtendedWarrantyList( {
    this.isActive,
    this.id,
    this.price,
    this.description,
    this.extWarantyCode,
    this.condition,
    this.isEnabled,
    this.maxOccurance,
    this.duration,
  });

  @override
  List<Object> get props => [];

  factory ExtendedWarrantyList.fromJson(Map<String, dynamic> json) =>
      _$ExtendedWarrantyListFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedWarrantyListToJson(this);
}
