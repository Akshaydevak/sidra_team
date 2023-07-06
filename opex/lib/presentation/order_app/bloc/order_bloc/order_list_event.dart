



part of 'order_list_bloc.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();

  @override
  List<Object> get props => [];

}
class GetOrderListEvent extends OrderListEvent {
  const GetOrderListEvent();
}
// class GetEmployeeListEvent extends OrderListEvent {
//   const GetEmployeeListEvent();
// }
class GetPickListEvent extends OrderListEvent {
  final bool? isAssign;
  const GetPickListEvent({this.isAssign});
}
class GetPackListEvent extends OrderListEvent {
  const GetPackListEvent();
}

