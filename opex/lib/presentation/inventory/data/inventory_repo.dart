

import 'dart:io';

import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/core/utils/failure.dart';
import 'package:cluster/core/utils/repo.dart';
import 'package:cluster/presentation/inventory/model/division_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../model/create_variant_model.dart';
import 'inventory_src.dart';

class InventoryRepo {
  final InventoryDataSource _dataSource = InventoryDataSource();


//get division
  Future<PaginatedResponse> getDivision({String? search,url
  }) async {
    final apiResponse = await _dataSource.getDivision(search:search,url:url );
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

            );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
//get nationality
  Future<PaginatedResponse> getCategory({int? id,String? search,url}) async {
    final apiResponse = await _dataSource.getCategory(id: id,search: search,url: url);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse(apiResponse,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
    previousUrl: apiResponse.previousUrl);
  }
//getSubCategory
  Future<PaginatedResponse> getSubCategory({int? id,String? search,url}) async {
    print("inside repo$search");
    final apiResponse = await _dataSource.getSubCategory(id: id,search:search,url:url);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
  //getGroup
  Future<PaginatedResponse> getGroup({int? id,String? search,url}) async {
    final apiResponse = await _dataSource.getGroup(id: id,search: search,url:url);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }  //getGroup
  Future<PaginatedResponse> getItem({int? id,String? search}) async {
    final apiResponse = await _dataSource.getItem(id: id,search: search);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
Future<PaginatedResponse> getUom({int? id,String? search}) async {
    final apiResponse = await _dataSource.getUom(id: id,search: search);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
  Future<PaginatedResponse> getSalesUom({int? id,String? search}) async {
    final apiResponse = await _dataSource.getSalesUom(id: id,search: search);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }

  //get variant
  Future<PaginatedResponse> getVariant({int? id,int? itemId,String? search}) async {
    final apiResponse = await _dataSource.getVariant(id: id,search: search,itemId:itemId);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }


  //upload Pic
  Future<DoubleResponse> postPic(File? profilePic)async {
    final apiResponse = await _dataSource.postPic(profilePic);
    print("inside postpic${apiResponse.data1}");
    try {
      if (apiResponse.data1!=null) {
        return DoubleResponse( apiResponse.data1,apiResponse.data2);
      } else {
        return DoubleResponse(null,  null);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DoubleResponse(
         apiResponse.data1,
         apiResponse.data2,
      );
  }
  //get combinations
  Future<DataResponse> getCombination({int? id}) async {
    final apiResponse = await _dataSource.getCombinations(id: id);
    try {
      if (apiResponse != null) {
        return DataResponse(data: apiResponse,error: "Success");
      } else {
        return DataResponse(data: apiResponse,error: "Failed");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(data: apiResponse,error: "Failed");
  }


  //get channel
  Future<PaginatedResponse> getChannel() async {
    final apiResponse = await _dataSource.getChannel();
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  } //get channel
  Future<PaginatedResponse> getManufacture({String? search,url}) async {
    final apiResponse = await _dataSource.getManufacture(search: search,url:url);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
  //Create Varient
  Future<DoubleResponse> createVariant({CreateVariantModel? variantModel}) async {
    final apiResponse = await _dataSource.createVarient(variantModel: variantModel);
    try {
      if (apiResponse.data1) {
        return DoubleResponse( apiResponse.data1, apiResponse.data2);
      } else {
        return DoubleResponse( apiResponse.data1, apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DoubleResponse( apiResponse.data1, apiResponse.data2);
  }
  //Return Type
  Future<DataResponse> returnType() async {
    final apiResponse = await _dataSource.returnType();
    try {
      return DataResponse(data: apiResponse.data);
      // if (apiResponse != null) {
      //   return DataResponse(data: apiResponse,error: "Success");
      // } else {
      //   return DataResponse(data: apiResponse,error: "Failed");
      // }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(data: apiResponse.data);
  }

  //get sibling
  Future<PaginatedResponse> getSibling() async {
    final apiResponse = await _dataSource.getSibling();
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }


  //get Inventory
  Future<DataResponse> getInventory() async {
    final apiResponse = await _dataSource.getInventory();
    try {
      if (apiResponse != null) {
        return DataResponse(data: apiResponse,error: "Success");
      } else {
        return DataResponse(data: apiResponse,error: "Failed");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(data: apiResponse,error: "Failed");
  }
  //list Variants
  Future<PaginatedResponse> listVariant({String ?url,search}) async {
    final apiResponse = await _dataSource.listVariants(url:url,search: search);
    try {
      if (apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(
            apiResponse.data, apiResponse.nextPageUrl, apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(
            [], apiResponse.nextPageUrl, apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(
        apiResponse.data, apiResponse.nextPageUrl, apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
  //get Inventory
  Future<DataResponse> readVariant({int ? id}) async {
    final apiResponse = await _dataSource.readVariant(id: id);
    try {
      if (apiResponse != null) {
        return DataResponse(data: apiResponse.data,error: "Success");
      } else {
        return DataResponse(data: apiResponse.data,error: "Failed");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(data: apiResponse,error: "Failed");
  }
  //update Inventory
  Future<DoubleResponse> updateVariant({CreateVariantModel? dataModel,int? id}) async {
    final apiResponse = await _dataSource.updateVariant(id: id,dataModel: dataModel);
    try {
      if (apiResponse.data1) {
        return DoubleResponse(apiResponse.data1,apiResponse.data2);
      } else {
        return DoubleResponse(apiResponse.data1,apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DoubleResponse(apiResponse.data1,apiResponse.data2);
  }  //update Inventory
  Future<DoubleResponse> deleteVariant({int? id}) async {
    final apiResponse = await _dataSource.deleteVariant(id: id);
    try {
      // print()
      if (apiResponse.data1) {
        return DoubleResponse( apiResponse.data1, apiResponse.data2);
      } else {
        return DoubleResponse( apiResponse.data1,apiResponse.data2);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DoubleResponse( apiResponse.data1, apiResponse.data2);
  }
  Future<PaginatedResponse> getStockPartition({String? id,String? search,String? url}) async {
    final apiResponse = await _dataSource.getStockPartition(id: id,search: search,url:url);
    try {
      if (apiResponse != null) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      } else {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
            previousUrl: apiResponse.previousUrl);
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
        previousUrl: apiResponse.previousUrl);
  }
  //STOCK
  Future<Either<Failure, PaginatedResponse<List<InventoryModel>>>> getStockProduct(
      String code, String? prev) async {
    return repoExecute<PaginatedResponse<List<InventoryModel>>>(
            () async => _dataSource.getStockProduct(code, prev));
  }


  Future<DataResponse> getStockProductRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getStockProductRead(id!);

      if (apiResponse.virtualType!.isNotEmpty) {
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }


  Future<DataResponse> createVirtualStock({
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
  }) async {
    final restAPIresponse = await _dataSource.createVirtualStock(
      addVirtualStock: addVirtualStock,
      channelId: channelId,
      crucialPoint: crucialPoint,
      dailyStockQty: dailyStockQty,
      isDailyStockAvailable: isDailyStockAvailable,
      mediumPoint: mediumPoint,
      stockWarning: stockWarning,
      variantCode: variantCode,
      variantId: variantId,
      virtualType: virtualType,
      inventoryId: inventoryId,
      channelCode: channelCode,

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<DataResponse> createMethodType({
    required String typeName,
    required String discription,
    required String createdBy,

  }) async {
    final restAPIresponse = await _dataSource.createMethodType(
        createdBy: createdBy,
        discription: discription,
        typeName: typeName

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<Either<Failure, PaginatedResponse<List<CostingModel>>>> costMethodTypeList(
      String code, String? prev) async {
    return repoExecute<PaginatedResponse<List<CostingModel>>>(
            () async => _dataSource.costMethodTypeList(code, prev));
  }

  Future<DataResponse> getCostMethodTypeRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getCostMethodTypeRead(id!);

      if (apiResponse.typeCode != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateCostMethodTypePost({
    required String typeName,
    required int id,
    required String discription,
    required String createdBy,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateCostMethodTypePost(
        createdBy: createdBy,
        isActive: isActive,
        id: id,
        typeName: typeName,
        discription: discription
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //mthodCreate
  Future<DataResponse> createMethod({
    required int methodTypeId,
    required String methodName,
    required String createdBy,
    required String discription,

  }) async {
    final restAPIresponse = await _dataSource.createMethod(
        createdBy: createdBy,
        discription: discription,
        methodName: methodName,
        methodTypeId: methodTypeId

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<Either<Failure, PaginatedResponse<List<CostingModel>>>> costMethodlist(
      String code, String? prev) async {
    return repoExecute<PaginatedResponse<List<CostingModel>>>(
            () async => _dataSource.costMethodlist(code, prev));
  }

  Future<DataResponse> getCostMethodRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getCostMethodRead(id!);

      if (apiResponse.methodCode != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateCostMethodPost({
    required int methodTypeId,
    required String methodName,
    required String createdBy,
    required String discription,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateCostMethodPost(
        createdBy: createdBy,
        isActive: isActive,
        id: id,
        methodName: methodName,
        methodTypeId: methodTypeId,
        discription: discription
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //pricingType
  Future<DataResponse> createPricingType({
    required String pricingTypeName,
    required String createdBy,
    required String discription,

  }) async {
    final restAPIresponse = await _dataSource.createPricingType(
      createdBy: createdBy,
      discription: discription,
      pricingTypeName: pricingTypeName,

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<Either<Failure, PaginatedResponse<List<CostingModel>>>> PricingTypelist(
      String code, String? prev) async {
    return repoExecute<PaginatedResponse<List<CostingModel>>>(
            () async => _dataSource.PricingTypelist(code, prev));
  }

  Future<DataResponse> getPricingTypeRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getPricingTypeRead(id!);

      if (apiResponse.pricingTypeCode != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updatePricingTypePost({
    required String pricingTypeName,
    required String pricingTypeCode,
    required String createdBy,
    required String discription,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updatePricingTypePost(
        createdBy: createdBy,
        isActive: isActive,
        id: id,
        pricingTypeName: pricingTypeName,
        pricingTypeCode: pricingTypeCode,
        discription: discription
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  //pricingGroup
  Future<DataResponse> createPricingGroup({
    required int pricingTypeId,
    required String pricingGroupName,
    required String customerGroupCode,
    required String createdBy,
    required String discription,

  }) async {
    final restAPIresponse = await _dataSource.createPricingGroup(
        createdBy: createdBy,
        discription: discription,
        pricingTypeId: pricingTypeId,
        customerGroupCode: customerGroupCode,
        pricingGroupName: pricingGroupName

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<Either<Failure, PaginatedResponse<List<CostingModel>>>> PricingGrouplist(
      String code, String? prev) async {
    return repoExecute<PaginatedResponse<List<CostingModel>>>(
            () async => _dataSource.PricingGrouplist(code, prev));
  }

  Future<DataResponse> getPricingGroupRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getPricingGroupRead(id!);

      if (apiResponse.pricingGroupCode != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updatePricingGroupPost({
    required int pricingTypeId,
    required String customerGroupCode,
    required String pricingGroupName,
    required String createdBy,
    required String discription,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updatePricingGroupPost(
        createdBy: createdBy,
        isActive: isActive,
        id: id,
        pricingGroupName: pricingGroupName,
        customerGroupCode: customerGroupCode,
        pricingTypeId: pricingTypeId,
        discription: discription
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getPricingGpTypeRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getPricingGpTypeRead(id!);

      if (apiResponse.pricingGpType!.isNotEmpty) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }


  Future<DataResponse> gpPercentagePost({
    required int variantId,
    required String GPType,
    required String inventoryId,

  }) async {
    final restAPIresponse = await _dataSource.gpPercentagePost(
      GPType: GPType,
      inventoryId: inventoryId,
      variantId: variantId,


    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  Future<DataResponse> costingCreatePost({
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

  }) async {
    final restAPIresponse = await _dataSource.costingCreatePost(
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
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<Either<Failure, PaginatedResponse<List<CostingReadData>>>> costinglist(
      String code, String? prev,int id) async {
    return repoExecute<PaginatedResponse<List<CostingReadData>>>(
            () async => _dataSource.costinglist(code, prev,id));
  }

  Future<DataResponse> getCostingRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getCostingRead(id!);

      if (apiResponse.costingCode != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateCostingPost({
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
  }) async {
    final restAPIresponse = await _dataSource.updateCostingPost(
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

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //division
  Future<DataResponse> createDivision({
    required int prioriy,
    required dynamic image,
    required String name,
    required String searchName,
    required String displayName,
    required String description,

  }) async {
    final restAPIresponse = await _dataSource.createDivision(
        displayName: displayName,
        searchName: searchName,
        name: name,
        prioriy: prioriy,
        description: description,
        image: image

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getDivisionRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getDivisionRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateDivisionPost({
    required int prioriy,
    required dynamic image,
    required String name,
    required String searchName,
    required String displayName,
    required String description,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateDivisionPost(
        image: image,
        isActive: isActive,
        id: id,
        description: description,
        prioriy: prioriy,
        name: name,
        searchName: searchName,
        displayName: displayName
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //category
  Future<DataResponse> createCategory({
    required int prioriy,
    required dynamic image,
    required String name,
    required String altName,
    required String parentCode,
    required String divisionCode,
    required String description,

  }) async {
    final restAPIresponse = await _dataSource.createCategory(
        altName: altName,
        divisionCode: divisionCode,
        parentCode: parentCode,
        name: name,
        prioriy: prioriy,
        description: description,
        image: image

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getCategoryRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getCategoryRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateCategoryPost({
    required int prioriy,
    required dynamic image,
    required String name,
    required String altName,
    required String divisionCode,
    required String parentCode,
    required String description,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateCategoryPost(
        image: image,
        isActive: isActive,
        id: id,
        description: description,
        prioriy: prioriy,
        name: name,
        altName: altName,
        parentCode: parentCode,
        divisionCode: divisionCode
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getCategorylist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getCategorylist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  //divv
  Future<PaginatedResponse> getDivisionlist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getDivisionlist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //group
  Future<DataResponse> createGroup({
    required int prioriy,
    required dynamic image,
    required String name,
    required String categoryCode,
    required String searchName,
    required String displayName,
    required String description,

  }) async {
    final restAPIresponse = await _dataSource.createGroup(
        searchName: searchName,
        displayName: displayName,
        categoryCode: categoryCode,
        name: name,
        prioriy: prioriy,
        description: description,
        image: image

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getGroupRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getGroupRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateGroupPost({
    required int prioriy,
    required dynamic image,
    required String name,
    required String categoryCode,
    required String searchName,
    required String displayName,
    required String description,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateGroupPost(
        image: image,
        isActive: isActive,
        id: id,
        description: description,
        prioriy: prioriy,
        name: name,
        categoryCode: categoryCode,
        displayName: displayName,
        searchName: searchName
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getGrouplist(String? search, String? next,String? prev) async {
    final apiResponse = await _dataSource.getGrouplist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  //UomGroup
  Future<DataResponse> createUomGroup({
    required String name,
    required String shortName,
    required String description,

  }) async {
    final restAPIresponse = await _dataSource.createUomGroup(
        name: name,
        description: description,
        shortName: shortName

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getUomGroupRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getUomGroupRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateUomGroupPost({
    required String name,
    required String shortName,
    required String description,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateUomGroupPost(
        isActive: isActive,
        id: id,
        description: description,
        name: name,
        shortName: shortName
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getUomGrouplist(String? search, String? next,String? prev) async {
    final apiResponse = await _dataSource.getUomGrouplist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //UOM
  Future<DataResponse> createUom({
    required String name,
    required String shortName,
    required String baseEquvalant,
    required String uomGroupCode,
    required double convertionFactor,
    required String statnderdCode,

  }) async {
    final restAPIresponse = await _dataSource.createUom(
        name: name,
        baseEquvalant: baseEquvalant,
        convertionFactor: convertionFactor,
        statnderdCode: statnderdCode,
        uomGroupCode: uomGroupCode,
        shortName: shortName

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getUomRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getUomRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateUomPost({
    required String name,
    required String shortName,
    required String baseEquvalant,
    required String uomGroupCode,
    required double convertionFactor,
    required String statnderdCode,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateUomPost(
        isActive: isActive,
        id: id,
        statnderdCode: statnderdCode,
        convertionFactor: convertionFactor,
        baseEquvalant: baseEquvalant,
        uomGroupCode: uomGroupCode,
        name: name,
        shortName: shortName
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getUomlist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getUomlist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //Material
  Future<DataResponse> createMaterial({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String discription,

  }) async {
    final restAPIresponse = await _dataSource.createMaterial(
        name: name,
        image: image,
        discription: discription,
        searchNmae: searchNmae

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getMaterialRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getMaterialRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateMaterialPost({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String code,
    required String discription,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateMaterialPost(
        isActive: isActive,
        id: id,
        name: name,
        image: image,
        discription: discription,
        searchNmae: searchNmae,
        code: code
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getMateriallist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getMateriallist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  //StaticGroup
  Future<DataResponse> createStaticGroup({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String discription,

  }) async {
    final restAPIresponse = await _dataSource.createStaticGroup(
        name: name,
        image: image,
        discription: discription,
        searchNmae: searchNmae

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getStaticGroupRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getStaticGroupRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateStaticGroupPost({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String discription,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateStaticGroupPost(
      isActive: isActive,
      id: id,
      name: name,
      image: image,
      discription: discription,
      searchNmae: searchNmae,
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getStaticGrouplist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getStaticGrouplist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //brand
  Future<DataResponse> createBrand({
    required String name,
    required dynamic image,
    required int priority,
    required String parentCode,
    required String discription,
    required String brandIdentifierUrl,

  }) async {
    final restAPIresponse = await _dataSource.createBrand(
        name: name,
        image: image,
        discription: discription,
        priority: priority,
        brandIdentifierUrl: brandIdentifierUrl,
        parentCode: parentCode

    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getBrandRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getBrandRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateBrandPost({
    required String name,
    required dynamic image,
    required int priority,
    required String parentCode,
    required String discription,
    required String brandIdentifierUrl,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateBrandPost(
        isActive: isActive,
        id: id,
        name: name,
        image: image,
        discription: discription,
        priority: priority,
        brandIdentifierUrl: brandIdentifierUrl,
        parentCode: parentCode
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getBrandlist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getBrandlist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  //atribute
  Future<DataResponse> getAttributeTypeRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getAttributeTypeRead();

      if (apiResponse.attributeType != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conersion Text",
    );
  }


  Future<DataResponse> createAttribute({
    required String attributeName,
    required String attributeType,
    required bool isActive,

  }) async {
    final restAPIresponse = await _dataSource.createAttribute(
        isActive: isActive,
        attributeName: attributeName,
        attributeType: attributeType
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getAttributeRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getAttributeRead(id!);

      if (apiResponse.attributeName != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateAttributePost({
    required String attributeName,
    required String attributeType,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateAttributePost(
        isActive: isActive,
        id: id,
        attributeType: attributeType,
        attributeName: attributeName
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getAttributelist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getAttributelist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //varioant
  Future<DataResponse> createVarientFramework({
    required String name,
    required String description,
    required List<AttributeLines> lines,

  }) async {
    final restAPIresponse = await _dataSource.createVarientFramework(
        lines: lines,
        name: name,
        description: description
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getVarientFrameworkRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getVarientFrameworkRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateVarientFrameworkPost({
    required String name,
    required String description,
    required List<AttributeLines> lines,
    required int id,
    required bool isActive,
  }) async {
    final restAPIresponse = await _dataSource.updateVarientFrameworkPost(
        isActive: isActive,
        id: id,
        name: name,
        description: description,
        lines: lines
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getVarientFrameworklist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getVarientFrameworklist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //item
  Future<DataResponse> createItem({
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

  }) async {
    final restAPIresponse = await _dataSource.createItem(
        name: name,
        description: description,
        searchName: searchName,
        displayName: displayName,
        barcode: barcode,
        brandCode: brandCode,
        groupCode: groupCode,
        img1: img1,
        img2: img2,
        img3: img3,
        itemCatalog1: itemCatalog1,
        itemCatalog2: itemCatalog2,
        itemCatalog3: itemCatalog3,
        itemCatalog4: itemCatalog4,
        itemCatalog5: itemCatalog5,
        materialCode: materialCode,
        oldSystemCode: oldSystemCode,
        staticGroupCode: staticGroupCode,
        uomCode: uomCode,
        uomgroupCode: uomgroupCode,
        variantFrameworkCode: variantFrameworkCode
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getItemRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getItemRead(id!);

      if (apiResponse.name != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateItemPost({
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
  }) async {
    final restAPIresponse = await _dataSource.updateItemPost(
        isActive: isActive,
        id: id,
        name: name,
        description: description,
        searchName: searchName,
        displayName: displayName,
        barcode: barcode,
        brandCode: brandCode,
        groupCode: groupCode,
        img1: img1,
        img2: img2,
        img3: img3,
        itemCatalog1: itemCatalog1,
        itemCatalog2: itemCatalog2,
        itemCatalog3: itemCatalog3,
        itemCatalog4: itemCatalog4,
        itemCatalog5: itemCatalog5,
        materialCode: materialCode,
        oldSystemCode: oldSystemCode,
        staticGroupCode: staticGroupCode,
        uomCode: uomCode,
        uomgroupCode: uomgroupCode,
        variantFrameworkCode: variantFrameworkCode
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getItemlist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getItemlist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //list for segment
  Future<PaginatedResponse> getGroupListSegment(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getGroupListSegment(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  Future<PaginatedResponse> getUomListSegment(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getUomListSegment(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  Future<PaginatedResponse> getCategoryListSegment(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getCategoryListSegment(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //division config
  Future<DataResponse> createDivisionConfiguration({
    required String name,
    required String description,
    required dynamic image,
    required bool isMixed,
    required int priority,
    required List<String> uomGroup,
    required List<String> grroup,
    required List<String> categoey,

  }) async {
    final restAPIresponse = await _dataSource.createDivisionConfiguration(
        name: name,
        description: description,
        priority: priority,
        image: image,
        categoey: categoey,
        grroup: grroup,
        isMixed: isMixed,
        uomGroup: uomGroup
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getDivisionConfigurationRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getDivisionConfigurationRead(id!);

      if (apiResponse.id != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateDivisionConfigurationPost({
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
  }) async {
    final restAPIresponse = await _dataSource.updateDivisionConfigurationPost(
        isActive: isActive,
        id: id,
        name: name,
        description: description,
        image: image,
        uomGroup: uomGroup,
        isMixed: isMixed,
        grroup: grroup,
        categoey: categoey,
        priority: priority
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getDivisionConfigurationlist(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getDivisionConfigurationlist(search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }


  //warrantyType
  Future<DataResponse> createWarrantyType({
    required String title,
    required String description,
    required bool isActive,

  }) async {
    final restAPIresponse = await _dataSource.createWarrantyType(

        description: description,
        isActive: isActive,
        title: title
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  Future<DataResponse> getWarrantyTypeRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getWarrantyTypeRead(id!);

      if (apiResponse.id != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateDiscount
  Future<DataResponse> updateWarrantyTypePost({
    required String title,
    required String description,
    required bool isActive,
    required int id,
  }) async {
    final restAPIresponse = await _dataSource.updateWarrantyTypePost(
        isActive: isActive,
        id: id,
        description: description,
        title: title
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  Future<PaginatedResponse> getWarrantyTypelist(String? search) async {
    final apiResponse = await _dataSource.getWarrantyTypelist(search);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //uomByGroup
  Future<PaginatedResponse> getGetUomByUomGrouplist(String? search,int? id,String? next,String? prev) async {
    final apiResponse = await _dataSource.getGetUomByUomGrouplist(search,id,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,
          apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }

  //createwarranty
  Future<DataResponse> createWarranty({
    required CreateWarrantyModel warrantyModel,

  }) async {
    final restAPIresponse = await _dataSource.createWarranty(

       warrantyModel: warrantyModel
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //
  Future<PaginatedResponse> getWarrantylist(  String? code,String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.getWarrantylist(code,search,next,prev);
    try {
      if (apiResponse.data!= null &&apiResponse.data!.isNotEmpty) {
        return PaginatedResponse(apiResponse.data,apiResponse.nextPageUrl,apiResponse.count,
          previousUrl: apiResponse.previousUrl,

        );
      } else {
        return PaginatedResponse([],"","",
          previousUrl: "",

        );
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return PaginatedResponse([],"","",
      previousUrl: "",

    );
  }
  Future<DataResponse> getWarrantyRead(String code) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getWarrantyRead(code);

      if (apiResponse.id != null) {
        print("sucCess");
        return DataResponse(
          data: apiResponse,
        );
      } else {
        return DataResponse(
          error: "implement Error conersion Text",
        );
      }
    } catch (e) {
      debugPrint("implement Error conersion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }


}