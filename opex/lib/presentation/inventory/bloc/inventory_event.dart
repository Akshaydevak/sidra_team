
part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];

}

class GetDivisionEvent extends InventoryEvent {
  final String? search,url;
  // final User? user;
  const GetDivisionEvent({this.search,this.url});
}
class GetCategoryEvent extends InventoryEvent {
  final int? id;
  final String? search,url;
  const GetCategoryEvent({this.id,this.search,this.url});
}class GetSubCategoryEvent extends InventoryEvent {
  final int? id;
  final String? search,url;
  const GetSubCategoryEvent({this.id,this.search,this.url});
}class GetGroupEvent extends InventoryEvent {
  final int? id;
  final String? search,url;
  const GetGroupEvent({this.id,this.search,this.url});
}class GetItemEvent extends InventoryEvent {
  final int? id;
  final String? search,url;
  const GetItemEvent({this.id,this.search,this.url});
}class GetUomEvent extends InventoryEvent {
  final int? id;
  final String? search,url;
  const GetUomEvent({this.id,this.search,this.url});
}class GetSalesUomEvent extends InventoryEvent {
  final int? id;
  final String? search;
  const GetSalesUomEvent({this.id,this.search});
}
class GetvariantEvent extends InventoryEvent {
  final int? id,itemId;
  final String? search;
  const GetvariantEvent({this.id,this.search,this.itemId});
}

class GetCombinationEvent extends InventoryEvent {
  final int? id;
  // final String? search;
  const GetCombinationEvent({this.id});
}

class GetChannelEvent extends InventoryEvent {

  const GetChannelEvent();
}
class GetManufactureEvent extends InventoryEvent {
final String? search,url;
  const GetManufactureEvent({this.search,this.url});
}


class PicEvent extends InventoryEvent {
  final File? image;
  const PicEvent({this.image});
}
class VariantEvent extends InventoryEvent {
  final CreateVariantModel? variantModel;
  const VariantEvent({this.variantModel});
}
class ReturnTypeEvent extends InventoryEvent {

  const ReturnTypeEvent();
}
class GetSiblingEvent extends InventoryEvent {

  const GetSiblingEvent();
}
class GetInventoryEvent extends InventoryEvent {

  const GetInventoryEvent();
}
class ListVariantEvent extends InventoryEvent {
final String? url,search;
  const ListVariantEvent({this.url,this.search});
}
class ReadVariantEvent extends InventoryEvent {
final int? id;
final CreateVariantModel? dataModel;
  const ReadVariantEvent({this.id,this.dataModel});
}
class UpdateVariantEvent extends InventoryEvent {
final CreateVariantModel? dataModel;
final int? id;
  const UpdateVariantEvent({this.dataModel,this.id});
}
class DeleteVariantEvent extends InventoryEvent {
// final CreateVariantModel? dataModel;
final int? id;
  const DeleteVariantEvent({this.id});
}
class GetStockPartitionEvent extends InventoryEvent {
  final String? id;
  final String? search;
  final String? url;
  const GetStockPartitionEvent({this.id,this.search,this.url});
}

//STOCK INVENTORY
class ProductStockListEvent extends InventoryEvent {
  final String code;
  final String prev;
  const ProductStockListEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code];
}

class ReadStockProductEvent extends InventoryEvent {
  final int variantId;
  const ReadStockProductEvent(this.variantId);
  @override
  List<Object> get props => [this.variantId];
}

class CreateVirtualStockPostEvent extends InventoryEvent {
  final String inventoryId;
  final String? channelId;
  final String? channelCode;
  final int variantId;
  final String variantCode;
  final bool stockWarning;
  final int? crucialPoint;
  final int? mediumPoint;
  final int addVirtualStock;
  final String virtualType;
  final bool isDailyStockAvailable;
  final int dailyStockQty;

  CreateVirtualStockPostEvent( {
    required this.dailyStockQty,
    required this.isDailyStockAvailable,
    required this.virtualType,
    required this.variantId,
    required this.variantCode,
    required this.addVirtualStock,
    required this.channelId,
    required this.crucialPoint,
    required this.mediumPoint,
    required this.stockWarning,
    required this.channelCode,
    required this.inventoryId,
  });
  @override
  List<Object> get props => [
    variantCode,
  ];
}

