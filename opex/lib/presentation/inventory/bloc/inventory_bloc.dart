
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/inventory/data/inventory_repo.dart';
import 'package:cluster/presentation/inventory/data/inventory_src.dart';
import 'package:cluster/presentation/inventory/model/division_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/model/manufacture_model.dart';
import 'package:cluster/presentation/inventory/model/read_variant_model.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:equatable/equatable.dart';

import '../model/create_variant_model.dart';

part 'inventory_event.dart';

part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepo _inventoryRepo = InventoryRepo();
  final InventoryDataSource _dataSource = InventoryDataSource();

  InventoryBloc() : super(InventoryInitial());

  @override
  Stream<InventoryState> mapEventToState(InventoryEvent event) async* {
    if (event is GetDivisionEvent) {
      yield* getDivision(
        search: event.search,
        url:event.url
      );
    } else if (event is GetCategoryEvent) {
      yield* getCategory(id: event.id,search: event.search,url: event.url);
    }else if (event is GetSubCategoryEvent) {
      yield* getSubCategory(id: event.id,search: event.search,url:event.url
      );
    }else if (event is GetGroupEvent) {
      yield* getGroup(id: event.id,search: event.search,url:event.url);
    }else if (event is GetItemEvent) {
      yield* getItem(id: event.id,
          search: event.search);
    }else if (event is GetStockPartitionEvent) {
      yield* getStockPartition(id: event.id,
          search: event.search,url: event.url);
    }else if (event is GetUomEvent) {
      yield* getUom(id: event.id,
          search: event.search);
    }else if (event is GetSalesUomEvent) {
      yield* getSalesUom(id: event.id,
          search: event.search);
    }else if (event is GetvariantEvent) {
      yield* getVariant(
          id: event.id,
          search: event.search,
        itemId: event.itemId
      );
    }
    else if (event is PicEvent) {
      yield* uploadPic(event.image);
    } else if (event is GetCombinationEvent) {
      yield* getCombination(id:event.id);
    }else if (event is GetChannelEvent) {
      yield* getChannel();
    }else if (event is GetManufactureEvent) {
      yield* getManufacture(
        search: event.search,
        url: event.url
      );
    }
    else if (event is VariantEvent) {
      yield* createVariant(event.variantModel);
    }
    else if (event is ReturnTypeEvent) {
      yield* returnType();
    }    else if (event is GetSiblingEvent) {
      yield* getSibling();
    }   else if (event is GetInventoryEvent) {
      yield* getInventory();
    } else if (event is ListVariantEvent) {
      yield* listVariant(url:event.url,search: event.search);
    }else if (event is ReadVariantEvent) {
      yield* readVariant(id:event.id);
    }else if (event is UpdateVariantEvent) {
      print("heereee befpree");
      yield* updateVariant( dataModel: event.dataModel,id:event.id);
    }else if (event is DeleteVariantEvent) {
      yield* deleteVariant(id:event.id);
    }
    //STOCK
    if (event is ProductStockListEvent) {
      yield* ProductStockListState(event.code.trim(),event.prev.trim());
    }
    else if (event is ReadStockProductEvent) {
      yield* getStockProductRead(event.variantId);
    }
    if (event is CreateVirtualStockPostEvent) {
      yield* createVirtualStock(
        channelCode: event.channelCode??"",
        inventoryId: event.inventoryId.trim(),
        variantId: event.variantId,
        addVirtualStock: event.addVirtualStock,
        channelId: event.channelId??"",
        crucialPoint: event.crucialPoint,
        dailyStockQty: event.dailyStockQty,
        isDailyStockAvailable: event.isDailyStockAvailable,
        mediumPoint: event.mediumPoint,
        stockWarning: event.stockWarning,
        variantCode: event.variantCode.trim(),
        virtualType: event.virtualType.trim(),
      );
    }
    if (event is CreateCostingMethodTypeEvent) {
      yield* createMethodType(

          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          typeName: event.typeName.trim()
      );
    }
    if (event is CostMethodTypeListEvent) {
      yield* costMethodTypeList(event.code.trim(),event.prev.trim());
    }

    else if (event is GetCostMethodTypeReadEvent) {
      yield* getCostMethodTypeRead(event.id);
    }
    if (event is DeleteCostMethodTypeEvent) {
      yield* deleteCostMethodType(id: event.id);
    }
    if (event is UpdateCostMethodTypeEvent) {
      yield* updateCostMethodTypePost(
          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          typeName: event.typeName.trim(),
          isActive: event.isActive,
          id: event.id

      );
    }

    //methodcreate
    if (event is CostingMethodCreateEvent) {
      yield* createMethod(

          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          methodName: event.methodName.trim(),
          methodTypeId: event.methodTypeId
      );
    }
    if (event is CostMethodListEvent) {
      yield* costMethodlist(event.code.trim(),event.prev.trim());
    }

    else if (event is GetCostMethodReadEvent) {
      yield* getCostMethodRead(event.id);
    }
    if (event is DeleteCostMethodEvent) {
      yield* deleteCostMethod(id: event.id);
    }
    if (event is UpdateCostMethodEvent) {
      yield* updateCostMethodPost(
          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          methodName: event.methodName.trim(),
          methodTypeId: event.methodTypeId,
          isActive: event.isActive,
          id: event.id

      );
    }

    //pricingType
    if (event is PricingTypeCreateEvent) {
      yield* createPricingType(
        createdBy: event.createdBy.trim(),
        discription: event.discription.trim(),
        pricingTypeName: event.pricingTypeName.trim(),

      );
    }
    if (event is PricingTypeListEvent) {
      yield* PricingTypelist(event.code.trim(),event.prev.trim());
    }

    else if (event is PricingTypeReadEvent) {
      yield* getPricingTypeRead(event.id);
    }
    if (event is DeletePricingTypeEvent) {
      yield* deletePricingType(id: event.id);
    }
    if (event is UpdatePricingTypeEvent) {
      yield* updatePricingTypePost(
          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          pricingTypeCode: event.pricingTypeCode.trim(),
          pricingTypeName: event.pricingTypeName.trim(),
          isActive: event.isActive,
          id: event.id

      );
    }

    //pricingGroup
    if (event is PricingGroupCreateEvent) {
      yield* createPricingGroup(
          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          pricingTypeId: event.priceTypeId,
          pricingGroupName: event.pricingGroupName.trim(),
          customerGroupCode: event.customerGroupCode.trim()
      );
    }
    if (event is PricingGroupListEvent) {
      yield* PricingGrouplist(event.code.trim(),event.prev.trim());
    }

    else if (event is PricingGroupReadEvent) {
      yield* getPricingGroupRead(event.id);
    }
    if (event is DeletePricingGroupEvent) {
      yield* deletePricingGroup(id: event.id);
    }
    if (event is UpdatePricingGroupEvent) {
      yield* updatePricingGroupPost(
          createdBy: event.createdBy.trim(),
          discription: event.discription.trim(),
          pricingGroupName: event.pricingGroupName.trim(),
          customerGroupCode: event.customerGroupCode.trim(),
          pricingTypeId: event.pricingTypeId,
          isActive: event.isActive,
          id: event.id

      );
    }
    else if (event is PricingGpTypeReadEvent) {
      yield* getPricingGpTypeRead(event.id);
    }
    if (event is GPPercentagePostEvent) {
      yield* gpPercentagePost(
        variantId: event.variantId,
        inventoryId: event.inventoryId.trim(),
        GPType: event.GPType,

      );
    }
    if (event is CostingCreationPostEvent) {
      yield* costingCreatePost(
        stockCode: event.stockCode.trim(),
        actualcost: event.actualcost,
        actualSellingPrice: event.actualSellingPrice,
        channelId: event.channelId??"",
        pricrType: event.pricrType,
        gpOperation: event.gpOperation,
        costingName: event.costingName,
        createdBy: event.createdBy,
        unitCost: event.unitCost,
        invId: event.invId,
        varientCode: event.varientCode,
        varientId: event.varientId,
        channelCode: event.channelCode??"",
        costingMethodId: event.costingMethodId,
        sellingPrice: event.sellingPrice,
        GpPercentage: event.GpPercentage,
        pricingGpType: event.pricingGpType,
        pricingGroupId: event.pricingGroupId,

      );
    }
    if (event is CostingListEvent) {
      yield* costinglist(event.code.trim(),event.prev.trim(),event.variantId);
    }

    else if (event is CostingReadEvent) {
      yield* getCostingRead(event.id);
    }
    if (event is UpdateCostingEvent) {
      yield* updateCostingPost(
          stockCode: event.stockCode.trim(),
          actualcost: event.actualcost,
          actualSellingPrice: event.actualSellingPrice,
          channelId: event.channelId??"",
          pricrType: event.pricrType,
          gpOperation: event.gpOperation,
          costingName: event.costingName,
          createdBy: event.createdBy,
          unitCost: event.unitCost,
          invId: event.invId,
          varientCode: event.varientCode,
          varientId: event.varientId,
          channelCode: event.channelCode??"",
          costingMethodId: event.costingMethodId,
          sellingPrice: event.sellingPrice,
          GpPercentage: event.GpPercentage,
          pricingGpType: event.pricingGpType,
          pricingGroupId: event.pricingGroupId,
          id: event.id
      );
    }

    //division
    if (event is DivisionCreateEvent) {
      yield* createDivision(
          image: event.image,
          description: event.description.trim(),
          prioriy: event.prioriy,
          name: event.name.trim(),
          displayName: event.displayName.trim(),
          searchName:  event.searchName.trim()
      );
    }

    else if (event is DivisionReadEvent) {
      yield* getDivisionRead(event.id);
    }
    if (event is DeleteDivisionEvent) {
      yield* deleteDivision(id: event.id);
    }
    if (event is UpdateDivisionEvent) {
      yield* updateDivisionPost(
          searchName: event.searchName.trim(),
          displayName: event.displayName.trim(),
          name: event.name.trim(),
          prioriy: event.prioriy,
          description: event.description.trim(),
          isActive: event.isActive,
          id: event.id,
          image: event.image

      );
    }
    //category
    if (event is CategoryCreateEvent) {
      yield* createCategory(
          image: event.image,
          description: event.description.trim(),
          prioriy: event.prioriy,
          name: event.name.trim(),
          parentCode: event.parentCode.trim(),
          divisionCode:  event.divisionCode.trim(),
          altName: event.altName.trim()
      );
    }
    if (event is GetCategoryListEvent) {
      yield* getCategorylist(
          search: event.search,
        next: event.next?.trim(),
        prev: event.prev?.trim()
      );
    }
    if (event is GetDivisionListEvent) {
      yield* getDivisionList(
          search: event.search,
          next: event.next?.trim(),
          prev: event.prev?.trim()
      );
    }
    else if (event is CategoryReadEvent) {
      yield* getCategoryRead(event.id);
    }
    if (event is DeleteCategoryEvent) {
      yield* deleteCategory(id: event.id);
    }
    if (event is UpdateCategoryEvent) {
      yield* updateCategoryPost(
          divisionCode: event.divisionCode.trim(),
          parentCode: event.parentCode.trim(),
          altName: event.altName.trim(),
          name: event.name.trim(),
          prioriy: event.prioriy,
          description: event.description.trim(),
          isActive: event.isActive,
          id: event.id,
          image: event.image

      );
    }

    //group
    if (event is GroupCreateEvent) {
      yield* createGroup(
          image: event.image,
          description: event.description.trim(),
          prioriy: event.prioriy,
          name: event.name.trim(),
          categoryCode: event.categoryCode.trim(),
          displayName:  event.displayName.trim(),
          searchName: event.searchName.trim()
      );
    }
    if (event is GetGroupListEvent) {
      yield* getGrouplist(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is GroupReadEvent) {
      yield* getGroupRead(event.id);
    }
    if (event is DeleteGroupEvent) {
      yield* deleteGroup(id: event.id);
    }
    if (event is UpdateGroupEvent) {
      yield* updateGroupPost(
          searchName: event.searchName.trim(),
          displayName: event.displayName.trim(),
          categoryCode: event.categoryCode.trim(),
          name: event.name.trim(),
          prioriy: event.prioriy,
          description: event.description.trim(),
          isActive: event.isActive,
          id: event.id,
          image: event.image

      );
    }
    //UOMgroup
    if (event is UomGroupCreateEvent) {
      yield* createUomGroup(
          description: event.description.trim(),
          name: event.name.trim(),
          shortName: event.shortName.trim()
      );
    }
    if (event is GetUomGroupListEvent) {
      yield* getUomGrouplist(
        prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is UomGroupReadEvent) {
      yield* getUomGroupRead(event.id);
    }
    if (event is DeleteUomGroupEvent) {
      yield* deleteUomGroup(id: event.id);
    }
    if (event is UpdateUomGroupEvent) {
      yield* updateUomGroupPost(
          name: event.name.trim(),
          description: event.description.trim(),
          isActive: event.isActive,
          id: event.id,
          shortName: event.shortName.trim()

      );
    }

    //UOM
    if (event is UomCreateEvent) {
      yield* createUom(
          uomGroupCode: event.uomGroupCode.trim(),
          name: event.name.trim(),
          baseEquvalant: event.baseEquvalant,
          convertionFactor: event.convertionFactor,
          statnderdCode: event.statnderdCode.trim(),
          shortName: event.shortName.trim()
      );
    }
    if (event is GetUomListEvent) {
      yield* getUomlist(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is UomReadEvent) {
      yield* getUomRead(event.id);
    }
    if (event is DeleteUomEvent) {
      yield* deleteUom(id: event.id);
    }
    if (event is UpdateUomEvent) {
      yield* updateUomPost(
          name: event.name.trim(),
          uomGroupCode: event.uomGroupCode.trim(),
          isActive: event.isActive,
          statnderdCode: event.statnderdCode,
          convertionFactor: event.convertionFactor,
          baseEquvalant: event.baseEquvalant,
          id: event.id,
          shortName: event.shortName.trim()

      );
    }
    //Material
    if (event is MaterialCreateEvent) {
      yield* createMaterial(
          name: event.name.trim(),
          image: event.image,
          discription: event.discription.trim(),
          searchNmae: event.searchNmae.trim()
      );
    }
    if (event is GetMaterialListEvent) {
      yield* getMateriallist(
        prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is MaterialReadEvent) {
      yield* getMaterialRead(event.id);
    }
    if (event is DeleteMaterialEvent) {
      yield* deleteMaterial(id: event.id);
    }
    if (event is UpdateMaterialEvent) {
      yield* updateMaterialPost(
          name: event.name.trim(),
          isActive: event.isActive,
          id: event.id,
          code: event.code.trim(),
          searchNmae: event.searchNmael.trim(),
          discription: event.discription.trim(),
          image: event.image

      );
    }
    //staticGroup
    if (event is StaticGroupCreateEvent) {
      yield* createStaticGroup(
          name: event.name.trim(),
          image: event.image,
          discription: event.discription.trim(),
          searchNmae: event.searchNmae.trim()
      );
    }
    if (event is GetStaticGroupListEvent) {
      yield* getStaticGrouplist(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is StaticGroupReadEvent) {
      yield* getStaticGroupRead(event.id);
    }
    if (event is DeleteStaticGroupEvent) {
      yield* deleteStaticGroup(id: event.id);
    }
    if (event is UpdateStaticGroupEvent) {
      yield* updateStaticGroupPost(
          name: event.name.trim(),
          isActive: event.isActive,
          id: event.id,
          searchNmae: event.searchNmael.trim(),
          discription: event.discription.trim(),
          image: event.image

      );
    }

    //brand
    if (event is BrandCreateEvent) {
      yield* createBrand(
          name: event.name.trim(),
          image: event.image,
          discription: event.discription.trim(),
          parentCode: event.parentCode.trim(),
          brandIdentifierUrl: event.brandIdentifierUrl.trim(),
          priority: event.priority
      );
    }
    if (event is GetBrandListEvent) {
      yield* getBrandlist(
        prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is BrandReadEvent) {
      yield* getBrandRead(event.id);
    }
    if (event is DeleteBrandEvent) {
      yield* deleteBrand(id: event.id);
    }
    if (event is UpdateBrandEvent) {
      yield* updateBrandPost(
          name: event.name.trim(),
          isActive: event.isActive,
          id: event.id,
          parentCode: event.parentCode.trim(),
          brandIdentifierUrl: event.brandIdentifierUrl.trim(),
          priority: event.priority,
          discription: event.discription.trim(),
          image: event.image

      );
    }

    //attribute
    if (event is GetAttributeTypeEvent) {
      yield* getAttributeTypeRead();
    }
    if (event is AttributeCreateEvent) {
      yield* createAttribute(
          isActive: event.isActive,
          attributeName: event.attributeName.trim(),
          attributeType: event.attributeType.trim()
      );
    }
    if (event is GetAttributeListEvent) {
      yield* getAttributelist(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is AttributeReadEvent) {
      yield* getAttributeRead(event.id);
    }
    if (event is DeleteAttributeEvent) {
      yield* deleteAttribute(id: event.id);
    }
    if (event is UpdateAttributeEvent) {
      yield* updateAttributePost(
          isActive: event.isActive,
          id: event.id,
          attributeType: event.attributeType.trim(),
          attributeName: event.attributeName.trim()

      );
    }

    //varientFramework
    if (event is VarientFrameworkCreateEvent) {
      yield* createVarientFramework(
          description: event.description.trim(),
          name: event.name.trim(),
          lines: event.lines
      );
    }
    if (event is GetVarientFrameworkListEvent) {
      yield* getVarientFrameworklist(
        prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is VarientFrameworkReadEvent) {
      yield* getVarientFrameworkRead(event.id);
    }
    if (event is DeleteVarientFrameworkEvent) {
      yield* deleteVarientFramework(id: event.id);
    }
    if (event is UpdateVarientFrameworkEvent) {
      yield* updateVarientFrameworkPost(
          isActive: event.isActive,
          id: event.id,
          name: event.name.trim(),
          description: event.description.trim(),
          lines: event.lines

      );
    }

    //item
    if (event is ItemCreateEvent) {
      yield* createItem(
          description: event.description.trim(),
          name: event.name.trim(),
          searchName: event.searchName.trim(),
          displayName: event.displayName.trim(),
          barcode: event.barcode.trim(),
          brandCode: event.brandCode.trim(),
          groupCode: event.groupCode,
          img1: event.img1,
          img2: event.img2,
          img3: event.img3,
          itemCatalog1: event.itemCatalog1,
          itemCatalog2: event.itemCatalog2,
          itemCatalog3: event.itemCatalog3,
          itemCatalog4: event.itemCatalog4,
          itemCatalog5: event.itemCatalog5,
          materialCode: event.materialCode.trim(),
          oldSystemCode: event.oldSystemCode.trim(),
          staticGroupCode: event.staticGroupCode.trim(),
          uomCode: event.uomCode.trim(),
          uomgroupCode: event.uomgroupCode.trim(),
          variantFrameworkCode: event.variantFrameworkCode.trim()
      );
    }
    if (event is GetItemListEvent) {
      yield* getItemlist(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }
    else if (event is ItemReadEvent) {
      yield* getItemRead(event.id);
    }
    if (event is DeleteItemEvent) {
      yield* deleteItem(id: event.id);
    }
    if (event is UpdateItemEvent) {
      yield* updateItemPost(
          isActive: event.isActive,
          id: event.id,
          description: event.description.trim(),
          name: event.name.trim(),
          searchName: event.searchName.trim(),
          displayName: event.displayName.trim(),
          barcode: event.barcode.trim(),
          brandCode: event.brandCode.trim(),
          groupCode: event.groupCode,
          img1: event.img1,
          img2: event.img2,
          img3: event.img3,
          itemCatalog1: event.itemCatalog1,
          itemCatalog2: event.itemCatalog2,
          itemCatalog3: event.itemCatalog3,
          itemCatalog4: event.itemCatalog4,
          itemCatalog5: event.itemCatalog5,
          materialCode: event.materialCode.trim(),
          oldSystemCode: event.oldSystemCode.trim(),
          staticGroupCode: event.staticGroupCode.trim(),
          uomCode: event.uomCode.trim(),
          uomgroupCode: event.uomgroupCode.trim(),
          variantFrameworkCode: event.variantFrameworkCode.trim()

      );
    }

    //list for segment
    if (event is GetGroupListSegmentEvent) {
      yield* getGroupListSegment(
          search: event.search,
        next: event.next,
        prev: event.prev,
      );
    }
    if (event is GetUomListSegmentEvent) {
      yield* getUomListSegment(
          search: event.search,
        next: event.next,
        prev: event.prev,
      );
    }
    if (event is GetCategoryListSegmentEvent) {
      yield* getCategoryListSegment(
        next: event.next,
          prev: event.prev,
          search: event.search
      );
    }


    //divisionConfig
    if (event is DivisionConfigurationCreateEvent) {
      yield* createDivisionConfiguration(
          description: event.description.trim(),
          name: event.name.trim(),
          priority: event.priority,
          categoey: event.categoey,
          grroup: event.grroup,
          isMixed: event.isMixed,
          uomGroup: event.uomGroup,
          image: event.image
      );
    }
    if (event is GetDivisionConfigurationListEvent) {
      yield* getDivisionConfigurationlist(
        prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is DivisionConfigurationReadEvent) {
      yield* getDivisionConfigurationRead(event.id);
    }
    if (event is DeleteDivisionConfigurationEvent) {
      yield* deleteDivisionConfiguration(id: event.id);
    }
    if (event is UpdateDivisionConfigurationEvent) {
      yield* updateDivisionConfigurationPost(
          isActive: event.isActive,
          id: event.id,
          description: event.description.trim(),
          name: event.name.trim(),
          priority: event.priority,
          categoey: event.categoey,
          grroup: event.grroup,
          isMixed: event.isMixed,
          uomGroup: event.uomGroup,
          image: event.image

      );
    }

    //warrantyType
    if (event is WarrantyTypeCreateEvent) {
      yield* createWarrantyType(
          description: event.description.trim(),
          isActive: event.isActive,
          title: event.title.trim()
      );
    }
    if (event is GetWarrantyTypeListEvent) {
      yield* getWarrantyTypelist(
          search: event.search
      );
    }
    else if (event is WarrantyTypeReadEvent) {
      yield* getWarrantyTypeRead(event.id);
    }
    if (event is DeleteWarrantyTypeEvent) {
      yield* deleteWarrantyType(id: event.id);
    }
    if (event is UpdateWarrantyTypeEvent) {
      yield* updateWarrantyTypePost(
          isActive: event.isActive,
          id: event.id,
          description: event.description.trim(),
          title: event.title.trim()

      );
    }

    //uombyGroup
    if (event is GetUomByUomGroupEvent) {
      yield* getGetUomByUomGrouplist(
        id: event.id,
          search: event.search,
        next: event.next,
        prev: event.prev
      );
    }

    //createWarranty
    if (event is CreateWarrantyEvent) {
      yield* createWarranty(
         warrantyModel: event.warrantyModel
      );
    }
    if (event is GetWarrantyListEvent) {
      yield* getWarrantylist(
        code: event.variantCode,
          prev: event.prev,
          next: event.next,
          search: event.search
      );
    }
    else if (event is WarrantyReadEvent) {
      yield* getWarrantyRead(event.code??"");
    }
    if (event is DeleteWarrantyEvent) {
      yield* deleteWarranty(code: event.code??"");
    }

  }

  // Division
  Stream<InventoryState> getDivision({
  String? search,url
}) async* {
    yield GetDivisionLoading();
    final dataResponse = await _inventoryRepo.getDivision(search: search,url: url);
    print("inside division bloc${dataResponse.data}");
    if (dataResponse.data !=null &&dataResponse.data !=[] &&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetDivisionFailed("failed");
    }
  }

  // Category
  Stream<InventoryState> getCategory({int? id,String? search,url}) async* {
    yield GetDivisionLoading();
    final dataResponse = await _inventoryRepo.getCategory(id: id,search: search,url: url);
    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetDivisionFailed("");
    }
  }

  // Sub Category
  Stream<InventoryState> getSubCategory({int? id,String? search,url}) async* {
    yield GetDivisionLoading();

    final dataResponse = await _inventoryRepo.getSubCategory(id: id,search: search,url:url);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetDivisionFailed("");
    }
  }
  Stream<InventoryState> getGroup({int? id,String? search,url}) async* {
    yield GetDivisionLoading();

    final dataResponse = await _inventoryRepo.getGroup(id: id,search: search,url:url);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetDivisionFailed("");
    }
  }Stream<InventoryState> getItem({int? id,String? search,url}) async* {
    yield GetDivisionLoading();

    final dataResponse = await _inventoryRepo.getItem(id: id,search:search);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetDivisionFailed("");
    }
  }
  Stream<InventoryState> getUom({int? id,String? search,url}) async* {
    yield GetDivisionLoading();

    final dataResponse = await _inventoryRepo.getUom(id: id,search:search);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetDivisionSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetDivisionFailed("");
    }
  }

  Stream<InventoryState> getSalesUom({int? id,String? search}) async* {
    yield GetUomLoading();

    final dataResponse = await _inventoryRepo.getSalesUom(id: id,search:search);

    if (dataResponse.data != null) {
      yield GetUomSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield GetUomFailed("");
    }
  }


  Stream<InventoryState> getVariant({int? id,int? itemId,String? search}) async* {
    yield VariantLoading();

    final dataResponse = await _inventoryRepo.getVariant(id: id,search:search,itemId: itemId);

    if (dataResponse.data != null) {
      yield VariantSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield VariantFailed();
    }
  }


  Stream<InventoryState> uploadPic(File? profilePic) async* {
    yield PicLoading();

    final dataResponse = await _inventoryRepo.postPic(profilePic);

    if (dataResponse.data1 != null) {
      print("inside bloc");
      yield PicSuccess(
          dataResponse.data1,
        dataResponse.data2
      );
    } else {
      yield PicFailed();
    }
  }
  Stream<InventoryState> getCombination({int? id}) async* {
    yield CombinationLoading();

    final dataResponse = await _inventoryRepo.getCombination(id: id);

    if (dataResponse.data != null) {
      yield CombinationSuccess(
          inventory:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield CombinationFailed();
    }


  }




  Stream<InventoryState> getChannel() async* {
    yield ChannelLoading();

    final dataResponse = await _inventoryRepo.getChannel();

    if (dataResponse.data != null) {
      yield ChannelSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield ChannelFailed();
    }
  }
  Stream<InventoryState> getManufacture({String? search,url}) async* {
    yield ManufacturerLoading();
print("search $search");
    final dataResponse = await _inventoryRepo.getManufacture(search:search,url:url);
print("inside bloc${dataResponse.data}");
    if (dataResponse.data != null) {
      yield ManufacturerSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          data:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield ManufacturerFailed();
    }
  }
  Stream<InventoryState> createVariant(CreateVariantModel? variantModel) async* {
    yield CreateVariantLoading();

    final dataResponse = await _inventoryRepo.createVariant(variantModel: variantModel);

    if (dataResponse.data1) {
      print("inside bloc");
      yield CreateVariantSuccess(
          data: dataResponse.data1,
         msg:  dataResponse.data2
      );
    } else {
      yield CreateVariantFailed(
        msg: dataResponse.data2
      );
    }
  }

  //return type
  Stream<InventoryState> returnType() async* {
    yield ReturnTypeLoading();
    print("inside bloc.............");
    final dataResponse = await _inventoryRepo.returnType();
    if (dataResponse.data.isNotEmpty) {
      print("inside bloc");
      yield ReturnTypeSuccess(data: dataResponse.data,);
    } else {
      yield ReturnTypeFailed();
    }
  }
  //get sibling
  Stream<InventoryState> getSibling() async* {
    yield SiblingLoading();

    final dataResponse = await _inventoryRepo.getSibling();
    print("inside bloc${dataResponse.data}");
    if (dataResponse.data != null) {
      yield SiblingSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          data:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield SiblingFailed();
    }
  }


  Stream<InventoryState> getInventory() async* {
    yield InventoryLoading();

    final dataResponse = await _inventoryRepo.getInventory();

    if (dataResponse.data != null) {
      yield InventorySuccess(
          inventory: dataResponse.data);
      print(dataResponse.data);
    } else {
      yield InventoryFailed();
    }
  }


  Stream<InventoryState> listVariant({String? url,search}) async* {
    yield ListVariantLoading();

    final dataResponse = await _inventoryRepo.listVariant(url: url,search: search);
    print("inside bloc${dataResponse.data}");
    if (dataResponse.data.isNotEmpty) {
      yield ListVariantSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          data:  dataResponse.data);
      print(dataResponse.data);
    } else {
      yield ListVariantFailed();
    }
  }
  Stream<InventoryState> readVariant({int? id}) async* {
    yield ReadVariantLoading();

    final dataResponse = await _inventoryRepo.readVariant(id: id);
print("inside read bloc${dataResponse.data}");
    if (dataResponse.data != null) {
      yield ReadVariantSuccess(
          data: dataResponse.data);
      print(dataResponse.data);
    } else {
      yield ReadVariantFailed();
    }
  }

  Stream<InventoryState> updateVariant({CreateVariantModel? dataModel,int? id}) async* {
    yield UpdateVariantLoading();

    final dataResponse = await _inventoryRepo.updateVariant(id: id,dataModel: dataModel);
print("inside read bloc${dataResponse.data1}");
    if (dataResponse.data1) {
      yield UpdateVariantSuccess(
          data: dataResponse.data2);
      print(dataResponse.data2);
    } else {
      yield UpdateVariantFailed();
    }
  }
  Stream<InventoryState> deleteVariant({int? id}) async* {
    yield DeleteVariantLoading();

    final dataResponse = await _inventoryRepo.deleteVariant(id: id);
print("inside read bloc${dataResponse.data1}");
    if (dataResponse.data1 ) {
      yield DeleteVariantSuccess(
          data: dataResponse.data2);
      print(dataResponse.data2 );
    } else {
      print(dataResponse.data2 );
      yield DeleteVariantFailed(data: dataResponse.data2);
    }
  }
  Stream<InventoryState> getStockPartition({String? id,String? search,String? url}) async* {
    yield GetStockLoading();

    final dataResponse = await _inventoryRepo.getStockPartition(id: id,search:search,url: url);

    if (dataResponse.data != null&&dataResponse.data.isNotEmpty) {
      yield GetStockSuccess(prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);
    } else {
      yield GetStockFailed("");
    }
  }
//STOCK
  Stream<InventoryState> ProductStockListState(String code,String prev) async* {
    List<InventoryModel> productList=[];
    String? next;
    yield StockListProductLoading();

    final dataResponse = await _inventoryRepo.getStockProduct(code, prev);

    dataResponse.fold((l) => emit(StockListProductFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });
      print("bloc${r.previousUrl}");
      print("bloc${r.previousPage}");
      print("bloc${r.nextPage}");
      emit(StockListProductSuccess(
          product: PaginatedResponse(productList, r.nextPage, r.previousUrl)));
    });
  }

  Stream<InventoryState> getStockProductRead(int id) async* {

    yield GetStockReadLoading();

    final dataResponse = await _inventoryRepo.getStockProductRead(id);

    if (dataResponse.hasData) {
      yield GetStockReadSuccess(stockData: dataResponse.data);
    } else {
      yield GetStockReadFailed(dataResponse.error.toString(),
      );
    }
  }


  Stream<InventoryState> createVirtualStock(
      {
        required String inventoryId,
        required String channelId,
        required String channelCode,
        required int variantId,
        required String variantCode,
        required bool stockWarning,
        required int? crucialPoint,
        required int? mediumPoint,
        required int addVirtualStock,
        required String virtualType,
        required bool isDailyStockAvailable,
        required int dailyStockQty
      }) async* {
    yield CreateVirtualStockLoading();

    final dataResponse = await _inventoryRepo.createVirtualStock(
        virtualType: virtualType,
        variantId: variantId,
        variantCode: variantCode,
        stockWarning: stockWarning,
        mediumPoint: mediumPoint,
        isDailyStockAvailable: isDailyStockAvailable,
        dailyStockQty: dailyStockQty,
        crucialPoint: crucialPoint,
        channelId: channelId,
        addVirtualStock: addVirtualStock,
        channelCode: channelCode,
        inventoryId: inventoryId
    );

    if (dataResponse.data ) {
      yield CreateVirtualStockSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateVirtualStockFailed(
        dataResponse.error ?? "",);
    }

  }


  Stream<InventoryState> createMethodType(
      {
        required String typeName,
        required String discription,
        required String createdBy,

      }) async* {
    yield CreateMethodTypeLoading();

    final dataResponse = await _inventoryRepo.createMethodType(
        typeName: typeName,
        discription: discription,
        createdBy: createdBy
    );

    if (dataResponse.data ) {
      yield CreateMethodTypeSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateMethodTypeFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> costMethodTypeList(String code,String prev) async* {
    List<CostingModel> productList=[];
    String? next;
    yield CostMethodTypeListLoading();

    final dataResponse = await _inventoryRepo.costMethodTypeList(code, prev);

    dataResponse.fold((l) => emit(CostMethodTypeListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });

      emit(CostMethodTypeListSuccess(
          product: PaginatedResponse(productList, r.nextPage, r.previousUrl)));
    });
  }


  Stream<InventoryState> getCostMethodTypeRead(int id) async* {

    yield GetCostMethodTypeReadLoading();

    final dataResponse = await _inventoryRepo.getCostMethodTypeRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetCostMethodTypeReadSuccess(costingModel: dataResponse.data);
    } else {
      yield GetCostMethodTypeReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteCostMethodType({required int id}) async* {
    yield DeleteCostMethodTypeLoading();
    final dataResponse = await _dataSource.deleteCostMethodType(id);
    if (dataResponse == "success") {
      yield DeleteCostMethodTypeSuccess();
    } else {
      yield DeleteCostMethodTypeFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateCostMethodTypePost(
      {
        required String typeName,
        required int id,
        required String discription,
        required String createdBy,
        required bool isActive,
      }) async* {
    yield CostMethodTypeUpdateLoading();

    final dataResponse = await _inventoryRepo.updateCostMethodTypePost(

        discription: discription,
        typeName: typeName,
        isActive: isActive,
        createdBy: createdBy,
        id: id
    );

    if (dataResponse.data ) {
      yield CostMethodTypeUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield CostMethodTypeUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> createMethod(
      {
        required int methodTypeId,
        required String methodName,
        required String createdBy,
        required String discription,

      }) async* {
    yield CreateMethodLoading();

    final dataResponse = await _inventoryRepo.createMethod(
        methodTypeId: methodTypeId,
        methodName: methodName,
        discription: discription,
        createdBy: createdBy
    );

    if (dataResponse.data ) {
      yield CreateMethodSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateMethodFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> costMethodlist(String code,String prev) async* {
    List<CostingModel> productList=[];
    String? next;
    yield CostMethodListLoading();

    final dataResponse = await _inventoryRepo.costMethodlist(code, prev);

    dataResponse.fold((l) => emit(CostMethodListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });

      emit(CostMethodListSuccess(
          product: PaginatedResponse(productList, r.nextPage, r.previousUrl)));
    });
  }


  Stream<InventoryState> getCostMethodRead(int id) async* {

    yield GetCostMethodReadLoading();

    final dataResponse = await _inventoryRepo.getCostMethodRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetCostMethodReadSuccess(costingModel: dataResponse.data);
    } else {
      yield GetCostMethodReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteCostMethod({required int id}) async* {
    yield DeleteCostMethodLoading();
    final dataResponse = await _dataSource.deleteCostMethod(id);
    if (dataResponse == "success") {
      yield DeleteCostMethodSuccess();
    } else {
      yield DeleteCostMethodFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateCostMethodPost(
      {
        required int methodTypeId,
        required String methodName,
        required String createdBy,
        required String discription,
        required int id,
        required bool isActive,
      }) async* {
    yield CostMethodUpdateLoading();

    final dataResponse = await _inventoryRepo.updateCostMethodPost(

        discription: discription,
        methodTypeId: methodTypeId,
        methodName: methodName,
        isActive: isActive,
        createdBy: createdBy,
        id: id
    );

    if (dataResponse.data ) {
      yield CostMethodUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield CostMethodUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //pricuingType
  Stream<InventoryState> createPricingType(
      {
        required String pricingTypeName,
        required String createdBy,
        required String discription,

      }) async* {
    yield PricingTypeLoading();

    final dataResponse = await _inventoryRepo.createPricingType(

        pricingTypeName: pricingTypeName,
        discription: discription,
        createdBy: createdBy
    );

    if (dataResponse.data ) {
      yield PricingTypeSuccess(successMessage: dataResponse.error);
    } else {
      yield PricingTypeFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> PricingTypelist(String code,String prev) async* {
    List<CostingModel> productList=[];
    String? next;
    yield PricingTypeListLoading();

    final dataResponse = await _inventoryRepo.PricingTypelist(code, prev);

    dataResponse.fold((l) => emit(PricingTypeListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });

      emit(PricingTypeListSuccess(
          product: PaginatedResponse(productList, r.nextPage, r.previousUrl)));
    });
  }


  Stream<InventoryState> getPricingTypeRead(int id) async* {

    yield PricingTypeReadLoading();

    final dataResponse = await _inventoryRepo.getPricingTypeRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield PricingTypeReadSuccess(costingModel: dataResponse.data);
    } else {
      yield PricingTypeReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deletePricingType({required int id}) async* {
    yield DeletePricingTypeLoading();
    final dataResponse = await _dataSource.deletePricingType(id);
    if (dataResponse == "success") {
      yield DeletePricingTypeSuccess();
    } else {
      yield DeletePricingTypeFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updatePricingTypePost(
      {
        required String pricingTypeName,
        required String pricingTypeCode,
        required String createdBy,
        required String discription,
        required int id,
        required bool isActive,
      }) async* {
    yield PricingTypeUpdateLoading();

    final dataResponse = await _inventoryRepo.updatePricingTypePost(

        discription: discription,
        pricingTypeName: pricingTypeName,
        pricingTypeCode: pricingTypeCode,
        isActive: isActive,
        createdBy: createdBy,
        id: id
    );

    if (dataResponse.data ) {
      yield PricingTypeUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield PricingTypeUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //pricingGroup
  Stream<InventoryState> createPricingGroup(
      {
        required int pricingTypeId,
        required String pricingGroupName,
        required String customerGroupCode,
        required String createdBy,
        required String discription,

      }) async* {
    yield PricingGroupLoading();

    final dataResponse = await _inventoryRepo.createPricingGroup(

        pricingGroupName: pricingGroupName,
        customerGroupCode: customerGroupCode,
        pricingTypeId: pricingTypeId,
        discription: discription,
        createdBy: createdBy
    );

    if (dataResponse.data ) {
      yield PricingGroupSuccess(successMessage: dataResponse.error);
    } else {
      yield PricingGroupFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> PricingGrouplist(String code,String prev) async* {
    List<CostingModel> productList=[];
    String? next;
    yield PricingGroupListLoading();

    final dataResponse = await _inventoryRepo.PricingGrouplist(code, prev);

    dataResponse.fold((l) => emit(PricingGroupListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        productList.add((element));
      });

      emit(PricingGroupListSuccess(
          product: PaginatedResponse(productList, r.nextPage, r.previousUrl)));
    });
  }


  Stream<InventoryState> getPricingGroupRead(int id) async* {

    yield PricingGroupReadLoading();

    final dataResponse = await _inventoryRepo.getPricingGroupRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield PricingGroupReadSuccess(costingModel: dataResponse.data);
    } else {
      yield PricingGroupReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deletePricingGroup({required int id}) async* {
    yield DeletePricingGroupLoading();
    final dataResponse = await _dataSource.deletePricingGroup(id);
    if (dataResponse == "success") {
      yield DeletePricingGroupSuccess();
    } else {
      yield DeletePricingGroupFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updatePricingGroupPost(
      {
        required int pricingTypeId,
        required String customerGroupCode,
        required String pricingGroupName,
        required String createdBy,
        required String discription,
        required int id,
        required bool isActive,
      }) async* {
    yield PricingGroupUpdateLoading();

    final dataResponse = await _inventoryRepo.updatePricingGroupPost(

        discription: discription,
        pricingTypeId: pricingTypeId,
        customerGroupCode: customerGroupCode,
        pricingGroupName: pricingGroupName,
        isActive: isActive,
        createdBy: createdBy,
        id: id
    );

    if (dataResponse.data ) {
      yield PricingGroupUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield PricingGroupUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //
  Stream<InventoryState> getPricingGpTypeRead(int id) async* {

    yield PricingGpTypeReadLoading();

    final dataResponse = await _inventoryRepo.getPricingGpTypeRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield PricingGpTypeReadSuccess(readCostingData: dataResponse.data);
    } else {
      yield PricingGpTypeReadFailed(dataResponse.error.toString(),
      );
    }
  }

  Stream<InventoryState> gpPercentagePost(
      {
        required int variantId,
        required String GPType,
        required String inventoryId,


      }) async* {
    yield GPPercentagePostLoading();

    final dataResponse = await _inventoryRepo.gpPercentagePost(

      variantId: variantId,
      inventoryId: inventoryId,
      GPType: GPType,

    );

    if (dataResponse.data ) {
      yield GPPercentagePostSuccess(successMessage: dataResponse.error);
    } else {
      yield GPPercentagePostFailed(
        dataResponse.error ?? "",);
    }

  }

  //ctreateCosting
  Stream<InventoryState> costingCreatePost(
      {
        required int pricingGroupId,
        required String pricingGpType,
        required double GpPercentage,
        required double sellingPrice,
        required int costingMethodId,
        required String channelCode,
        required int varientId,
        required String varientCode,
        required String invId,
        required double unitCost,
        required String costingName,
        required String createdBy,
        required String gpOperation,
        required String pricrType,
        required String channelId,
        required double actualSellingPrice,
        required double actualcost,
        required String stockCode

      }) async* {
    print("GGGG$GpPercentage");
    yield CreateCostingPostLoading();

    final dataResponse = await _inventoryRepo.costingCreatePost(

      stockCode: stockCode,
      actualcost: actualcost,
      actualSellingPrice: actualSellingPrice,
      channelId: channelId,
      pricrType: pricrType,
      gpOperation: gpOperation,
      costingName: costingName,
      createdBy: createdBy,
      unitCost: unitCost,
      invId: invId,
      varientCode: varientCode,
      varientId: varientId,
      channelCode: channelCode,
      costingMethodId: costingMethodId,
      sellingPrice: sellingPrice,
      GpPercentage: GpPercentage,
      pricingGpType: pricingGpType,
      pricingGroupId: pricingGroupId,
    );

    if (dataResponse.data ) {
      yield CreateCostingPostSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateCostingPostFailed(
        dataResponse.error ?? "",);
    }

  }


  Stream<InventoryState> costinglist(String code,String prev,int id) async* {
    List<CostingReadData> costData=[];
    String? next;
    yield CostingListLoading();

    final dataResponse = await _inventoryRepo.costinglist(code, prev,id);

    dataResponse.fold((l) => emit(CostingListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        costData.add((element));
      });

      emit(CostingListSuccess(
          costData: PaginatedResponse(costData, r.nextPage, r.previousUrl)));
    });
  }


  Stream<InventoryState> getCostingRead(int id) async* {

    yield CostingReadLoading();

    final dataResponse = await _inventoryRepo.getCostingRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield CostingReadSuccess(costingModel: dataResponse.data);
    } else {
      yield CostingReadFailed(dataResponse.error.toString(),
      );
    }
  }

  //updateDiscount
  Stream<InventoryState> updateCostingPost(
      {
        required int id,
        required int pricingGroupId,
        required String pricingGpType,
        required double GpPercentage,
        required double sellingPrice,
        required int costingMethodId,
        required String channelCode,
        required int varientId,
        required String varientCode,
        required String invId,
        required double unitCost,
        required String costingName,
        required String createdBy,
        required String gpOperation,
        required String pricrType,
        required String channelId,
        required double actualSellingPrice,
        required double actualcost,
        required String stockCode
      }) async* {
    yield CostingUpdateLoading();

    final dataResponse = await _inventoryRepo.updateCostingPost(

        stockCode: stockCode,
        actualcost: actualcost,
        actualSellingPrice: actualSellingPrice,
        channelId: channelId,
        pricrType: pricrType,
        gpOperation: gpOperation,
        costingName: costingName,
        createdBy: createdBy,
        unitCost: unitCost,
        invId: invId,
        varientCode: varientCode,
        varientId: varientId,
        channelCode: channelCode,
        costingMethodId: costingMethodId,
        sellingPrice: sellingPrice,
        GpPercentage: GpPercentage,
        pricingGpType: pricingGpType,
        pricingGroupId: pricingGroupId,
        id: id
    );

    if (dataResponse.data ) {
      yield CostingUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield CostingUpdateFailed(
        dataResponse.error ?? "",);
    }

  }
  //division
  Stream<InventoryState> createDivision(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String searchName,
        required String displayName,
        required String description,

      }) async* {
    yield CreateDivisionLoading();

    final dataResponse = await _inventoryRepo.createDivision(

        image: image,
        description: description,
        prioriy: prioriy,
        name: name,
        displayName:  displayName,
        searchName: searchName
    );

    if (dataResponse.data ) {
      yield CreateDivisionSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateDivisionFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getDivisionRead(int id) async* {

    yield DivisionReadLoading();

    final dataResponse = await _inventoryRepo.getDivisionRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield DivisionReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield DivisionReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteDivision({required int id}) async* {
    yield DeleteDivisionLoading();
    final dataResponse = await _dataSource.deleteDivision(id);
    if (dataResponse == "success") {
      print("delete divisionsiccess");
      yield DeleteDivisionSuccess();
    } else {
      yield DeleteDivisionFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateDivisionPost(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String searchName,
        required String displayName,
        required String description,
        required int id,
        required bool isActive,
      }) async* {
    yield DivisionUpdateLoading();

    final dataResponse = await _inventoryRepo.updateDivisionPost(

        displayName:  displayName,
        searchName: searchName,
        name: name,
        prioriy: prioriy,
        isActive: isActive,
        description: description,
        image: image,
        id: id
    );

    if (dataResponse.data ) {
      yield DivisionUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield DivisionUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //cateegory
  Stream<InventoryState> getCategorylist({
    String? search,
    String? next,String? prev
  }) async* {
    yield GetCategoryListLoading();
    final dataResponse = await _inventoryRepo.getCategorylist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetCategoryListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetCategoryListFailed("failed");
    }
  }

  Stream<InventoryState> getDivisionList({
    String? search,
    String? next,String? prev
  }) async* {
    yield GetDivisionListLoading();
    final dataResponse = await _inventoryRepo.getDivisionlist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetDivisionListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetDivisionListFailed("failed");
    }
  }


  Stream<InventoryState> createCategory(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String altName,
        required String parentCode,
        required String divisionCode,
        required String description,

      }) async* {
    yield CreateCategoryLoading();

    final dataResponse = await _inventoryRepo.createCategory(

        image: image,
        description: description,
        prioriy: prioriy,
        name: name,
        parentCode:  parentCode,
        divisionCode: divisionCode,
        altName: altName
    );

    if (dataResponse.data ) {
      yield CreateCategorySuccess(successMessage: dataResponse.error);
    } else {
      yield CreateCategoryFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getCategoryRead(int id) async* {

    yield CategoryReadLoading();

    final dataResponse = await _inventoryRepo.getCategoryRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield CategoryReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield CategoryReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteCategory({required int id}) async* {
    yield DeleteCategoryLoading();
    final dataResponse = await _dataSource.deleteCategory(id);
    if (dataResponse == "success") {
      yield DeleteCategorySuccess();
    } else {
      yield DeleteCategoryFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateCategoryPost(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String altName,
        required String divisionCode,
        required String parentCode,
        required String description,
        required int id,
        required bool isActive,
      }) async* {
    yield CategoryUpdateLoading();

    final dataResponse = await _inventoryRepo.updateCategoryPost(

        divisionCode:  divisionCode,
        parentCode: parentCode,
        altName: altName,
        name: name,
        prioriy: prioriy,
        isActive: isActive,
        description: description,
        image: image,
        id: id
    );

    if (dataResponse.data ) {
      yield CategoryUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield CategoryUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //group
  Stream<InventoryState> getGrouplist({
    String? search,
    String? next,String? prev
  }) async* {
    yield GetGroupListLoading();
    final dataResponse = await _inventoryRepo.getGrouplist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetGroupListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetGroupListFailed("failed");
    }
  }

  Stream<InventoryState> createGroup(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String categoryCode,
        required String searchName,
        required String displayName,
        required String description,
      }) async* {
    yield CreateGroupLoading();

    final dataResponse = await _inventoryRepo.createGroup(

        image: image,
        description: description,
        prioriy: prioriy,
        name: name,
        categoryCode:  categoryCode,
        displayName: displayName,
        searchName: searchName
    );

    if (dataResponse.data ) {
      yield CreateGroupSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateGroupFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getGroupRead(int id) async* {

    yield GroupReadLoading();

    final dataResponse = await _inventoryRepo.getGroupRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GroupReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield GroupReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteGroup({required int id}) async* {
    yield DeleteGroupLoading();
    final dataResponse = await _dataSource.deleteGroup(id);
    if (dataResponse == "success") {
      yield DeleteGroupSuccess();
    } else {
      yield DeleteGroupFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateGroupPost(
      {
        required int prioriy,
        required dynamic image,
        required String name,
        required String categoryCode,
        required String searchName,
        required String displayName,
        required String description,
        required int id,
        required bool isActive,
      }) async* {
    yield GroupUpdateLoading();

    final dataResponse = await _inventoryRepo.updateGroupPost(

        searchName:  searchName,
        displayName: displayName,
        categoryCode: categoryCode,
        name: name,
        prioriy: prioriy,
        isActive: isActive,
        description: description,
        image: image,
        id: id
    );

    if (dataResponse.data ) {
      yield GroupUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield GroupUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //UomGroup
  Stream<InventoryState> getUomGrouplist({
    String? search, String? next,String? prev
  }) async* {
    yield GetUomGroupListLoading();
    final dataResponse = await _inventoryRepo.getUomGrouplist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetUomGroupListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetUomGroupListFailed("failed");
    }
  }

  Stream<InventoryState> createUomGroup(
      {
        required String name,
        required String shortName,
        required String description,
      }) async* {
    yield CreateUomGroupLoading();

    final dataResponse = await _inventoryRepo.createUomGroup(
        description: description,
        name: name,
        shortName: shortName
    );

    if (dataResponse.data ) {
      yield CreateUomGroupSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateUomGroupFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getUomGroupRead(int id) async* {

    yield UomGroupReadLoading();

    final dataResponse = await _inventoryRepo.getUomGroupRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield UomGroupReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield UomGroupReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteUomGroup({required int id}) async* {
    yield DeleteUomGroupLoading();
    final dataResponse = await _dataSource.deleteUomGroup(id);
    if (dataResponse == "success") {
      yield DeleteUomGroupSuccess();
    } else {
      yield DeleteUomGroupFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateUomGroupPost(
      {
        required String name,
        required String shortName,
        required String description,
        required int id,
        required bool isActive,
      }) async* {
    yield UomGroupUpdateLoading();

    final dataResponse = await _inventoryRepo.updateUomGroupPost(
        name: name,
        isActive: isActive,
        description: description,
        shortName: shortName,
        id: id
    );

    if (dataResponse.data ) {
      yield UomGroupUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield UomGroupUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //UOM
  Stream<InventoryState> getUomlist({
    String? search,String? next,String? prev
  }) async* {
    yield GetUomListLoading();
    final dataResponse = await _inventoryRepo.getUomlist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetUomListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetUomListFailed("failed");
    }
  }

  Stream<InventoryState> createUom(
      {
        required String name,
        required String shortName,
        required String baseEquvalant,
        required String uomGroupCode,
        required double convertionFactor,
        required String statnderdCode,
      }) async* {
    yield CreateUomLoading();

    final dataResponse = await _inventoryRepo.createUom(
        uomGroupCode: uomGroupCode,
        statnderdCode: statnderdCode,
        convertionFactor: convertionFactor,
        baseEquvalant: baseEquvalant,
        name: name,
        shortName: shortName
    );

    if (dataResponse.data ) {
      yield CreateUomSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateUomFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getUomRead(int id) async* {

    yield UomReadLoading();

    final dataResponse = await _inventoryRepo.getUomRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield UomReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield UomReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteUom({required int id}) async* {
    yield DeleteUomLoading();
    final dataResponse = await _dataSource.deleteUom(id);
    if (dataResponse == "success") {
      yield DeleteUomSuccess();
    } else {
      yield DeleteUomFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateUomPost(
      {
        required String name,
        required String shortName,
        required String baseEquvalant,
        required String uomGroupCode,
        required double convertionFactor,
        required String statnderdCode,
        required int id,
        required bool isActive,
      }) async* {
    yield UomUpdateLoading();

    final dataResponse = await _inventoryRepo.updateUomPost(
        name: name,
        isActive: isActive,
        uomGroupCode: uomGroupCode,
        baseEquvalant: baseEquvalant,
        convertionFactor: convertionFactor,
        statnderdCode: statnderdCode,
        shortName: shortName,
        id: id
    );

    if (dataResponse.data ) {
      yield UomUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield UomUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //Material
  Stream<InventoryState> getMateriallist({
    String? search,String? next,String? prev
  }) async* {
    yield GetMaterialListLoading();
    final dataResponse = await _inventoryRepo.getMateriallist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetMaterialListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetMaterialListFailed("failed");
    }
  }

  Stream<InventoryState> createMaterial(
      {
        required String name,
        required dynamic image,
        required String searchNmae,
        required String discription,
      }) async* {
    yield CreateMaterialLoading();

    final dataResponse = await _inventoryRepo.createMaterial(
        name: name,
        searchNmae: searchNmae,
        discription: discription,
        image: image
    );

    if (dataResponse.data ) {
      yield CreateMaterialSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateMaterialFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getMaterialRead(int id) async* {

    yield MaterialReadLoading();

    final dataResponse = await _inventoryRepo.getMaterialRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield MaterialReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield MaterialReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteMaterial({required int id}) async* {
    yield DeleteMaterialLoading();
    final dataResponse = await _dataSource.deleteMaterial(id);
    if (dataResponse == "success") {
      yield DeleteMaterialSuccess();
    } else {
      yield DeleteMaterialFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateMaterialPost(
      {
        required String name,
        required dynamic image,
        required String searchNmae,
        required String code,
        required String discription,
        required int id,
        required bool isActive,
      }) async* {
    yield MaterialUpdateLoading();

    final dataResponse = await _inventoryRepo.updateMaterialPost(
        name: name,
        isActive: isActive,
        image: image,
        code: code,
        discription: discription,
        searchNmae: searchNmae,
        id: id
    );

    if (dataResponse.data ) {
      yield MaterialUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield MaterialUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //staticGroup
  Stream<InventoryState> getStaticGrouplist({
    String? search,String? next,String? prev
  }) async* {
    yield GetStaticGroupListLoading();
    final dataResponse = await _inventoryRepo.getStaticGrouplist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetStaticGroupListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetStaticGroupListFailed("failed");
    }
  }

  Stream<InventoryState> createStaticGroup(
      {
        required String name,
        required dynamic image,
        required String searchNmae,
        required String discription,
      }) async* {
    yield CreateStaticGroupLoading();

    final dataResponse = await _inventoryRepo.createStaticGroup(
        name: name,
        searchNmae: searchNmae,
        discription: discription,
        image: image
    );

    if (dataResponse.data ) {
      yield CreateStaticGroupSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateStaticGroupFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getStaticGroupRead(int id) async* {

    yield StaticGroupReadLoading();

    final dataResponse = await _inventoryRepo.getStaticGroupRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield StaticGroupReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield StaticGroupReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteStaticGroup({required int id}) async* {
    yield DeleteStaticGroupLoading();
    final dataResponse = await _dataSource.deleteStaticGroup(id);
    if (dataResponse == "success") {
      yield DeleteStaticGroupSuccess();
    } else {
      yield DeleteStaticGroupFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateStaticGroupPost(
      {
        required String name,
        required dynamic image,
        required String searchNmae,
        required String discription,
        required int id,
        required bool isActive,
      }) async* {
    yield StaticGroupUpdateLoading();

    final dataResponse = await _inventoryRepo.updateStaticGroupPost(
        name: name,
        isActive: isActive,
        image: image,
        discription: discription,
        searchNmae: searchNmae,
        id: id
    );

    if (dataResponse.data ) {
      yield StaticGroupUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield StaticGroupUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //brand
  Stream<InventoryState> getBrandlist({
    String? search,String? next,String? prev
  }) async* {
    yield GetBrandListLoading();
    final dataResponse = await _inventoryRepo.getBrandlist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetBrandListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetBrandListFailed("failed");
    }
  }

  Stream<InventoryState> createBrand(
      {
        required String name,
        required dynamic image,
        required int priority,
        required String parentCode,
        required String discription,
        required String brandIdentifierUrl,
      }) async* {
    yield CreateBrandLoading();

    final dataResponse = await _inventoryRepo.createBrand(
        name: name,
        parentCode: parentCode,
        brandIdentifierUrl: brandIdentifierUrl,
        priority: priority,
        discription: discription,
        image: image
    );

    if (dataResponse.data ) {
      yield CreateBrandSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateBrandFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getBrandRead(int id) async* {

    yield BrandReadLoading();

    final dataResponse = await _inventoryRepo.getBrandRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield BrandReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield BrandReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteBrand({required int id}) async* {
    yield DeleteBrandLoading();
    final dataResponse = await _dataSource.deleteBrand(id);
    if (dataResponse == "success") {
      yield DeleteBrandSuccess();
    } else {
      yield DeleteBrandFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateBrandPost(
      {
        required String name,
        required dynamic image,
        required int priority,
        required String parentCode,
        required String discription,
        required String brandIdentifierUrl,
        required int id,
        required bool isActive,
      }) async* {
    yield BrandUpdateLoading();

    final dataResponse = await _inventoryRepo.updateBrandPost(
        name: name,
        isActive: isActive,
        image: image,
        discription: discription,
        parentCode: parentCode,
        priority: priority,
        brandIdentifierUrl: brandIdentifierUrl,
        id: id
    );

    if (dataResponse.data ) {
      yield BrandUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield BrandUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //attribute
  Stream<InventoryState> getAttributeTypeRead() async* {

    yield GetAttributeTypeLoading();

    final dataResponse = await _inventoryRepo.getAttributeTypeRead();

    if (dataResponse.hasData) {
      print("Susss");
      yield GetAttributeTypeSuccess(discount: dataResponse.data);
    } else {
      yield GetAttributeTypeFailed(dataResponse.error.toString(),
      );
    }
  }

  Stream<InventoryState> getAttributelist({
    String? search,String? next,String? prev
  }) async* {
    yield GetAttributeListLoading();
    final dataResponse = await _inventoryRepo.getAttributelist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetAttributeListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetAttributeListFailed("failed");
    }
  }

  Stream<InventoryState> createAttribute(
      {
        required String attributeName,
        required String attributeType,
        required bool isActive,
      }) async* {
    yield CreateAttributeLoading();

    final dataResponse = await _inventoryRepo.createAttribute(
        attributeType: attributeType,
        attributeName: attributeName,
        isActive: isActive
    );

    if (dataResponse.data ) {
      yield CreateAttributeSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateAttributeFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getAttributeRead(int id) async* {

    yield AttributeReadLoading();

    final dataResponse = await _inventoryRepo.getAttributeRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield AttributeReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield AttributeReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteAttribute({required int id}) async* {
    yield DeleteAttributeLoading();
    final dataResponse = await _dataSource.deleteAttribute(id);
    if (dataResponse == "success") {
      yield DeleteAttributeSuccess();
    } else {
      yield DeleteAttributeFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateAttributePost(
      {
        required String attributeName,
        required String attributeType,
        required int id,
        required bool isActive,
      }) async* {
    yield AttributeUpdateLoading();

    final dataResponse = await _inventoryRepo.updateAttributePost(

        isActive: isActive,
        attributeName: attributeName,
        attributeType: attributeType,
        id: id
    );

    if (dataResponse.data ) {
      yield AttributeUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield AttributeUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //varientframework
  Stream<InventoryState> getVarientFrameworklist({
    String? search,String? next,String? prev
  }) async* {
    yield GetVarientFrameWorkListLoading();
    final dataResponse = await _inventoryRepo.getVarientFrameworklist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetVarientFrameWorkListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetVarientFrameWorkListFailed("failed");
    }
  }

  Stream<InventoryState> createVarientFramework(
      {
        required String name,
        required String description,
        required List<AttributeLines> lines,
      }) async* {
    yield CreateVarientFrameWorkLoading();

    final dataResponse = await _inventoryRepo.createVarientFramework(
        description: description,
        name: name,
        lines: lines
    );

    if (dataResponse.data ) {
      yield CreateVarientFrameWorkSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateVarientFrameWorkFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getVarientFrameworkRead(int id) async* {

    yield VarientFrameWorkReadLoading();

    final dataResponse = await _inventoryRepo.getVarientFrameworkRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield VarientFrameWorkReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield VarientFrameWorkReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteVarientFramework({required int id}) async* {
    yield DeleteVarientFrameWorkLoading();
    final dataResponse = await _dataSource.deleteVarientFramework(id);
    if (dataResponse == "Success") {
      yield DeleteVarientFrameWorkSuccess();
    } else {
      yield DeleteVarientFrameWorkFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateVarientFrameworkPost(
      {
        required String name,
        required String description,
        required List<AttributeLines> lines,
        required int id,
        required bool isActive,
      }) async* {
    yield VarientFrameWorkUpdateLoading();

    final dataResponse = await _inventoryRepo.updateVarientFrameworkPost(

        isActive: isActive,
        lines: lines,
        description: description,
        name: name,
        id: id
    );

    if (dataResponse.data ) {
      yield VarientFrameWorkUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield VarientFrameWorkUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //item
  Stream<InventoryState> getItemlist({
    String? search,String? next,String? prev
  }) async* {
    yield GetItemListLoading();
    final dataResponse = await _inventoryRepo.getItemlist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetItemListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetItemListFailed("failed");
    }
  }

  Stream<InventoryState> createItem(
      {
        required String name,
        required String description,
        required String materialCode,
        required String uomgroupCode,
        required String uomCode,
        required String groupCode,
        required String brandCode,
        required String staticGroupCode,
        required String variantFrameworkCode,
        required int? img1,
        required int? img2,
        required int? img3,
        required int? itemCatalog1,
        required int? itemCatalog2,
        required int? itemCatalog3,
        required int? itemCatalog4,
        required int? itemCatalog5,
        required String displayName,
        required String barcode,
        required String oldSystemCode,
        required String searchName,
      }) async* {
    yield CreateItemLoading();

    final dataResponse = await _inventoryRepo.createItem(
        description: description,
        name: name,
        variantFrameworkCode: variantFrameworkCode,
        uomgroupCode: uomgroupCode,
        uomCode: uomCode,
        staticGroupCode: staticGroupCode,
        oldSystemCode: oldSystemCode,
        materialCode: materialCode,
        itemCatalog5: itemCatalog5,
        itemCatalog4: itemCatalog4,
        itemCatalog3: itemCatalog3,
        itemCatalog2: itemCatalog2,
        itemCatalog1: itemCatalog1,
        img3: img3,
        img2: img2,
        img1: img1,
        groupCode: groupCode,
        brandCode: brandCode,
        barcode: barcode,
        displayName: displayName,
        searchName: searchName
    );

    if (dataResponse.data ) {
      yield CreateItemSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateItemFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getItemRead(int id) async* {

    yield ItemReadLoading();

    final dataResponse = await _inventoryRepo.getItemRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield ItemReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield ItemReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteItem({required int id}) async* {
    yield DeleteItemLoading();
    final dataResponse = await _dataSource.deleteItem(id);
    if (dataResponse == "success") {
      yield DeleteItemSuccess();
    } else {
      yield DeleteItemFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateItemPost(
      {
        required String name,
        required String description,
        required String materialCode,
        required String uomgroupCode,
        required String uomCode,
        required String groupCode,
        required String brandCode,
        required String staticGroupCode,
        required String variantFrameworkCode,
        required dynamic img1,
        required dynamic img2,
        required dynamic img3,
        required dynamic itemCatalog1,
        required dynamic itemCatalog2,
        required dynamic itemCatalog3,
        required dynamic itemCatalog4,
        required dynamic itemCatalog5,
        required String displayName,
        required String barcode,
        required String oldSystemCode,
        required String searchName,
        required int id,
        required bool isActive,
      }) async* {
    yield ItemUpdateLoading();

    final dataResponse = await _inventoryRepo.updateItemPost(

        isActive: isActive,
        description: description,
        name: name,
        variantFrameworkCode: variantFrameworkCode,
        uomgroupCode: uomgroupCode,
        uomCode: uomCode,
        staticGroupCode: staticGroupCode,
        oldSystemCode: oldSystemCode,
        materialCode: materialCode,
        itemCatalog5: itemCatalog5,
        itemCatalog4: itemCatalog4,
        itemCatalog3: itemCatalog3,
        itemCatalog2: itemCatalog2,
        itemCatalog1: itemCatalog1,
        img3: img3,
        img2: img2,
        img1: img1,
        groupCode: groupCode,
        brandCode: brandCode,
        barcode: barcode,
        displayName: displayName,
        searchName: searchName,
        id: id
    );

    if (dataResponse.data ) {
      yield ItemUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield ItemUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //list for segment
  Stream<InventoryState> getGroupListSegment({
    String? search,String? next,String? prev
  }) async* {
    yield GroupListSegmentLoading();
    final dataResponse = await _inventoryRepo.getGroupListSegment(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GroupListSegmentSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GroupListSegmentFailed("failed");
    }
  }

  Stream<InventoryState> getUomListSegment({
    String? search,String? next,String? prev
  }) async* {
    yield UomListSegmentLoading();
    final dataResponse = await _inventoryRepo.getUomListSegment(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield UomListSegmentSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield UomListSegmentFailed("failed");
    }
  }

  Stream<InventoryState> getCategoryListSegment({
    String? search,String? next,String? prev
  }) async* {
    yield CategoryListSegmentLoading();
    final dataResponse = await _inventoryRepo.getCategoryListSegment(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield CategoryListSegmentSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield CategoryListSegmentFailed("failed");
    }
  }

  //division config
  Stream<InventoryState> getDivisionConfigurationlist({
    String? search,String? next,String? prev
  }) async* {
    yield GetDivisionConfigurationListLoading();
    final dataResponse = await _inventoryRepo.getDivisionConfigurationlist(search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetDivisionConfigurationListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetDivisionConfigurationListFailed("failed");
    }
  }

  Stream<InventoryState> createDivisionConfiguration(
      {
        required String name,
        required String description,
        required dynamic image,
        required bool isMixed,
        required int priority,
        required List<String> uomGroup,
        required List<String> grroup,
        required List<String> categoey,
      }) async* {
    yield CreateDivisionConfigurationLoading();

    final dataResponse = await _inventoryRepo.createDivisionConfiguration(
        description: description,
        name: name,
        uomGroup: uomGroup,
        isMixed: isMixed,
        grroup: grroup,
        categoey: categoey,
        image: image,
        priority: priority
    );

    if (dataResponse.data ) {
      yield CreateDivisionConfigurationSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateDivisionConfigurationFailed(
        dataResponse.error ?? "",);
    }

  }

  Stream<InventoryState> getDivisionConfigurationRead(int id) async* {

    yield DivisionConfigurationReadLoading();

    final dataResponse = await _inventoryRepo.getDivisionConfigurationRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield DivisionConfigurationReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield DivisionConfigurationReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteDivisionConfiguration({required int id}) async* {
    yield DeleteDivisionConfigurationLoading();
    final dataResponse = await _dataSource.deleteDivisionConfiguration(id);
    if (dataResponse == "success") {
      yield DeleteDivisionConfigurationSuccess();
    } else {
      yield DeleteDivisionConfigurationFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateDivisionConfigurationPost(
      {
        required String name,
        required String description,
        required dynamic image,
        required bool isMixed,
        required int priority,
        required List<String> uomGroup,
        required List<String> grroup,
        required List<String> categoey,
        required int id,
        required bool isActive,
      }) async* {
    yield DivisionConfigurationUpdateLoading();

    final dataResponse = await _inventoryRepo.updateDivisionConfigurationPost(

        isActive: isActive,
        description: description,
        name: name,
        priority: priority,
        image: image,
        categoey: categoey,
        grroup: grroup,
        isMixed: isMixed,
        uomGroup: uomGroup,
        id: id
    );

    if (dataResponse.data ) {
      yield DivisionConfigurationUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield DivisionConfigurationUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //warrantyType
  Stream<InventoryState> getWarrantyTypelist({
    String? search
  }) async* {
    yield GetWarrantyTypeListLoading();
    final dataResponse = await _inventoryRepo.getWarrantyTypelist(search);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetWarrantyTypeListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetWarrantyTypeListFailed("failed");
    }
  }

  Stream<InventoryState> createWarrantyType(
      {
        required String title,
        required String description,
        required bool isActive,
      }) async* {
    yield CreateWarrantyTypeLoading();

    final dataResponse = await _inventoryRepo.createWarrantyType(
        description: description,
        title: title,
        isActive: isActive
    );

    if (dataResponse.data ) {
      yield CreateWarrantyTypeSuccess(successMessage: dataResponse.error);
    } else {
      yield CreateWarrantyTypeFailed(
        dataResponse.error ?? "",);
    }

  }
  Stream<InventoryState> getWarrantyTypeRead(int id) async* {

    yield WarrantyTypeReadLoading();

    final dataResponse = await _inventoryRepo.getWarrantyTypeRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield WarrantyTypeReadSuccess(readData: dataResponse.data);
    } else {
      yield WarrantyTypeReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteWarrantyType({required int id}) async* {
    yield DeleteWarrantyTypeLoading();
    final dataResponse = await _dataSource.deleteWarrantyType(id);
    if (dataResponse == "success") {
      yield DeleteWarrantyTypeSuccess();
    } else {
      yield DeleteWarrantyTypeFailed();
    }
  }

  //updateDiscount
  Stream<InventoryState> updateWarrantyTypePost(
      {
        required String title,
        required String description,
        required bool isActive,
        required int id,
      }) async* {
    yield WarrantyTypeUpdateLoading();

    final dataResponse = await _inventoryRepo.updateWarrantyTypePost(

        isActive: isActive,
        description: description,
        title: title,
        id: id
    );

    if (dataResponse.data ) {
      yield WarrantyTypeUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield WarrantyTypeUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

  //uomByUomGroup
  Stream<InventoryState> getGetUomByUomGrouplist({
    String? search,
    int? id,
    String? next,String? prev
  }) async* {
    yield GetUomByUomGroupListLoading();
    final dataResponse = await _inventoryRepo.getGetUomByUomGrouplist(search,id,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetUomByUomGroupListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetUomByUomGroupListFailed("failed");
    }
  }

  //createWarranty
  Stream<InventoryState> createWarranty(
      {
        required CreateWarrantyModel warrantyModel,
      }) async* {
    yield CreateWarrantyLoading();

    final dataResponse = await _inventoryRepo.createWarranty(
        warrantyModel: warrantyModel
    );

    if (dataResponse.data ) {
      yield CreateWarrantySuccess(successMessage: dataResponse.error);
    } else {
      yield CreateWarrantyFailed(
        dataResponse.error ?? "",);
    }

  }

  //
  Stream<InventoryState> getWarrantylist({
    String? code,String? search,String? next,String? prev
  }) async* {
    yield GetWarrantyListLoading();
    final dataResponse = await _inventoryRepo.getWarrantylist(code,search,next,prev);
    if (dataResponse.data !=null &&dataResponse.data.isNotEmpty) {
      yield GetWarrantyListSuccess(
          prevPageUrl: dataResponse.previousUrl??"",
          nextPageUrl: dataResponse.nextPageUrl ?? "",
          inventory:  dataResponse.data);  }

    else {
      yield GetWarrantyListFailed("failed");
    }
  }

  Stream<InventoryState> getWarrantyRead(String code,) async* {

    yield WarrantyReadLoading();

    final dataResponse = await _inventoryRepo.getWarrantyRead(code);

    if (dataResponse.hasData) {
      print("Susss");
      yield WarrantyReadSuccess(divisionModel: dataResponse.data);
    } else {
      yield WarrantyReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<InventoryState> deleteWarranty({required String code}) async* {
    yield DeleteWarrantyLoading();
    final dataResponse = await _dataSource.deleteWarranty(code);
    if (dataResponse == "success") {
      yield DeleteWarrantySuccess();
    } else {
      yield DeleteWarrantyFailed();
    }
  }


}
