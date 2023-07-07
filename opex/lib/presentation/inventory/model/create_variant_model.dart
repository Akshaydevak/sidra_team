import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_variant_model.g.dart';

@JsonSerializable()
class CreateVariantModel extends Equatable {
  @JsonKey(name: 'item_id')
  final int? itemId;
  @JsonKey(name: 'variant_name')
  final String? variantName;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'inventory_name')
  final String? inventoryName;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'variant_value')
  final List<VarintValue>? variantValue;
  final String? name;
  final String? barcode;
  @JsonKey(name: 'search_name')
  final String? searchName;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? description;
  @JsonKey(name: 'sales_uom')
  final int? salesUom;
  @JsonKey(name: 'produced_country')
  final String? producedCountry;
  final int? image1;
  final int? image2;
  final int? image3;
  final int? image4;
  final int? image5;
  final int? catalog1;
  final int? catalog2;
  final int? catalog3;
  final int? catalog4;
  final int? catalog5;
  final int? catalog6;
  final int? catalog7;
  final int? catalog8;
  @JsonKey(name: 'about_the_products')
  final ProductDetails? aboutTheProducts;
  @JsonKey(name: 'product_details')
  final Abouttheproducts? productDetails;
  @JsonKey(name: 'product_features')
  final Abouttheproducts? productFeatures;
  @JsonKey(name: 'Additional_info')
  final Abouttheproducts? additionalInfo;
  @JsonKey(name: 'Nutriants_facts')
  final Abouttheproducts? nutrientsFacts;
  @JsonKey(name: 'usage_direction')
  final ProductDetails? usageDirection;
  @JsonKey(name: 'Ingrediants')
  final ProductDetails? ingredients;
  final ProductDetails? storage;
  @JsonKey(name: 'important_info')
  final Abouttheproducts? importantInfo;
  @JsonKey(name: 'product_behaviour')
  final List<SubClassBehaviour>? productBehaviour;
  @JsonKey(name: 'channel_id')
  final int? channelId;
  @JsonKey(name: 'pos_name')
  final String? posName;
  @JsonKey(name: 'arabic_description')
  final String? arabicDescription;
  @JsonKey(name: 'additional_description')
  final String? additionalDescription;
  @JsonKey(name: 'gross_weight')
  final String? grossWeight;
  @JsonKey(name: 'net_weight')
  final String? netWeight;
  @JsonKey(name: 'unit_cost')
  final double? unitCost;
  @JsonKey(name: 'actual_cost')
  final double? actualCost;
  @JsonKey(name: 'manufacture_id')
  final int? manufactureId;
  @JsonKey(name: 'manufacture_name')
  final String? manufactureName;
  @JsonKey(name: 'sales_block')
  final bool? salesBlock;
  @JsonKey(name: 'min_sales_order_limit')
  final int? minSalesOrderLimit;
  @JsonKey(name: 'max_sales_order_limit')
  final int? maxSalesOrderLimit;
  @JsonKey(name: 'item_catalog')
  final bool? itemCatalog;
  @JsonKey(name: 'item_image')
  final bool? itemImage;
  final double? vat;
  @JsonKey(name: 'excess_tax')
  final double? excessTax;
  @JsonKey(name: 'minimum_gp')
  final double? minimumGp;
  @JsonKey(name: 'maximum_gp')
  final double? maximumGp;
  @JsonKey(name: 'average_gp')
  final double? averageGp;
  @JsonKey(name: 'targeted_gp')
  final double? targetedGp;
  @JsonKey(name: 'vedio_url')
  final String? videoUrl;
  @JsonKey(name: 'vendor_details')
  final List<VendorDetails>? vendorDetails;
  @JsonKey(name: 'var_alternative_rfid')
  final List<dynamic>? varAlternativeRfid;
  @JsonKey(name: 'sebling_id')
  final int? siblingId;
  @JsonKey(name: 'sibling_code')
  final String? siblingCode;
  @JsonKey(name: 'return_type')
  final String? returnType;
  @JsonKey(name: 'return_time')
  final String? returnTime;
  @JsonKey(name: 'replacement_type')
  final String? replacementType;
  @JsonKey(name: 'replacement_time')
  final String? replacementTime;
  @JsonKey(name: 'shelf_type')
  final String? shelfType;
  @JsonKey(name: 'shelf_time')
  final int? shelfTime;
  @JsonKey(name: 'old_system_code')
  final String? oldSystemCode;
  @JsonKey(name: "height")
  final double? height;
  final double? length;
  final double? width;
  final double? weight;
  @JsonKey(name: 'need_multiple_integration')
  final bool? needMultipleIntegration;
  @JsonKey(name: 'have_gift_option')
  final bool? haveGiftOption;
  @JsonKey(name: 'have_wrap_option')
  final bool? haveWrapOption;
  @JsonKey(name: 'alternative_barcode')
  final List<String>? alternativeBarcode;
  @JsonKey(name: 'is_active')
  final bool? isActive;

  const CreateVariantModel( {
    this.oldSystemCode,
    this.isActive,
    this.variantName,this.usageDirection,
    this.replacementType, this.replacementTime,
    this.itemId,
    this.inventoryId,
    this.inventoryName,
    this.channelCode,
    this.variantValue,
    this.name,
    this.barcode,
    this.searchName,
    this.displayName,
    this.description,
    this.salesUom,
    this.producedCountry,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.catalog1,
    this.catalog2,
    this.catalog3,
    this.catalog4,
    this.catalog5,
    this.catalog6,
    this.catalog7,
    this.catalog8,
    this.aboutTheProducts,
    this.productDetails,
    this.productFeatures,
    this.additionalInfo,
    this.nutrientsFacts,
    this.ingredients,
    this.storage,
    this.importantInfo,
    this.productBehaviour,
    this.channelId,
    this.posName,
    this.arabicDescription,
    this.additionalDescription,
    this.grossWeight,
    this.netWeight,
    this.unitCost,
    this.actualCost,
    this.manufactureId,
    this.manufactureName,
    this.salesBlock,
    this.minSalesOrderLimit,
    this.maxSalesOrderLimit,
    this.itemCatalog,
    this.itemImage,
    this.vat,
    this.excessTax,
    this.minimumGp,
    this.maximumGp,
    this.averageGp,
    this.targetedGp,
    this.videoUrl,
    this.vendorDetails,
    this.varAlternativeRfid,
    this.siblingId,
    this.siblingCode,
    this.returnType,
    this.returnTime,
    this.shelfType,
    this.shelfTime,
    this.height,
    this.length,
    this.width,
    this.weight,
    this.needMultipleIntegration,
    this.haveGiftOption,
    this.haveWrapOption,
    this.alternativeBarcode,
  });

  @override
  List<Object> get props => [];

  factory CreateVariantModel.need_multiple_integrationfromJson(
          Map<String, dynamic> json) =>
      _$CreateVariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVariantModelToJson(this);
}