class CreateCostingMethodTypeEvent extends InventoryEvent {
  final String typeName;
  final String discription;
  final String createdBy;

  CreateCostingMethodTypeEvent( {
    required this.createdBy,
    required this.discription,
    required this.typeName,

  });
  @override
  List<Object> get props => [
    typeName,
  ];
}

class CostMethodTypeListEvent extends InventoryEvent {
  final String code;
  final String prev;
  const CostMethodTypeListEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code];
}

class GetCostMethodTypeReadEvent extends InventoryEvent {
  final int id;
  const GetCostMethodTypeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteCostMethodTypeEvent extends InventoryEvent {
  final int id;
  const DeleteCostMethodTypeEvent(this.id);
}
//updateDiscount
class UpdateCostMethodTypeEvent extends InventoryEvent {
  final String typeName;
  final int id;
  final String discription;
  final String createdBy;
  final bool isActive;
  const UpdateCostMethodTypeEvent( {
    required this.typeName,
    required this.id,
    required this.discription,
    required this.isActive,
    required this.createdBy,
  });
  @override
  List<Object> get props => [
    typeName,
  ];
}

//costingmethod
class CostingMethodCreateEvent extends InventoryEvent {
  final String methodName;
  final int methodTypeId;
  final String discription;
  final String createdBy;

  CostingMethodCreateEvent( {
    required this.createdBy,
    required this.discription,
    required this.methodName,
    required this.methodTypeId,

  });
  @override
  List<Object> get props => [
    methodName,
  ];
}

class CostMethodListEvent extends InventoryEvent {
  final String code;
  final String prev;
  const CostMethodListEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code];
}

class GetCostMethodReadEvent extends InventoryEvent {
  final int id;
  const GetCostMethodReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteCostMethodEvent extends InventoryEvent {
  final int id;
  const DeleteCostMethodEvent(this.id);
}
//updateDiscount
class UpdateCostMethodEvent extends InventoryEvent {
  final String methodName;
  final int methodTypeId;
  final String discription;
  final String createdBy;
  final int id;
  final bool isActive;
  const UpdateCostMethodEvent( {
    required this.methodTypeId,
    required this.methodName,
    required this.id,
    required this.discription,
    required this.isActive,
    required this.createdBy,
  });
  @override
  List<Object> get props => [
    methodName,
  ];
}

//processType
class PricingTypeCreateEvent extends InventoryEvent {
  final String pricingTypeName;
  final String discription;
  final String createdBy;

  PricingTypeCreateEvent( {
    required this.createdBy,
    required this.discription,
    required this.pricingTypeName,


  });
  @override
  List<Object> get props => [
    pricingTypeName,
  ];
}

class PricingTypeListEvent extends InventoryEvent {
  final String code;
  final String prev;
  const PricingTypeListEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code];
}

class PricingTypeReadEvent extends InventoryEvent {
  final int id;
  const PricingTypeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeletePricingTypeEvent extends InventoryEvent {
  final int id;
  const DeletePricingTypeEvent(this.id);
}
//updateDiscount
class UpdatePricingTypeEvent extends InventoryEvent {
  final String pricingTypeName;
  final String pricingTypeCode;
  final String discription;
  final String createdBy;
  final int id;
  final bool isActive;
  const UpdatePricingTypeEvent( {
    required this.pricingTypeName,
    required this.pricingTypeCode,
    required this.id,
    required this.discription,
    required this.isActive,
    required this.createdBy,
  });
  @override
  List<Object> get props => [
    pricingTypeName,
  ];
}

//priceGroup
class PricingGroupCreateEvent extends InventoryEvent {
  final int priceTypeId;
  final String pricingGroupName;
  final String customerGroupCode;
  final String discription;
  final String createdBy;

