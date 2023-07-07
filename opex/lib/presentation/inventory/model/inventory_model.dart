import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_model.g.dart';

@JsonSerializable()
class InventoryModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? title;
  final String? image1;
  @JsonKey(name: 'stock_count')
  final int? stockCount;
  @JsonKey(name: 'warranty_code')
  final String? warrantyCode;
  @JsonKey(name: 'brand_name')
  final String? brandName;
  final String? code;
  final BarcodeData? barcode;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'variant_framework_data')
  final VariantFrameWorkData? variantFrameWorkData;
  @JsonKey(name: 'base_uom_data')
  final BaseUomData? baseUomData;
  final List<String>? values;
  @JsonKey(name: 'attribute_data')
  final AttributeData? attributeData;
  @JsonKey(name: 'warranty_type_code')
  final String? warrantyTypeCode;
  @JsonKey(name: 'attribute_name')
  final String? attributeName;
  @JsonKey(name: 'standard_code')
  final String? statnderdCode;
  @JsonKey(name: 'conversion_factor')
  final double? conversionFactor;
  @JsonKey(name: 'uom_code')
  final String? uomCode;

  InventoryModel({this.warrantyTypeCode, this.attributeName, this.statnderdCode, this.conversionFactor, this.uomCode,
    this.variantFrameWorkData,
    this.values,
    this.description,
    this.warrantyCode,
    this.id,
    this.name,
    this.title,
    this.image1,
    this.barcode,
    this.code,
    this.displayName,
    this.baseUomData,
    this.attributeData,
    this.stockCount,
    this.brandName
  });

  @override
  List<Object> get props => [];

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);
}

@JsonSerializable()
class AttributeData extends Equatable {
  @JsonKey(name: 'attribute_id')
  final int? attributeId;
  @JsonKey(name: 'attribute_name')
  final String? attributeName;
  @JsonKey(name: 'attribute_code')
  final String? attributeCode;




  AttributeData({
    this.attributeId, this.attributeName, this.attributeCode,
  });

  @override
  List<Object> get props => [];

  factory AttributeData.fromJson(Map<String, dynamic> json) =>
      _$AttributeDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeDataToJson(this);
}

@JsonSerializable()
class VariantFrameWorkData extends Equatable {
  @JsonKey(name: 'variant_framework_id')
  final int? variantFrameworkId;
  @JsonKey(name: 'variant_framework_name')
  final String? variantFrameworkName;
  @JsonKey(name: 'variant_framework_code')
  final String? variantFrameworkCode;




  VariantFrameWorkData({
    this.variantFrameworkId, this.variantFrameworkName, this.variantFrameworkCode,
  });

  @override
  List<Object> get props => [];

  factory VariantFrameWorkData.fromJson(Map<String, dynamic> json) =>
      _$VariantFrameWorkDataFromJson(json);

  Map<String, dynamic> toJson() => _$VariantFrameWorkDataToJson(this);
}

@JsonSerializable()
class BaseUomData extends Equatable {
  @JsonKey(name: 'uom_id')
  final int? uomId;
  @JsonKey(name: 'uom_code')
  final String? uomCode;
  @JsonKey(name: 'uom_name')
  final String? uomName;

  BaseUomData({
    this.uomId, this.uomName, this.uomCode,
  });

  @override
  List<Object> get props => [];

  factory BaseUomData.fromJson(Map<String, dynamic> json) =>
      _$BaseUomDataFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUomDataToJson(this);
}
@JsonSerializable()
class BarcodeData extends Equatable {

  @JsonKey(name: 'file_name')
  final String? fileName;
  @JsonKey(name: 'barcode_number')
  final String? barcodeNumber;


  BarcodeData( {
    this.barcodeNumber,
    this.fileName,
  });

  @override
  List<Object> get props => [];

  factory BarcodeData.fromJson(Map<String, dynamic> json) =>
      _$BarcodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeDataToJson(this);
}

@JsonSerializable()
class ReadStockData extends Equatable {


  @JsonKey(name: 'virtual_type')
  final List<String>? virtualType;
  @JsonKey(name: 'data')
  final StockDataModel? dataModel;

  ReadStockData({
    this.dataModel,
    this.virtualType,
  });

  @override
  List<Object> get props => [];

  factory ReadStockData.fromJson(Map<String, dynamic> json) =>
      _$ReadStockDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReadStockDataToJson(this);
}


@JsonSerializable()
class StockDataModel extends Equatable {

  final int? id;
  @JsonKey(name: 'inventory_id')
  final String? inventoryId;
  @JsonKey(name: 'base_uom_data')
  final BaseUomData? baseUomData;
  @JsonKey(name: 'sales_uom_code')
  final String? salesUomCode;
  @JsonKey(name: 'sales_uom')
  final String? salesUom;
  @JsonKey(name: 'sales_uom_name')
  final String? salesUomName;
  @JsonKey(name: 'stock_id')
  final int? stockId;
  @JsonKey(name: 'stock_code')
  final String? stockCode;
  @JsonKey(name: 'stock_data')
  final StockData? stockData;
  @JsonKey(name: 'website_status_medium_point')
  final int? websiteStatusMediumPoint;
  @JsonKey(name: 'website_status_crucial_point')
  final int? websiteStatusCrucialPoint;

