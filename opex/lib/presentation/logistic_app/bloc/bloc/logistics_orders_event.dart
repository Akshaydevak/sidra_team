part of 'logistics_orders_bloc.dart';



abstract class LogisticsOrdersEvent extends Equatable {
  const LogisticsOrdersEvent();

  @override
  List<Object> get props => [];

}
class GetLogisticsOrdersEvent extends LogisticsOrdersEvent {
  const GetLogisticsOrdersEvent();
}
// class GetEmployeeListEvent extends LogisticsOrdersEvent {
//   const GetEmployeeListEvent();
// }
class GetPickListEvent extends LogisticsOrdersEvent {
  final bool? isAssign;
  const GetPickListEvent({this.isAssign});
}
class GetPackListEvent extends LogisticsOrdersEvent {
  const GetPackListEvent();
}