  PricingGroupCreateEvent( {
    required this.createdBy,
    required this.discription,
    required this.priceTypeId,
    required this.customerGroupCode,
    required this.pricingGroupName,


  });
  @override
  List<Object> get props => [
    pricingGroupName,
  ];
}

class PricingGroupListEvent extends InventoryEvent {
  final String code;
  final String prev;
  const PricingGroupListEvent(this.code,this.prev);
  @override
  List<Object> get props => [this.code];
}

class PricingGroupReadEvent extends InventoryEvent {
  final int id;
  const PricingGroupReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeletePricingGroupEvent extends InventoryEvent {
  final int id;
  const DeletePricingGroupEvent(this.id);
}
//updateDiscount
class UpdatePricingGroupEvent extends InventoryEvent {
  final int pricingTypeId;
  final String pricingGroupName;
  final String customerGroupCode;
  final String discription;
  final String createdBy;
  final int id;
  final bool isActive;
  const UpdatePricingGroupEvent( {
    required this.pricingGroupName,
    required this.customerGroupCode,
    required this.pricingTypeId,
    required this.id,
    required this.discription,
    required this.isActive,
    required this.createdBy,
  });
  @override
  List<Object> get props => [
    pricingGroupName,
  ];
}

//readPriceGpType
class PricingGpTypeReadEvent extends InventoryEvent {
  final int id;
  const PricingGpTypeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//
class GPPercentagePostEvent extends InventoryEvent {
  final int variantId;
  final String inventoryId;
  final String GPType;

  GPPercentagePostEvent( {
    required this.inventoryId,
    required this.variantId,
    required this.GPType,
  });
  @override
  List<Object> get props => [
    GPType,
  ];
}

//costingCreattion
class CostingCreationPostEvent extends InventoryEvent {
  final int pricingGroupId;
  final String pricingGpType;
  final double GpPercentage;
  final double sellingPrice;
  final int costingMethodId;
  final String? channelCode;
  final int varientId;
  final String varientCode;
  final String invId;
  final double unitCost;
  final String costingName;
  final String createdBy;
  final String gpOperation;
  final String pricrType;
  final String? channelId;
  final double actualSellingPrice;
  final double actualcost;
  final String stockCode;

  CostingCreationPostEvent( {
    required this.actualcost,
    required this.stockCode,
    required this.invId,
    required this.pricingGpType,
    required this.createdBy,
    required this.channelId,
    required this.channelCode,
    required this.sellingPrice,
    required this.actualSellingPrice,
    required this.costingMethodId,
    required this.costingName,
    required this.gpOperation,
    required this.GpPercentage,
    required this.pricingGroupId,
    required this.pricrType,
    required this.unitCost,
    required this.varientCode,
    required this.varientId,
  });
  @override
  List<Object> get props => [
    varientCode,
  ];
}

//
class CostingListEvent extends InventoryEvent {
  final String code;
  final String prev;
  final int variantId;
  const CostingListEvent(this.code,this.prev,this.variantId);
  @override
  List<Object> get props => [this.code];
}

class CostingReadEvent extends InventoryEvent {
  final int id;
  const CostingReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}

//updateDiscount
class UpdateCostingEvent extends InventoryEvent {
  final int id;
  final int pricingGroupId;
  final String pricingGpType;
  final double GpPercentage;
  final double sellingPrice;
  final int costingMethodId;
  final String? channelCode;
  final int varientId;
  final String varientCode;
  final String invId;
  final double unitCost;
  final String costingName;
  final String createdBy;
  final String gpOperation;
  final String pricrType;
  final String? channelId;
  final double actualSellingPrice;
  final double actualcost;
  final String stockCode;
  const UpdateCostingEvent( {
    required this.id,
    required this.actualcost,
    required this.stockCode,
    required this.invId,
    required this.pricingGpType,
    required this.createdBy,
    required this.channelId,
    required this.channelCode,
    required this.sellingPrice,
    required this.actualSellingPrice,
    required this.costingMethodId,
    required this.costingName,
    required this.gpOperation,
    required this.GpPercentage,
    required this.pricingGroupId,
    required this.pricrType,
    required this.unitCost,
    required this.varientCode,
    required this.varientId,
  });
  @override
  List<Object> get props => [
    varientCode,
  ];
}

//Division
class DivisionCreateEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String searchName;
  final String displayName;
  final String description;

