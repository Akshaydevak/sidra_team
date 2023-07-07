import 'package:cluster/presentation/inventory/model/division_model.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/model/read_variant_model.dart';
import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:cluster/core/cluster_urls.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:cluster/presentation/authentication/authentication.dart';

import '../model/create_variant_model.dart';
import '../model/manufacture_model.dart';
import 'inventory_url.dart';

class InventoryDataSource {
  Dio client = Dio();

  //getDivision
  Future<PaginatedResponse<List<InventoryModel>>> getDivision(
      {String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.divisionUrl}?name=$search"
        : "${InventoryUrls.divisionUrl}?name=$search";
    // final String api = search!.isNotEmpty
    //     ? "${InventoryUrls.divisionUrl}?name=$search"
    //     : InventoryUrls.divisionUrl;

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

//getCategory
  Future<PaginatedResponse<List<InventoryModel>>> getCategory(
      {int? id, String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.categoryUrl}${id}?name=$search"
        : "${InventoryUrls.categoryUrl}${id}";
    // final String api = search!.isNotEmpty
    //     ? "${InventoryUrls.categoryUrl}${id}?name=$search"
    //     : "${InventoryUrls.categoryUrl}${id}";
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    print("api " + api);
    print("response${response.data['data']['results']}");
    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //getCategory
  Future<PaginatedResponse<List<InventoryModel>>> getSubCategory(
      {int? id, String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    print(search);
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.subCategoryUrl}${id}?name=$search"
        : "${InventoryUrls.subCategoryUrl}${id}";
    // final String api = search != null
    //     ? "${InventoryUrls.subCategoryUrl}${id}?name=$search"
    //     : "${InventoryUrls.subCategoryUrl}${id}";

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response ${response.data['data']['results']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //get Group
  Future<PaginatedResponse<List<InventoryModel>>> getGroup(
      {int? id, String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    print("............." + id.toString());
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.groupUrl}${id}?name=$search"
        : "${InventoryUrls.groupUrl}${id}";
    // final String api = search != null
    //     ? "${InventoryUrls.groupUrl}${id}?name=$search"
    //     : "${InventoryUrls.groupUrl}${id}";
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa" + response.data['data'].toString());
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

//get Group
  Future<PaginatedResponse<List<InventoryModel>>> getItem(
      {int? id, String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.itemUrl}${id}?name=$search"
        : "${InventoryUrls.itemUrl}${id}";
    // final String api = search != null
    //     ? "${InventoryUrls.itemUrl}${id}?name=$search"
    //     : "${InventoryUrls.itemUrl}${id}";
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa " + api);
    print("aaaaaaaaaaaaaaa" + response.data['data'].toString());
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  } //get Group

  Future<PaginatedResponse<List<InventoryModel>>> getUom(
      {int? id, String? search,url}) async {
    List<InventoryModel> nationalityModel = [];
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.uomUrl}?name=$search"
        : "${InventoryUrls.uomUrl}";
    // final String api = search != null
    //     ? "${InventoryUrls.uomUrl}?name=$search"
    //     : "${InventoryUrls.uomUrl}";
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa " + api);
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //get sales Uom
  Future<PaginatedResponse<List<InventoryModel>>> getSalesUom(
      {int? id, String? search}) async {
    List<InventoryModel> nationalityModel = [];

    final String api = search != null
        ? "${InventoryUrls.saleUomUrl}${id}?name=$search"
        : "${InventoryUrls.saleUomUrl}${id}";
    print("aaaaaaaaaaaaaaa " + api);
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa " + api);
    print("aaaaaaaaaaaaaaa " + response.data.toString());
    if(response.data['status']=='success'){

    }
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //post Pic
  Future<DoubleResponse> postPic(File? profilePic) async {
    User authenticatedUser;
    String filePath = "";
    print("heyyyy login url  ${InventoryUrls.pictureUrl}");
    if (profilePic != null) filePath = profilePic.path;
    final mime = lookupMimeType(filePath)!.split("/");
    final fileData = await MultipartFile.fromFile(
      filePath,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({"image": fileData
    });

    final response = await client.post(
      InventoryUrls.pictureUrl,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data);
    if (response.data != null || response.data != "") {
      return DoubleResponse(response.data['data'], response.data['image_url']);
    }
    return DoubleResponse(response.data, "failed");
  }

  //LIST varient
  Future<PaginatedResponse<List<InventoryModel>>> getVariant(
      {int? id, int? itemId, String? search}) async {
    List<InventoryModel> nationalityModel = [];

    final String api = search != null
        ? "${InventoryUrls.variantUrl}${id}?name=$search"
        : "${InventoryUrls.variantUrl}${itemId}/${authentication.authenticatedUser.organisationCode}";
    print(
        "itemmmmmmmm${InventoryUrls.variantUrl}${itemId}/${authentication.authenticatedUser.organisationCode}");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa " + api);
    print("create inventory" + response.data.toString());
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //LIST varient

  Future<List<InventoryModel>> getCombinations({int? id}) async {
    List<InventoryModel> departmentModel = [];
    print("${InventoryUrls.combinationUrl + id.toString()}");
    final response = await client.get(
        InventoryUrls.combinationUrl + id.toString(),
        // final response = await client.get(InventoryUrls.combinationUrl+"2",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(InventoryUrls.combinationUrl + id.toString());
    print("aaaaaaaaaaaaaaabbb" + response.data['data'].toString());
    (response.data['data'] as List).forEach((element) {
      departmentModel.add(InventoryModel.fromJson(element));
    });

    return departmentModel;
  }

//LIST channel
  Future<PaginatedResponse<List<InventoryModel>>> getChannel(
      {int? id, int? itemId}) async {
    List<InventoryModel> nationalityModel = [];

    final response = await client.get(
        InventoryUrls.channelUrl +
            "${authentication.authenticatedUser.organisationCode}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '${authentication.authenticatedUser.token}'
          },
        ));

    print("aaaaaaaaaaaaaaa " + InventoryUrls.channelUrl);
    print("aaaaaaaaaaaaaaa " + response.data.toString());
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

    //LIST manufacturer
  Future<PaginatedResponse<List<ManufactureModel>>> getManufacture(
      {String? search,url}) async {
    List<ManufactureModel> manufactureModel = [];
String api=search==""?InventoryUrls.manufactureUrl:"${InventoryUrls.manufactureUrl}?search_key=$search";
print("inside manufacture $search  $api");
    final response = await client.get(
        api ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'token ${authentication.authenticatedUser.token}'
          },
        ));

    print("aaaaaaaaaaaaaaa " + InventoryUrls.channelUrl);
    print("aaaaaaaaaaaaaaa " + response.data.toString());
    (response.data['data']['results'] as List).forEach((element) {
      manufactureModel.add(ManufactureModel.fromJson(element));
    });

    return PaginatedResponse<List<ManufactureModel>>(
      manufactureModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }
    //LIST sibling
  Future<PaginatedResponse<List<InventoryModel>>> getSibling(
      {int? id, int? itemId}) async {
    List<InventoryModel> dataModel = [];
String api=InventoryUrls.siblingUrl+"${authentication.authenticatedUser.organisationCode}";
print(api);
    final response = await client.get(
       api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': ' ${authentication.authenticatedUser.token}'
          },
        ));


    print("aaaaaaaaaaaaaaa " + response.data.toString());
    (response.data['data']['results'] as List).forEach((element) {
      dataModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      dataModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //variant create
  Future<DoubleResponse> createVarient({CreateVariantModel? variantModel}) async {
    String api = InventoryUrls.createVariantUrl;
    final response = await client.post(api,
        data: variantModel,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '${authentication.authenticatedUser.token}'
          },
        ));
    print(response.data);
    // if (response.data != null || response.data != "") {
      return DoubleResponse(response.data['status']=='success', response.data['message']);
    // }
    // return DoubleResponse(response.data, "failed");
  }
  //variant create
  Future<DataResponse> returnType() async {
    String api = InventoryUrls.createVariantUrl;
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '${authentication.authenticatedUser.token}'
          },
        ));
    // print(response.data);
    // if (response.data != null || response.data != "") {
    //   return response.data;
    // }
    print("response of return type ${response.data['data']['return_type']}");

    return DataResponse(data: response.data['data']['return_type']);
  }


  //oganisation

  Future<List<InventoryModel>> getInventory() async {
    List<InventoryModel> dataModel = [];
    String api="${InventoryUrls.inventoryDataUrl}${authentication.authenticatedUser.organisationCode}";
    final response = await client.get(
        api ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside inventory Model" + response.data['data']["results"].toString());
    (response.data['data']["results"] as List).forEach((element) {
      dataModel.add(InventoryModel.fromJson(element));
    });

    return dataModel;
  }


  //List varients
  Future<PaginatedResponse<List<InventoryModel>>> listVariants({String ?url,search})async {
  // Future<List<InventoryModel>> listVariants() async {
    List<InventoryModel> dataModel = [];
    String api="${url==""? InventoryUrls.listVariantsUrl+authentication.authenticatedUser.organisationCode.toString()+search: url}";
    print(api);
    final response = await client.get(
        api ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside inventory Model" + response.data['data']["results"].toString());
    (response.data['data']["results"] as List).forEach((element) {
      dataModel.add(InventoryModel.fromJson(element));
    });

        return PaginatedResponse<List<InventoryModel>>(
      dataModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }



  Future<DataResponse> readVariant({int? id}) async {

    String api="${InventoryUrls.readVariantsUrl}${id}";
    print("Inside read variant url " + api);

    final response = await client.get(
        api ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside read variant" + response.data['data'].toString());
    // (response.data['data'] as List).forEach((element) {
    //   dataModel.add(InventoryModel.fromJson(element));
    // });
    ReadVariantModel dataModel=ReadVariantModel.fromJson(response.data['data']);


    return DataResponse(data:dataModel);
  }

  Future<DoubleResponse> updateVariant({CreateVariantModel? dataModel,int? id}) async {

    String api="${InventoryUrls.updateVariantsUrl}${id}";
    print("heighhttttttt !!!! ${dataModel?.siblingId}");
    print("heighhttttttt !!!! ${dataModel?.shelfType}");
    print("heighhttttttt !!!! ${dataModel?.salesUom}");
    print("heighhttttttt !!!!  apiiiiiiiiiiiiii $api");
    print("heighhttttttt !!!! ${dataModel?.displayName}");
    try {
       final response = await client.post(
        api ,
        data: dataModel,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside read variant" + response.toString());
    // (response.data['data'] as List).forEach((element) {
    //   dataModel.add(InventoryModel.fromJson(element));
    // });
    // ReadVariantModel dataModelRead=ReadVariantModel.fromJson(response.data['data']);


    return DoubleResponse(response.data['status']=='success',response.data['message']);
    } catch (e) {
      print("Inside read variant exception  $e");
    }
    final response = await client.post(
        api ,
        data: dataModel,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside read variant" + response.toString());
    // (response.data['data'] as List).forEach((element) {
    //   dataModel.add(InventoryModel.fromJson(element));
    // });
    // ReadVariantModel dataModelRead=ReadVariantModel.fromJson(response.data['data']);


    return DoubleResponse(response.data['status']=='success',response.data['message']);
  }

  Future<DoubleResponse> deleteVariant({int? id}) async {

    String api="${InventoryUrls.deleteVariantsUrl}${id}";
    print("delete api $api");
    final response = await client.delete(
        api ,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print(api);
    print("Inside read variant" + response.data.toString());
    // (response.data['data'] as List).forEach((element) {
    //   dataModel.add(InventoryModel.fromJson(element));
    // });
    // ReadVariantModel dataModel=ReadVariantModel.fromJson(response.data['data']);


    return DoubleResponse(response.data['status']=='success',response.data['message']);
  }
  Future<PaginatedResponse<List<InventoryModel>>> getStockPartition(
      {String? id, String? search, String? url}) async {
    List<InventoryModel> dataModel = [];
    print("Url $url ${url==""} nullcheck${url==null}");
    final String api = url!=""&&url!=null ?"$url":search != null
        ? "${InventoryUrls.stockPartitionUrl}${id}?name=$search"
        : "${InventoryUrls.stockPartitionUrl}${id}";
    print("stock Partition ${api}");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("aaaaaaaaaaaaaaa " + api);
    print("aaaaaaaaaaaaaaa" + response.data['data'].toString());
    (response.data['data']['results'] as List).forEach((element) {
      dataModel.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      dataModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  } //get Group

//STOCK
  Future<PaginatedResponse<List<InventoryModel>>> getStockProduct(
      String code, String? prev) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.productStocklistUrl + authentication.authenticatedUser.organisationCode.toString()}?name=$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.productStocklistUrl+authentication.authenticatedUser.organisationCode.toString();
    }
    List<InventoryModel> discountList = [];
    print("LIST DISCOUNT URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      discountList.add(InventoryModel.fromJson(element));
    });

    return PaginatedResponse<List<InventoryModel>>(
      discountList,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }

  Future<ReadStockData> getStockProductRead(int id) async {
    ReadStockData stock;

    print("Task Read:${InventoryUrls.readStockUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readStockUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );
    print(response.data['data']);
    stock = ReadStockData.fromJson((response.data['data']));

    return stock;
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
    print("DATA IDD$channelCode");
    final response = await client.post(
      InventoryUrls.createStockUrl,
      data: {
        "inventory_id":inventoryId,
        "channel_id":null,
        "channel_code":null,
        "variant_id":variantId,
        "variant_code":variantCode,
        "stock_warning":stockWarning,
        "website_status_crucial_point":crucialPoint,
        "website_status_medium_point":mediumPoint,
        "add_virtual_stock":addVirtualStock,
        "virtual_type":virtualType,
        "is_daily_stock_available":isDailyStockAvailable,
        "daily_stock_quantity":dailyStockQty,

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


  Future<DataResponse> createMethodType({
    required String typeName,
    required String discription,
    required String createdBy,
  }) async {
    // print("DATA IDD$channelCode");
    final response = await client.post(
      InventoryUrls.createCostMethodTypeUrl,
      data: {
        "type_name":typeName,
        "description":discription,
        "created_by":createdBy,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }


  Future<PaginatedResponse<List<CostingModel>>> costMethodTypeList(
      String code, String? prev) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.costMethodTypeListUrl}?$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.costMethodTypeListUrl;
    }
    List<CostingModel> costModel = [];
    print("LIST MMM URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      costModel.add(CostingModel.fromJson(element));
    });

    return PaginatedResponse<List<CostingModel>>(
      costModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }



  Future<CostingModel> getCostMethodTypeRead(int id) async {
    CostingModel discountList;

    print("method type:${InventoryUrls.costMethodTypeReadUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.costMethodTypeReadUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = CostingModel.fromJson((response.data['data']));

    return discountList;
  }

  //deleteDiscount
  Future<String> deleteCostMethodType(int id) async {
    String statusCode;
    print("dele${InventoryUrls.costMethodTypeReadUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.costMethodTypeReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateCostMethodTypePost({
    required String typeName,
    required int id,
    required String discription,
    required String createdBy,
    required bool isActive,
  }) async {
    print("DATA IDD$typeName");
    print("DATA IDD$discription");
    print("DATA IDD$createdBy");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.costMethodTypeReadUrl+id.toString(),
      data: {
        "type_name":typeName,
        "description":discription,
        "created_by":createdBy,
        "is_active":isActive,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }


  //createmethod
  Future<DataResponse> createMethod({
    required int methodTypeId,
    required String methodName,
    required String createdBy,
    required String discription,
  }) async {
    // print("DATA IDD$channelCode");
    final response = await client.post(
      InventoryUrls.createcostMethodUrl,
      data: {
        "method_type_id":methodTypeId,
        "method_name":methodName,
        "created_by":createdBy,
        "description":discription,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }


  Future<PaginatedResponse<List<CostingModel>>> costMethodlist(
      String code, String? prev) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.costingmethodListUrl}?$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.costingmethodListUrl;
    }
    List<CostingModel> costModel = [];
    print("LIST MMM URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      costModel.add(CostingModel.fromJson(element));
    });

    return PaginatedResponse<List<CostingModel>>(
      costModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }



  Future<CostingModel> getCostMethodRead(int id) async {
    CostingModel discountList;

    print("method type:${InventoryUrls.costingMethodReadUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.costingMethodReadUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = CostingModel.fromJson((response.data['data']));

    return discountList;
  }

  //deleteDiscount
  Future<String> deleteCostMethod(int id) async {
    String statusCode;
    print("dele${InventoryUrls.costingMethodReadUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.costingMethodReadUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$methodName");
    print("DATA IDD$discription");
    print("DATA IDD$createdBy");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.costingMethodReadUrl+id.toString(),
      data: {
        "method_type_id":methodTypeId,
        "method_name":methodName,
        "description":discription,
        "is_active":isActive,
        "created_by":createdBy,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  //pricingType
  Future<DataResponse> createPricingType({

    required String pricingTypeName,
    required String createdBy,
    required String discription,
  }) async {
    print("DATA IDD$pricingTypeName");
    print("DATA IDD$createdBy");
    print("DATA IDD$discription");
    final response = await client.post(
      InventoryUrls.createPricingTypeUrl,
      data: {
        "pricing_type_name":pricingTypeName,
        "created_by":createdBy,
        "description":discription,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }


  Future<PaginatedResponse<List<CostingModel>>> PricingTypelist(
      String code, String? prev) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.pricingTypeListUrl}?$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.pricingTypeListUrl;
    }
    List<CostingModel> costModel = [];
    print("LIST MMM URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      costModel.add(CostingModel.fromJson(element));
    });

    return PaginatedResponse<List<CostingModel>>(
      costModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }



  Future<CostingModel> getPricingTypeRead(int id) async {
    CostingModel discountList;

    print("method type:${InventoryUrls.costingMethodReadUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readPricingTypeUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = CostingModel.fromJson((response.data['data']));

    return discountList;
  }

  //deleteDiscount
  Future<String> deletePricingType(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readPricingTypeUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readPricingTypeUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$pricingTypeName");
    print("DATA IDD$discription");
    print("DATA IDD$createdBy");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readPricingTypeUrl+id.toString(),
      data: {
        "id":id,
        "pricing_type_code":pricingTypeCode,
        "pricing_type_name":pricingTypeName,
        "description":discription,
        "is_active":isActive,
        "created_by":createdBy,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
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
    print("DATA IDD$pricingGroupName");
    print("DATA IDD$createdBy");
    print("DATA IDD$discription");
    final response = await client.post(
      InventoryUrls.createPricingGroupUrl,
      data: {
        "pricing_type_id":pricingTypeId,
        "pricing_group_name":pricingGroupName,
        "customer_group_code":customerGroupCode,
        "description":discription,
        "created_by":createdBy,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }


  Future<PaginatedResponse<List<CostingModel>>> PricingGrouplist(
      String code, String? prev) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.pricinggroupListUrl}?$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.pricinggroupListUrl;
    }
    List<CostingModel> costModel = [];
    print("LIST MMM URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      costModel.add(CostingModel.fromJson(element));
    });

    return PaginatedResponse<List<CostingModel>>(
      costModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }



  Future<CostingModel> getPricingGroupRead(int id) async {
    CostingModel discountList;

    print("method type:${InventoryUrls.readPricingGroupUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readPricingGroupUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = CostingModel.fromJson((response.data['data']));

    return discountList;
  }

  //deleteDiscount
  Future<String> deletePricingGroup(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readPricingGroupUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readPricingGroupUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$pricingGroupName");
    print("DATA IDD$discription");
    print("DATA IDD$createdBy");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readPricingGroupUrl+id.toString(),
      data: {
        "pricing_type_id":pricingTypeId,
        "customer_group_code":customerGroupCode,
        "pricing_group_name":pricingGroupName,
        "description":discription,
        "is_active":isActive,
        "created_by":createdBy,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }

  Future<ReadCostingData> getPricingGpTypeRead(int id) async {
    ReadCostingData discountList;

    print("type:${InventoryUrls.readCostingByVariant + id.toString()}");
    final response = await client.get(
      InventoryUrls.readCostingByVariant+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = ReadCostingData.fromJson((response.data['data']));

    return discountList;
  }

  Future<DataResponse> gpPercentagePost({

    required int variantId,
    required String GPType,
    required String inventoryId,
  }) async {
    // print("DATA IDD$pricingGroupName");
    // print("DATA IDD$createdBy");
    // print("DATA IDD$discription");
    final response = await client.post(
      InventoryUrls.GPPostUrl,
      data: {
        "variant_id":variantId,
        "inventory_id":inventoryId,
        "choice":GPType,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['data'].toString());
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  //createCosting
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
    // print("DATA IDD$pricingGroupName");
    // print("DATA IDD$createdBy");
    print("DATA IDD$GpPercentage");
    final response = await client.post(
      InventoryUrls.createCostingUrl,
      data: {
        "pricing_group_id":pricingGroupId,
        "pricing_gp_type":pricingGpType,
        "gp_percentage":GpPercentage,
        "selling_price":sellingPrice,
        "costing_method_id":costingMethodId,
        "channel_code":channelCode,
        "variant_id":varientId,
        "variant_code":varientCode,
        "inventory_id":invId,
        "unit_cost":unitCost,
        "created_by":createdBy,
        "costing_name":costingName,
        "gp_operation":gpOperation,
        "price_type":pricrType,
        "channel_id":channelId,
        "actual_selling_price":actualSellingPrice,
        "actual_cost":actualcost,
        "stock_code":stockCode,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

//
  Future<PaginatedResponse<List<CostingReadData>>> costinglist(
      String code, String? prev,int id) async {
    String? api;
    print("DDDD$code");
    print("DDDD$prev");
    if(code!=null&&code!=""){
      api= "${InventoryUrls.costingListUrl}?$code";
    }
    else if(prev!=null&&prev!="") {
      api=prev.toString();
    }
    else{
      api=InventoryUrls.costingListUrl+id.toString();
    }
    List<CostingReadData> costModel = [];
    print("LIST MMM URL :$api");
    final response = await client.get(
      api,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print("DDDD${response.data['data']['results'] }");
    (response.data['data']['results'] as List).forEach((element) {
      costModel.add(CostingReadData.fromJson(element));
    });

    return PaginatedResponse<List<CostingReadData>>(
      costModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],);
  }



  Future<CostingReadData> getCostingRead(int id) async {
    CostingReadData discountList;

    print("costing read:${InventoryUrls.readCostingUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readCostingUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    discountList = CostingReadData.fromJson((response.data['data']['costing_data']));

    return discountList;
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
    // print("DATA IDD$pricingGroupName");
    // print("DATA IDD$discription");
    // print("DATA IDD$createdBy");
    // print("DATA IDD$isActive");
    print("HHHH${InventoryUrls.patchCostingUrl+id.toString()}");
    final response = await client.post(
      InventoryUrls.patchCostingUrl+id.toString(),
      data: {
        "pricing_group_id":pricingGroupId,
        "pricing_gp_type":pricingGpType,
        "gp_percentage":GpPercentage,
        "selling_price":sellingPrice,
        "costing_method_id":costingMethodId,
        "channel_code":channelCode,
        "variant_id":varientId,
        "variant_code":varientCode,
        "inventory_id":invId,
        "unit_cost":unitCost,
        "created_by":createdBy,
        "costing_name":costingName,
        "gp_operation":gpOperation,
        "price_type":pricrType,
        "channel_id":channelId,
        "actual_selling_price":actualSellingPrice,
        "actual_cost":actualcost,
        "stock_code":stockCode,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
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
    print("DATA IDD$prioriy");
    print("DATA IDD$image");
    print("DATA IDD$description");
    final response = await client.post(
      InventoryUrls.createDivisionUrl,
      data: {
        "description":description,
        "image":image,
        "display_name":displayName,
        "name":name,
        "search_name":searchName,
        "priority":prioriy,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getDivisionRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readDivisionUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readDivisionUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteDivision(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readDivisionUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readDivisionUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print("responsee eis a${response.data}");
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$description");
    print("DATA IDD$image");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readDivisionUrl+id.toString(),
      data: {
        "description":description,
        "image":image,
        "display_name":displayName,
        "name":name,
        "search_name":searchName,
        "is_active":isActive,
        "priority":prioriy,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
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
    print("DATA IDD$prioriy");
    print("DATA IDD$image");
    print("DATA IDD$description");
    final response = await client.post(
      InventoryUrls.createCategoryUrl,
      data: {
        "description":description,
        "alternative_name":altName,
        "parent_code":parentCode,
        "division_code":divisionCode,
        "name":name,
        "image":image,
        "priority":prioriy,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getCategoryRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readCategoryUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readCategoryUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteCategory(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readCategoryUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readCategoryUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$description");
    print("DATA IDD$image");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readCategoryUrl+id.toString(),
      data: {
        "name":name,
        "image":image,
        "is_active":isActive,
        "priority":prioriy,
        "division_code":divisionCode,
        "parent_code":parentCode,
        "description":description,
        "alternative_name":altName,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getCategorylist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
     String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listCategoryUrl}?name=$search"
          : InventoryUrls.listCategoryUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }


  //divv
  Future<PaginatedResponse<List<InventoryModel>>> getDivisionlist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.divisionUrl}?name=$search"
          : InventoryUrls.divisionUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
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
    print("DATA IDD$prioriy");
    print("DATA IDD$image");
    print("DATA IDD$description");
    final response = await client.post(
      InventoryUrls.createGroupUrl,
      data: {
        "category_code":categoryCode,
        "name":name,
        "display_name":displayName,
        "image":image,
        "priority":prioriy,
        "search_name":searchName,
        "description":description,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getGroupRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readGroupUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readGroupUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteGroup(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readGroupUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readGroupUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    print("DATA IDD$description");
    print("DATA IDD$image");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readGroupUrl+id.toString(),
      data: {
        "name":name,
        "search_name":searchName,
        "description":description,
        "image":image,
        "display_name":displayName,
        "category_code":categoryCode,
        "is_active":isActive,
        "priority":prioriy,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getGrouplist(
      String? search, String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listGroupUrl}?name=$search"
          : InventoryUrls.listGroupUrl;

    }
    print("api " + api);
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //Uomgroup
  Future<DataResponse> createUomGroup({
    required String name,
    required String shortName,
    required String description,
  }) async {
    // print("DATA IDD$prioriy");
    // print("DATA IDD$image");
    print("DATA IDD$description");
    final response = await client.post(
      InventoryUrls.createUomGroupUrl,
      data: {
        "name":name,
        "short_name":shortName,
        "description":description,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getUomGroupRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readUomGroupurl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readUomGroupurl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteUomGroup(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readUomGroupurl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readUomGroupurl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateUomGroupPost({
    required String name,
    required String shortName,
    required String description,
    required int id,
    required bool isActive,
  }) async {
    print("DATA IDD$description");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readUomGroupurl+id.toString(),
      data: {
        "name":name,
        "short_name":shortName,
        "description":description,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getUomGrouplist(
      String? search, String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listUomgroupUrl}?name=$search"
          : InventoryUrls.listUomgroupUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //UOm
  Future<DataResponse> createUom({
    required String name,
    required String shortName,
    required String baseEquvalant,
    required String uomGroupCode,
    required double convertionFactor,
    required String statnderdCode,
  }) async {
    // print("DATA IDD$prioriy");
    // print("DATA IDD$image");
    print("DATA IDD$uomGroupCode");
    final response = await client.post(
      InventoryUrls.createUomUrl,
      data: {
        "name":name,
        "short_name":shortName,
        "uomgroup_code":uomGroupCode,
        "conversion_factor":convertionFactor,
        "standard_code":statnderdCode,
        "base_equivalent":baseEquvalant,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getUomRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readUomUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readUomUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteUom(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readUomUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readUomUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    // print("DATA IDD$di");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readUomUrl+id.toString(),
      data: {
        "name":name,
        "short_name":shortName,
        "uomgroup_code":uomGroupCode,
        "conversion_factor":convertionFactor,
        "standard_code":statnderdCode,
        "base_equivalent":baseEquvalant,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getUomlist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listUomUrl}?name=$search"
          : InventoryUrls.listUomUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //Material
  Future<DataResponse> createMaterial({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String discription,

  }) async {
    // print("DATA IDD$prioriy");
    // print("DATA IDD$image");
    print("DATA IDD$image");
    final response = await client.post(
      InventoryUrls.createMaterialUrl,
      data: {
        "name":name,
        "image":image,
        "search_name":searchNmae,
        "description":discription,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getMaterialRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readMaterialUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readMaterialUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteMaterial(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readMaterialUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readMaterialUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    // print("DATA IDD$di");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readMaterialUrl+id.toString(),
      data: {
        "id":id,
        "name":name,
        "code":code,
        "image":image,
        "search_name":searchNmae,
        "description":discription,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getMateriallist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listMaterialUrl}?name=$search"
          : InventoryUrls.listMaterialUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //staticGroup
  Future<DataResponse> createStaticGroup({
    required String name,
    required dynamic image,
    required String searchNmae,
    required String discription,

  }) async {
    print("DATA IDD$image");
    final response = await client.post(
      InventoryUrls.createStaticGroupUrl,
      data: {
        "name":name,
        "image":image,
        "search_name":searchNmae,
        "description":discription,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getStaticGroupRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readStaticGroupUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readStaticGroupUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteStaticGroup(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readStaticGroupUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readStaticGroupUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    // print("DATA IDD$di");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readStaticGroupUrl+id.toString(),
      data: {
        "name":name,
        "image":image,
        "search_name":searchNmae,
        "description":discription,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getStaticGrouplist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api =  search!.isNotEmpty
          ? "${InventoryUrls.listStaticGroupUrl}?name=$search"
          : InventoryUrls.listStaticGroupUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
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
    print("DATA IDD$image");
    final response = await client.post(
      InventoryUrls.createBrandUrl,
      data: {
        "name":name,
        "image":image,
        "priority":priority,
        "parent_code":parentCode,
        "brand_identifier_url":brandIdentifierUrl,
        "description":discription,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionModels> getBrandRead(int id) async {
    DivisionModels divisionModel;

    print("method type:${InventoryUrls.readBrandUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readBrandUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data['data']);
    divisionModel = DivisionModels.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteBrand(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readBrandUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readBrandUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    // print("DATA IDD$di");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readBrandUrl+id.toString(),
      data: {
        "name":name,
        "image":image,
        "priority":priority,
        "parent_code":parentCode,
        "brand_identifier_url":brandIdentifierUrl,
        "description":discription,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getBrandlist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listBrandUrl}?name=$search"
          : InventoryUrls.listBrandUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //attribute
  Future<GetDiscount> getAttributeTypeRead() async {
    GetDiscount discount;

    final response = await client.get(
      InventoryUrls.createAttributeUrl,
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

  Future<DataResponse> createAttribute({
    required String attributeName,
    required String attributeType,
    required bool isActive,


  }) async {
    // print("DATA IDD$image");
    final response = await client.post(
      InventoryUrls.createAttributeUrl,
      data: {
        "attribute_name":attributeName,
        "attribute_type":attributeType,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<AttributeDataModel> getAttributeRead(int id) async {
    AttributeDataModel divisionModel;

    print("method type:${InventoryUrls.readAttributeUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readAttributeUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = AttributeDataModel.fromJson((response.data['data']['attribute_data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteAttribute(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readAttributeUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readAttributeUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateAttributePost({
    required String attributeName,
    required String attributeType,
    required int id,
    required bool isActive,
  }) async {
    // print("DATA IDD$di");
    // print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readAttributeUrl+id.toString(),
      data: {
        "attribute_name":attributeName,
        "attribute_type":attributeType,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getAttributelist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listAttributeUrl}?name=$search"
          : InventoryUrls.listAttributeUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //cvariant
  Future<DataResponse> createVarientFramework({
    required String name,
    required String description,
    required List<AttributeLines> lines,


  }) async {
    print("DATA CREATE$lines");
    final response = await client.post(
      InventoryUrls.createVarientFrameworkUrl,
      data: {
        "name":name,
        "description":description,
        "lines":lines,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<AttributeDataModel> getVarientFrameworkRead(int id) async {
    AttributeDataModel divisionModel;

    print("method type:${InventoryUrls.readVariantFrameworkUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readVariantFrameworkUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = AttributeDataModel.fromJson((response.data['data']));

    return divisionModel;
  }

  //deleteDiscount
  Future<String> deleteVarientFramework(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readVariantFrameworkUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readVariantFrameworkUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateVarientFrameworkPost({
    required String name,
    required String description,
    required List<AttributeLines> lines,
    required int id,
    required bool isActive,
  }) async {
    print("DATA IN VARR${lines.length}");
    print("DATA IN VARR${lines[0].isActive}");
    print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readVariantFrameworkUrl+id.toString(),
      data: {
        "name":name,
        "description":description,
        "lines":lines,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getVarientFrameworklist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listVarientFrameworkUrl}?name=$search"
          : InventoryUrls.listVarientFrameworkUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
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
    // print("DATA IDD$image");
    final response = await client.post(
      InventoryUrls.createItemUrl,
      data: {
        "name":name,
        "material_code":materialCode,
        "uom_group_code":uomgroupCode,
        "uom_code":uomCode,
        "group_code":groupCode,
        "brand_code":brandCode,
        "static_group_code":staticGroupCode,
        "image1":img1,
        "variant_framework_code":variantFrameworkCode,
        "display_name":displayName,
        "barcode":barcode,
        "item_cataloge1":itemCatalog1,
        "item_cataloge2":itemCatalog2,
        "item_cataloge3":itemCatalog3,
        "item_cataloge4":itemCatalog4,
        "item_cataloge5":itemCatalog5,
        "image2":img1,
        "image3":img2,
        "description":description,
        "old_system_code":oldSystemCode,
        "search_name":searchName,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<ItemReadModel> getItemRead(int id) async {
    ItemReadModel divisionModel;

    print("method type:${InventoryUrls.readItemUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readItemUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = ItemReadModel.fromJson((response.data['data']));

    return divisionModel;
  }
  //deleteDiscount
  Future<String> deleteItem(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readItemUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readItemUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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
    // print("DATA IDD$di");
    // print("DATA IDD$name");
    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readItemUrl+id.toString(),
      data: {
        "name":name,
        "material_code":materialCode,
        "uom_group_code":uomgroupCode,
        "uom_code":uomCode,
        "group_code":groupCode,
        "brand_code":brandCode,
        "static_group_code":staticGroupCode,
        "image1":img1,
        "variant_framework_code":variantFrameworkCode,
        "display_name":displayName,
        "barcode":barcode,
        "item_cataloge1":itemCatalog1,
        "item_cataloge2":itemCatalog2,
        "item_cataloge3":itemCatalog3,
        "item_cataloge4":itemCatalog4,
        "item_cataloge5":itemCatalog5,
        "image2":img1,
        "image3":img2,
        "description":description,
        "old_system_code":oldSystemCode,
        "search_name":searchName,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getItemlist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listItemUrl}?name=$search"
          : InventoryUrls.listItemUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //list for segment
  Future<PaginatedResponse<List<InventoryModel>>> getGroupListSegment(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listgroupforDivisionAllocationUrl}?name=$search"
          : InventoryUrls.listgroupforDivisionAllocationUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  Future<PaginatedResponse<List<InventoryModel>>> getUomListSegment(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listUomforDivisionAllocationUrl}?name=$search"
          : InventoryUrls.listUomforDivisionAllocationUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  Future<PaginatedResponse<List<InventoryModel>>> getCategoryListSegment(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listCategoryforDivisionAllocationUrl}?name=$search"
          : InventoryUrls.listCategoryforDivisionAllocationUrl;
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }
  //div config
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
    print("DATA IDD$uomGroup");
    print("DATA IDD$grroup");
    print("DATA IDD$categoey");
    final response = await client.post(
      InventoryUrls.createDivisionConfigUrl,
      data: {
        "name":name,
        "description":description,
        "image":image,
        "is_mixed":isMixed,
        "priority":priority,
        "uom_code":uomGroup,
        "category_code":categoey,
        "group_code":grroup,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<DivisionConfigRead> getDivisionConfigurationRead(int id) async {
    DivisionConfigRead divisionModel;

    print("method type:${InventoryUrls.readDivisionConfigUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readDivisionConfigUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = DivisionConfigRead.fromJson((response.data['data']));

    return divisionModel;
  }
  //deleteDiscount
  Future<String> deleteDivisionConfiguration(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readDivisionConfigUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readDivisionConfigUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
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

    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readDivisionConfigUrl+id.toString(),
      data: {
        "name":name,
        "description":description,
        "image":image,
        "is_mixed":isMixed,
        "priority":priority,
        "uom_code":uomGroup,
        "category_code":categoey,
        "group_code":grroup,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getDivisionConfigurationlist(
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listdivisionConfigUrl}?name=$search"
          : InventoryUrls.listdivisionConfigUrl;
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //warrantyType
  Future<DataResponse> createWarrantyType({
    required String title,
    required String description,
    required bool isActive,



  }) async {
    // print("DATA IDD$uomGroup");
    // print("DATA IDD$grroup");
    // print("DATA IDD$categoey");
    final response = await client.post(
      InventoryUrls.createWarrantyTypeUrl,
      data: {
        "title":title,
        "description":description,
        "is_active":isActive,

      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }

  Future<WarrantyTypeRead> getWarrantyTypeRead(int id) async {
    WarrantyTypeRead divisionModel;

    print("method type:${InventoryUrls.readWarrantyTypeUrl + id.toString()}");
    final response = await client.get(
      InventoryUrls.readWarrantyTypeUrl+ id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = WarrantyTypeRead.fromJson((response.data['data']));

    return divisionModel;
  }
  //deleteDiscount
  Future<String> deleteWarrantyType(int id) async {
    String statusCode;
    print("dele${InventoryUrls.readWarrantyTypeUrl + id.toString()}");
    final response = await client.delete(
      InventoryUrls.readWarrantyTypeUrl + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }

  //updateDiscount
  Future<DataResponse> updateWarrantyTypePost({
    required String title,
    required String description,
    required bool isActive,
    required int id,
  }) async {

    print("DATA IDD$isActive");
    final response = await client.patch(
      InventoryUrls.readWarrantyTypeUrl+id.toString(),
      data: {
        "title":title,
        "description":description,
        "is_active":isActive,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response${response}");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }
  }
  Future<PaginatedResponse<List<InventoryModel>>> getWarrantyTypelist(
      String? search) async {
    List<InventoryModel> nationalityModel = [];
    final String api = search!.isNotEmpty
        ? "${InventoryUrls.listWarrantyTypeUrl}?name=$search"
        : InventoryUrls.listWarrantyTypeUrl;

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api $api");
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //uomByGroup
  Future<PaginatedResponse<List<InventoryModel>>> getGetUomByUomGrouplist(
      String? search,int? id,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.uomByUomGroupUrl+id.toString()}?name=$search"
          : InventoryUrls.uomByUomGroupUrl+id.toString();
      // api+id.toString();
    }


    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
    print("api for uom BYt$api");
    print("response${response.data}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

  //createWarranty
  Future<DataResponse> createWarranty({
    required CreateWarrantyModel warrantyModel,

  }) async {
    print("THAS${InventoryUrls.createWarrantyUrl}");
    print("THAS${warrantyModel.variantCode}");
    print("THAS${warrantyModel.variantId}");
    print("THAS${warrantyModel.warrantyDetailsModel!.length}");
    print("THAS${warrantyModel.warrantyDetailsModel}");
    print("THAS${warrantyModel.warrantyDetailsModel?[0].warrantyTypeId}");
    print("THAS${warrantyModel.warrantyDetailsModel?[0].additionalWarrantyDetails?[0].conditionList}");
    print("THAS${warrantyModel.warrantyDetailsModel?[0].exConditionList}");
    print("THAS${warrantyModel.warrantyDetailsModel?[0].exdescription}");

    try{
      final response = await client.post(
        InventoryUrls.createWarrantyUrl,
        data: warrantyModel,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization':authentication.authenticatedUser.token
          },
        ),
      );

      print(" response$response");
      if (response.data['status'] == 'success') {
        return DataResponse(
            data: response.data["status"]=="success", error: response.data['message']);
      } else {
        return DataResponse(data: false, error: response.data['message']);
      }
    }catch(K){
      print("FDFD$K");
    }
    final response = await client.post(
      InventoryUrls.createWarrantyUrl,
      data: warrantyModel,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );

    print(" response$response");
    if (response.data['status'] == 'success') {
      return DataResponse(
          data: response.data["status"]=="success", error: response.data['message']);
    } else {
      return DataResponse(data: false, error: response.data['message']);
    }

  }
  //
  Future<WarrantyReadModel> getWarrantyRead(String code) async {
    WarrantyReadModel divisionModel;

    print("method type:${InventoryUrls.readWarrantyUrl + code.toString()}");
    final response = await client.get(
      InventoryUrls.readWarrantyUrl+ code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    print(response.data);
    divisionModel = WarrantyReadModel.fromJson((response.data['data']));

    return divisionModel;
  }
  //deleteDiscount
  Future<String> deleteWarranty(String code) async {
    String statusCode;
    print("dele${InventoryUrls.deleteWarrantyUrl + code.toString()}");
    final response = await client.delete(
      InventoryUrls.deleteWarrantyUrl + code.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization':authentication.authenticatedUser.token
        },
      ),
    );
    statusCode = (response.data['status']);
    return statusCode;
  }
  Future<PaginatedResponse<List<InventoryModel>>> getWarrantylist(
  String? code,
      String? search,String? next,String? prev) async {
    List<InventoryModel> nationalityModel = [];
    String api="";
    if(next!=""){
      api=next??"";
    }
    else if(prev!=""){
      api=prev??"";
    }
    else{
      api = search!.isNotEmpty
          ? "${InventoryUrls.listWarrantyUrl+code.toString()}?name=$search"
          : InventoryUrls.listWarrantyUrl+code.toString();
    }

    print("api $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(InventoryModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
  }

}
