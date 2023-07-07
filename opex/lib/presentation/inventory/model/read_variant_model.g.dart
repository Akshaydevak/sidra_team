// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadVariantModel _$ReadVariantModelFromJson(Map<String, dynamic> json) =>
    ReadVariantModel(
      dimension: json['dimension'] == null
          ? null
          : Dimension.fromJson(json['dimension'] as Map<String, dynamic>),
      id: json['id'] as int?,
      salesUomData: json['sales_uom_data'] == null
          ? null
          : SalesUomData.fromJson(
              json['sales_uom_data'] as Map<String, dynamic>),
      uomNameData: json['uom_name_data'] == null
          ? null
          : UomNameData.fromJson(json['uom_name_data'] as Map<String, dynamic>),
      purchaseUomData: json['purchase_uom_data'] == null
          ? null
          : PurchaseUomData.fromJson(
              json['purchase_uom_data'] as Map<String, dynamic>),
      variantFrameworkData: json['variant_framework_data'] == null
          ? null
          : VariantFrameworkData.fromJson(
              json['variant_framework_data'] as Map<String, dynamic>),
      itemData: json['item_data'] == null
          ? null
          : ItemData.fromJson(json['item_data'] as Map<String, dynamic>),
      varAlternativeBarcode: (json['var_alternative_barcode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      code: json['code'] as String?,
      inventoryId: json['inventory_id'] as String?,
      inventoryName: json['inventory_name'] as String?,
      channelId: json['channel_id'] as int?,
      channelCode: json['channel_code'] as String?,
      name: json['name'] as String?,
      barcode: json['barcode'] == null
          ? null
          : BarCode.fromJson(json['barcode'] as Map<String, dynamic>),
      qrcodeImage: json['qrcode_image'] as String?,
      searchName: json['search_name'] as String?,
      posName: json['pos_name'] as String?,
      displayName: json['display_name'] as String?,
      description: json['description'] as String?,
      arabicDescription: json['arabic_description'] as String?,
      additionalDescription: json['additional_description'] as String?,
      image1: json['image1'] as String?,
      uomId: json['uom_id'] as int?,
      salesUom: json['sales_uom'] as String?,
      salesUomCode: json['sales_uom_code'] as String?,
      purchaseUom: json['purchase_uom'] as String?,
      purchaseUomCode: json['purchase_uom_code'] as String?,
      grossWeight: json['gross_weight'] as String?,
      netWeight: json['net_weight'] as String?,
      unitCost: (json['unit_cost'] as num?)?.toDouble(),
      basePrice: (json['base_price'] as num?)?.toDouble(),
      landingCost: (json['landing_cost'] as num?)?.toDouble(),
      actualCost: (json['actual_cost'] as num?)?.toDouble(),
      producedCountry: json['produced_country'] as String?,
      manufactureId: json['manufacture_id'] as int?,
      manufactureName: json['manufacture_name'] as String?,
      safetyStock: json['safty_stock'] as int?,
      salesBlock: json['sales_block'] as bool?,
      minSalesOrderLimit: (json['min_sales_order_limit'] as num?)?.toDouble(),
      maxSalesOrderLimit: (json['max_sales_order_limit'] as num?)?.toDouble(),
      itemCatalog: json['item_catalog'] as bool?,
      itemImage: json['item_image'] as bool?,
      isActive: json['is_active'] as bool?,
      videoUrl: json['vedio_url'] as String?,
      vendorDetails: (json['vendor_details'] as List<dynamic>?)
          ?.map((e) => VendorDetailsRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      variantMeta: json['variant_meta'] == null
          ? null
          : VariantMeta.fromJson(json['variant_meta'] as Map<String, dynamic>),
      siblingId: json['sebling_id'] as int?,
      siblingCode: json['sibling_code'] as String?,
      vat: (json['vat'] as num?)?.toDouble(),
      excessTax: (json['excess_tax'] as num?)?.toDouble(),
      minGp: (json['min_gp'] as num?)?.toDouble(),
      avrgGp: (json['avrg_gp'] as num?)?.toDouble(),
      maxGp: (json['max_gp'] as num?)?.toDouble(),
      targetedGp: (json['targeted_gp'] as num?)?.toDouble(),
      returnType: json['return_type'] as String?,
      returnTime: json['return_time'] as int?,
      replacementType: json['replacement_type'] as String?,
      replacementTime: json['replacement_time'] as int?,
      shelfType: json['shelf_type'] as String?,
      shelfTime: json['shelf_time'] as int?,
      returnDays: json['return_days'] as int?,
      haveGiftOption: json['have_gift_option'] as bool?,
      haveWrapOption: json['have_wrap_option'] as bool?,
      variantFrameworkId: json['variantframework_id'] as int?,
    );

Map<String, dynamic> _$ReadVariantModelToJson(ReadVariantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sales_uom_data': instance.salesUomData,
      'uom_name_data': instance.uomNameData,
      'purchase_uom_data': instance.purchaseUomData,
      'variant_framework_data': instance.variantFrameworkData,
      'item_data': instance.itemData,
      'var_alternative_barcode': instance.varAlternativeBarcode,
      'code': instance.code,
      'inventory_id': instance.inventoryId,
      'inventory_name': instance.inventoryName,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'name': instance.name,
      'barcode': instance.barcode,
      'qrcode_image': instance.qrcodeImage,
      'search_name': instance.searchName,
      'pos_name': instance.posName,
      'display_name': instance.displayName,
      'description': instance.description,
      'arabic_description': instance.arabicDescription,
      'additional_description': instance.additionalDescription,
      'image1': instance.image1,
      'uom_id': instance.uomId,
      'sales_uom': instance.salesUom,
      'sales_uom_code': instance.salesUomCode,
      'purchase_uom': instance.purchaseUom,
      'purchase_uom_code': instance.purchaseUomCode,
      'gross_weight': instance.grossWeight,
      'net_weight': instance.netWeight,
      'unit_cost': instance.unitCost,
      'base_price': instance.basePrice,
      'landing_cost': instance.landingCost,
      'actual_cost': instance.actualCost,
      'produced_country': instance.producedCountry,
      'manufacture_id': instance.manufactureId,
      'manufacture_name': instance.manufactureName,
      'safty_stock': instance.safetyStock,
      'sales_block': instance.salesBlock,
      'min_sales_order_limit': instance.minSalesOrderLimit,
      'max_sales_order_limit': instance.maxSalesOrderLimit,
      'item_catalog': instance.itemCatalog,
      'item_image': instance.itemImage,
      'is_active': instance.isActive,
      'vedio_url': instance.videoUrl,
      'vendor_details': instance.vendorDetails,
      'variant_meta': instance.variantMeta,
      'sebling_id': instance.siblingId,
      'sibling_code': instance.siblingCode,
      'vat': instance.vat,
      'excess_tax': instance.excessTax,
      'min_gp': instance.minGp,
      'avrg_gp': instance.avrgGp,
      'max_gp': instance.maxGp,
      'targeted_gp': instance.targetedGp,
      'return_type': instance.returnType,
      'return_time': instance.returnTime,
      'replacement_type': instance.replacementType,
      'replacement_time': instance.replacementTime,
      'shelf_type': instance.shelfType,
      'shelf_time': instance.shelfTime,
      'return_days': instance.returnDays,
      'have_gift_option': instance.haveGiftOption,
      'have_wrap_option': instance.haveWrapOption,
      'variantframework_id': instance.variantFrameworkId,
      'dimension': instance.dimension,
    };

SalesUomData _$SalesUomDataFromJson(Map<String, dynamic> json) => SalesUomData(
      salesUomName: json['sales_uom_name'] as String?,
      salesUomCode: json['sales_uom_code'] as String?,
    );

Map<String, dynamic> _$SalesUomDataToJson(SalesUomData instance) =>
    <String, dynamic>{
      'sales_uom_name': instance.salesUomName,
      'sales_uom_code': instance.salesUomCode,
    };

UomNameData _$UomNameDataFromJson(Map<String, dynamic> json) => UomNameData(
      uomCode: json['uom_code'] as String?,
      uomName: json['uom_name'] as String?,
    );

Map<String, dynamic> _$UomNameDataToJson(UomNameData instance) =>
    <String, dynamic>{
      'uom_name': instance.uomName,
      'uom_code': instance.uomCode,
    };

PurchaseUomData _$PurchaseUomDataFromJson(Map<String, dynamic> json) =>
    PurchaseUomData(
      purchaseUomCode: json['purchase_uom_code'] as String?,
      purchaseUomName: json['purchase_uom_name'] as String?,
    );

Map<String, dynamic> _$PurchaseUomDataToJson(PurchaseUomData instance) =>
    <String, dynamic>{
      'purchase_uom_name': instance.purchaseUomName,
      'purchase_uom_code': instance.purchaseUomCode,
    };

VariantFrameworkData _$VariantFrameworkDataFromJson(
        Map<String, dynamic> json) =>
    VariantFrameworkData(
      variantFrameworkCode: json['variant_framewrok_code'] as String?,
      variantFrameworkName: json['variant_framewrok_name'] as String?,
    );

Map<String, dynamic> _$VariantFrameworkDataToJson(
        VariantFrameworkData instance) =>
    <String, dynamic>{
      'variant_framewrok_name': instance.variantFrameworkName,
      'variant_framewrok_code': instance.variantFrameworkCode,
    };

ItemData _$ItemDataFromJson(Map<String, dynamic> json) => ItemData(
      itemCode: json['item_code'] as String?,
      itemName: json['item_name'] as String?,
    );

Map<String, dynamic> _$ItemDataToJson(ItemData instance) => <String, dynamic>{
      'item_name': instance.itemName,
      'item_code': instance.itemCode,
    };

BarCode _$BarCodeFromJson(Map<String, dynamic> json) => BarCode(
      barcodeNumber: json['barcode_number'] as String?,
      fileName: json['file_name'] as String?,
    );

Map<String, dynamic> _$BarCodeToJson(BarCode instance) => <String, dynamic>{
      'file_name': instance.fileName,
      'barcode_number': instance.barcodeNumber,
    };

VariantMeta _$VariantMetaFromJson(Map<String, dynamic> json) => VariantMeta(
      aboutTheProducts: json['about_the_products'] == null
          ? null
          : Single.fromJson(json['about_the_products'] as Map<String, dynamic>),
      productDetails: json['product_details'] == null
          ? null
          : KeyValue.fromJson(json['product_details'] as Map<String, dynamic>),
      usageDirection: json['usage_direction'] == null
          ? null
          : Single.fromJson(json['usage_direction'] as Map<String, dynamic>),
      productFeatures: json['product_features'] == null
          ? null
          : KeyValue.fromJson(json['product_features'] as Map<String, dynamic>),
      productBehaviour: (json['product_behaviour'] as List<dynamic>?)
          ?.map((e) => SubClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      catalog: json['catelog'] == null
          ? null
          : Catalog.fromJson(json['catelog'] as Map<String, dynamic>),
      storage: json['storage'] == null
          ? null
          : Single.fromJson(json['storage'] as Map<String, dynamic>),
      varImage: json['var_image'] == null
          ? null
          : VarImage.fromJson(json['var_image'] as Map<String, dynamic>),
      ingredients: json['Ingrediants'] == null
          ? null
          : Single.fromJson(json['Ingrediants'] as Map<String, dynamic>),
      specifications: json['specifictions'] == null
          ? null
          : KeyValue.fromJson(json['specifictions'] as Map<String, dynamic>),
      importantInfo: json['important_info'] == null
          ? null
          : KeyValue.fromJson(json['important_info'] as Map<String, dynamic>),
      additionalInfo: json['Additional_info'] == null
          ? null
          : KeyValue.fromJson(json['Additional_info'] as Map<String, dynamic>),
      nutrientsFacts: json['Nutriants_facts'] == null
          ? null
          : KeyValue.fromJson(json['Nutriants_facts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariantMetaToJson(VariantMeta instance) =>
    <String, dynamic>{
      'catelog': instance.catalog,
      'storage': instance.storage,
      'var_image': instance.varImage,
      'Ingrediants': instance.ingredients,
      'specifictions': instance.specifications,
      'important_info': instance.importantInfo,
      'Additional_info': instance.additionalInfo,
      'Nutriants_facts': instance.nutrientsFacts,
      'product_details': instance.productDetails,
      'usage_direction': instance.usageDirection,
      'product_features': instance.productFeatures,
      'product_behaviour': instance.productBehaviour,
      'about_the_products': instance.aboutTheProducts,
    };

Single _$SingleFromJson(Map<String, dynamic> json) => Single(
      name: json['name'] as String?,
      keyvalues: (json['key_values'] as List<dynamic>?)
          ?.map((e) => Name.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SingleToJson(Single instance) => <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyvalues,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'name': instance.name,
    };

KeyValue _$KeyValueFromJson(Map<String, dynamic> json) => KeyValue(
      name: json['name'] as String?,
      keyvalues: (json['key_values'] as List<dynamic>?)
          ?.map((e) => KeyValueSubclass.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KeyValueToJson(KeyValue instance) => <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyvalues,
    };

KeyValueSubclass _$KeyValueSubclassFromJson(Map<String, dynamic> json) =>
    KeyValueSubclass(
      value: json['value'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$KeyValueSubclassToJson(KeyValueSubclass instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

SubClass _$SubClassFromJson(Map<String, dynamic> json) => SubClass(
      ethnic: json['ethinik'] as String?,
      purpose: json['purpose'] as String?,
      ageGroup: json['ageGroup'] as String?,
      country: json['countries'] as String?,
      genderGroup: json['genderGroup'] as String?,
    );

Map<String, dynamic> _$SubClassToJson(SubClass instance) => <String, dynamic>{
      'ethinik': instance.ethnic,
      'purpose': instance.purpose,
      'ageGroup': instance.ageGroup,
      'countries': instance.country,
      'genderGroup': instance.genderGroup,
    };

BehaviourSubClass _$BehaviourSubClassFromJson(Map<String, dynamic> json) =>
    BehaviourSubClass(
      ethnic: json['ethinik'] as String?,
      purpose: json['purpose'] as String?,
      ageGroup: json['age group'] as String?,
      country: json['country'] as String?,
      genderGroup: json['gender'] as String?,
    );

Map<String, dynamic> _$BehaviourSubClassToJson(BehaviourSubClass instance) =>
    <String, dynamic>{
      'ethinik': instance.ethnic,
      'purpose': instance.purpose,
      'age group': instance.ageGroup,
      'country': instance.country,
      'gender': instance.genderGroup,
    };

Catalog _$CatalogFromJson(Map<String, dynamic> json) => Catalog(
      name: json['name'] as String?,
      keyvalues: json['key_values'] == null
          ? null
          : CatalogSubClass.fromJson(
              json['key_values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CatalogToJson(Catalog instance) => <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyvalues,
    };

CatalogSubClass _$CatalogSubClassFromJson(Map<String, dynamic> json) =>
    CatalogSubClass(
      catalog1: json['catelog1'] as String?,
      catalog2: json['catelog2'] as String?,
      catalog3: json['catelog3'] as String?,
      catalog4: json['catelog4'] as String?,
      catalog5: json['catelog5'] as String?,
      catalog6: json['catelog6'] as String?,
      catalog7: json['catelog7'] as String?,
      catalog8: json['catelog8'] as String?,
    );

Map<String, dynamic> _$CatalogSubClassToJson(CatalogSubClass instance) =>
    <String, dynamic>{
      'catelog1': instance.catalog1,
      'catelog2': instance.catalog2,
      'catelog3': instance.catalog3,
      'catelog4': instance.catalog4,
      'catelog5': instance.catalog5,
      'catelog6': instance.catalog6,
      'catelog7': instance.catalog7,
      'catelog8': instance.catalog8,
    };

VarImage _$VarImageFromJson(Map<String, dynamic> json) => VarImage(
      name: json['name'] as String?,
      keyValues: json['key_values'] == null
          ? null
          : VarImageSubClass.fromJson(
              json['key_values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VarImageToJson(VarImage instance) => <String, dynamic>{
      'name': instance.name,
      'key_values': instance.keyValues,
    };

VarImageSubClass _$VarImageSubClassFromJson(Map<String, dynamic> json) =>
    VarImageSubClass(
      image2: json['image_2'] as String?,
      image3: json['image_3'] as String?,
      image4: json['image_4'] as String?,
      image5: json['image_5'] as String?,
    );

Map<String, dynamic> _$VarImageSubClassToJson(VarImageSubClass instance) =>
    <String, dynamic>{
      'image_2': instance.image2,
      'image_3': instance.image3,
      'image_4': instance.image4,
      'image_5': instance.image5,
    };

VendorDetailsRead _$VendorDetailsReadFromJson(Map<String, dynamic> json) =>
    VendorDetailsRead(
      vendorCode: json['vendor_code'] as String?,
      vendorName: json['vendor_name'] as String?,
      vendorReferenceCode: json['vendor_reference_code'] as String?,
    );

Map<String, dynamic> _$VendorDetailsReadToJson(VendorDetailsRead instance) =>
    <String, dynamic>{
      'vendor_code': instance.vendorCode,
      'vendor_name': instance.vendorName,
      'vendor_reference_code': instance.vendorReferenceCode,
    };

Dimension _$DimensionFromJson(Map<String, dynamic> json) => Dimension(
      height: (json['height'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DimensionToJson(Dimension instance) => <String, dynamic>{
      'height': instance.height,
      'length': instance.length,
      'width': instance.width,
      'weight': instance.weight,
    };