  DivisionCreateEvent( {
    required this.name,
    required this.description,
    required this.image,
    required this.displayName,
    required this.prioriy,
    required this.searchName,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class DivisionReadEvent extends InventoryEvent {
  final int id;
  const DivisionReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteDivisionEvent extends InventoryEvent {
  final int id;
  const DeleteDivisionEvent(this.id);
}
//updateDiscount
class UpdateDivisionEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String searchName;
  final String displayName;
  final String description;
  final int id;
  final bool isActive;
  const UpdateDivisionEvent( {
    required this.name,
    required this.searchName,
    required this.prioriy,
    required this.id,
    required this.displayName,
    required this.isActive,
    required this.image,
    required this.description,
  });
  @override
  List<Object> get props => [
    name,
  ];
}


//category
class CategoryCreateEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String altName;
  final String parentCode;
  final String divisionCode;
  final String description;

  CategoryCreateEvent( {
    required this.name,
    required this.description,
    required this.image,
    required this.altName,
    required this.prioriy,
    required this.divisionCode,
    required this.parentCode,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetCategoryListEvent extends InventoryEvent {
  final String? search;
 final String? next;
 final String? prev;
  // final User? user;
  const GetCategoryListEvent(this.search, this.next, this.prev);
}


class GetDivisionListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  // final User? user;
  const GetDivisionListEvent(this.search, this.next, this.prev);
}

class CategoryReadEvent extends InventoryEvent {
  final int id;
  const CategoryReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteCategoryEvent extends InventoryEvent {
  final int id;
  const DeleteCategoryEvent(this.id);
}
//updateDiscount
class UpdateCategoryEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String altName;
  final String divisionCode;
  final String parentCode;
  final String description;
  final int id;
  final bool isActive;
  const UpdateCategoryEvent( {
    required this.name,
    required this.altName,
    required this.prioriy,
    required this.id,
    required this.parentCode,
    required this.isActive,
    required this.image,
    required this.divisionCode,
    required this.description,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//group
class GroupCreateEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String categoryCode;
  final String searchName;
  final String displayName;
  final String description;

  GroupCreateEvent( {
    required this.name,
    required this.description,
    required this.image,
    required this.searchName,
    required this.prioriy,
    required this.displayName,
    required this.categoryCode,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetGroupListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  // final User? user;
  const GetGroupListEvent(this.search, this.next, this.prev);
}

class GroupReadEvent extends InventoryEvent {
  final int id;
  const GroupReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteGroupEvent extends InventoryEvent {
  final int id;
  const DeleteGroupEvent(this.id);
}
//updateDiscount
class UpdateGroupEvent extends InventoryEvent {
  final int prioriy;
  final dynamic image;
  final String name;
  final String categoryCode;
  final String searchName;
  final String displayName;
  final String description;
  final int id;
  final bool isActive;
  const UpdateGroupEvent( {
    required this.name,
    required this.categoryCode,
    required this.prioriy,
    required this.id,
    required this.displayName,
    required this.isActive,
    required this.image,
    required this.searchName,
    required this.description,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//UomGroup
class UomGroupCreateEvent extends InventoryEvent {
  final String name;
  final String shortName;
  final String description;

  UomGroupCreateEvent( {
    required this.name,
    required this.description,
    required this.shortName,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetUomGroupListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetUomGroupListEvent(this.search, this.next, this.prev);
}

class UomGroupReadEvent extends InventoryEvent {
  final int id;
  const UomGroupReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteUomGroupEvent extends InventoryEvent {
  final int id;
  const DeleteUomGroupEvent(this.id);
}
//updateDiscount
class UpdateUomGroupEvent extends InventoryEvent {
  final String name;
  final String shortName;
  final String description;
  final int id;
  final bool isActive;
  const UpdateUomGroupEvent( {
    required this.name,
    required this.shortName,
    required this.id,
    required this.isActive,
    required this.description,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//UOm
class UomCreateEvent extends InventoryEvent {
  final String name;
  final String shortName;
  final String baseEquvalant;
  final String uomGroupCode;
  final double convertionFactor;
  final String statnderdCode;

  UomCreateEvent( {
    required this.name,
    required this.baseEquvalant,
    required this.convertionFactor,
    required this.statnderdCode,
    required this.uomGroupCode,
    required this.shortName,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetUomListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetUomListEvent(this.search, this.next, this.prev);
}

class UomReadEvent extends InventoryEvent {
  final int id;
  const UomReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteUomEvent extends InventoryEvent {
  final int id;
  const DeleteUomEvent(this.id);
}
//updateDiscount
class UpdateUomEvent extends InventoryEvent {
  final String name;
  final String shortName;
  final String baseEquvalant;
  final String uomGroupCode;
  final double convertionFactor;
  final String statnderdCode;
  final int id;
  final bool isActive;
  const UpdateUomEvent( {
    required this.name,
    required this.shortName,
    required this.id,
    required this.isActive,
    required this.statnderdCode,
    required this.convertionFactor,
    required this.uomGroupCode,
    required this.baseEquvalant,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//Material
class MaterialCreateEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final String searchNmae;
  final String discription;
  MaterialCreateEvent( {
    required this.name,
    required this.image,
    required this.discription,
    required this.searchNmae,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetMaterialListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetMaterialListEvent(this.search, this.next, this.prev);
}

class MaterialReadEvent extends InventoryEvent {
  final int id;
  const MaterialReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteMaterialEvent extends InventoryEvent {
  final int id;
  const DeleteMaterialEvent(this.id);
}
//updateDiscount
class UpdateMaterialEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final String searchNmael;
  final String code;
  final String discription;
  final int id;
  final bool isActive;
  const UpdateMaterialEvent( {
    required this.name,
    required this.discription,
    required this.id,
    required this.isActive,
    required this.code,
    required this.image,
    required this.searchNmael,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//staticgroup
class StaticGroupCreateEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final String searchNmae;
  final String discription;
  StaticGroupCreateEvent( {
    required this.name,
    required this.image,
    required this.discription,
    required this.searchNmae,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetStaticGroupListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetStaticGroupListEvent(this.search, this.next, this.prev);
}

class StaticGroupReadEvent extends InventoryEvent {
  final int id;
  const StaticGroupReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteStaticGroupEvent extends InventoryEvent {
  final int id;
  const DeleteStaticGroupEvent(this.id);
}
//updateDiscount
class UpdateStaticGroupEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final String searchNmael;
  final String discription;
  final int id;
  final bool isActive;
  const UpdateStaticGroupEvent( {
    required this.name,
    required this.discription,
    required this.id,
    required this.isActive,
    required this.image,
    required this.searchNmael,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//brand
class BrandCreateEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final int priority;
  final String parentCode;
  final String discription;
  final String brandIdentifierUrl;
  BrandCreateEvent( {
    required this.name,
    required this.image,
    required this.discription,
    required this.priority,
    required this.brandIdentifierUrl,
    required this.parentCode,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetBrandListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetBrandListEvent(this.search, this.next, this.prev);
}

class BrandReadEvent extends InventoryEvent {
  final int id;
  const BrandReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteBrandEvent extends InventoryEvent {
  final int id;
  const DeleteBrandEvent(this.id);
}
//updateDiscount
class UpdateBrandEvent extends InventoryEvent {
  final String name;
  final dynamic image;
  final int priority;
  final String parentCode;
  final String discription;
  final String brandIdentifierUrl;
  final int id;
  final bool isActive;
  const UpdateBrandEvent( {
    required this.name,
    required this.discription,
    required this.id,
    required this.isActive,
    required this.image,
    required this.brandIdentifierUrl,
    required this.priority,
    required this.parentCode,
  });
  @override
  List<Object> get props => [
    name,
  ];
}

//attribute
class GetAttributeTypeEvent extends InventoryEvent {
  const GetAttributeTypeEvent();
  @override
  List<Object> get props => [];
}

class AttributeCreateEvent extends InventoryEvent {
  final String attributeName;
  final String attributeType;
  final bool isActive;
  AttributeCreateEvent( {
    required this.isActive,
    required this.attributeName,
    required this.attributeType,


  });
  @override
  List<Object> get props => [
    attributeName,
  ];
}

class GetAttributeListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetAttributeListEvent(this.search, this.next, this.prev);
}

class AttributeReadEvent extends InventoryEvent {
  final int id;
  const AttributeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteAttributeEvent extends InventoryEvent {
  final int id;
  const DeleteAttributeEvent(this.id);
}
//updateDiscount
class UpdateAttributeEvent extends InventoryEvent {
  final String attributeName;
  final String attributeType;
  final int id;
  final bool isActive;
  const UpdateAttributeEvent( {
    required this.attributeType,
    required this.attributeName,
    required this.id,
    required this.isActive,

  });
  @override
  List<Object> get props => [
    attributeType,
  ];
}

//varianetFramework
class VarientFrameworkCreateEvent extends InventoryEvent {
  final String name;
  final String description;
  final List<AttributeLines> lines;
  VarientFrameworkCreateEvent( {
    required this.lines,
    required this.name,
    required this.description,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetVarientFrameworkListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetVarientFrameworkListEvent(this.search, this.next, this.prev);
}

class VarientFrameworkReadEvent extends InventoryEvent {
  final int id;
  const VarientFrameworkReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteVarientFrameworkEvent extends InventoryEvent {
  final int id;
  const DeleteVarientFrameworkEvent(this.id);
}
//updateDiscount
class UpdateVarientFrameworkEvent extends InventoryEvent {
  final String name;
  final String description;
  final List<AttributeLines> lines;
  final int id;
  final bool isActive;
  const UpdateVarientFrameworkEvent( {
    required this.name,
    required this.description,
    required this.lines,
    required this.id,
    required this.isActive,

  });
  @override
  List<Object> get props => [
    name,
  ];
}


//items
class ItemCreateEvent extends InventoryEvent {
  final String name;
  final String description;
  final String materialCode;
  final String uomgroupCode;
  final String uomCode;
  final String groupCode;
  final String brandCode;
  final String staticGroupCode;
  final String variantFrameworkCode;
  final int? img1;
  final int? img2;
  final int? img3;
  final int? itemCatalog1;
  final int? itemCatalog2;
  final int? itemCatalog3;
  final int? itemCatalog4;
  final int? itemCatalog5;
  final String displayName;
  final String barcode;
  final String oldSystemCode;
  final String searchName;
  ItemCreateEvent( {
    required this.searchName,
    required this.displayName,
    required this.barcode,
    required this.brandCode,
    required this.groupCode,
    required this.itemCatalog1,
    required this.itemCatalog2,
    required this.itemCatalog3,
    required this.itemCatalog4,
    required this.itemCatalog5,
    required this.materialCode,
    required this.oldSystemCode,
    required this.staticGroupCode,
    required this.uomCode,
    required this.uomgroupCode,
    required this.variantFrameworkCode,
    required this.img3,
    required this.img2,
    required this.img1,
    required this.name,
    required this.description,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetItemListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetItemListEvent(this.search, this.next, this.prev);
}

class ItemReadEvent extends InventoryEvent {
  final int id;
  const ItemReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteItemEvent extends InventoryEvent {
  final int id;
  const DeleteItemEvent(this.id);
}
//updateDiscount
class UpdateItemEvent extends InventoryEvent {
  final String name;
  final String description;
  final String materialCode;
  final String uomgroupCode;
  final String uomCode;
  final String groupCode;
  final String brandCode;
  final String staticGroupCode;
  final String variantFrameworkCode;
  final dynamic? img1;
  final dynamic? img2;
  final dynamic? img3;
  final dynamic? itemCatalog1;
  final dynamic? itemCatalog2;
  final dynamic? itemCatalog3;
  final dynamic? itemCatalog4;
  final dynamic? itemCatalog5;
  final String displayName;
  final String barcode;
  final String oldSystemCode;
  final String searchName;
  final int id;
  final bool isActive;
  const UpdateItemEvent( {
    required this.searchName,
    required this.displayName,
    required this.barcode,
    required this.brandCode,
    required this.groupCode,
    required this.itemCatalog1,
    required this.itemCatalog2,
    required this.itemCatalog3,
    required this.itemCatalog4,
    required this.itemCatalog5,
    required this.materialCode,
    required this.oldSystemCode,
    required this.staticGroupCode,
    required this.uomCode,
    required this.uomgroupCode,
    required this.variantFrameworkCode,
    required this.img3,
    required this.img2,
    required this.img1,
    required this.name,
    required this.description,
    required this.id,
    required this.isActive,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

//listing for segment
class GetGroupListSegmentEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetGroupListSegmentEvent(this.search, this.next, this.prev);
}

class GetUomListSegmentEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetUomListSegmentEvent(this.search, this.next, this.prev);
}

class GetCategoryListSegmentEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetCategoryListSegmentEvent(this.search, this.next, this.prev);
}


//

class DivisionConfigurationCreateEvent extends InventoryEvent {
  final String name;
  final String description;
  final dynamic image;
  final bool isMixed;
  final int priority;
  final List<String> uomGroup;
  final List<String> grroup;
  final List<String> categoey;
  DivisionConfigurationCreateEvent( {

    required this.priority,
    required this.categoey,
    required this.grroup,
    required this.isMixed,
    required this.uomGroup,
    required this.image,
    required this.name,
    required this.description,


  });
  @override
  List<Object> get props => [
    name,
  ];
}

class GetDivisionConfigurationListEvent extends InventoryEvent {
  final String? search;
  final String? next;
  final String? prev;
  const GetDivisionConfigurationListEvent(this.search, this.next, this.prev);
}

class DivisionConfigurationReadEvent extends InventoryEvent {
  final int id;
  const DivisionConfigurationReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteDivisionConfigurationEvent extends InventoryEvent {
  final int id;
  const DeleteDivisionConfigurationEvent(this.id);
}
//updateDiscount
class UpdateDivisionConfigurationEvent extends InventoryEvent {
  final String name;
  final String description;
  final dynamic image;
  final bool isMixed;
  final int priority;
  final List<String> uomGroup;
  final List<String> grroup;
  final List<String> categoey;
  final int id;
  final bool isActive;
  const UpdateDivisionConfigurationEvent( {
    required this.uomGroup,
    required this.isMixed,
    required this.grroup,
    required this.categoey,
    required this.image,
    required this.priority,
    required this.name,
    required this.description,
    required this.id,
    required this.isActive,

  });
  @override
  List<Object> get props => [
    name,
  ];
}

//warrantyType
class WarrantyTypeCreateEvent extends InventoryEvent {
  final String title;
  final String description;
  final bool isActive;
  WarrantyTypeCreateEvent( {

    required this.isActive,
    required this.title,
    required this.description,


  });
  @override
  List<Object> get props => [
    title,
  ];
}

class GetWarrantyTypeListEvent extends InventoryEvent {
  final String? search;
  // final User? user;
  const GetWarrantyTypeListEvent(this.search);
}

class WarrantyTypeReadEvent extends InventoryEvent {
  final int id;
  const WarrantyTypeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deleteDiscount
class DeleteWarrantyTypeEvent extends InventoryEvent {
  final int id;
  const DeleteWarrantyTypeEvent(this.id);
}
//updateDiscount
class UpdateWarrantyTypeEvent extends InventoryEvent {
  final String title;
  final String description;
  final bool isActive;
  final int id;
  const UpdateWarrantyTypeEvent( {
    required this.title,
    required this.description,
    required this.id,
    required this.isActive,

  });
  @override
  List<Object> get props => [
    title,
  ];
}

class GetUomByUomGroupEvent extends InventoryEvent {
  final String? search;
  final int? id;
  final String? next;
  final String? prev;
  const GetUomByUomGroupEvent(this.search,this.id, this.next, this.prev);
}

//createWarranty
class CreateWarrantyEvent extends InventoryEvent {
  final CreateWarrantyModel warrantyModel;

  CreateWarrantyEvent( {

    required this.warrantyModel,



  });
  @override
  List<Object> get props => [
    warrantyModel,
  ];
}


//read

class GetWarrantyListEvent extends InventoryEvent {
  final String? variantCode;
  final String? search;
  final String? next;
  final String? prev;
  const GetWarrantyListEvent(this.search,this.variantCode, this.next, this.prev);
}

class WarrantyReadEvent extends InventoryEvent {
  final String? code;
  const WarrantyReadEvent(this.code);
  @override
  List<Object> get props => [this.code??""];
}
//deleteDiscount
class DeleteWarrantyEvent extends InventoryEvent {
  final String? code;
  const DeleteWarrantyEvent(this.code);
}