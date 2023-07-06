part of 'order_status_bloc.dart';




abstract class OrderStatusState extends Equatable {
  const OrderStatusState();

  @override
  List<Object> get props => [];
}
//move to picking
class MoveOrderToPickingInitial extends OrderStatusState {}

class MoveOrderToPickingLoading extends OrderStatusState {}

class MoveOrderToPickingSuccess extends OrderStatusState {
  final String? message;

  const MoveOrderToPickingSuccess(this.message);
}
class MoveOrderToPickingFailed extends OrderStatusState {
  final String? message;

  const MoveOrderToPickingFailed(this.message);
}
//move to packing
class MoveOrderToPackingInitial extends OrderStatusState {}

class MoveOrderToPackingLoading extends OrderStatusState {}

class MoveOrderToPackingSuccess extends OrderStatusState {
  final String? message;

  const MoveOrderToPackingSuccess(this.message);
}
class MoveOrderToPackingFailed extends OrderStatusState {
  final String? message;

  const MoveOrderToPackingFailed(this.message);
}
//employee list
class GetEmployeeListInitial extends OrderStatusState {}

class GetEmployeeListLoading extends OrderStatusState {}

class GetEmployeeListSuccess extends OrderStatusState {
  final List<ListOrdersModel> ordersList;

  const GetEmployeeListSuccess(this.ordersList);
}
class GetEmployeeListFailed extends OrderStatusState {}