  StockDataModel({
    this.id,
    this.inventoryId,
    this.salesUom,
    this.stockCode,
    this.stockId,
    this.salesUomCode,
    this.salesUomName,
    this.stockData,
    this.baseUomData,
    this.websiteStatusCrucialPoint,
    this.websiteStatusMediumPoint,
  });

  @override
  List<Object> get props => [];

  factory StockDataModel.fromJson(Map<String, dynamic> json) =>
      _$StockDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockDataModelToJson(this);
}


@JsonSerializable()
class StockData extends Equatable {

  final int? id;
  @JsonKey(name: 'stock_code')
  final String? stockCode;
  @JsonKey(name: 'available_qty')
  final int? availableQty;
  @JsonKey(name: 'base_uom')
  final int? baseUom;
  @JsonKey(name: 'base_uom_name')
  final String? baseUomName;
  @JsonKey(name: 'sales_uom')
  final int? salesUom;
  @JsonKey(name: 'sales_uom_name')
  final String? salesUomName;
  @JsonKey(name: 'website_status_medium_point')
  final int? websiteStatusMediumPoint;
  @JsonKey(name: 'website_status_crucial_point')
  final int? websiteStatusCrucialPoint;
  @JsonKey(name: 'stock_type_using')
  final String? stockTypeUsing;
  @JsonKey(name: 'is_daily_stock_available',defaultValue: false)
  final bool? isDailyStockAvailable;
  @JsonKey(name: 'daily_stock_quantity')
  final int? dailyStockQty;
  @JsonKey(name: 'virtual_stock')
  final int? virtualStock;
  @JsonKey(name: 'virtual_type')
  final String? virtualType;
  @JsonKey(name: 'cancelled_qty')
  final int? cancelledQty;
  @JsonKey(name: 'reserved_qty')
  final int? reservedQty;
  @JsonKey(name: 'damaged_qty')
  final int? damagedQty;
  @JsonKey(name: 'return_qty')
  final int? returnedQty;
  @JsonKey(name: 'replacement_qty')
  final int? replacementQty;

  StockData({
    this.id,
    this.websiteStatusCrucialPoint,
    this.websiteStatusMediumPoint,
    this.salesUomName,
    this.salesUom,
    this.availableQty,
    this.baseUom,
    this.baseUomName,
    this.cancelledQty,
    this.dailyStockQty,
    this.damagedQty,
    this.isDailyStockAvailable,
    this.reservedQty,
    this.replacementQty,
    this.returnedQty,
    this.stockCode,
    this.stockTypeUsing,
    this.virtualStock,
    this.virtualType,
  });

  @override
  List<Object> get props => [];

  factory StockData.fromJson(Map<String, dynamic> json) =>
      _$StockDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockDataToJson(this);
}


@JsonSerializable()
class CostingModel extends Equatable {

  final int? id;
  @JsonKey(name: 'type_code')
  final String? typeCode;
  @JsonKey(name: 'pricing_type_id')
  final int? pricingTypeId;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'type_name')
  final String? typeName;
  @JsonKey(name: 'method_name')
  final String? methodName;
  @JsonKey(name: 'method_code')
  final String? methodCode;
  @JsonKey(name: 'pricing_type_code')
  final String? pricingTypeCode;
  @JsonKey(name: 'pricing_type_name')
  final String? pricingTypeName;
  @JsonKey(name: 'pricing_group_code')
  final String? pricingGroupCode;
  @JsonKey(name: 'pricing_group_name')
  final String? pricingGroupName;
  @JsonKey(name: 'customer_group_code')
  final String? customerGroupCode;
  @JsonKey(name: 'method_type_id')
  final int? methodTypeId;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;


  CostingModel( {
    this.id,
    this.pricingTypeId,
    this.typeName,
    this.isActive,
    this.pricingGroupName,
    this.customerGroupCode,
    this.pricingGroupCode,
    this.methodName,
    this.pricingTypeName,
    this.pricingTypeCode,
    this.methodTypeId,
    this.methodCode,
    this.typeCode,
    this.description,
  });

  @override
  List<Object> get props => [];

  factory CostingModel.fromJson(Map<String, dynamic> json) =>
      _$CostingModelFromJson(json);

  Map<String, dynamic> toJson() => _$CostingModelToJson(this);
}

@JsonSerializable()
class ReadCostingVarient extends Equatable {

  final int? id;
  @JsonKey(name: 'inventory_id')
  final String? invId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'actual_cost')
  final double? actualCost;
  @JsonKey(name: 'stock_data')
  final StockDataModel? stockDataModel;

  ReadCostingVarient({
    this.stockDataModel,
    this.id,
    this.name,
    this.actualCost,
    this.invId,
  });

  @override
  List<Object> get props => [];

  factory ReadCostingVarient.fromJson(Map<String, dynamic> json) =>
      _$ReadCostingVarientFromJson(json);

  Map<String, dynamic> toJson() => _$ReadCostingVarientToJson(this);
}

