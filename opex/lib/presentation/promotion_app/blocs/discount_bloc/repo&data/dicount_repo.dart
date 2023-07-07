import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/core/utils/failure.dart';
import 'package:cluster/core/utils/repo.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:flutter/cupertino.dart';
import 'package:dartz/dartz.dart';
import 'discount_datasource.dart';

class DiscountRepo {
  final DiscountDataSource _dataSource = DiscountDataSource();


  //segmentList
  Future<DataResponse> getSegmentList() async {
    final apiResponse = await _dataSource.getSegmentList();
    try {
      if (apiResponse.isNotEmpty) {
        return DataResponse(data: apiResponse);
      } else {
        return DataResponse(error: "error Text");
      }
    } catch (e) {
      debugPrint("error Text$e");
    }
    return DataResponse(error: "error Text");
  }

  //createOfferPeriod
  Future<DataResponse> offerperiodPost({
    required String fromDate,
    required String toDate,
    required String fromTime,
    required String toTime,
    required String title,
    required String description,
    required String note,
    required String? createdBy,
    required bool? isActive,
  }) async {
    final restAPIresponse = await _dataSource.offerperiodPost(
      createdBy: createdBy,
      note: note,
      isActive: isActive,
      description: description,
      title:title,
      toTime: toTime,
      fromTime: fromTime,
      toDate: toDate,
      fromDate: fromDate
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //listofferGroup
  Future<Either<Failure, PaginatedResponse<List<GetOfferPeriod>>>> getOfferPeriodList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<GetOfferPeriod>>>(
            () async => _dataSource.getOfferPeriodList(code, next));
  }

  //readOfferPeriod
  Future<DataResponse> getOfferPeriodRead(int? id) async {
    try {
      final apiResponse = await _dataSource.getOfferPeriodRead(id!);

      if (apiResponse.id != null) {
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

  //updateofferperiod
  Future<DataResponse> updateOfferperiodPatch({
    required String fromDate,
    required String toDate,
    required String fromTime,
    required String toTime,
    required String title,
    required String description,
    required String note,
    required String? createdBy,
    required bool? isActive,
    required int? id,
  }) async {
    final restAPIresponse = await _dataSource.updateOfferperiodPatch(
        createdBy: createdBy,
        id: id,
        note: note,
        isActive: isActive,
        description: description,
        title:title,
        toTime: toTime,
        fromTime: fromTime,
        toDate: toDate,
        fromDate: fromDate
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  //channelList
  Future<Either<Failure, PaginatedResponse<List<ChannelList>>>> getChannelList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<ChannelList>>>(
            () async => _dataSource.getChannelList(code, next));
  }

  //offerGroupCreation
  Future<DataResponse> offerGroupPost({
    required int image,
    required String channelCode,
    required String inventoryId,
    required String title,
    required String description,
    required String? createdBy,
    required bool? isActive,
    required int priority,
  }) async {
    final restAPIresponse = await _dataSource.offerGroupPost(
        createdBy: createdBy,
        image: image,
        isActive: isActive,
        description: description,
        title:title,
        inventoryId: inventoryId,
        channelCode: channelCode,
      priority: priority
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //listOfferGroup
  Future<Either<Failure, PaginatedResponse<List<GetOfferGroup>>>> getOfferGroupList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<GetOfferGroup>>>(
            () async => _dataSource.getOfferGroupList(code, next));
  }

  //offergrouplist
  Future<DataResponse> getOfferGroupRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getOfferGroupRead(id!);

      if (apiResponse.title != null) {
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

  //offerGroupUpdate
  Future<DataResponse> updateOffergroup({
    required int img,
    required String title,
    required String description,
    required String? createdBy,
    required bool? isActive,
    required int? id,
    required int priority,
  }) async {
    final restAPIresponse = await _dataSource.updateOffergroup(
        createdBy: createdBy,
        id: id,
        isActive: isActive,
        description: description,
        title:title,
        img: img,
      priority: priority
    );
    if (restAPIresponse.hasData) {
      return DataResponse(error: restAPIresponse.error);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "");
    }
  }

  //readBasedon
  Future<DataResponse> getOfferAppliyingBasedOnRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getOfferAppliyingBasedOnRead();

      if (apiResponse.typeAppliying != null) {
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

  //listCustomerGroup
  Future<Either<Failure, PaginatedResponse<List<GetTypeApplying>>>> getCustomerGroupList(
      String? code, String? next) async {
    return repoExecute<PaginatedResponse<List<GetTypeApplying>>>(
            () async => _dataSource.getCustomerGroupList(code, next));
  }

  //createDisconut
  Future<DataResponse> createDiscountPost({
    required String typeApplying,
    required int typeId,
    required String typeCode,
    required dynamic image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    required int maxQty,
    required String inventoryId,
    required String? channelCode,
    required String? description,
    required double? discountPercentagePrice,
    required String? basedOn,
    required int? offerPeriodId,
    required int? offerGroupId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
    required int priority,
  }) async {
    final restAPIresponse = await _dataSource.createDiscountPost(
        createdBy: createdBy,
        isActive: isActive,
        priority: priority,
        description: description,
        title:title,
        inventoryId: inventoryId,
      channelCode: channelCode,
      image: image,
      typeId: typeId,
      basedOn: basedOn,
      customer: customer,
      discountPercentagePrice: discountPercentagePrice,
      isAvailableforAll: isAvailableforAll,
      maxQty: maxQty,
      offerGroupId: offerGroupId,
      offerPeriodId: offerPeriodId,
      segment: segment,
      typeApplying: typeApplying,
      typeCode: typeCode,
      variants: variants
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //listDiscount
  Future<Either<Failure, PaginatedResponse<List<DiscountList>>>> getDiscountList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<DiscountList>>>(
            () async => _dataSource.getDiscountList(code, next));
  }
  //search
  Future<Either<Failure, PaginatedResponse<List<DiscountList>>>>
  getSearchedDiscount(String searchQuery, String? next) async {
    return repoExecute<PaginatedResponse<List<DiscountList>>>(
            () async => _dataSource.getSearchedDiscount(searchQuery, next));
  }

  //readDiscount
  Future<DataResponse> getDiscountRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getDiscountRead(id!);

      if (apiResponse.title != null) {
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
  Future<DataResponse> updateDiscountPost({
    required String typeApplying,
    required int typeId,
    required int id,
    required String typeCode,
    required dynamic image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    required int maxQty,
    required String inventoryId,
    required String? channelCode,
    required String? description,
    required double? discountPercentagePrice,
    required String? basedOn,
    required int? offerPeriodId,
    required int? offerGroupId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required String? offerProductGroupCode,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
    required int offerLineId,
    required int priority,
  }) async {
    final restAPIresponse = await _dataSource.updateDiscountPost(
        createdBy: createdBy,
        isActive: isActive,
        description: description,
        title:title,
        id: id,
        priority: priority,
        offerLineId: offerLineId,
        offerProductGroupCode: offerProductGroupCode,
        inventoryId: inventoryId,
        channelCode: channelCode,
        image: image,
        typeId: typeId,
        basedOn: basedOn,
        customer: customer,
        discountPercentagePrice: discountPercentagePrice,
        isAvailableforAll: isAvailableforAll,
        maxQty: maxQty,
        offerGroupId: offerGroupId,
        offerPeriodId: offerPeriodId,
        segment: segment,
        typeApplying: typeApplying,
        typeCode: typeCode,
        variants: variants
    );

    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  //variants
  Future<Either<Failure, PaginatedResponse<List<ProductListPromotion>>>> getSelectedVariantsList(
      String code, String? next,String groupCode) async {
    return repoExecute<PaginatedResponse<List<ProductListPromotion>>>(
            () async => _dataSource.getSelectedVariantsList(code, next,groupCode));
  }
  //selectuve
  Future<DataResponse> deleteSelectiveVariantsPost({

    required List<ProductListPromotion> variants,

  }) async {
    final restAPIresponse = await _dataSource.deleteSelectiveVariantsPost(

        variants: variants
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }


  ////////////BUY MORE /////////////////////////
  Future<DataResponse> getOfferApplyingBasedOnBuyMoreRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getOfferApplyingBasedOnBuyMoreRead();

      if (apiResponse.buyMoreTypeAppliying != null) {
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

  //createBuyMORE
  Future<DataResponse> createBuyMorePost({
    required String buyMoreApplyingOn,
    required String buyMoreApplyingOnName,
    required int buyMoreApplyingOnId,
    required String buyMoreApplyingOnCode,
    required List<GetCount>? count,
    // required String? offerAppliedTo,
    // required int? offerAppliedToId,
    // required String? offerAppliedToCode,
    required String? channelId,
    required int image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    // required int maxQty,
    required String inventoryId,
    required String? channelCode,
    required String? description,
    // required double? discountPercentagePrice,
    required String? basedOn,
    required int? offerPeriodId,
    required int? offerGroupId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
  }) async {
    final restAPIresponse = await _dataSource.createBuyMorePost(
        createdBy: createdBy,
        isActive: isActive,
        description: description,
        title:title,
        inventoryId: inventoryId,
        channelCode: channelCode,
        image: image,
        basedOn: basedOn,
        customer: customer,
        isAvailableforAll: isAvailableforAll,
        offerGroupId: offerGroupId,
        offerPeriodId: offerPeriodId,
        segment: segment,
        variants: variants,
      buyMoreApplyingOn: buyMoreApplyingOn,
      buyMoreApplyingOnCode: buyMoreApplyingOnCode,
      buyMoreApplyingOnId: buyMoreApplyingOnId,
      buyMoreApplyingOnName: buyMoreApplyingOnName,
      channelId: channelId,
      count: count,
      // offerAppliedTo: offerAppliedTo,
      // offerAppliedToCode: offerAppliedToCode,
      // offerAppliedToId: offerAppliedToId
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //listBuyMore
  Future<Either<Failure, PaginatedResponse<List<BuyMoreList>>>> getBuyMoreList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<BuyMoreList>>>(
            () async => _dataSource.getBuyMoreList(code, next));
  }

  //searchBuyMore
  Future<Either<Failure, PaginatedResponse<List<BuyMoreList>>>>
  getSearchedBuyMore(String searchQuery, String? next) async {
    return repoExecute<PaginatedResponse<List<BuyMoreList>>>(
            () async => _dataSource.getSearchedBuyMore(searchQuery, next));
  }
  //readBuyMore
  Future<DataResponse> getBuyMoreRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getBuyMoreRead(id!);

      if (apiResponse.title != null) {
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
      debugPrint("implement Error conversion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateBuyMore
  Future<DataResponse> updateBuyMorePost({
    required String buyMoreApplyingOn,
    required String buyMoreApplyingOnName,
    required int buyMoreApplyingOnId,
    required String buyMoreApplyingOnCode,
    required List<GetCount>? count,
    // required String? channelId,
    required int id,
    required dynamic image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    required String inventoryId,
    required String? channelCode,
    required String? description,
    required String? basedOn,
    required int? offerPeriodId,
    required int? offerGroupId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
  }) async {
    final restAPIresponse = await _dataSource.updateBuyMorePost(id: id,
      createdBy: createdBy,
      isActive: isActive,
      description: description,
      title:title,
      inventoryId: inventoryId,
      channelCode: channelCode,
      image: image,
      basedOn: basedOn,
      customer: customer,
      isAvailableforAll: isAvailableforAll,
      offerGroupId: offerGroupId,
      offerPeriodId: offerPeriodId,
      segment: segment,
      variants: variants,
      buyMoreApplyingOn: buyMoreApplyingOn,
      buyMoreApplyingOnCode: buyMoreApplyingOnCode,
      buyMoreApplyingOnId: buyMoreApplyingOnId,
      buyMoreApplyingOnName: buyMoreApplyingOnName,
      // channelId: channelId,
      count: count,
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  ///COUPON REPO////////
  Future<DataResponse> getOfferApplyingBasedOnCouponRead() async {
    print("object");
    try {
      final apiResponse = await _dataSource.getOfferApplyingBasedOnCouponRead();

      if (apiResponse.couponBasedOn != null) {
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

  //createCoupen
  Future<DataResponse> createCouponPost({
    required String name,
    required int? offerPeriodId,
    required String? basedOn,
    required String inventoryId,
    required double? percentagePrice,
    required int? maxCount,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required String couponApplyingOnName,
    required int couponApplyingOnId,
    required String couponApplyingOnCode,
    required String? couponApplyingOn,
    required String? channelCode,
    required String? channelId,
    required String? couponType,
    required int image,
    required String? description,
    required double? totalValue,
    required List<ProductListPromotion> lines,
    required bool? isActive,
    required bool? canApplyTogather,
    required bool? canApplyMultiple,
    required bool? isAvailableforAll,
    required String? displayName,
    required List<String> termsList,
    required List<GetTypeApplying>? customer,
  }) async {
    final restAPIresponse = await _dataSource.createCouponPost(
      createdBy: createdBy,
      isActive: isActive,
      description: description,
      lines:lines,
      termsList: termsList,
      inventoryId: inventoryId,
      channelCode: channelCode,
      image: image,
      basedOn: basedOn,
      customer: customer,
      isAvailableforAll: isAvailableforAll,
      displayName: displayName,
      offerPeriodId: offerPeriodId,
      segment: segment,
      canApplyMultiple: canApplyMultiple,
      canApplyTogather: canApplyTogather,
      totalValue: totalValue,
      couponType: couponType,
      couponApplyingOnName: couponApplyingOnName,
      channelId: channelId,
      couponApplyingOnCode: couponApplyingOnCode,
     name: name,
      couponApplyingOn: couponApplyingOn,
      couponApplyingOnId: couponApplyingOnId,
      maxCount: maxCount,
      percentagePrice: percentagePrice
    );
    if (restAPIresponse.data) {
      print("RPO RES");
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
  //listcoupon
  Future<Either<Failure, PaginatedResponse<List<CouponList>>>> paginatedCouponList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<CouponList>>>(
            () async => _dataSource.paginatedCouponList(code, next));
  }
  //serach
  Future<Either<Failure, PaginatedResponse<List<CouponList>>>>
  getSearchCoponList(String searchQuery, String? next) async {
    return repoExecute<PaginatedResponse<List<CouponList>>>(
            () async => _dataSource.getSearchCoponList(searchQuery, next));
  }
  //readCoupon
  Future<DataResponse> getCouponRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getCouponRead(id!);

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
      debugPrint("implement Error conversion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }
  //update
  Future<DataResponse> updateCoupenPost({
    required String name,
    required int? offerPeriodId,
    required String? basedOn,
    required String inventoryId,
    required double? percentagePrice,
    required int? maxCount,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required String couponApplyingOnName,
    required int couponApplyingOnId,
    required String couponApplyingOnCode,
    required String? couponApplyingOn,
    required String? channelCode,
    required int? id,
    required String? couponType,
    required dynamic image,
    required String? description,
    required double? totalValue,
    required List<ProductListPromotion> lines,
    required bool? isActive,
    required bool? canApplyTogather,
    required bool? canApplyMultiple,
    required bool? isAvailableforAll,
    required String? displayName,
    required List<GetTypeApplying>? customer,
    required List<String>? termsList,
  }) async {
    final restAPIresponse = await _dataSource.updateCoupenPost(
        createdBy: createdBy,
        isActive: isActive,
        description: description,
        lines:lines,
        termsList: termsList,
        inventoryId: inventoryId,
        channelCode: channelCode,
        image: image,
        basedOn: basedOn,
        customer: customer,
        isAvailableforAll: isAvailableforAll,
        displayName: displayName,
        offerPeriodId: offerPeriodId,
        segment: segment,
        canApplyMultiple: canApplyMultiple,
        canApplyTogather: canApplyTogather,
        totalValue: totalValue,
        couponType: couponType,
        couponApplyingOnName: couponApplyingOnName,
        id: id,
        couponApplyingOnCode: couponApplyingOnCode,
        name: name,
        couponApplyingOn: couponApplyingOn,
        couponApplyingOnId: couponApplyingOnId,
        maxCount: maxCount,
        percentagePrice: percentagePrice
    );
    if (restAPIresponse.data) {
      print("RPO RES");
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //negotiation
  Future<DataResponse> createNegotiationPost({
    required List<GetCount>? cartValueList,
    required List<GetCount>? cartGpList,
    required int image,
    required String title,
    required List<ProductListPromotion> variants,
    required String? description,
    required String? basedOn,
    required int? offerPeriodId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
  }) async {
    final restAPIresponse = await _dataSource.createNegotiationPost(
      createdBy: createdBy,
      description: description,
      title:title,
      image: image,
      basedOn: basedOn,
      customer: customer,
      isAvailableforAll: isAvailableforAll,
      offerPeriodId: offerPeriodId,
      segment: segment,
      variants: variants,
      cartGpList: cartGpList,
      cartValueList: cartValueList
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }

  //list
  Future<Either<Failure, PaginatedResponse<List<NegotiationList>>>> paginatedNegotiationList(
      String code, String? next) async {
    return repoExecute<PaginatedResponse<List<NegotiationList>>>(
            () async => _dataSource.paginatedNegotiationList(code, next));
  }

  //searchBuyMore
  Future<Either<Failure, PaginatedResponse<List<NegotiationList>>>>
  getSearchNegotiationList(String searchQuery, String? next) async {
    return repoExecute<PaginatedResponse<List<NegotiationList>>>(
            () async => _dataSource.getSearchNegotiationList(searchQuery, next));
  }
  //readBuyMore
  Future<DataResponse> getNegotiationRead(int? id) async {
    print("object");
    try {
      final apiResponse = await _dataSource.getNegotiationRead(id!);

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
      debugPrint("implement Error conversion Text$e");
    }
    return DataResponse(
      error: "implement Error conversion Text",
    );
  }

  //updateBuyMore
  Future<DataResponse> updateNegotiationPost({
    required bool? isActive,
    required int id,
    required List<GetCount>? cartValueList,
    required List<GetCount>? cartGpList,
    required dynamic image,
    required String title,
    required List<ProductListPromotion> variants,
    required String? description,
    required String? basedOn,
    required int? offerPeriodId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,
  }) async {
    final restAPIresponse = await _dataSource.updateNegotiationPost(id: id,
      createdBy: createdBy,
      isActive: isActive,
      description: description,
      title:title,
      image: image,
      basedOn: basedOn,
      customer: customer,
      isAvailableforAll: isAvailableforAll,
      offerPeriodId: offerPeriodId,
      segment: segment,
      variants: variants,
      cartGpList: cartGpList,
      cartValueList: cartValueList
    );
    if (restAPIresponse.data) {
      return DataResponse(error: restAPIresponse.error,data: true);
    } else {
      return DataResponse(error: restAPIresponse.error ?? "",data: false);
    }
  }
}