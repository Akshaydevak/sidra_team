import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/logistic_app/model/logistics_model.dart';
import 'package:cluster/presentation/logistic_app/utils/logistics_urls.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:cluster/presentation/order_app/utils/order_app_urls.dart';
import 'package:dio/dio.dart';

class LogisticsDataSource {
  Dio client = Dio();

  // new order list
  Future<PaginatedResponse> listOrders() async {
    List<ResultModel> tasktypeList = [];
    print(LogisticsAppUrls.newOrdersUrl);
    final response = await client.get(
      LogisticsAppUrls.newOrdersUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '9a63084503617e502ba114e81464dd5474476fe0',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(ResultModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }
}