@JsonSerializable()
class ReadCostingData extends Equatable {


  @JsonKey(name: 'pricing_gp_type')
  final List<String>? pricingGpType;
  @JsonKey(name: 'gp_operations')
  final List<String>? gpOperations;
  @JsonKey(name: 'price_type')
  final List<String>? priceType;
  @JsonKey(name: 'data')
  final ReadCostingVarient? dataModel;
  @JsonKey(name: 'costing_data')
  final CostingReadData? costingReadData;

  ReadCostingData({
    this.dataModel,
    this.costingReadData,
    this.pricingGpType,
    this.gpOperations,
    this.priceType,
  });

  @override
  List<Object> get props => [];

  factory ReadCostingData.fromJson(Map<String, dynamic> json) =>
      _$ReadCostingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReadCostingDataToJson(this);
}

@JsonSerializable()
class CostingReadData extends Equatable {


  final int? id;
  @JsonKey(name: 'costing_method_data')
  final CostingMethodData? costingMethodData;
  @JsonKey(name: 'pricing_group_data')
  final PricingGroupData? pricingGroupData;
  @JsonKey(name: 'stock_data')
  final StockDataModel? stockDataModel;
  @JsonKey(name: 'costing_code')
  final String? costingCode;
  @JsonKey(name: 'variant_id')
  final int? variantId;
  @JsonKey(name: 'variant_code')
  final String? variantCode;
  @JsonKey(name: 'channel_id')
  final int? channelId;
  @JsonKey(name: 'channel_code')
  final String? channelCode;
  @JsonKey(name: 'costing_name')
  final String? costingName;
  @JsonKey(name: 'inventory_id')
  final String? invId;
  @JsonKey(name: 'pricing_gp_type')
  final String? priceGpType;
  @JsonKey(name: 'gp_percentage')
  final double? gpPercentage;
  @JsonKey(name: 'gp_operation')
  final String? gpOperation;
  @JsonKey(name: 'unit_cost')
  final double? unitCost;
  @JsonKey(name: 'price_type')
  final String? priceType;
  @JsonKey(name: 'selling_price')
  final double? sellingPrice;
  @JsonKey(name: 'actual_selling_price')
  final double? actualSellingPrice;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;
  @JsonKey(name: 'stock_id')
  final int? stockId;
  @JsonKey(name: 'pricing_group_id')
  final int? pricingGroupId;
  @JsonKey(name: 'costing_method')
  final int? costMethod;

  CostingReadData({
    this.stockDataModel,
    this.costingMethodData,
    this.pricingGroupId,
    this.id,
    this.priceType,
    this.sellingPrice,
    this.channelCode,
    this.invId,
    this.unitCost,
    this.costingName,
    this.gpOperation,
    this.channelId,
    this.actualSellingPrice,
    this.stockId,
    this.variantId,
    this.isActive,
    this.variantCode,
    this.costingCode,
    this.costMethod,
    this.gpPercentage,
    this.priceGpType,
    this.pricingGroupData
    ,
  });

  @override
  List<Object> get props => [];

  factory CostingReadData.fromJson(Map<String, dynamic> json) =>
      _$CostingReadDataFromJson(json);

  Map<String, dynamic> toJson() => _$CostingReadDataToJson(this);
}

@JsonSerializable()
class CostingMethodData extends Equatable {


  @JsonKey(name: 'costing_method_code')
  final String? costingMethodCode;
  @JsonKey(name: 'costing_method_name')
  final String? costingMethodName;


  CostingMethodData({
    this.costingMethodCode,
    this.costingMethodName

  });

  @override
  List<Object> get props => [];

  factory CostingMethodData.fromJson(Map<String, dynamic> json) =>
      _$CostingMethodDataFromJson(json);

  Map<String, dynamic> toJson() => _$CostingMethodDataToJson(this);
}


@JsonSerializable()
class PricingGroupData extends Equatable {


  @JsonKey(name: 'pricing_group_code')
  final String? priceGroupCode;
  @JsonKey(name: 'pricing_group_name')
  final String? priceGroupName;


  PricingGroupData({
    this.priceGroupCode,
    this.priceGroupName

  });

  @override
  List<Object> get props => [];

  factory PricingGroupData.fromJson(Map<String, dynamic> json) =>
      _$PricingGroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$PricingGroupDataToJson(this);
}


@JsonSerializable()
class WarrantyTypeRead extends Equatable {


  final int? id;
  @JsonKey(name: 'warranty_type_code')
  final String? warrantyTypeCode;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'is_active',defaultValue: false)
  final bool? isActive;


  WarrantyTypeRead({
    this.id,
    this.title,
    this.isActive,
    this.description,
    this.warrantyTypeCode,


  });

  @override
  List<Object> get props => [];

  factory WarrantyTypeRead.fromJson(Map<String, dynamic> json) =>
      _$WarrantyTypeReadFromJson(json);

  Map<String, dynamic> toJson() => _$WarrantyTypeReadToJson(this);
}


