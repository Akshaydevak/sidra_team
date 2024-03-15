

import 'package:cluster/core/cluster_urls.dart';
import 'package:cluster/core/utils/data_response.dart';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:cluster/presentation/order_app/utils/order_app_urls.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:dio/dio.dart';

import '../../authentication/authentication.dart';

class OrderDataSource {
  Dio client = Dio();
  List<User> authenticatedTokenList = [];
  // order list
  Future<PaginatedResponse> listOrders() async {
    List<ListOrdersModel> tasktypeList = [];
    print(OrderAppUrls.orderListUrl);
    final response = await client.get(
      OrderAppUrls.orderListUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '241d4889da5d5b6a68e4c170907b724fa9d5e84d',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(ListOrdersModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  // employee list
  Future<PaginatedResponse> getEmployeeList() async {
    List<ListOrdersModel> tasktypeList = [];
    print("heyyyy order employee list urll ${OrderAppUrls.employeeListUrl}");
    final response = await client.get(
      OrderAppUrls.employeeListUrl,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'token 241d4889da5d5b6a68e4c170907b724fa9d5e84d',
        },
      ),
    );
    print(response.data);
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(ListOrdersModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  Future<DoubleResponse> login(
      String? email, String? password, String? code) async {
    User authenticatedUser;
    print(email.toString()+password.toString()+code.toString());
    final response = await client.post(
      data:
      {
        "username": email,
        "password": password,
        "usercode": code
      },
// { "username":"shifas@rgcdynamics.com","password":"876254604560","usercode":"EMPY112"},

      "https://api-uat-user.sidrabazar.com/user-account_login-admin/cluster",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data);
    if (response.data['status'] == "success") {
      print("log out check ${authentication.userNameData.length}");
      authenticatedUser = User.fromJson(response.data['data']);
      // await authentication.saveAuthenticatedUser(
      //     authenticatedUser: authenticatedUser);
      print("roleesssss ${authenticatedUser.roleList}");
      for (int i = 0; i < authenticatedUser.roleList!.length; i++) {

        if (authenticatedUser.roleList?[i] == "admin") {
          await authentication.saveAuthenticatedUser(
              authenticatedUser: authenticatedUser, isAdmin: true,isAssociateAdmin: false);
        }
        else   if (authenticatedUser.roleList?[i] == "associate_admin") {
          await authentication.saveAuthenticatedUser(
              authenticatedUser: authenticatedUser, isAssociateAdmin: true,isAdmin: false);
        }
        else if (authenticatedUser.roleList?[i] == "staff") {
          await authentication.saveAuthenticatedUser(
              authenticatedUser: authenticatedUser, isAdmin: false);
        }
      }
      authenticatedTokenList.add(authenticatedUser);
      await authentication.saveAuthenticatedToken(
          authenticatedTokenData: authenticatedTokenList);
      print("roleesssss adminnn ${authentication.isAdmin}");
      print("roleesssss adminnn ${authenticatedTokenList}");

      return DoubleResponse(
          response.data['status'] == "success", response.data['message']);
    }
    return DoubleResponse(
        response.data['status'] == "success", response.data['message']);
  }

  //switch account get data
  Future<DataResponse> switchUserAccountGetData({required String token}) async {
    User userData = User();
    final response = await client.get(
        "https://api-uat-user.sidrabazar.com/user-director_check-auth-token/admin",
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'token $token',
          },
        ));
    print("switch user dataSource ${response.data}");


    authentication.clearAuthenticatedUser();
    // authentication.clearAuthenticatedTokens();

    if (response.data['status'] == 'success') {
      userData = User.fromJson((response.data['data']));
      print("user dataaaaaa !!!!! ${userData.fname}");
      if (userData.code != null) {
        for (int i = 0; i < userData.roleList2!.length;
        i++) {

          if (userData.roleList2?[i] == "admin") {
            await authentication.saveAuthenticatedUser(authenticatedUser: userData,isAdd: false,
                isAdmin: true,isAssociateAdmin: false);
            // await authentication.saveAuthenticatedUser(
            //     authenticatedUser: authenticatedUser,);
          }
          else   if (userData.roleList2?[i] == "associate_admin") {
            await authentication.saveAuthenticatedUser(authenticatedUser: userData,isAdd: false,
                isAdmin: false,isAssociateAdmin: true);
            // await authentication.saveAuthenticatedUser(
            //     authenticatedUser: authenticatedUser, isAssociateAdmin: true,isAdmin: false);
          }
          else if(userData.roleList2?[i] == "staff"){
            await authentication.saveAuthenticatedUser(authenticatedUser: userData,isAdd: false,
                isAdmin: false);
            // await authentication.saveAuthenticatedUser(
            //     authenticatedUser: authenticatedUser, isAdmin: false);
          }
        }

      }
    }
    print("authhhhh user ${authentication.authenticatedUser.token}");
    return DataResponse(data: userData, error: response.data['message']);
  }

  //picking list
  Future<PaginatedResponse> getPicklist(bool? isAssign) async {
    List<ListOrdersModel> tasktypeList = [];
    final response = await client.get(
      isAssign == true ? OrderAppUrls.assignListUrl : OrderAppUrls.pickListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    (response.data['data']['results'] as List).forEach((element) {
      tasktypeList.add(ListOrdersModel.fromJson(element));
    });
    return PaginatedResponse(tasktypeList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  //pack list
  Future<PaginatedResponse> getPacklist() async {
    List<ListOrdersModel> packList = [];
    print("URL:${OrderAppUrls.packListUrl}");

    try {
      final response = await client.get(
        OrderAppUrls.packListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        packList.add(ListOrdersModel.fromJson(element));
      });
      return PaginatedResponse(packList, response.data['data']['next'],
          response.data['data']['count'].toString(),
          previousUrl: response.data['data']['previous']);
    } catch (h) {
      print("$h");
    }
    final response = await client.get(
      OrderAppUrls.packListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print(response);
    (response.data['data']['results'] as List).forEach((element) {
      packList.add(ListOrdersModel.fromJson(element));
    });
    return PaginatedResponse(packList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  //assign list
  Future<PaginatedResponse> getAssignList() async {
    List<ListOrdersModel> packList = [];
    print("URL:${OrderAppUrls.packListUrl}");

    try {
      final response = await client.get(
        OrderAppUrls.packListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
          },
        ),
      );
      (response.data['data']['results'] as List).forEach((element) {
        packList.add(ListOrdersModel.fromJson(element));
      });
      return PaginatedResponse(packList, response.data['data']['next'],
          response.data['data']['count'].toString(),
          previousUrl: response.data['data']['previous']);
    } catch (h) {
      print("$h");
    }
    final response = await client.get(
      OrderAppUrls.packListUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print(response);
    (response.data['data']['results'] as List).forEach((element) {
      packList.add(ListOrdersModel.fromJson(element));
    });
    return PaginatedResponse(packList, response.data['data']['next'],
        response.data['data']['count'].toString(),
        previousUrl: response.data['data']['previous']);
  }

  //taskread
  Future<ListOrdersModel> getTaskReadData(int id) async {
    ListOrdersModel selectedItemDetails;
    print("Task Read:${ClusterUrls.taskread + id.toString()}");
    final response = await client.get(
      ClusterUrls.taskread + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print(response.data);
    selectedItemDetails = ListOrdersModel.fromJson((response.data['data']));

    return selectedItemDetails;
  }

  //assigntask
  Future<ListOrdersModel> getAssignCount(int? id) async {
    ListOrdersModel countTask;
    id = 1;
    print("Task Assign Read:${ClusterUrls.taskCountUrl + id.toString()}");
    final response = await client.get(
      ClusterUrls.taskread + id.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print(response.data);
    countTask = ListOrdersModel.fromJson((response.data['data']));

    return countTask;
  }

  // update order
  Future<DoubleResponse> moveToPicking(CreatePickingModel? updateOrder) async {
    List<Map<String, dynamic>> map = [];

    print("pickkk api is called ${updateOrder?.orderCode}");
    print(
        "pickkk api is called lines ${updateOrder?.lineItems?[0].variantCode}");
    for (var i = 0; i < updateOrder!.lineItems!.length; i++) {
      map.add({
        "id": updateOrder.lineItems?[i].id,
        "payment_status": updateOrder.lineItems?[i].paymentStatus,
        "variant_code": updateOrder.lineItems?[i].variantCode,
        "total_quantity": updateOrder.lineItems?[i].totalQuantity,
        "amount": updateOrder.lineItems?[i].amount,
        "delivery_slot": updateOrder.lineItems?[i].deliverySlot,
        "status": updateOrder.lineItems?[i].status,
        "delivery_address": updateOrder.lineItems?[i].deliveryAddress
      });
    }
    print("pickkk api is called");
    final response = await client.post(
      OrderAppUrls.createPickingUrl,
      data: {
        "order_code": updateOrder.orderCode,
        "inventory": updateOrder.inventory,
        "created_by": updateOrder.createdBy,
        "order_status": updateOrder.orderStatus,
        "total_amount": updateOrder.totalAmount,
        "line_items": map
        // [
        //   {
        //     "id": 123,
        //     "payment_status": "not paid",
        //     "variant_code": "VART001",
        //     "total_quantity": "2",
        //     "amount": "1000",
        //     "delivery_slot": "12 am to 1 pm 12-2-22",
        //     "status": "Shipped",
        //     "delivery_address": "12"
        //   }
        // ]
      },
      //  updateOrder,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'Auth_Token=91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print("Responseeeee ${response.data}");
    return DoubleResponse(
        response.data['status'] == 'success', response.data['message']);
  }

  // move to packing
  Future<DoubleResponse> moveToPacking(
      String? orderCode,
      List<int>? orderLineIds,
      bool? isPacking,
      bool? isAssignment,
      String organizationCode,
      String? employeeCode) async {
    print("api calleeddddd");
    isPacking == true
        ? print(OrderAppUrls.createAssignmentUrl): isAssignment == true?print(OrderAppUrls.assignToPartnerUrl)
        : print(OrderAppUrls.createPackingUrl);
    final response = await client.post(
      // "https://api-order-management.hilalcart.com/order-process/order-process-items/picking",
      isPacking == true
          ? OrderAppUrls.createAssignmentUrl
          : isAssignment == true
          ? OrderAppUrls.assignToPartnerUrl
          : OrderAppUrls.createPackingUrl,
      data: isPacking == true
          ? {"order_code": orderCode, "id_list": orderLineIds}
          : isAssignment == true
          ? {
        "order_code": orderCode,
        "company_code": organizationCode,
        "user_code": employeeCode,
        "id_list": orderLineIds
      }
          : {"order_code": orderCode, "id_list": orderLineIds},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '91b5901569e62b37d0098fb0850ef14fad3945a1',
        },
      ),
    );
    print("Responseeeee move to packkinggg${response.data}");
    return DoubleResponse(
        response.data['status'] == 'success', response.data['message']);
  }
}