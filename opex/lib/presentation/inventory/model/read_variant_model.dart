import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'read_variant_model.g.dart';

@JsonSerializable()
class ReadVariantModel extends Equatable {
  final int? id;
  @JsonKey(name: 'sales_uom_data')
  final SalesUomData? salesUomData;
  @JsonKey(name: 'uom_name_data')
  final UomNameData? uomNameData;
  @JsonKey(name: 'purchase_uom_data')
  final PurchaseUomData? purchaseUomData;
  @JsonKey(name: 'variant_framework_data')
  final VariantFrameworkData? variantFrameworkData;
  @JsonKey(name: 'item_data')
  final ItemData? itemData;
  @JsonKey(name: 'var_alternative_barcode')
  final List<String>? varAlternativeBarcode;
  final String? code;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'inventory_name')
  final String? inventoryName;
  @JsonKey(name: 'channel_id')
  final int? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  final String? name;
  final BarCode? barcode;
  @JsonKey(name: 'qrcode_image')
  final String? qrcodeImage;
  @JsonKey(name: 'search_name')
  final String? searchName;
  @JsonKey(name: 'pos_name')
  final String? posName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'arabic_description')
  final String? arabicDescription;
  @JsonKey(name: 'additional_description')
  final String? additionalDescription;
  @JsonKey(name: 'image1')
  final String? image1;
  @JsonKey(name: 'uom_id')
  final int? uomId;
  @JsonKey(name: 'sales_uom')
  final String? salesUom;
  @JsonKey(name: 'sales_uom_code')
  final String? salesUomCode;
  @JsonKey(name: 'purchase_uom')
  final String? purchaseUom;
  @JsonKey(name: 'purchase_uom_code')
  final String? purchaseUomCode;
  @JsonKey(name: 'gross_weight')
  final String? grossWeight;
  @JsonKey(name: 'net_weight')
  final String? netWeight;
  @JsonKey(name: 'unit_cost')
  final double? unitCost;
  @JsonKey(name: 'base_price')
  final double? basePrice;
  @JsonKey(name: 'landing_cost')
  final double? landingCost;
  @JsonKey(name: 'actual_cost')
  final double? actualCost;
  @JsonKey(name: 'produced_country')
  final String? producedCountry;
  @JsonKey(name: 'manufacture_id')
  final int? manufactureId;
  @JsonKey(name: 'manufacture_name')
  final String? manufactureName;
  @JsonKey(name: 'safty_stock')
  final int? safetyStock;
  @JsonKey(name: 'sales_block')
  final bool? salesBlock;
  @JsonKey(name: 'min_sales_order_limit')
  final double? minSalesOrderLimit;
  @JsonKey(name: 'max_sales_order_limit')
  final double? maxSalesOrderLimit;
  @JsonKey(name: 'item_catalog')
  final bool? itemCatalog;
  @JsonKey(name: 'item_image')
  final bool? itemImage;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'vedio_url')
  final String? videoUrl;
  @JsonKey(name: 'vendor_details')
  final List<VendorDetailsRead>? vendorDetails;

  @JsonKey(name: 'variant_meta')
  final VariantMeta? variantMeta;
  @JsonKey(name: 'sebling_id')
  final int? siblingId;
  @JsonKey(name: 'sibling_code')
  final String? siblingCode;
  @JsonKey(name: 'vat')
  final double? vat;
  @JsonKey(name: 'excess_tax')
  final double? excessTax;
  @JsonKey(name: 'min_gp')
  final double? minGp;
  @JsonKey(name: 'avrg_gp')
  final double? avrgGp;
  @JsonKey(name: 'max_gp')
  final double? maxGp;
  @JsonKey(name: 'targeted_gp')
  final double? targetedGp;
  @JsonKey(name: 'return_type')
  final String? returnType;
  @JsonKey(name: 'return_time')
  final int? returnTime;
  @JsonKey(name: 'replacement_type')
  final String? replacementType;
  @JsonKey(name: 'replacement_time')
  final int? replacementTime;
  @JsonKey(name: 'shelf_type')
  final String? shelfType;
  @JsonKey(name: 'shelf_time')
  final int? shelfTime;
  @JsonKey(name: 'return_days')
  final int? returnDays;
  @JsonKey(name: 'have_gift_option')
  final bool? haveGiftOption;
  @JsonKey(name: 'have_wrap_option')
  final bool? haveWrapOption;
  @JsonKey(name: 'variantframework_id')
  final int? variantFrameworkId;
  @JsonKey(name: 'dimension')
  final Dimension? dimension;

  const ReadVariantModel({
    this.dimension,
    this.id,
    this.salesUomData,
    this.uomNameData,
    this.purchaseUomData,
    this.variantFrameworkData,
    this.itemData,
    this.varAlternativeBarcode,
    this.code,
    this.inventoryId,
    this.inventoryName,
    this.channelId,
    this.channelCode,
    this.name,
    this.barcode,
    this.qrcodeImage,
    this.searchName,
    this.posName,
    this.displayName,
    this.description,
    this.arabicDescription,
    this.additionalDescription,
    this.image1,
    this.uomId,
    this.salesUom,
    this.salesUomCode,
    this.purchaseUom,
    this.purchaseUomCode,
    this.grossWeight,
    this.netWeight,
    this.unitCost,
    this.basePrice,
    this.landingCost,
    this.actualCost,
    this.producedCountry,
    this.manufactureId,
    this.manufactureName,
    this.safetyStock,
    this.salesBlock,
    this.minSalesOrderLimit,
    this.maxSalesOrderLimit,
    this.itemCatalog,
    this.itemImage,
    this.isActive,
    this.videoUrl,
    this.vendorDetails,
    this.variantMeta,
    this.siblingId,
    this.siblingCode,
    this.vat,
    this.excessTax,
    this.minGp,
    this.avrgGp,
    this.maxGp,
    this.targetedGp,
    this.returnType,
    this.returnTime,
    this.replacementType,
    this.replacementTime,
    this.shelfType,
    this.shelfTime,
    this.returnDays,
    this.haveGiftOption,
    this.haveWrapOption,
    this.variantFrameworkId,
  });

  @override
  List<Object> get props => [];

  factory ReadVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ReadVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReadVariantModelToJson(this);
}

