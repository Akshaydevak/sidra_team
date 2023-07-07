// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      warrantyTypeCode: json['warranty_type_code'] as String?,
      attributeName: json['attribute_name'] as String?,
      statnderdCode: json['standard_code'] as String?,
      conversionFactor: (json['conversion_factor'] as num?)?.toDouble(),
      uomCode: json['uom_code'] as String?,
      variantFrameWorkData: json['variant_framework_data'] == null
          ? null
          : VariantFrameWorkData.fromJson(
              json['variant_framework_data'] as Map<String, dynamic>),
      values:
          (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      warrantyCode: json['warranty_code'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      image1: json['image1'] as String?,
      barcode: json['barcode'] == null
          ? null
          : BarcodeData.fromJson(json['barcode'] as Map<String, dynamic>),
      code: json['code'] as String?,
      displayName: json['display_name'] as String?,
      baseUomData: json['base_uom_data'] == null
          ? null
          : BaseUomData.fromJson(json['base_uom_data'] as Map<String, dynamic>),
      attributeData: json['attribute_data'] == null
          ? null
          : AttributeData.fromJson(
              json['attribute_data'] as Map<String, dynamic>),
      stockCount: json['stock_count'] as int?,
      brandName: json['brand_name'] as String?,
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'title': instance.title,
      'image1': instance.image1,
      'stock_count': instance.stockCount,
      'warranty_code': instance.warrantyCode,
      'brand_name': instance.brandName,
      'code': instance.code,
      'barcode': instance.barcode,
      'display_name': instance.displayName,
      'variant_framework_data': instance.variantFrameWorkData,
      'base_uom_data': instance.baseUomData,
      'values': instance.values,
      'attribute_data': instance.attributeData,
      'warranty_type_code': instance.warrantyTypeCode,
      'attribute_name': instance.attributeName,
      'standard_code': instance.statnderdCode,
      'conversion_factor': instance.conversionFactor,
      'uom_code': instance.uomCode,
    };

AttributeData _$AttributeDataFromJson(Map<String, dynamic> json) =>
    AttributeData(
      attributeId: json['attribute_id'] as int?,
      attributeName: json['attribute_name'] as String?,
      attributeCode: json['attribute_code'] as String?,
    );

Map<String, dynamic> _$AttributeDataToJson(AttributeData instance) =>
    <String, dynamic>{
      'attribute_id': instance.attributeId,
      'attribute_name': instance.attributeName,
      'attribute_code': instance.attributeCode,
    };

VariantFrameWorkData _$VariantFrameWorkDataFromJson(
        Map<String, dynamic> json) =>
    VariantFrameWorkData(
      variantFrameworkId: json['variant_framework_id'] as int?,
      variantFrameworkName: json['variant_framework_name'] as String?,
      variantFrameworkCode: json['variant_framework_code'] as String?,
    );

Map<String, dynamic> _$VariantFrameWorkDataToJson(
        VariantFrameWorkData instance) =>
    <String, dynamic>{
      'variant_framework_id': instance.variantFrameworkId,
      'variant_framework_name': instance.variantFrameworkName,
      'variant_framework_code': instance.variantFrameworkCode,
    };

BaseUomData _$BaseUomDataFromJson(Map<String, dynamic> json) => BaseUomData(
      uomId: json['uom_id'] as int?,
      uomName: json['uom_name'] as String?,
      uomCode: json['uom_code'] as String?,
    );

Map<String, dynamic> _$BaseUomDataToJson(BaseUomData instance) =>
    <String, dynamic>{
      'uom_id': instance.uomId,
      'uom_code': instance.uomCode,
      'uom_name': instance.uomName,
    };

BarcodeData _$BarcodeDataFromJson(Map<String, dynamic> json) => BarcodeData(
      barcodeNumber: json['barcode_number'] as String?,
      fileName: json['file_name'] as String?,
    );

Map<String, dynamic> _$BarcodeDataToJson(BarcodeData instance) =>
    <String, dynamic>{
      'file_name': instance.fileName,
      'barcode_number': instance.barcodeNumber,
    };

ReadStockData _$ReadStockDataFromJson(Map<String, dynamic> json) =>
    ReadStockData(
      dataModel: json['data'] == null
          ? null
          : StockDataModel.fromJson(json['data'] as Map<String, dynamic>),
      virtualType: (json['virtual_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReadStockDataToJson(ReadStockData instance) =>
    <String, dynamic>{
      'virtual_type': instance.virtualType,
      'data': instance.dataModel,
    };

StockDataModel _$StockDataModelFromJson(Map<String, dynamic> json) =>
    StockDataModel(
      id: json['id'] as int?,
      inventoryId: json['inventory_id'] as String?,
      salesUom: json['sales_uom'] as String?,
      stockCode: json['stock_code'] as String?,
      stockId: json['stock_id'] as int?,
      salesUomCode: json['sales_uom_code'] as String?,
      salesUomName: json['sales_uom_name'] as String?,
      stockData: json['stock_data'] == null
          ? null
          : StockData.fromJson(json['stock_data'] as Map<String, dynamic>),
      baseUomData: json['base_uom_data'] == null
          ? null
          : BaseUomData.fromJson(json['base_uom_data'] as Map<String, dynamic>),
      websiteStatusCrucialPoint: json['website_status_crucial_point'] as int?,
      websiteStatusMediumPoint: json['website_status_medium_point'] as int?,
    );

Map<String, dynamic> _$StockDataModelToJson(StockDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventory_id': instance.inventoryId,
      'base_uom_data': instance.baseUomData,
      'sales_uom_code': instance.salesUomCode,
      'sales_uom': instance.salesUom,
      'sales_uom_name': instance.salesUomName,
      'stock_id': instance.stockId,
      'stock_code': instance.stockCode,
      'stock_data': instance.stockData,
      'website_status_medium_point': instance.websiteStatusMediumPoint,
      'website_status_crucial_point': instance.websiteStatusCrucialPoint,
    };

StockData _$StockDataFromJson(Map<String, dynamic> json) => StockData(
      id: json['id'] as int?,
      websiteStatusCrucialPoint: json['website_status_crucial_point'] as int?,
      websiteStatusMediumPoint: json['website_status_medium_point'] as int?,
      salesUomName: json['sales_uom_name'] as String?,
      salesUom: json['sales_uom'] as int?,
      availableQty: json['available_qty'] as int?,
      baseUom: json['base_uom'] as int?,
      baseUomName: json['base_uom_name'] as String?,
      cancelledQty: json['cancelled_qty'] as int?,
      dailyStockQty: json['daily_stock_quantity'] as int?,
      damagedQty: json['damaged_qty'] as int?,
      isDailyStockAvailable: json['is_daily_stock_available'] as bool? ?? false,
      reservedQty: json['reserved_qty'] as int?,
      replacementQty: json['replacement_qty'] as int?,
      returnedQty: json['return_qty'] as int?,
      stockCode: json['stock_code'] as String?,
      stockTypeUsing: json['stock_type_using'] as String?,
      virtualStock: json['virtual_stock'] as int?,
      virtualType: json['virtual_type'] as String?,
    );

Map<String, dynamic> _$StockDataToJson(StockData instance) => <String, dynamic>{
      'id': instance.id,
      'stock_code': instance.stockCode,
      'available_qty': instance.availableQty,
      'base_uom': instance.baseUom,
      'base_uom_name': instance.baseUomName,
      'sales_uom': instance.salesUom,
      'sales_uom_name': instance.salesUomName,
      'website_status_medium_point': instance.websiteStatusMediumPoint,
      'website_status_crucial_point': instance.websiteStatusCrucialPoint,
      'stock_type_using': instance.stockTypeUsing,
      'is_daily_stock_available': instance.isDailyStockAvailable,
      'daily_stock_quantity': instance.dailyStockQty,
      'virtual_stock': instance.virtualStock,
      'virtual_type': instance.virtualType,
      'cancelled_qty': instance.cancelledQty,
      'reserved_qty': instance.reservedQty,
      'damaged_qty': instance.damagedQty,
      'return_qty': instance.returnedQty,
      'replacement_qty': instance.replacementQty,
    };

CostingModel _$CostingModelFromJson(Map<String, dynamic> json) => CostingModel(
      id: json['id'] as int?,
      pricingTypeId: json['pricing_type_id'] as int?,
      typeName: json['type_name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      pricingGroupName: json['pricing_group_name'] as String?,
      customerGroupCode: json['customer_group_code'] as String?,
      pricingGroupCode: json['pricing_group_code'] as String?,
      methodName: json['method_name'] as String?,
      pricingTypeName: json['pricing_type_name'] as String?,
      pricingTypeCode: json['pricing_type_code'] as String?,
      methodTypeId: json['method_type_id'] as int?,
      methodCode: json['method_code'] as String?,
      typeCode: json['type_code'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CostingModelToJson(CostingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_code': instance.typeCode,
      'pricing_type_id': instance.pricingTypeId,
      'description': instance.description,
      'type_name': instance.typeName,
      'method_name': instance.methodName,
      'method_code': instance.methodCode,
      'pricing_type_code': instance.pricingTypeCode,
      'pricing_type_name': instance.pricingTypeName,
      'pricing_group_code': instance.pricingGroupCode,
      'pricing_group_name': instance.pricingGroupName,
      'customer_group_code': instance.customerGroupCode,
      'method_type_id': instance.methodTypeId,
      'is_active': instance.isActive,
    };

ReadCostingVarient _$ReadCostingVarientFromJson(Map<String, dynamic> json) =>
    ReadCostingVarient(
      stockDataModel: json['stock_data'] == null
          ? null
          : StockDataModel.fromJson(json['stock_data'] as Map<String, dynamic>),
      id: json['id'] as int?,
      name: json['name'] as String?,
      actualCost: (json['actual_cost'] as num?)?.toDouble(),
      invId: json['inventory_id'] as String?,
    );

Map<String, dynamic> _$ReadCostingVarientToJson(ReadCostingVarient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventory_id': instance.invId,
      'name': instance.name,
      'actual_cost': instance.actualCost,
      'stock_data': instance.stockDataModel,
    };

ReadCostingData _$ReadCostingDataFromJson(Map<String, dynamic> json) =>
    ReadCostingData(
      dataModel: json['data'] == null
          ? null
          : ReadCostingVarient.fromJson(json['data'] as Map<String, dynamic>),
      costingReadData: json['costing_data'] == null
          ? null
          : CostingReadData.fromJson(
              json['costing_data'] as Map<String, dynamic>),
      pricingGpType: (json['pricing_gp_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gpOperations: (json['gp_operations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      priceType: (json['price_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReadCostingDataToJson(ReadCostingData instance) =>
    <String, dynamic>{
      'pricing_gp_type': instance.pricingGpType,
      'gp_operations': instance.gpOperations,
      'price_type': instance.priceType,
      'data': instance.dataModel,
      'costing_data': instance.costingReadData,
    };

CostingReadData _$CostingReadDataFromJson(Map<String, dynamic> json) =>
    CostingReadData(
      stockDataModel: json['stock_data'] == null
          ? null
          : StockDataModel.fromJson(json['stock_data'] as Map<String, dynamic>),
      costingMethodData: json['costing_method_data'] == null
          ? null
          : CostingMethodData.fromJson(
              json['costing_method_data'] as Map<String, dynamic>),
      pricingGroupId: json['pricing_group_id'] as int?,
      id: json['id'] as int?,
      priceType: json['price_type'] as String?,
      sellingPrice: (json['selling_price'] as num?)?.toDouble(),
      channelCode: json['channel_code'] as String?,
      invId: json['inventory_id'] as String?,
      unitCost: (json['unit_cost'] as num?)?.toDouble(),
      costingName: json['costing_name'] as String?,
      gpOperation: json['gp_operation'] as String?,
      channelId: json['channel_id'] as int?,
      actualSellingPrice: (json['actual_selling_price'] as num?)?.toDouble(),
      stockId: json['stock_id'] as int?,
      variantId: json['variant_id'] as int?,
      isActive: json['is_active'] as bool? ?? false,
      variantCode: json['variant_code'] as String?,
      costingCode: json['costing_code'] as String?,
      costMethod: json['costing_method'] as int?,
      gpPercentage: (json['gp_percentage'] as num?)?.toDouble(),
      priceGpType: json['pricing_gp_type'] as String?,
      pricingGroupData: json['pricing_group_data'] == null
          ? null
          : PricingGroupData.fromJson(
              json['pricing_group_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostingReadDataToJson(CostingReadData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'costing_method_data': instance.costingMethodData,
      'pricing_group_data': instance.pricingGroupData,
      'stock_data': instance.stockDataModel,
      'costing_code': instance.costingCode,
      'variant_id': instance.variantId,
      'variant_code': instance.variantCode,
      'channel_id': instance.channelId,
      'channel_code': instance.channelCode,
      'costing_name': instance.costingName,
      'inventory_id': instance.invId,
      'pricing_gp_type': instance.priceGpType,
      'gp_percentage': instance.gpPercentage,
      'gp_operation': instance.gpOperation,
      'unit_cost': instance.unitCost,
      'price_type': instance.priceType,
      'selling_price': instance.sellingPrice,
      'actual_selling_price': instance.actualSellingPrice,
      'is_active': instance.isActive,
      'stock_id': instance.stockId,
      'pricing_group_id': instance.pricingGroupId,
      'costing_method': instance.costMethod,
    };

CostingMethodData _$CostingMethodDataFromJson(Map<String, dynamic> json) =>
    CostingMethodData(
      costingMethodCode: json['costing_method_code'] as String?,
      costingMethodName: json['costing_method_name'] as String?,
    );

Map<String, dynamic> _$CostingMethodDataToJson(CostingMethodData instance) =>
    <String, dynamic>{
      'costing_method_code': instance.costingMethodCode,
      'costing_method_name': instance.costingMethodName,
    };

PricingGroupData _$PricingGroupDataFromJson(Map<String, dynamic> json) =>
    PricingGroupData(
      priceGroupCode: json['pricing_group_code'] as String?,
      priceGroupName: json['pricing_group_name'] as String?,
    );

Map<String, dynamic> _$PricingGroupDataToJson(PricingGroupData instance) =>
    <String, dynamic>{
      'pricing_group_code': instance.priceGroupCode,
      'pricing_group_name': instance.priceGroupName,
    };

WarrantyTypeRead _$WarrantyTypeReadFromJson(Map<String, dynamic> json) =>
    WarrantyTypeRead(
      id: json['id'] as int?,
      title: json['title'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      description: json['description'] as String?,
      warrantyTypeCode: json['warranty_type_code'] as String?,
    );

Map<String, dynamic> _$WarrantyTypeReadToJson(WarrantyTypeRead instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warranty_type_code': instance.warrantyTypeCode,
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
    };
