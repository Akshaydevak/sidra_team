


import 'package:cluster/presentation/seller_app/data_and_repo/seller_datasource.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/data_response.dart';

class SellerRepo {
  final SellerDataSource _dataSource = SellerDataSource();

  Future<PaginatedResponse> newOrderListSeller(String? search,String? next,String? prev,String? filter,String? startDate,String? endDate) async {
    final apiResponse = await _dataSource.newOrderListSeller(search,next,prev,filter,startDate,endDate);
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

  //out
  Future<PaginatedResponse> outOfStockListSeller(String? search,String? next,String? prev,String? code,) async {
    final apiResponse = await _dataSource.outOfStockListSeller(search,next,prev,code);
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

  //seller
  Future<PaginatedResponse> sellersListSeller(String? search,String? next,String? prev) async {
    final apiResponse = await _dataSource.sellersListSeller(search,next,prev);
    try {
      if (apiResponse.data!= null && apiResponse.data!.isNotEmpty) {
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

  //dash
  // Future<DataResponse> getDashboardData() async {
  //   final apiResponse = await _dataSource.getDashboardData();
  //   try {
  //     if (apiResponse.data1=="success") {
  //       return DataResponse(data: apiResponse.data2,error: apiResponse.data1);
  //     } else {
  //       return DataResponse(data: [], error: "error Text");
  //     }
  //   } catch (e) {
  //     debugPrint("error Text$e");
  //   }
  //   return DataResponse(error: "error Text");
  // }


  //
  Future<DataResponse> productCount() async {
    try {
      final apiResponse = await _dataSource.productCount();

      if (apiResponse != null) {
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


  //newly
  Future<PaginatedResponse> newlyAddedList(String? search,String? next,String? prev,String? code,) async {
    final apiResponse = await _dataSource.newlyAddedList(search,next,prev,code);
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

  //topSelling
  Future<PaginatedResponse> topSellingList(String? search,String? next,String? prev,String? code,) async {
    final apiResponse = await _dataSource.topSellingList(search,next,prev,code);
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

  //topReviewd
  Future<PaginatedResponse> topReviewedList(String? search,String? next,String? prev,String? code,) async {
    final apiResponse = await _dataSource.topReviewedList(search,next,prev,code);
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


}