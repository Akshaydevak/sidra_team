// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVariantModel _$CreateVariantModelFromJson(Map<String, dynamic> json) =>
    CreateVariantModel(
      oldSystemCode: json['old_system_code'] as String?,
      isActive: json['is_active'] as bool?,
      variantName: json['variant_name'] as String?,
      usageDirection: json['usage_direction'] == null
          ? null
          : ProductDetails.fromJson(
              json['usage_direction'] as Map<String, dynamic>),
      replacementType: json['replacement_type'] as String?,
      replacementTime: json['replacement_time'] as String?,
      itemId: json['item_id'] as int?,
      inventoryId: json['inventory_id'] as String?,
      inventoryName: json['inventory_name'] as String?,
      channelCode: json['channel_code'] as String?,
      variantValue: (json['variant_value'] as List<dynamic>?)
          ?.map((e) => VarintValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      barcode: json['barcode'] as String?,
      searchName: json['search_name'] as String?,
      displayName: json['display_name'] as String?,
      description: json['description'] as String?,
      salesUom: json['sales_uom'] as int?,
      producedCountry: json['produced_country'] as String?,
      image1: json['image1'] as int?,
      image2: json['image2'] as int?,
      image3: json['image3'] as int?,
      image4: json['image4'] as int?,
      image5: json['image5'] as int?,
      catalog1: json['catalog1'] as int?,
      catalog2: json['catalog2'] as int?,
      catalog3: json['catalog3'] as int?,
      catalog4: json['catalog4'] as int?,
      catalog5: json['catalog5'] as int?,
      catalog6: json['catalog6'] as int?,
      catalog7: json['catalog7'] as int?,
      catalog8: json['catalog8'] as int?,
      aboutTheProducts: json['about_the_products'] == null
          ? null
          : ProductDetails.fromJson(
              json['about_the_products'] as Map<String, dynamic>),
      productDetails: json['product_details'] == null
          ? null
          : Abouttheproducts.fromJson(
              json['product_details'] as Map<String, dynamic>),
      productFeatures: json['product_features'] == null
          ? null
          : Abouttheproducts.fromJson(
              json['product_features'] as Map<String, dynamic>),
      additionalInfo: json['Additional_info'] == null
          ? null
          : Abouttheproducts.fromJson(
              json['Additional_info'] as Map<String, dynamic>),
      nutrientsFacts: json['Nutriants_facts'] == null
          ? null
          : Abouttheproducts.fromJson(
              json['Nutriants_facts'] as Map<String, dynamic>),
      ingredients: json['Ingrediants'] == null
          ? null
          : ProductDetails.fromJson(
              json['Ingrediants'] as Map<String, dynamic>),
      storage: json['storage'] == null
          ? null
          : ProductDetails.fromJson(json['storage'] as Map<String, dynamic>),
      importantInfo: json['important_info'] == null
          ? null
          : Abouttheproducts.fromJson(
              json['important_info'] as Map<String, dynamic>),
      productBehaviour: (json['product_behaviour'] as List<dynamic>?)
          ?.map((e) => SubClassBehaviour.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channel_id'] as int?,
      posName: json['pos_name'] as String?,
      arabicDescription: json['arabic_description'] as String?,
      additionalDescription: json['additional_description'] as String?,
      grossWeight: json['gross_weight'] as String?,
      netWeight: json['net_weight'] as String?,
      unitCost: (json['unit_cost'] as num?)?.toDouble(),
      actualCost: (json['actual_cost'] as num?)?.toDouble(),
      manufactureId: json['manufacture_id'] as int?,
      manufactureName: json['manufacture_name'] as String?,
      salesBlock: json['sales_block'] as bool?,
      minSalesOrderLimit: json['min_sales_order_limit'] as int?,
      maxSalesOrderLimit: json['max_sales_order_limit'] as int?,
      itemCatalog: json['item_catalog'] as bool?,
      itemImage: json['item_image'] as bool?,
      vat: (json['vat'] as num?)?.toDouble(),
      excessTax: (json['excess_tax'] as num?)?.toDouble(),
      minimumGp: (json['minimum_gp'] as num?)?.toDouble(),
      maximumGp: (json['maximum_gp'] as num?)?.toDouble(),
      averageGp: (json['average_gp'] as num?)?.toDouble(),
      targetedGp: (json['targeted_gp'] as num?)?.toDouble(),
      videoUrl: json['vedio_url'] as String?,
      vendorDetails: (json['vendor_details'] as List<dynamic>?)
          ?.map((e) => VendorDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      varAlternativeRfid: json['var_alternative_rfid'] as List<dynamic>?,
      siblingId: json['sebling_id'] as int?,
      siblingCode: json['sibling_code'] as String?,
      returnType: json['return_type'] as String?,
      returnTime: json['return_time'] as String?,
      shelfType: json['shelf_type'] as String?,
      shelfTime: json['shelf_time'] as int?,
      height: (json['height'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      needMultipleIntegration: json['need_multiple_integration'] as bool?,
      haveGiftOption: json['have_gift_option'] as bool?,
      haveWrapOption: json['have_wrap_option'] as bool?,
      alternativeBarcode: (json['alternative_barcode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateVariantModelToJson(CreateVariantModel instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'variant_name': instance.variantName,
      'inventory_id': instance.inventoryId,
      'inventory_name': instance.inventoryName,
      'channel_code': instance.channelCode,
      'variant_value': instance.variantValue,
      'name': instance.name,
      'barcode': instance.barcode,
      'search_name': instance.searchName,
      'display_name': instance.displayName,
      'description': instance.description,
      'sales_uom': instance.salesUom,
      'produced_country': instance.producedCountry,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'image4': instance.image4,
      'image5': instance.image5,
      'catalog1': instance.catalog1,
      'catalog2': instance.catalog2,
      'catalog3': instance.catalog3,
      'catalog4': instance.catalog4,
      'catalog5': instance.catalog5,
      'catalog6': instance.catalog6,
      'catalog7': instance.catalog7,
      'catalog8': instance.catalog8,
      'about_the_products': instance.aboutTheProducts,
      'product_details': instance.productDetails,
      'product_features': instance.productFeatures,
      'Additional_info': instance.additionalInfo,
      'Nutriants_facts': instance.nutrientsFacts,
      'usage_direction': instance.usageDirection,
      'Ingrediants': instance.ingredients,
      'storage': instance.storage,
      'important_info': instance.importantInfo,
      'product_behaviour': instance.productBehaviour,
      'channel_id': instance.channelId,
      'pos_name': instance.posName,
      'arabic_description': instance.arabicDescription,
      'additional_description': instance.additionalDescription,
      'gross_weight': instance.grossWeight,
      'net_weight': instance.netWeight,
      'unit_cost': instance.unitCost,
      'actual_cost': instance.actualCost,
      'manufacture_id': instance.manufactureId,
      'manufacture_name': instance.manufactureName,
      'sales_block': instance.salesBlock,
      'min_sales_order_limit': instance.minSalesOrderLimit,
      'max_sales_order_limit': instance.maxSalesOrderLimit,
      'item_catalog': instance.itemCatalog,
      'item_image': instance.itemImage,
      'vat': instance.vat,
      'excess_tax': instance.excessTax,
      'minimum_gp': instance.minimumGp,
      'maximum_gp': instance.maximumGp,
      'average_gp': instance.averageGp,
      'targeted_gp': instance.targetedGp,
      'vedio_url': instance.videoUrl,
      'vendor_details': instance.vendorDetails,
      'var_alternative_rfid': instance.varAlternativeRfid,
      'sebling_id': instance.siblingId,
      'sibling_code': instance.siblingCode,
      'return_type': instance.returnType,
      'return_time': instance.returnTime,
      'replacement_type': instance.replacementType,
      'replacement_time': instance.replacementTime,
      'shelf_type': instance.shelfType,
      'shelf_time': instance.shelfTime,
      'old_system_code': instance.oldSystemCode,
      'height': instance.height,
      'length': instance.length,
      'width': instance.width,
      'weight': instance.weight,
      'need_multiple_integration': instance.needMultipleIntegration,
      'have_gift_option': instance.haveGiftOption,
      'have_wrap_option': instance.haveWrapOption,
      'alternative_barcode': instance.alternativeBarcode,
      'is_active': instance.isActive,
    };

VarintValue _$VarintValueFromJson(Map<String, dynamic> json) => VarintValue(
      key: json['key'] as String?,
      value: json['value'] as String?,
      attributeId: json['attribute_id'] as int?,
      attributeCode: json['attribute_code'] as String?,
    );

Map<String, dynamic> _$VarintValueToJson(VarintValue instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'attribute_id': instance.attributeId,
      'attribute_code': instance.attributeCode,
    };

Abouttheproducts _$AbouttheproductsFromJson(Map<String, dynamic> json) =>
    Abouttheproducts(
      name: json['name'] as String?,
      keyvalues: (json['key_values'] as List<dynamic>?)
          ?.map((e) => KeyValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AbouttheproductsToJson(Abouttheproducts instance) =>
    <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyvalues,
    };

KeyValues _$KeyValuesFromJson(Map<String, dynamic> json) => KeyValues(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$KeyValuesToJson(KeyValues instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

VendorDetails _$VendorDetailsFromJson(Map<String, dynamic> json) =>
    VendorDetails(
      vendorCode: json['vendor_code'] as String?,
      vendorName: json['vendor_name'] as String?,
      vendorReferenceCode: json['vendor_reference_code'] as String?,
    );

Map<String, dynamic> _$VendorDetailsToJson(VendorDetails instance) =>
    <String, dynamic>{
      'vendor_code': instance.vendorCode,
      'vendor_name': instance.vendorName,
      'vendor_reference_code': instance.vendorReferenceCode,
    };

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      name: json['name'] as String?,
      keyvalues: (json['key_values'] as List<dynamic>?)
          ?.map((e) => NameCreate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyvalues,
    };

NameCreate _$NameCreateFromJson(Map<String, dynamic> json) => NameCreate(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NameCreateToJson(NameCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ProductBehaviour _$ProductBehaviourFromJson(Map<String, dynamic> json) =>
    ProductBehaviour(
      keyvalues: (json['key_values'] as List<dynamic>?)
          ?.map((e) => SubClassBehaviour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductBehaviourToJson(ProductBehaviour instance) =>
    <String, dynamic>{
      'key_values': instance.keyvalues,
    };

SubClassBehaviour _$SubClassBehaviourFromJson(Map<String, dynamic> json) =>
    SubClassBehaviour(
      ethnic: json['ethinik'] as String?,
      purpose: json['purpose'] as String?,
      ageGroup: json['ageGroup'] as String?,
      countries: json['countries'] as String?,
      genderGroup: json['genderGroup'] as String?,
    );

Map<String, dynamic> _$SubClassBehaviourToJson(SubClassBehaviour instance) =>
    <String, dynamic>{
      'ethinik': instance.ethnic,
      'purpose': instance.purpose,
      'ageGroup': instance.ageGroup,
      'countries': instance.countries,
      'genderGroup': instance.genderGroup,
    };
