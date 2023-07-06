part of 'order_list_bloc.dart';



abstract class OrderListState extends Equatable {
  const OrderListState();

  @override
  List<Object> get props => [];
}
//jobList
class GetOrderListInitial extends OrderListState {}

class GetOrderListLoading extends OrderListState {}

class GetOrderListSuccess extends OrderListState {
  final List<ListOrdersModel> ordersList;

  const GetOrderListSuccess(this.ordersList);
}

class GetOrderListFailed extends OrderListState {}
// //employee list
// class GetEmployeeListInitial extends OrderListState {}

// class GetEmployeeListLoading extends OrderListState {}

// class GetEmployeeListSuccess extends OrderListState {
//   final List<ListOrdersModel> ordersList;

//   const GetEmployeeListSuccess(this.ordersList);
// }

class GetEmployeeListFailed extends OrderListState {}


class GetPickListInitial extends OrderListState {}

class GetPickListLoading extends OrderListState {}

class GetPickListSuccess extends OrderListState {
  final List<ListOrdersModel> ordersList;

  const GetPickListSuccess(this.ordersList);
}

class GetPickListFailed extends OrderListState {}


class GetPackListInitial extends OrderListState {}

class GetPackListLoading extends OrderListState {}

class GetPackListSuccess extends OrderListState {
  final List<ListOrdersModel> ordersList;

  const GetPackListSuccess(this.ordersList);
}

class GetPackListFailed extends OrderListState {}