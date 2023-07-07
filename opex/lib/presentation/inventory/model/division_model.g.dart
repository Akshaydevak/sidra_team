// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'division_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DivisionModels _$DivisionModelsFromJson(Map<String, dynamic> json) =>
    DivisionModels(
      description: json['description'] as String?,
      brandIdenUrl: json['brand_identifier_url'] as String?,
      attributeData: json['attribute_data'] == null
          ? null
          : AttributeDataModel.fromJson(
              json['attribute_data'] as Map<String, dynamic>),
      image: json['image'] as String?,
      divisionCode: json['division_code'] as String?,
      conversionFactor: (json['conversion_factor'] as num?)?.toDouble(),
      uomCode: json['uom_code'] as String?,
      statnderdCode: json['standard_code'] as String?,
      uomGroupCode: json['uomgroup_code'] as String?,
      altName: json['alternative_name'] as String?,
      catCode: json['category_code'] as String?,
      shortName: json['short_name'] as String?,
      baseEquvalat: json['base_equivalent'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      searchName: json['search_name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      code: json['code'] as String?,
      parentCode: json['parent_code'] as String?,
      displayName: json['display_name'] as String?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$DivisionModelsToJson(DivisionModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'display_name': instance.displayName,
      'brand_identifier_url': instance.brandIdenUrl,
      'alternative_name': instance.altName,
      'search_name': instance.searchName,
      'image': instance.image,
      'is_active': instance.isActive,
      'priority': instance.priority,
      'base_equivalent': instance.baseEquvalat,
      'uomgroup_code': instance.uomGroupCode,
      'uom_code': instance.uomCode,
      'division_code': instance.divisionCode,
      'short_name': instance.shortName,
      'standard_code': instance.statnderdCode,
      'parent_code': instance.parentCode,
      'category_code': instance.catCode,
      'conversion_factor': instance.conversionFactor,
      'attribute_data': instance.attributeData,
    };

AttributeDataModel _$AttributeDataModelFromJson(Map<String, dynamic> json) =>
    AttributeDataModel(
      description: json['description'] as String?,
      attributeCode: json['attribute_code'] as String?,
      attributeId: json['attribute_id'] as int?,
      lines: (json['lines'] as List<dynamic>?)
          ?.map((e) => AttributeLines.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      attributeName: json['attribute_name'] as String?,
      attributetype: json['attribute_type'] as String?,
    );

Map<String, dynamic> _$AttributeDataModelToJson(AttributeDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'attribute_name': instance.attributeName,
      'attribute_code': instance.attributeCode,
      'attribute_type': instance.attributetype,
      'attribute_id': instance.attributeId,
      'lines': instance.lines,
      'is_active': instance.isActive,
    };

AttributeLines _$AttributeLinesFromJson(Map<String, dynamic> json) =>
    AttributeLines(
      attributeId: json['attribute_id'] as int?,
      values:
          (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
      attributeDataModel: json['attribute_data'] == null
          ? null
          : AttributeDataModel.fromJson(
              json['attribute_data'] as Map<String, dynamic>),
      id: json['id'] as int?,
      attributeName: json['attribute_name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$AttributeLinesToJson(AttributeLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'attribute_id': instance.attributeId,
      'attribute_name': instance.attributeName,
      'attribute_data': instance.attributeDataModel,
      'values': instance.values,
      'is_active': instance.isActive,
    };

ItemReadModel _$ItemReadModelFromJson(Map<String, dynamic> json) =>
    ItemReadModel(
      id: json['id'] as int?,
      itemMeteDataModel: json['item_meta'] == null
          ? null
          : ItemMeteDataModel.fromJson(
              json['item_meta'] as Map<String, dynamic>),
      barcodeDataModel: json['barcode'] == null
          ? null
          : BarcodeDataModel.fromJson(json['barcode'] as Map<String, dynamic>),
      varientFrameworkDataModel: json['variant_framework_data'] == null
          ? null
          : VarientFrameworkDataModel.fromJson(
              json['variant_framework_data'] as Map<String, dynamic>),
      staticGroupDataModel: json['static_group_data'] == null
          ? null
          : StaticGroupDataModel.fromJson(
              json['static_group_data'] as Map<String, dynamic>),
      materialDataModel: json['material_data'] == null
          ? null
          : MaterialDataModel.fromJson(
              json['material_data'] as Map<String, dynamic>),
      brandDataModel: json['brand_data'] == null
          ? null
          : BrandDataModel.fromJson(json['brand_data'] as Map<String, dynamic>),
      groupDataModel: json['group_data'] == null
          ? null
          : GroupDataModel.fromJson(json['group_data'] as Map<String, dynamic>),
      uomGroupDataModel: json['uom_group_data'] == null
          ? null
          : UomGroupDataModel.fromJson(
              json['uom_group_data'] as Map<String, dynamic>),
      uomDataModel: json['uom_data'] == null
          ? null
          : UomDataModel.fromJson(json['uom_data'] as Map<String, dynamic>),
      staticGroupId: json['static_group'] as int?,
      materialId: json['material_id'] as int?,
      brandId: json['brand_id'] as int?,
      groupId: json['group_id'] as int?,
      uomGroupId: json['uom_group'] as int?,
      uomId: json['uom_id'] as int?,
      img1: json['image1'] as String?,
      displayName: json['display_name'] as String?,
      searchName: json['search_name'] as String?,
      name: json['name'] as String?,
      qrImage: json['qrcode_image'] as String?,
      variantFrameworkId: json['variant_framework_id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$ItemReadModelToJson(ItemReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'qrcode_image': instance.qrImage,
      'image1': instance.img1,
      'search_name': instance.searchName,
      'display_name': instance.displayName,
      'uom_data': instance.uomDataModel,
      'uom_group_data': instance.uomGroupDataModel,
      'group_data': instance.groupDataModel,
      'brand_data': instance.brandDataModel,
      'material_data': instance.materialDataModel,
      'static_group_data': instance.staticGroupDataModel,
      'variant_framework_data': instance.varientFrameworkDataModel,
      'barcode': instance.barcodeDataModel,
      'material_id': instance.materialId,
      'uom_group': instance.uomGroupId,
      'uom_id': instance.uomId,
      'group_id': instance.groupId,
      'brand_id': instance.brandId,
      'static_group': instance.staticGroupId,
      'variant_framework_id': instance.variantFrameworkId,
      'item_meta': instance.itemMeteDataModel,
      'is_active': instance.isActive,
    };

UomDataModel _$UomDataModelFromJson(Map<String, dynamic> json) => UomDataModel(
      uomCode: json['uom_code'] as String?,
      uomName: json['uom_name'] as String?,
      name: json['name'] as String?,
      uomId: json['uom_id'] as int?,
    );

Map<String, dynamic> _$UomDataModelToJson(UomDataModel instance) =>
    <String, dynamic>{
      'uom_code': instance.uomCode,
      'name': instance.name,
      'uom_name': instance.uomName,
      'uom_id': instance.uomId,
    };

UomGroupDataModel _$UomGroupDataModelFromJson(Map<String, dynamic> json) =>
    UomGroupDataModel(
      uomGroupCode: json['uom_group_code'] as String?,
      uomGroupId: json['uom_group_id'] as int?,
      uomGroupName: json['uom_group_name'] as String?,
    );

Map<String, dynamic> _$UomGroupDataModelToJson(UomGroupDataModel instance) =>
    <String, dynamic>{
      'uom_group_code': instance.uomGroupCode,
      'uom_group_name': instance.uomGroupName,
      'uom_group_id': instance.uomGroupId,
    };

GroupDataModel _$GroupDataModelFromJson(Map<String, dynamic> json) =>
    GroupDataModel(
      groupCode: json['group_code'] as String?,
      groupId: json['group_id'] as int?,
      groupName: json['group_name'] as String?,
    );

Map<String, dynamic> _$GroupDataModelToJson(GroupDataModel instance) =>
    <String, dynamic>{
      'group_code': instance.groupCode,
      'group_name': instance.groupName,
      'group_id': instance.groupId,
    };

BrandDataModel _$BrandDataModelFromJson(Map<String, dynamic> json) =>
    BrandDataModel(
      brandCode: json['brand_code'] as String?,
      brandName: json['brand_name'] as String?,
      brandId: json['brand_id'] as int?,
    );

Map<String, dynamic> _$BrandDataModelToJson(BrandDataModel instance) =>
    <String, dynamic>{
      'brand_code': instance.brandCode,
      'brand_name': instance.brandName,
      'brand_id': instance.brandId,
    };

MaterialDataModel _$MaterialDataModelFromJson(Map<String, dynamic> json) =>
    MaterialDataModel(
      materialCode: json['material_code'] as String?,
      materailName: json['material_name'] as String?,
      materialId: json['material_id'] as int?,
    );

Map<String, dynamic> _$MaterialDataModelToJson(MaterialDataModel instance) =>
    <String, dynamic>{
      'material_code': instance.materialCode,
      'material_name': instance.materailName,
      'material_id': instance.materialId,
    };

StaticGroupDataModel _$StaticGroupDataModelFromJson(
        Map<String, dynamic> json) =>
    StaticGroupDataModel(
      staticGroupCode: json['static_group_code'] as String?,
      staticGroupId: json['static_group_id'] as int?,
      staticGroupName: json['static_group_name'] as String?,
    );

Map<String, dynamic> _$StaticGroupDataModelToJson(
        StaticGroupDataModel instance) =>
    <String, dynamic>{
      'static_group_code': instance.staticGroupCode,
      'static_group_name': instance.staticGroupName,
      'static_group_id': instance.staticGroupId,
    };

VarientFrameworkDataModel _$VarientFrameworkDataModelFromJson(
        Map<String, dynamic> json) =>
    VarientFrameworkDataModel(
      variantFrameCode: json['variant_framework_code'] as String?,
      variantFrameId: json['variant_framework_id'] as int?,
      variantFrameName: json['variant_framework_name'] as String?,
    );

Map<String, dynamic> _$VarientFrameworkDataModelToJson(
        VarientFrameworkDataModel instance) =>
    <String, dynamic>{
      'variant_framework_code': instance.variantFrameCode,
      'variant_framework_name': instance.variantFrameName,
      'variant_framework_id': instance.variantFrameId,
    };

BarcodeDataModel _$BarcodeDataModelFromJson(Map<String, dynamic> json) =>
    BarcodeDataModel(
      fileName: json['file_name'] as String?,
      barcodeNumber: json['barcode_number'] as String?,
    );

Map<String, dynamic> _$BarcodeDataModelToJson(BarcodeDataModel instance) =>
    <String, dynamic>{
      'file_name': instance.fileName,
      'barcode_number': instance.barcodeNumber,
    };

ItemMeteDataModel _$ItemMeteDataModelFromJson(Map<String, dynamic> json) =>
    ItemMeteDataModel(
      oldSystemCode: json['old_system_code'] as String?,
      img3: json['image3'] as String?,
      img2: json['image2'] as String?,
      description: json['description'] as String?,
      cat1: json['item_cataloge1'] as String?,
      cat2: json['item_cataloge2'] as String?,
      cat3: json['item_cataloge3'] as String?,
      cat4: json['item_cataloge4'] as String?,
      cat5: json['item_cataloge5'] as String?,
    );

Map<String, dynamic> _$ItemMeteDataModelToJson(ItemMeteDataModel instance) =>
    <String, dynamic>{
      'image2': instance.img2,
      'image3': instance.img3,
      'description': instance.description,
      'item_cataloge1': instance.cat1,
      'item_cataloge2': instance.cat2,
      'item_cataloge3': instance.cat3,
      'item_cataloge4': instance.cat4,
      'item_cataloge5': instance.cat5,
      'old_system_code': instance.oldSystemCode,
    };

DivisionConfigRead _$DivisionConfigReadFromJson(Map<String, dynamic> json) =>
    DivisionConfigRead(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      configurationMete: json['configuration_meta'] == null
          ? null
          : ConfigurationMete.fromJson(
              json['configuration_meta'] as Map<String, dynamic>),
      isMixed: json['is_mixed'] as bool? ?? false,
      image: json['image'] as String?,
      code: json['code'] as String?,
      priority: json['priority'] as int?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      isSalesBlock: json['is_sales_blocked'] as bool? ?? false,
      categoryNameData: (json['category_name'] as List<dynamic>?)
          ?.map((e) => ItemReadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      colorCpode: json['color_code'] as String?,
      groupData: (json['group_name'] as List<dynamic>?)
          ?.map((e) => ItemReadModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      segmentAvailableType: json['segment_available_type'] as String?,
      uomNameData: (json['uom_name'] as List<dynamic>?)
          ?.map((e) => UomDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DivisionConfigReadToJson(DivisionConfigRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'group_name': instance.groupData,
      'uom_name': instance.uomNameData,
      'category_name': instance.categoryNameData,
      'image': instance.image,
      'description': instance.description,
      'color_code': instance.colorCpode,
      'segment_available_type': instance.segmentAvailableType,
      'priority': instance.priority,
      'created_at': instance.createdAt,
      'configuration_meta': instance.configurationMete,
      'is_active': instance.isActive,
      'is_sales_blocked': instance.isSalesBlock,
      'is_mixed': instance.isMixed,
    };

ConfigurationMete _$ConfigurationMeteFromJson(Map<String, dynamic> json) =>
    ConfigurationMete(
      includeData: json['include'] == null
          ? null
          : IncludeData.fromJson(json['include'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigurationMeteToJson(ConfigurationMete instance) =>
    <String, dynamic>{
      'include': instance.includeData,
    };

IncludeData _$IncludeDataFromJson(Map<String, dynamic> json) => IncludeData(
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      group:
          (json['group'] as List<dynamic>?)?.map((e) => e as String).toList(),
      uomData:
          (json['uom'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IncludeDataToJson(IncludeData instance) =>
    <String, dynamic>{
      'uom': instance.uomData,
      'group': instance.group,
      'category': instance.category,
    };

CreateWarrantyModel _$CreateWarrantyModelFromJson(Map<String, dynamic> json) =>
    CreateWarrantyModel(
      variantCode: json['variant_code'] as String?,
      variantId: json['variant_id'] as int?,
      warrantyDetailsModel: (json['warranty_details'] as List<dynamic>?)
          ?.map((e) => WarrantyDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateWarrantyModelToJson(
        CreateWarrantyModel instance) =>
    <String, dynamic>{
      'variant_id': instance.variantId,
      'variant_code': instance.variantCode,
      'warranty_details': instance.warrantyDetailsModel,
    };

WarrantyDetailsModel _$WarrantyDetailsModelFromJson(
        Map<String, dynamic> json) =>
    WarrantyDetailsModel(
      id: json['id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      conditionList: (json['conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalWarrantyDetails: (json['additional_warranty_details']
              as List<dynamic>?)
          ?.map((e) => WarrantyDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int?,
      exConditionList: (json['ex_conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      exdescription: json['ex_description'] as String?,
      exDuration: json['ex_duration'] as int?,
      exIsActive: json['ex_is_active'] as bool?,
      isAdditionalWarranty: json['is_additional_warranty'] as bool? ?? false,
      isExtendedWarraty: json['is_extended_warranty'] as bool?,
      maximumOccurence: (json['maximum_occurence'] as num?)?.toDouble(),
      warrantyTypeId: json['warranty_type_id'] as int?,
      warrantySection: json['warranty_section'] as String?,
    );

Map<String, dynamic> _$WarrantyDetailsModelToJson(
        WarrantyDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warranty_type_id': instance.warrantyTypeId,
      'duration': instance.duration,
      'description': instance.description,
      'warranty_section': instance.warrantySection,
      'is_active': instance.isActive,
      'conditions': instance.conditionList,
      'is_additional_warranty': instance.isAdditionalWarranty,
      'additional_warranty_details': instance.additionalWarrantyDetails,
      'is_extended_warranty': instance.isExtendedWarraty,
      'ex_duration': instance.exDuration,
      'ex_description': instance.exdescription,
      'ex_is_active': instance.exIsActive,
      'price': instance.price,
      'maximum_occurence': instance.maximumOccurence,
      'ex_conditions': instance.exConditionList,
    };

ConditionList _$ConditionListFromJson(Map<String, dynamic> json) =>
    ConditionList(
      isActive: json['is_active'] as bool? ?? false,
      id: json['id'] as int?,
      title: json['title'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ConditionListToJson(ConditionList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'title': instance.title,
      'is_active': instance.isActive,
    };

WarrantyReadModel _$WarrantyReadModelFromJson(Map<String, dynamic> json) =>
    WarrantyReadModel(
      isActive: json['is_active'] as bool? ?? false,
      id: json['id'] as int?,
      warrantyCode: json['warranty_code'] as String?,
      description: json['description'] as String?,
      warrantyTypeId: json['warranty_type_id'] as int?,
      warrantyTypeCode: json['warranty_type_code'] as String?,
      warrantyTypeName: json['warranty_type_name'] as String?,
      additionalWarranty: (json['additional_warranty'] as List<dynamic>?)
          ?.map(
              (e) => AdditionalWarrantyList.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int?,
      extentedWarrantyList: json['extended_warranty'] == null
          ? null
          : ExtendedWarrantyList.fromJson(
              json['extended_warranty'] as Map<String, dynamic>),
      isAdditionalWarranty: json['is_additional_warranty'] as bool? ?? false,
      isExtendedWarranty: json['is_extended_warranty'] as bool? ?? false,
      warrantyCoditions: (json['warranty_conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WarrantyReadModelToJson(WarrantyReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warranty_type_code': instance.warrantyTypeCode,
      'warranty_type_name': instance.warrantyTypeName,
      'warranty_conditions': instance.warrantyCoditions,
      'additional_warranty': instance.additionalWarranty,
      'extended_warranty': instance.extentedWarrantyList,
      'warranty_code': instance.warrantyCode,
      'duration': instance.duration,
      'description': instance.description,
      'is_extended_warranty': instance.isExtendedWarranty,
      'is_additional_warranty': instance.isAdditionalWarranty,
      'warranty_type_id': instance.warrantyTypeId,
      'is_active': instance.isActive,
    };

AdditionalWarrantyList _$AdditionalWarrantyListFromJson(
        Map<String, dynamic> json) =>
    AdditionalWarrantyList(
      isActive: json['is_active'] as bool? ?? false,
      id: json['id'] as int?,
      warrantySection: json['warranty_section'] as String?,
      description: json['description'] as String?,
      addWarantyCode: json['additional_warranty_code'] as String?,
      condition: (json['addtional_warranty_conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEnabled: json['is_enabled'] as bool? ?? false,
      maxOccurance: json['maximum_occurence'] as int?,
      duration: json['duration'] as int?,
    );

Map<String, dynamic> _$AdditionalWarrantyListToJson(
        AdditionalWarrantyList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addtional_warranty_conditions': instance.condition,
      'additional_warranty_code': instance.addWarantyCode,
      'warranty_section': instance.warrantySection,
      'duration': instance.duration,
      'description': instance.description,
      'maximum_occurence': instance.maxOccurance,
      'is_active': instance.isActive,
      'is_enabled': instance.isEnabled,
    };

ExtendedWarrantyList _$ExtendedWarrantyListFromJson(
        Map<String, dynamic> json) =>
    ExtendedWarrantyList(
      isActive: json['is_active'] as bool? ?? false,
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      extWarantyCode: json['extended_warranty_code'] as String?,
      condition: (json['extended_warranty_conditions'] as List<dynamic>?)
          ?.map((e) => ConditionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEnabled: json['is_enabled'] as bool? ?? false,
      maxOccurance: json['maximum_occurence'] as int?,
      duration: json['duration'] as int?,
    );

Map<String, dynamic> _$ExtendedWarrantyListToJson(
        ExtendedWarrantyList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'extended_warranty_conditions': instance.condition,
      'extended_warranty_code': instance.extWarantyCode,
      'price': instance.price,
      'duration': instance.duration,
      'description': instance.description,
      'maximum_occurence': instance.maxOccurance,
      'is_active': instance.isActive,
      'is_enabled': instance.isEnabled,
    };