@JsonSerializable()
class SalesUomData extends Equatable {
  @JsonKey(name: 'sales_uom_name')
  final String? salesUomName;
  @JsonKey(name: 'sales_uom_code')
  final String? salesUomCode;

  const SalesUomData({this.salesUomName, this.salesUomCode});

  @override
  List<Object> get props => [];

  factory SalesUomData.fromJson(Map<String, dynamic> json) =>
      _$SalesUomDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalesUomDataToJson(this);
}

@JsonSerializable()
class UomNameData extends Equatable {
  @JsonKey(name: 'uom_name')
  final String? uomName;
  @JsonKey(name: 'uom_code')
  final String? uomCode;

  const UomNameData({this.uomCode, this.uomName});

  @override
  List<Object> get props => [];

  factory UomNameData.fromJson(Map<String, dynamic> json) =>
      _$UomNameDataFromJson(json);

  Map<String, dynamic> toJson() => _$UomNameDataToJson(this);
}

@JsonSerializable()
class PurchaseUomData extends Equatable {
  @JsonKey(name: 'purchase_uom_name')
  final String? purchaseUomName;
  @JsonKey(name: 'purchase_uom_code')
  final String? purchaseUomCode;

  const PurchaseUomData({this.purchaseUomCode, this.purchaseUomName});

  @override
  List<Object> get props => [];

  factory PurchaseUomData.fromJson(Map<String, dynamic> json) =>
      _$PurchaseUomDataFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseUomDataToJson(this);
}

@JsonSerializable()
class VariantFrameworkData extends Equatable {
  @JsonKey(name: 'variant_framewrok_name')
  final String? variantFrameworkName;
  @JsonKey(name: 'variant_framewrok_code')
  final String? variantFrameworkCode;

  const VariantFrameworkData(
      {this.variantFrameworkCode, this.variantFrameworkName});

  @override
  List<Object> get props => [];

  factory VariantFrameworkData.fromJson(Map<String, dynamic> json) =>
      _$VariantFrameworkDataFromJson(json);

  Map<String, dynamic> toJson() => _$VariantFrameworkDataToJson(this);
}

@JsonSerializable()
class ItemData extends Equatable {
  @JsonKey(name: 'item_name')
  final String? itemName;
  @JsonKey(name: 'item_code')
  final String? itemCode;