@JsonSerializable()
class VarintValue extends Equatable {
  final String? key;
  final String? value;
  @JsonKey(name: 'attribute_id')
  final int? attributeId;
  @JsonKey(name: 'attribute_code')
  final String? attributeCode;

  VarintValue({
    this.key,
    this.value,
    this.attributeId,
    this.attributeCode,
  });

  @override
  List<Object> get props => [];

  factory VarintValue.fromJson(Map<String, dynamic> json) =>
      _$VarintValueFromJson(json);

  Map<String, dynamic> toJson() => _$VarintValueToJson(this);
}

@JsonSerializable()
class Abouttheproducts extends Equatable {
  @JsonKey(name: "name")
  late final String? name;
  @JsonKey(name: "key_values")
  final List<KeyValues>? keyvalues;

  Abouttheproducts({this.name, this.keyvalues});

  @override
  List<Object> get props => [];

  factory Abouttheproducts.fromJson(Map<String, dynamic> json) =>
      _$AbouttheproductsFromJson(json);

  Map<String, dynamic> toJson() => _$AbouttheproductsToJson(this);
}

@JsonSerializable()
class KeyValues extends Equatable {
  @JsonKey(name: "key")
  final String? key;
  @JsonKey(name: "value")
  final String? value;

  KeyValues({this.key, this.value});

  @override
  List<Object> get props => [];

  factory KeyValues.fromJson(Map<String, dynamic> json) =>
      _$KeyValuesFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValuesToJson(this);
}

@JsonSerializable()
class VendorDetails extends Equatable {
  @JsonKey(name: "vendor_code")
  final String? vendorCode;
  @JsonKey(name: "vendor_name")
  final String? vendorName;
  @JsonKey(name: "vendor_reference_code")
  final String? vendorReferenceCode;

  VendorDetails({this.vendorCode, this.vendorName, this.vendorReferenceCode});

  @override
  List<Object> get props => [];

  factory VendorDetails.fromJson(Map<String, dynamic> json) =>
      _$VendorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDetailsToJson(this);
}

@JsonSerializable()
class ProductDetails extends Equatable {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "key_values")
  final List<NameCreate>? keyvalues;

  ProductDetails({this.name, this.keyvalues});
  @override
  List<Object> get props => [];
  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}

@JsonSerializable()
class NameCreate extends Equatable {
  @JsonKey(name: "name")
  final String? name;
  NameCreate({this.name});
  @override
  List<Object> get props => [];
  factory NameCreate.fromJson(Map<String, dynamic> json) => _$NameCreateFromJson(json);
  Map<String, dynamic> toJson() => _$NameCreateToJson(this);
}

@JsonSerializable()
class ProductBehaviour extends Equatable {

  @JsonKey(name: "key_values")
  final List<SubClassBehaviour>? keyvalues;

  ProductBehaviour({ this.keyvalues});

  @override
  List<Object> get props => [];

  factory ProductBehaviour.fromJson(Map<String, dynamic> json) =>
      _$ProductBehaviourFromJson(json);

  Map<String, dynamic> toJson() => _$ProductBehaviourToJson(this);
}
@JsonSerializable()
class SubClassBehaviour extends Equatable {
  @JsonKey(name: "ethinik")
  final String? ethnic;
  @JsonKey(name: "purpose")
  final String? purpose;
  @JsonKey(name: "ageGroup")
  final String? ageGroup;
  @JsonKey(name: "countries")
  final String? countries;
  @JsonKey(name: "genderGroup")
  final String? genderGroup;
  const SubClassBehaviour({this.ethnic, this.purpose, this.ageGroup, this.countries, this.genderGroup,});
  @override
  List<Object> get props => [];
  factory SubClassBehaviour.fromJson(Map<String, dynamic> json) => _$SubClassBehaviourFromJson(json);
  Map<String, dynamic> toJson() => _$SubClassBehaviourToJson(this);
}