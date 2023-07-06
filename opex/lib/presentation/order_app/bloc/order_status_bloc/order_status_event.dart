part of 'order_status_bloc.dart';

abstract class OrderStatusEvent extends Equatable {
  const OrderStatusEvent();

  @override
  List<Object> get props => [];
}
class MoveOrderToPicking extends OrderStatusEvent {
  final CreatePickingModel? updateOrder;
  const MoveOrderToPicking({this.updateOrder});
}
class MoveOrderToPacking extends OrderStatusEvent {
  final bool? isPacking;
  final bool? isAssignment;
  final String? orderCode;
  final String? organizationCode;
  final String? employeeCode;
  final List<int>? orderLineIds;
  const MoveOrderToPacking({this.isPacking, this.orderCode, this.orderLineIds,this.isAssignment, this.organizationCode, this.employeeCode, });
}
class GetEmployeeListEvent extends OrderStatusEvent {
  const GetEmployeeListEvent();
}