  const ItemData({this.itemCode, this.itemName});

  @override
  List<Object> get props => [];

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDataToJson(this);
}

@JsonSerializable()
class BarCode extends Equatable {
  @JsonKey(name: 'file_name')
  final String? fileName;
  @JsonKey(name: 'barcode_number')
  final String? barcodeNumber;

  const BarCode({this.barcodeNumber, this.fileName});

  @override
  List<Object> get props => [];

  factory BarCode.fromJson(Map<String, dynamic> json) =>
      _$BarCodeFromJson(json);

  Map<String, dynamic> toJson() => _$BarCodeToJson(this);
}

@JsonSerializable()
class VariantMeta extends Equatable {
  @JsonKey(name: 'catelog')
  final Catalog? catalog;
  @JsonKey(name: 'storage')
  final Single? storage;
  @JsonKey(name: 'var_image')
  final VarImage? varImage;
  @JsonKey(name: 'Ingrediants')
  final Single? ingredients;
  @JsonKey(name: 'specifictions')
  final KeyValue? specifications;
  @JsonKey(name: 'important_info')
  final KeyValue? importantInfo;
  @JsonKey(name: 'Additional_info')
  final KeyValue? additionalInfo;
  @JsonKey(name: 'Nutriants_facts')
  final KeyValue? nutrientsFacts;
  @JsonKey(name: 'product_details')
  final KeyValue? productDetails;
  @JsonKey(name: 'usage_direction')
  final Single? usageDirection;
  @JsonKey(name: 'product_features')
  final KeyValue? productFeatures;
  @JsonKey(name: 'product_behaviour')
  final List<SubClass>? productBehaviour;
  @JsonKey(name: 'about_the_products')
  final Single? aboutTheProducts;

  const VariantMeta( {this.aboutTheProducts,
    this.productDetails, this.usageDirection, this.productFeatures, this.productBehaviour,
    this.catalog,
    this.storage,
    this.varImage,
    this.ingredients,
    this.specifications,
    this.importantInfo,
    this.additionalInfo,
    this.nutrientsFacts,
  });

  @override
  List<Object> get props => [];

  factory VariantMeta.fromJson(Map<String, dynamic> json) =>
      _$VariantMetaFromJson(json);

  Map<String, dynamic> toJson() => _$VariantMetaToJson(this);
}

@JsonSerializable()
class Single extends Equatable {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "key_values")
  final List<Name>? keyvalues;

  Single({this.name, this.keyvalues});

  @override
  List<Object> get props => [];

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);

  Map<String, dynamic> toJson() => _$SingleToJson(this);
}

@JsonSerializable()
class Name extends Equatable {
  @JsonKey(name: "name")
  final String? name;

  Name({this.name});

  @override
  List<Object> get props => [];

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class KeyValue extends Equatable {
  @JsonKey(name: "name")
  late final String? name;
  @JsonKey(name: "key_values")
  final List<KeyValueSubclass>? keyvalues;

  KeyValue({this.name, this.keyvalues});

  @override
  List<Object> get props => [];

  factory KeyValue.fromJson(Map<String, dynamic> json) =>
      _$KeyValueFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueToJson(this);
}
@JsonSerializable()
class KeyValueSubclass extends Equatable {

  late final String? key;

  late final String? value;


  KeyValueSubclass({this.value,this.key});

  @override
  List<Object> get props => [];

  factory KeyValueSubclass.fromJson(Map<String, dynamic> json) =>
      _$KeyValueSubclassFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueSubclassToJson(this);
}

@JsonSerializable()
class SubClass extends Equatable {
  @JsonKey(name: "ethinik")
  final String? ethnic;
  final String? purpose;
  @JsonKey(name: "ageGroup")
  final String? ageGroup;
  @JsonKey(name: "countries")
  final String? country;
  @JsonKey(name: "genderGroup")
  final String? genderGroup;

  const SubClass({
    this.ethnic,
    this.purpose,
    this.ageGroup,
    this.country,
    this.genderGroup,
  });

  @override
  List<Object> get props => [];

  factory SubClass.fromJson(Map<String, dynamic> json) =>
      _$SubClassFromJson(json);

