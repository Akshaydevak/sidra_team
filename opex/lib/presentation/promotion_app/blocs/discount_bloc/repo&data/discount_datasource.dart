import 'dart:io';

import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:cluster/presentation/promotion_app/promotion_urls.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../../../core/utils/data_response.dart';

class DiscountDataSource {
  Dio client = Dio();

  //segmentList
  Future<List<GetSegmentList>> getSegmentList() async {
    List<GetSegmentList> segmentList = [];

    print("SEGMET URL:${PromotionUrls.segmentsPromotionUrl}");

    try {
      final response = await client.get(PromotionUrls.segmentsPromotionUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        segmentList.add(GetSegmentList.fromJson(element));
      });

      return segmentList;
    } catch (h) {
      print("SHIFAS ERROR$h");
    }
    final response = await client.get(PromotionUrls.segmentsPromotionUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      segmentList.add(GetSegmentList.fromJson(element));
    });
    return segmentList;
  }

  //createofferperod
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
    print("create$fromTime");
    print("create$toTime");
    final response = await client.post(
      PromotionUrls.createOfferPeriodUrl,
      data: {
        "from_date":fromDate,
        "to_date":toDate,
        "from_time":fromTime,
        "to_time":toTime,
        "title":title,
        "description":description,
        "is_active":isActive,
        "notes":note,
        "created_by":createdBy
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("employee response$response");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //offerlist
  Future<PaginatedResponse<List<GetOfferPeriod>>> getOfferPeriodList(
      String code, String? next) async {
    print("VVVVV$next");
    print("VVVVV$code");
    String path="";
    if(next==""){
      path="${PromotionUrls.listOfferPeriodUrl}?$code";
    }
    else if(next!=""){
      path=next??"";
    }
    List<GetOfferPeriod> offerPeriodList = [];
    print("pagiiiiii$path");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      offerPeriodList.add(GetOfferPeriod.fromJson(element));
    });

    return PaginatedResponse<List<GetOfferPeriod>>(
        offerPeriodList,
        response.data['data']['next'],
        response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous']
    );
  }

  //readOfferPeriod
  Future<GetOfferPeriod> getOfferPeriodRead(int id) async {
    GetOfferPeriod offerPeriod;

    print("Task Read:${PromotionUrls.offerPeriodRead + id.toString()}");
    final response = await client.get(
      PromotionUrls.offerPeriodRead + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data);
    offerPeriod = GetOfferPeriod.fromJson((response.data['data']));

    return offerPeriod;
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
    print("update${ PromotionUrls.offerPeriodRead+id.toString()}");
    print("update$fromDate");
    print("update$toDate");
    print("update$fromTime");
    print("update$toTime");
    print("update$title");
    print("update$description");
    print("update$isActive");
    print("update$note");
    print("update$createdBy");
    final response = await client.patch(
      PromotionUrls.offerPeriodRead+id.toString(),
      data: {
        "from_date":fromDate,
        "to_date":toDate,
        "from_time":fromTime,
        "to_time":toTime,
        "title":title,
        "description":description,
        "is_active":isActive,
        "notes":note,
        "created_by":createdBy
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  //deleteofferperiod
  Future<String> deleteofferPeriod(int id) async {
    String statusCode;
    print("dele${PromotionUrls.offerPeriodRead + id.toString()}");
    final response = await client.delete(
      PromotionUrls.offerPeriodRead + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //channelList
  Future<PaginatedResponse<List<ChannelList>>> getChannelList(
      String code, String? next) async {
    List<ChannelList> channelList = [];
    print("ChannelList:${PromotionUrls.channelListUrl+authentication.authenticatedUser.organisationCode.toString()}");
    final response = await client.get(
      PromotionUrls.channelListUrl+authentication.authenticatedUser.organisationCode.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      channelList.add(ChannelList.fromJson(element));
    });

    return PaginatedResponse<List<ChannelList>>(
        channelList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //uploadImage
  Future<DoubleResponse> PostImage(
      {File? img}) async {
    print("image:${PromotionUrls.imageUploadDiscount}");
    String filePath = "";
    print("check new at datasource");
    if (img != null) filePath = img.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(filePath,
        contentType: MediaType(mime.first, mime.last));
    final FormData formData = FormData.fromMap({"image": fileData});
    final response = await client.post(
      PromotionUrls.imageUploadDiscount,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("check new response ${response.data}");
    return DoubleResponse(
        response.data['status'] == 'success', response.data['data']);
  }
  //createOfferGroup
  Future<DataResponse> offerGroupPost({
    required int image,
    required int priority,
    required String channelCode,
    required String inventoryId,
    required String title,
    required String description,
    required String? createdBy,
    required bool? isActive,
  }) async {
    print("creaaaaa$image");
    print("creaaaaa$channelCode");
    print("creaaaaa$inventoryId");
    print("creaaaaa$title");
    print("creaaaaa$description");
    print("creaaaaa$createdBy");
    print("creaaaaa$isActive");
    final response = await client.post(
      PromotionUrls.createOfferGroupUrl,
      data: {
        "image":image,
        "channel_code":channelCode,
        "inventory_id":inventoryId,
        "title":title,
        "description":description,
        "is_active":isActive,
        "created_by":createdBy,
        "priority":priority
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response$response");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //listOfferGroup
  Future<PaginatedResponse<List<GetOfferGroup>>> getOfferGroupList(
      String code, String? next) async {
    List<GetOfferGroup> offerGroupList = [];
    print("LIST URL${PromotionUrls.listOfferGroupListUrl+authentication.authenticatedUser.organisationCode.toString()}");
    final response = await client.get(
      PromotionUrls.listOfferGroupListUrl+authentication.authenticatedUser.organisationCode.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      offerGroupList.add(GetOfferGroup.fromJson(element));
    });

    return PaginatedResponse<List<GetOfferGroup>>(
        offerGroupList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //readofferGroup
  Future<GetOfferGroup> getOfferGroupRead(int id) async {
    GetOfferGroup offerGroup;

    print("Offer Group Read:${PromotionUrls.offerGroupReadListUrl + id.toString()}");
    final response = await client.get(
      PromotionUrls.offerGroupReadListUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']['offer_group_data']);
    offerGroup = GetOfferGroup.fromJson((response.data['data']['offer_group_data']));

    return offerGroup;
  }
  //updateOfferGroup
  Future<DataResponse> updateOffergroup({
    required int img,
    required String title,
    required String description,
    required String? createdBy,
    required bool? isActive,
    required int? id,
    required int priority,
  }) async {
    print("update group${ PromotionUrls.offerGroupReadListUrl+id.toString()}");
    final response = await client.patch(
      PromotionUrls.offerGroupReadListUrl+id.toString(),
      data: {
        "image":img,
        "title":title,
        "description":description,
        "is_active":isActive,
        "created_by":createdBy,
        "priority":priority
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: null, error: response.data['message']);
    }
  }

  //deleteOfferGroup
  Future<String> deleteofferGroup(int id) async {
    String statusCode;
    print("dele${PromotionUrls.offerGroupReadListUrl + id.toString()}");
    final response = await client.delete(
      PromotionUrls.offerGroupReadListUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //readBased
  Future<GetDiscount> getOfferAppliyingBasedOnRead() async {
    GetDiscount discount;

    print("Offer Based Read:${PromotionUrls.discountCreateUrl}");
    final response = await client.get(
      PromotionUrls.discountCreateUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']);
    discount = GetDiscount.fromJson((response.data['data']));

    return discount;
  }

  //typeAppliying
  Future<PaginatedDoubleDataResponse> typeAppliyingPost({
    required String type,
    required String inventoryId,
    required List<String> segmentList,
    String? searchElement,
    String? nextUrl,
    String? prevUrl,
  }) async {
    print("ttyy$type");
    print("ttyy$inventoryId");
    print("ttyy$segmentList");
    print("ttyy$searchElement");
    print("ttyy$nextUrl");
    print("ttyy$prevUrl");
    List<GetTypeApplying> typeAppliyingList = [];
    print("UURRLL:${nextUrl==""||prevUrl==""?PromotionUrls.typeAppliyingPostUrl:nextUrl.toString()}");
    final response = await client.post(
      nextUrl==""||prevUrl==""?PromotionUrls.typeAppliyingPostUrl:nextUrl.toString(),
      data: {
        "type":type,
        "search_element":searchElement,
        "inventory_id":inventoryId,
        "segment_list":segmentList
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("That API response${response}");
if(response.data['status']=="success") {
  (response.data['data']['results'] as List).forEach((element) {
    typeAppliyingList.add(GetTypeApplying.fromJson(element));
  });
  return PaginatedDoubleDataResponse(
      typeAppliyingList,
      response.data['data']['next'],
      previousUrl: response.data['data']['previous'],
      response.data['data']['count'].toString());
}
else{
  return PaginatedDoubleDataResponse(
      typeAppliyingList,
     null,
      previousUrl: null,
      "");
}



  }

  //productlist
  Future<PaginatedDoubleDataResponse> productListPost({
    required String applyingType,
    required String inventoryId,
    required String? applyingTypeCode,
    required List<String> segmentList,
    String? searchElement,
    String? nextUrl,
    String? prevUrl,
  }) async {
    print("GGYY$applyingType");
    print("GGYY$inventoryId");
    print("GGYY$applyingTypeCode");
    print("GGYY$segmentList");
    print("GGYY$searchElement");
    print("GGYY$nextUrl");
    print("GGYY$prevUrl");
    List<ProductListPromotion> productList = [];
    String? path;
    if(nextUrl!=null&&nextUrl!=""){
      path=nextUrl;
    }
    else if(prevUrl!=null&&prevUrl!=""){
      path=prevUrl;
    }
    else{
      path=PromotionUrls.productListUrl;
    }
    print("Product UUUUUU:${path}");
    final response = await client.post(
      path,
      data: {
        "applying_type":applyingType,
        "segment_list":segmentList,
        "search_element":searchElement,
        "applying_type_code":applyingTypeCode,
        "inventory_id":inventoryId
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("Product lids$response");

    (response.data['data']['results'] as List).forEach((element) {
      productList.add(ProductListPromotion.fromJson(element));
    });

    return PaginatedDoubleDataResponse(
        productList,
        response.data['data']['next'],
        previousUrl: response.data['data']['previous'],
        response.data['data']['count'].toString());

  }
  //customerGroup
  Future<PaginatedResponse<List<GetTypeApplying>>> getCustomerGroupList(
      String? code, String? next) async {
    print("NEXT$next");
    print("NEXT$code");
    String path="";
    if(code!=null&&next==null){
      print("iffff$code");
      path="${PromotionUrls.customerGroupListUrl}/?$code";
    }
    else if(next!=null&&code==null){
      print("elseifff$code");
      path=next.toString();
    }
    else{
      print("else$code");
      path=PromotionUrls.customerGroupListUrl;
    }
    List<GetTypeApplying> customerGroup = [];
    print("LIST CUSTOMER URL$path");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      customerGroup.add(GetTypeApplying.fromJson(element));
    });

    return PaginatedResponse<List<GetTypeApplying>>(
        customerGroup,
        response.data['data']['next'],
        response.data['data']['count'].toString(),
    previousUrl: response.data['data']['previous']);
  }//createDiscount
  Future<DataResponse> createDiscountPost({
    required String typeApplying,
    required int typeId,
    required int priority,
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
  }) async {
    print("DATA Offer Group Id$offerGroupId");
    final response = await client.post(
      PromotionUrls.discountCreateUrl,
      data: {
        "type_applying":typeApplying,
        "type_id":typeId,
        "priority":priority,
        "type_code":typeCode,
        "image":image??null,
        "title":title,
        "variants":variants,
        "is_active":isActive,
        "maximum_qty":maxQty,
        "inventory_id":inventoryId,
        "channel_code":channelCode,
        "description":description,
        "discount_percentage_or_price":discountPercentagePrice,
        "based_on":basedOn,
        "offer_period_id":offerPeriodId,
        "offer_group_id":offerGroupId,
        "is_available_for_all":isAvailableforAll,
        "created_by":createdBy,
        "segments":segment,
        "available_customer_groups":customer,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("discount response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['discount_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }
  //listDiscount
  Future<PaginatedResponse<List<DiscountList>>> getDiscountList(
      String code, String? next) async {
    List<DiscountList> discountList = [];
    String path='';
    if(code!=null&&next==""){
      path="${PromotionUrls.listDiscountUrl+authentication.authenticatedUser.organisationCode.toString()}?$code";
    }
    else if(next!=""&&code==""){
      path=next.toString();
    }
    else{
      path=PromotionUrls.listDiscountUrl+authentication.authenticatedUser.organisationCode.toString();
    }
    print("LIST DISCOUNT URL$path");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      discountList.add(DiscountList.fromJson(element));
    });

    return PaginatedResponse<List<DiscountList>>(
        discountList,
        response.data['data']['next'],
        response.data['data']['count'].toString(),
    previousUrl: response.data['data']['previous']);
  }
  //listseatch
  Future<PaginatedResponse<List<DiscountList>>> getSearchedDiscount(
      String searchQuery, String? next) async {
    print("api found${"${PromotionUrls.listDiscountUrl}${authentication.authenticatedUser.organisationCode}?title=$searchQuery"}");
    final response = await client.get(
      "${PromotionUrls.listDiscountUrl}${authentication.authenticatedUser.organisationCode}?title=$searchQuery",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<DiscountList> searchedProductList = [];
    (response.data['data']['results'] as List).forEach((element) {
      searchedProductList.add(DiscountList.fromJson(element));
    });
    return PaginatedResponse<List<DiscountList>>(
        searchedProductList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }

  //readDiscount
  Future<DiscountList> getDiscountRead(int id) async {
    DiscountList discountList;

    print("Discount Read:${PromotionUrls.discountReadUrl + id.toString()}");
    final response = await client.get(
      PromotionUrls.discountReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']['discount_data']);
    discountList = DiscountList.fromJson((response.data['data']['discount_data']));

    return discountList;
  }

  //deleteDiscount
  Future<String> deleteDiscount(int id) async {
    String statusCode;
    print("dele${PromotionUrls.discountReadUrl + id.toString()}");
    final response = await client.delete(
      PromotionUrls.discountReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateDiscountPost({
    required int id,
    required int priority,
    required String typeApplying,
    required int typeId,
    required String typeCode,
    required dynamic image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    required int maxQty,
    required int offerLineId,
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
  }) async {
    print("DATA IDD$id");
    print("DATA IDD$typeApplying");
    print("DATA IDD$typeId");
    print("DATA IDD$typeCode");
    print("DATA IDD$image");
    print("DATA IDD$title");
    print("DATA IDD$variants");
    print("DATA IDD$isActive");
    print("DATA IDD$maxQty");
    print("DATA IDD$discountPercentagePrice");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$offerGroupId");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$offerProductGroupCode");
    print("DATA IDD$offerLineId");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    print("DATA URL:${PromotionUrls.discountReadUrl+id.toString()}");
    try{
      final response = await client.patch(
        PromotionUrls.discountReadUrl+id.toString(),
        data: {
          "type_applying":typeApplying,
          "type_id":typeId,
          "type_code":typeCode,
          "image":image??null,
          "title":title,
          "variants":variants,
          "is_active":isActive,
          "maximum_qty":maxQty,
          "priority":priority,
          "channel_code":channelCode,
          "inventory_id":inventoryId,
          "description":description,
          "discount_percentage_or_price":discountPercentagePrice,
          "based_on":basedOn,
          "offer_period_id":offerPeriodId,
          "offer_group_id":offerGroupId,
          "is_available_for_all":isAvailableforAll,
          "created_by":createdBy,
          "segments":segment,
          "available_customer_groups":customer,
          "offer_line_id":offerLineId,
          "offer_product_group_code":offerProductGroupCode,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("employee response${response}");
      if (response.data['status'] == 'success') {

        return DataResponse(
            data: response.data["status"]=="success", error: response.data['discount_id'].toString());
      } else {
        if(response.data['is_another_promotion']==true){
          print("fas failed${response.data['message']['message']}");
          print("fas failed${response.data['message']['type_data']}");
          print("fas failed${response.data['is_another_promotion']}");
          Variable.errorMessage = response.data['message']['message'];
          Variable.typeData = response.data['message']['type_data'];
          Variable.isTypeDataCheck = true;
        }
        else{
          Variable.errorMessage = response.data['message'];
          Variable.isTypeDataCheck = false;
        }
        return DataResponse(data: false, error:  Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
      }
    }
    catch(u){
      print("GGGG${u}");
    }
    final response = await client.patch(
      PromotionUrls.discountReadUrl+id.toString(),
      data: {
        "type_applying":typeApplying,
        "type_id":typeId,
        "type_code":typeCode,
        "image":image??null,
        "title":title,
        "variants":variants,
        "is_active":isActive,
        "maximum_qty":maxQty,
        "priority":priority,
        // "channel_code":channelCode,
        "description":description,
        "discount_percentage_or_price":discountPercentagePrice,
        "based_on":basedOn,
        "offer_period_id":offerPeriodId,
        "offer_group_id":offerGroupId,
        "is_available_for_all":isAvailableforAll,
        "created_by":createdBy,
        "segments":segment,
        "available_customer_groups":customer,
        "offer_line_id":offerLineId,
        "offer_product_group_code":offerProductGroupCode,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['discount_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error:  Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }


  //selectedVariants
  Future<PaginatedResponse<List<ProductListPromotion>>> getSelectedVariantsList(
      String code, String? next,String groupCode) async {
    List<ProductListPromotion> productList = [];
    print("SElected URL${PromotionUrls.listSelectedVariantsUrl+groupCode.toString()}");
    final response = await client.get(
      PromotionUrls.listSelectedVariantsUrl+groupCode.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("FAASS${response.data['data']}");

    (response.data['data']['results'] as List).forEach((element) {
      productList.add(ProductListPromotion.fromJson(element));
    });

    return PaginatedResponse<List<ProductListPromotion>>(
        productList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //deactivate
  Future<DoubleResponse> deactivatePrevPromotion({
    required String typeData,
    required List<int> idList,
    required bool? type,
    required bool isCoupon,


  }) async {
    print("DATA IDD$typeData");
    print("DATA IDD$idList");
    print("DATA IDD$type");
    print("DATA IDD$isCoupon");
    print("DATA IDD:${type==true?PromotionUrls.deactivatePromotionUrl:PromotionUrls.allvariantDeactivateUrl}");
    List<ProductListPromotion> productList=[];
    String path="";
    if(type==true&&isCoupon==true){
      print("Coupon&Type${PromotionUrls.deactivateCouponPromotionUrl}");
      path=PromotionUrls.deactivateCouponPromotionUrl;
    }
    else if(type==false&&isCoupon==true){
      print("CouponTRUE&Type${PromotionUrls.allVariantsUrlCoupon}");
      path=PromotionUrls.allVariantsUrlCoupon;
    }
    else if(type==true){
      print("TypeTRUE${PromotionUrls.deactivatePromotionUrl}");
      path=PromotionUrls.deactivatePromotionUrl;
    }
    else if(type==false){
      print("TypeFALSE${PromotionUrls.allvariantDeactivateUrl}");
      path=PromotionUrls.allvariantDeactivateUrl;
    }
    print("URL DAEA:$path");
    final response = await client.post(
      path,
      data: {
        "type_data":typeData,
        "id_list":idList,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("DAE response${response.data}");
    print("DAE response$type");
    // Variable.deactiveMsg=response.data['message'];
    type==false?(response.data['data'] as List).forEach((element) {

      productList.add(ProductListPromotion.fromJson(element));

    }):null;
    if (response.data['status'] == 'failed') {
      print("failed rex");
      Variable.errorMessage = response.data['message'];
    }
    // if(response.data['message'] != ''){
    //   Variable.deactiveMsg=response.data['message'];
    // }
    print("succ${response.data['status']}");

    return DoubleResponse(
        response.data['status'] == 'success', type==true?null:productList);

  }

  //selective
  Future<DataResponse> deleteSelectiveVariantsPost({

    required List<ProductListPromotion> variants,

  }) async {
    print("DATA IDD$variants");
    final response = await client.post(
      PromotionUrls.deleteSelectiveUrl,
      data: {
        "id_list":variants,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {

      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }

  /////////BUY MORE /////////////////////

  Future<GetDiscount> getOfferApplyingBasedOnBuyMoreRead() async {
    GetDiscount discount;

    print("Buy More:${PromotionUrls.createBuyMoreUrl}");

    final response = await client.get(
      PromotionUrls.createBuyMoreUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']);
    discount = GetDiscount.fromJson((response.data['data']));

    return discount;
  }

  //createBuyMore
  Future<DataResponse> createBuyMorePost({
    required String buyMoreApplyingOn,
    required String buyMoreApplyingOnName,
    required int buyMoreApplyingOnId,
    required String buyMoreApplyingOnCode,
    required List<GetCount>? count,
    // required String? offerAppliedTo,
    // required int? offerAppliedToId,
    // required String? offerAppliedToCode,
    required int image,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    // required int maxQty,
    required String inventoryId,
    required String? channelCode,
    required String? channelId,
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
    print("DATA IDD$offerGroupId");
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$image");
    print("DATA IDD$title");
    print("DATA IDD$variants");
    print("DATA IDD$isActive");
    print("DATA IDD$inventoryId");
    print("DATA IDD$channelCode");
    print("DATA IDD$channelId");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$buyMoreApplyingOn");
    print("DATA IDD$buyMoreApplyingOnName");
    print("DATA IDD$buyMoreApplyingOnId");
    print("DATA IDD$buyMoreApplyingOnCode");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    print("DATA IDD$count");
    final response = await client.post(
      PromotionUrls.createBuyMoreUrl,
      data: {
        // "offer_applied_to":offerAppliedTo,
        // "offer_applied_to_id":offerAppliedToId,
        // "offer_applied_to_code":offerAppliedToCode,
        "image":image,
        "title":title,
        "lines":variants,
        "is_active":isActive,
        // "maximum_qty":maxQty,
        "inventory_id":inventoryId,
        "channel_code":channelCode,
        "channel_id":channelId,
        "description":description,
        // "discount_percentage_or_price":discountPercentagePrice,
        "based_on":basedOn,
        "buy_more_applying_on":buyMoreApplyingOn,
        "buy_more_applying_on_name":buyMoreApplyingOnName,
        "buy_more_applying_on_id":buyMoreApplyingOnId,
        "buy_more_applying_on_code":buyMoreApplyingOnCode,
        "offer_period_id":offerPeriodId,
        "offer_group_id":null,
        "is_available_for_all":isAvailableforAll,
        "created_by":createdBy,
        "segments":segment,
        "available_customer_groups":customer,
        "count_price_percentage":count
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['buy_more_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }

  //listBuyMore
  Future<PaginatedResponse<List<BuyMoreList>>> getBuyMoreList(
      String code, String? next) async {
    List<BuyMoreList> buymoreList = [];
    String path='';
    if(code!=null&&next==""){
      path="${PromotionUrls.listBuyMoreUrl+authentication.authenticatedUser.organisationCode.toString()}?$code";
    }
    else if(next!=""&&code==""){
      path=next.toString();
    }
    else{
      path=PromotionUrls.listBuyMoreUrl+authentication.authenticatedUser.organisationCode.toString();
    }
    print("LIST DISCOUNT URL$path");
    print("LIST DISCOUNT URL${PromotionUrls.listBuyMoreUrl+authentication.authenticatedUser.organisationCode.toString()}");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      buymoreList.add(BuyMoreList.fromJson(element));
    });

    return PaginatedResponse<List<BuyMoreList>>(
        buymoreList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //listSeach
  Future<PaginatedResponse<List<BuyMoreList>>> getSearchedBuyMore(
      String searchQuery, String? next) async {
    print("Buy Search${"${PromotionUrls.listBuyMoreUrl}${authentication.authenticatedUser.organisationCode}?name=$searchQuery"}");
    final response = await client.get(
      "${PromotionUrls.listBuyMoreUrl}${authentication.authenticatedUser.organisationCode}?name=$searchQuery",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<BuyMoreList> searchedProductList = [];
    (response.data['data']['results'] as List).forEach((element) {
      searchedProductList.add(BuyMoreList.fromJson(element));
    });
    return PaginatedResponse<List<BuyMoreList>>(
        searchedProductList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }


  //readBuyMore
  Future<BuyMoreList> getBuyMoreRead(int id) async {
    BuyMoreList buyMoreList;

    print("Buy more Read:${PromotionUrls.readBuyMoreUrl + id.toString()}");
    final response = await client.get(
      PromotionUrls.readBuyMoreUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']);
    buyMoreList = BuyMoreList.fromJson((response.data['data']));

    return buyMoreList;
  }

  //deleteBuyMore
  Future<String> deleteBuyMore(int id) async {
    String statusCode;
    print("delete BUY MORE${PromotionUrls.readBuyMoreUrl + id.toString()}");
    final response = await client.delete(
      PromotionUrls.readBuyMoreUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }
  //updateBuyMore
  Future<DataResponse> updateBuyMorePost({
    required String buyMoreApplyingOn,
    required String buyMoreApplyingOnName,
    required int buyMoreApplyingOnId,
    required String buyMoreApplyingOnCode,
    required List<GetCount>? count,
    required dynamic image,
    required int id,
    required String title,
    required List<ProductListPromotion> variants,
    required bool? isActive,
    required String inventoryId,
    required String? channelCode,
    // required String? channelId,
    required String? description,
    required String? basedOn,
    required int? offerPeriodId,
    required int? offerGroupId,
    required bool? isAvailableforAll,
    required String? createdBy,
    required List<GetSegmentList>? segment,
    required List<GetTypeApplying>? customer,

  }) async {
    print("DATA IDD$offerGroupId");
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$image");
    print("DATA IDD$title");
    print("DATA IDD$variants");
    print("DATA IDD$isActive");
    print("DATA IDD$inventoryId");
    print("DATA IDD$channelCode");
    // print("DATA IDD$channelId");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$buyMoreApplyingOn");
    print("DATA IDD$buyMoreApplyingOnName");
    print("DATA IDD$buyMoreApplyingOnId");
    print("DATA IDD$buyMoreApplyingOnCode");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    print("DATA IDD$count");
    print("DATA URL${PromotionUrls.readBuyMoreUrl+id.toString()}");
    final response = await client.patch(
      PromotionUrls.readBuyMoreUrl+id.toString(),
      data:
      {
        "image":image,
        "title":title,
        "lines":variants,
        "is_active":isActive,
        "inventory_id":inventoryId,
        "channel_code":channelCode,
        "description":description,
        "based_on":basedOn,
        "offer_period_id":offerPeriodId,
        "offer_group_id":null,
        "is_available_for_all":isAvailableforAll,
        "created_by":createdBy,
        "segments":segment,
        "available_customer_groups":customer,
        "count_price_percentage":count,
        "buy_more_applying_on":buyMoreApplyingOn,
        "buy_more_applying_on_name":buyMoreApplyingOnName,
        "buy_more_applying_on_id":buyMoreApplyingOnId,
        "buy_more_applying_on_code":buyMoreApplyingOnCode,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['buy_more_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }

  ///COUPON DATA//////
  Future<GetDiscount> getOfferApplyingBasedOnCouponRead() async {
    GetDiscount discount;

    print("Buy More:${PromotionUrls.createCouponUrl}");

    final response = await client.get(
      PromotionUrls.createCouponUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']);
    discount = GetDiscount.fromJson((response.data['data']));

    return discount;
  }

  //creayeCopen
  Future<DataResponse> createCouponPost({
    required String name,
    required List<String> termsList,
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
    required List<GetTypeApplying>? customer,

  }) async {
    print("DATA IDD$name");
    print("DATA IDD$displayName");
    print("DATA IDD$canApplyTogather");
    print("DATA IDD$canApplyMultiple");
    print("DATA IDD$couponType");
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$totalValue");
    print("DATA IDD$maxCount");
    print("DATA IDD$couponApplyingOnName");
    print("DATA IDD$couponApplyingOnCode");
    print("DATA IDD$percentagePrice");
    print("DATA IDD$image");
    print("DATA IDD$couponApplyingOn");
    print("DATA IDD$isActive");
    print("DATA IDD$couponApplyingOnId");
    print("DATA IDD$inventoryId");
    print("DATA IDD$channelCode");
    print("DATA IDD$channelId");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    print("DATA IDD$lines");
    print("DATA IDD$termsList");
    print("COUI URL${PromotionUrls.createCouponUrl}");

    final response = await client.post(
      PromotionUrls.createCouponUrl,
      data: {
        "name":name,
        "offer_period_id":offerPeriodId,
        "based_on":basedOn,
        "inventory_id":inventoryId,
        "price_or_percentage":percentagePrice,
        "maximum_count":maxCount,
        "segments":segment,
        "created_by":createdBy,
        "coupon_applying_on":couponApplyingOn,
        "coupon_applying_on_id":couponApplyingOnId,
        "coupon_applying_on_code":couponApplyingOnCode,
        "coupon_applying_on_name":couponApplyingOnName,
        "channel_code":channelCode,
        "channel_id":channelCode,
        "coupon_type":couponType,
        "condition_list":termsList,
        "image":image,
        "description":description,
        "total_value":totalValue,
        "can_apply_together":canApplyTogather,
        "can_apply_multiple_times":canApplyMultiple,
        "is_active":isActive,
        "is_available_to_all":isAvailableforAll,
        "display_name":displayName,
        "available_customer_groups":customer,
        "line":lines,
      },
      options: Options(
        validateStatus: (val)=>true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response.data}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['coupon_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }

  //couponlist
  Future<PaginatedResponse<List<CouponList>>> paginatedCouponList(
      String code, String? next) async {
    List<CouponList> couponList = [];
    String path='';
    if(code!=null&&next==""){
      path="${PromotionUrls.listCouponListUrl+authentication.authenticatedUser.organisationCode.toString()}?$code";
    }
    else if(next!=""&&code==""){
      path=next.toString();
    }
    else{
      path=PromotionUrls.listCouponListUrl+authentication.authenticatedUser.organisationCode.toString();
    }
    print("LIST DISCOUNT URL$path");
     try{
      final response = await client.get(
       path,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      (response.data['data']['results'] as List).forEach((element) {
        couponList.add(CouponList.fromJson(element));
      });
      print("fassssss${response.data['data']['results']}");

      return PaginatedResponse<List<CouponList>>(
          couponList,
          response.data['data']['next'],
          response.data['data']['count'].toString());
    }
    catch(d){
      print("RRRRRR$d");
    }
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      couponList.add(CouponList.fromJson(element));
    });
    print("fassssss${response.data['data']['results']}");

    return PaginatedResponse<List<CouponList>>(
        couponList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //serchCoupon
  Future<PaginatedResponse<List<CouponList>>> getSearchCoponList(
      String searchQuery, String? next) async {
    print("Coupon Search${"${PromotionUrls.listCouponListUrl}${authentication.authenticatedUser.organisationCode}?name=$searchQuery"}");
    final response = await client.get(
      "${PromotionUrls.listCouponListUrl}${authentication.authenticatedUser.organisationCode}?name=$searchQuery",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    List<CouponList> searchedProductList = [];
    (response.data['data']['results'] as List).forEach((element) {
      searchedProductList.add(CouponList.fromJson(element));
    });
    return PaginatedResponse<List<CouponList>>(
        searchedProductList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }

  //readBuyMore
  Future<CouponList> getCouponRead(int id) async {
    CouponList couponList;

    print("Buy more Read:${PromotionUrls.readCouponUrl + id.toString()}");
    final response = await client.get(
      PromotionUrls.readCouponUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']['coupon_data']);
    couponList = CouponList.fromJson((response.data['data']['coupon_data']));

    return couponList;
  }

  //deleteBuyMore
  Future<String> deleteCoupon(int id) async {
    String statusCode;
    print("delete BUY MORE${PromotionUrls.readCouponUrl + id.toString()}");
    final response = await client.delete(
      PromotionUrls.readCouponUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$name");
    print("DATA IDD$displayName");
    print("DATA IDD$canApplyTogather");
    print("DATA IDD$canApplyMultiple");
    print("DATA IDD$couponType");
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$totalValue");
    print("DATA IDD$maxCount");
    print("DATA IDD$couponApplyingOnName");
    print("DATA IDD$couponApplyingOnCode");
    print("DATA IDD$percentagePrice");
    print("DATA IDD$image");
    print("DATA IDD$couponApplyingOn");
    print("DATA IDD$isActive");
    print("DATA IDD$couponApplyingOnId");
    print("DATA IDD$inventoryId");
    print("DATA IDD$channelCode");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    print("DATA IDD$lines");
    print("DATA IDD$termsList");
    // print("DATA IDDLINE${lines[1].isActive}");
    // print("DATA IDDLINE${lines[1].id}");
    // print("DATA IDDLINE${lines[1].variantName}");
    print("COUI URL${PromotionUrls.readCouponUrl+id.toString()}");

    final response = await client.patch(
      PromotionUrls.readCouponUrl+id.toString(),
      data: {
        "name":name,
        "offer_period_id":offerPeriodId,
        "based_on":basedOn,
        "inventory_id":inventoryId,
        "price_or_percentage":percentagePrice,
        "maximum_count":maxCount,
        "segments":segment,
        "created_by":createdBy,
        "condition_list":termsList,
        "coupon_applying_on":couponApplyingOn,
        "coupon_applying_on_id":couponApplyingOnId,
        "coupon_applying_on_code":couponApplyingOnCode,
        "coupon_applying_on_name":couponApplyingOnName,
        "channel_code":channelCode,
        "coupon_type":couponType,
        "image":image,
        "description":description,
        "total_value":totalValue,
        "can_apply_together":canApplyTogather,
        "can_apply_multiple_times":canApplyMultiple,
        "is_active":isActive,
        "is_available_to_all":isAvailableforAll,
        "display_name":displayName,
        "available_customer_groups":customer,
        "line":lines,
      },
      options: Options(
        validateStatus: (val)=>true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("employee response${response.data}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['coupon_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
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
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$image");
    print("DATA IDD$title");
    print("DATA IDD$variants");
    print("DATA IDD$description");
    print("DATA IDD$basedOn");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$createdBy");
    print("DATA IDD$segment");
    print("DATA IDD$customer");
    // print("DATA IDD$count");
    final response = await client.post(
      PromotionUrls.createNegotiationUrl,
      data: {
        "segments":segment,
        "available_customer_groups":customer,
        "is_available_for_all":isAvailableforAll,
        "name":title,
        "offer_period_id":offerPeriodId,
        "based_on":basedOn,
        "cart_value_price_percentage":cartValueList,
        "cart_gp_price_percentage":cartGpList,
        "image":image,
        "description":description,
        "created_by":createdBy,
        "line":variants,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['negotiaion_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }

  //list
  Future<PaginatedResponse<List<NegotiationList>>> paginatedNegotiationList(
      String code, String? next) async {
    List<NegotiationList> negotiationList = [];
    String path='';
    if(code!=null&&next==""){
      path="${PromotionUrls.listNegotiationUrl}?$code";
    }
    else if(next!=""&&code==""){
      path=next.toString();
    }
    else{
      path=PromotionUrls.listNegotiationUrl;
    }
    print("LIST DISCOUNT URL$path");
    final response = await client.get(
      path,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );

    (response.data['data']['results'] as List).forEach((element) {
      negotiationList.add(NegotiationList.fromJson(element));
    });

    return PaginatedResponse<List<NegotiationList>>(
        negotiationList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }
  //listSeach
  Future<PaginatedResponse<List<NegotiationList>>> getSearchNegotiationList(
      String searchQuery, String? next) async {
    print("Buy Search${"${PromotionUrls.listNegotiationUrl}?name=$searchQuery"}");
    final response = await client.get(
      "${PromotionUrls.listNegotiationUrl}?name=$searchQuery",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );
    List<NegotiationList> negotiationList = [];
    (response.data['data']['results'] as List).forEach((element) {
      negotiationList.add(NegotiationList.fromJson(element));
    });
    return PaginatedResponse<List<NegotiationList>>(
        negotiationList,
        response.data['data']['next'],
        response.data['data']['count'].toString());
  }


  //readBuyMore
  Future<NegotiationList> getNegotiationRead(int id) async {
    NegotiationList negotiationList;

    print("Buy more Read:${PromotionUrls.readNegotiationUrl + id.toString()}");
    final response = await client.get(
      PromotionUrls.readNegotiationUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    negotiationList = NegotiationList.fromJson((response.data['data']['negotiation_data']));

    return negotiationList;
  }

  //deleteBuyMore
  Future<String> deleteNegotiation(int id) async {
    String statusCode;
    print("delete${PromotionUrls.readNegotiationUrl + id.toString()}");
    final response = await client.delete(
      PromotionUrls.readNegotiationUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$offerPeriodId");
    print("DATA IDD$image");
    print("DATA IDD$title");
    print("DATA IDD$variants");
    print("DATA IDD$isActive");
    print("DATA IDD$isAvailableforAll");
    print("DATA IDD$variants");
    print("DATA IDD${variants[0].isActive}");
    print("DATA IN NEGO$description");
    print("DATA IN NEGO$basedOn");
    print("DATA URL${PromotionUrls.readNegotiationUrl+id.toString()}");
    final response = await client.patch(
      PromotionUrls.readNegotiationUrl+id.toString(),
      data:
      {
        "segments":segment,
        "available_customer_groups":customer,
        "is_available_for_all":isAvailableforAll,
        "name":title,
        "offer_period_id":offerPeriodId,
        "based_on":basedOn,
        "cart_value_price_percentage":cartValueList,
        "cart_gp_price_percentage":cartGpList,
        "image":image,
        "description":description,
        "created_by":createdBy,
        "line":variants,
        'is_active':isActive

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authentication.authenticatedUser.token
        },
      ),
    );

    print("employee response${response}");
    if (response.data['status'] == 'success') {

      return DataResponse(
          data: response.data["status"]=="success", error: response.data['negotiaion_id'].toString());
    } else {
      if(response.data['is_another_promotion']==true){
        print("fas failed${response.data['message']['message']}");
        print("fas failed${response.data['message']['type_data']}");
        print("fas failed${response.data['is_another_promotion']}");
        Variable.errorMessage = response.data['message']['message'];
        Variable.typeData = response.data['message']['type_data'];
        Variable.isTypeDataCheck = true;
      }
      else{
        Variable.errorMessage = response.data['message'];
        Variable.isTypeDataCheck = false;
      }
      return DataResponse(data: false, error: Variable.isTypeDataCheck==true?Variable.errorMessage:response.data['message']);
    }
  }



}