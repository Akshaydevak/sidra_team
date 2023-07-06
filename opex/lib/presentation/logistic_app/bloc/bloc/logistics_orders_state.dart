part of 'logistics_orders_bloc.dart';




abstract class LogisticsOrdersState extends Equatable {
  const LogisticsOrdersState();

  @override
  List<Object> get props => [];
}
//new orders list
class NewOrdersListInitial extends LogisticsOrdersState {}

class NewOrdersListLoading extends LogisticsOrdersState {}

class NewOrdersListSuccess extends LogisticsOrdersState {
  final List<ResultModel> ordersList;

  const NewOrdersListSuccess(this.ordersList);
}

class NewOrdersListFailed extends LogisticsOrdersState {}