  Map<String, dynamic> toJson() => _$SubClassToJson(this);
}
@JsonSerializable()
class BehaviourSubClass extends Equatable {
  @JsonKey(name: "ethinik")
  final String? ethnic;
  final String? purpose;
  @JsonKey(name: "age group")
  final String? ageGroup;
  final String? country;
  @JsonKey(name: "gender")
  final String? genderGroup;

  const BehaviourSubClass({
    this.ethnic,
    this.purpose,
    this.ageGroup,
    this.country,
    this.genderGroup,
  });

  @override
  List<Object> get props => [];

  factory BehaviourSubClass.fromJson(Map<String, dynamic> json) =>
      _$BehaviourSubClassFromJson(json);

  Map<String, dynamic> toJson() => _$BehaviourSubClassToJson(this);
}
@JsonSerializable()
class Catalog extends Equatable {
  @JsonKey(name: "name")
   final String? name;
  @JsonKey(name: "key_values")
  final CatalogSubClass? keyvalues;

  const Catalog({this.name, this.keyvalues,

  });

  @override
  List<Object> get props => [];

  factory Catalog.fromJson(Map<String, dynamic> json) =>
      _$CatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogToJson(this);
}

@JsonSerializable()
class CatalogSubClass extends Equatable {
  @JsonKey(name: "catelog1")
   final String? catalog1;
  @JsonKey(name: "catelog2")
   final String? catalog2;
  @JsonKey(name: "catelog3")
   final String? catalog3;
  @JsonKey(name: "catelog4")
   final String? catalog4;
  @JsonKey(name: "catelog5")
   final String? catalog5;
  @JsonKey(name: "catelog6")
   final String? catalog6;
  @JsonKey(name: "catelog7")
   final String? catalog7;
  @JsonKey(name: "catelog8")
   final String? catalog8;


  const CatalogSubClass({this.catalog1, this.catalog2, this.catalog3, this.catalog4, this.catalog5, this.catalog6, this.catalog7, this.catalog8,

  });

  @override
  List<Object> get props => [];

  factory CatalogSubClass.fromJson(Map<String, dynamic> json) =>
      _$CatalogSubClassFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogSubClassToJson(this);
}
@JsonSerializable()
class VarImage extends Equatable {
  @JsonKey(name: "name")
   final String? name;
  @JsonKey(name: "key_values")
  final VarImageSubClass? keyValues;

  const VarImage({this.name, this.keyValues,

  });

  @override
  List<Object> get props => [];

  factory VarImage.fromJson(Map<String, dynamic> json) =>
      _$VarImageFromJson(json);

  Map<String, dynamic> toJson() => _$VarImageToJson(this);
}

@JsonSerializable()
class VarImageSubClass extends Equatable {
  @JsonKey(name: "image_2")
   final String? image2;
  @JsonKey(name: "image_3")
   final String? image3;
  @JsonKey(name: "image_4")
   final String? image4;
  @JsonKey(name: "image_5")
   final String? image5;



  const VarImageSubClass({this.image2, this.image3, this.image4, this.image5,

  });

  @override
  List<Object> get props => [];

  factory VarImageSubClass.fromJson(Map<String, dynamic> json) =>
      _$VarImageSubClassFromJson(json);

  Map<String, dynamic> toJson() => _$VarImageSubClassToJson(this);
}


@JsonSerializable()
class VendorDetailsRead extends Equatable {
  @JsonKey(name: "vendor_code")
  final String? vendorCode;
  @JsonKey(name: "vendor_name")
  final String? vendorName;
  @JsonKey(name: "vendor_reference_code")
  final String? vendorReferenceCode;

  VendorDetailsRead({this.vendorCode, this.vendorName, this.vendorReferenceCode});

  @override
  List<Object> get props => [];

  factory VendorDetailsRead.fromJson(Map<String, dynamic> json) =>
      _$VendorDetailsReadFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDetailsReadToJson(this);
}
@JsonSerializable()
class Dimension extends Equatable {

  final double? height;
  final double? length;
  final double? width;
  final double? weight;


  Dimension({this.height, this.length, this.width, this.weight, });

  @override
  List<Object> get props => [];

  factory Dimension.fromJson(Map<String, dynamic> json) =>
      _$DimensionFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionToJson(this);
}