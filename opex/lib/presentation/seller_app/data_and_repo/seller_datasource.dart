import 'package:cluster/presentation/seller_app/data_and_repo/seller_urls.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/data_response.dart';
import '../../../core/utils/variables.dart';
import '../../authentication/authentication.dart';
import '../../inventory/model/inventory_model.dart';
import '../../order_app/model/order_model.dart';
import '../seller_models/seller_model_class.dart';

class SellerDataSource {
  Dio client = Dio();

  Future<PaginatedResponse<List<GetNewOrderSellerList>>> newOrderListSeller(
      String? search, String? next, String? prev,String? filter,String? startDate,String? endDate) async {
    List<GetNewOrderSellerList> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    }
    else if (filter != "") {
      api = "${SellerUrls.newOrdersSellerUrl}?status=$filter";
    }
    else if (startDate != ""||endDate != "") {
      api = "${SellerUrls.newOrdersSellerUrl}?start_date=$startDate&end_date=$endDate";
    }
    else {
      // api = search!.isNotEmpty
      //     ? Variable.isOrderId==true?
      // "${SellerUrls.newOrdersSellerUrl}?order_id=$search":
      // "${SellerUrls.newOrdersSellerUrl}?order_line_id=$search"
      //     : SellerUrls.newOrdersSellerUrl;
    }
    print("api $api");
    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(GetNewOrderSellerList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }


  //out
  Future<PaginatedResponse<List<VariantListModel>>> outOfStockListSeller(
    String? search,
    String? next,
    String? prev,
    String? code,
  ) async {
    List<VariantListModel> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${SellerUrls.outOfStockListUrl + code.toString()}?name=$search"
          : SellerUrls.outOfStockListUrl + code.toString();
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(VariantListModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //seller
  Future<PaginatedResponse<List<SellerList>>> sellersListSeller(
      String? search, String? next, String? prev) async {
    List<SellerList> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${SellerUrls.sellerListUrl + authentication.authenticatedUser.organisationCode.toString()}?name=$search"
          : SellerUrls.sellerListUrl +
              authentication.authenticatedUser.organisationCode.toString();
    }
    print("APIIII$api");

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(SellerList.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //dash
  // Future<DoubleResponse> getDashboardData() async {
  //   OrderAnalyticsModel analyticsData;
  //
  //   final response = await client.get(
  //     SellerUrls.dathboadUrl,
  //     options: Options(
  //       validateStatus: (val) => true,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': '${authentication.authenticatedUser.token}',
  //       },
  //     ),
  //   );
  //   print("order analysis ${response.data}");
  //   analyticsData = OrderAnalyticsModel.fromJson(response.data['data']);
  //   return DoubleResponse(response.data['status'], analyticsData);
  // }

  //
  Future<int> productCount() async {
    int Total;
    print("COUNT DATA ${SellerUrls.totalProductCountUrl}${authentication.authenticatedUser.organisationCode}");
    final response = await client.get(
      "${SellerUrls.totalProductCountUrl}${authentication.authenticatedUser.organisationCode}",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data);
    Total = response.data['data'];
    return Total;
  }

  //newly
  Future<PaginatedResponse<List<VariantListModel>>> newlyAddedList(
      String? search,
      String? next,
      String? prev,
      String? code,
      ) async {
    List<VariantListModel> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${SellerUrls.newlyAddedListUrl + code.toString()}?name=$search"
          : SellerUrls.newlyAddedListUrl + code.toString();
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(VariantListModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //topSelling
  Future<PaginatedResponse<List<VariantListModel>>> topSellingList(
      String? search,
      String? next,
      String? prev,
      String? code,
      ) async {
    List<VariantListModel> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${SellerUrls.topSellingListUrl + code.toString()}?name=$search"
          : SellerUrls.topSellingListUrl + code.toString();
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(VariantListModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }

  //topReviews
  Future<PaginatedResponse<List<VariantListModel>>> topReviewedList(
      String? search,
      String? next,
      String? prev,
      String? code,
      ) async {
    List<VariantListModel> nationalityModel = [];
    String api = "";
    if (next != "") {
      api = next ?? "";
    } else if (prev != "") {
      api = prev ?? "";
    } else {
      api = search!.isNotEmpty
          ? "${SellerUrls.topReviewdListUrl + code.toString()}?name=$search"
          : SellerUrls.topReviewdListUrl + code.toString();
    }

    final response = await client.get(api,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': authentication.authenticatedUser.token
          },
        ));
    print("api " + api);
    print("response${response.data['data']}");
    (response.data['data']['results'] as List).forEach((element) {
      nationalityModel.add(VariantListModel.fromJson(element));
    });
    return PaginatedResponse(
      nationalityModel,
      response.data['data']['next'],
      response.data['data']['count'].toString(),
      previousUrl: response.data['data']['previous'],
    );
    // return nationalityModel;
  }
}
