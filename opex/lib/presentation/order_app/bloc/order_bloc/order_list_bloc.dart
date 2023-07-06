import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:equatable/equatable.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
    final OredrRepo _taskRepo = OredrRepo();

  OrderListBloc() : super(GetOrderListInitial());
     @override
  Stream<OrderListState> mapEventToState(OrderListEvent event) async* {
    if (event is GetOrderListEvent) {
      yield* getOrderList();
    }
    else if (event is GetPickListEvent) {
      yield* getPicklist(event.isAssign);
    }
    else if (event is GetPackListEvent) {
      yield* getPacklist();
    }
    // else if (event is GetEmployeeListEvent) {
    //   yield* getEmployeeList();
    // }
   
  }
    Stream<OrderListState> getOrderList() async* {
    yield GetOrderListLoading();

    final dataResponse = await _taskRepo.listOrdersModel();

    if (dataResponse.data!=null) {
      yield GetOrderListSuccess(dataResponse.data);
    } else {
      yield GetOrderListFailed();
    }
  } Stream<OrderListState> getPicklist(bool? isAssign) async* {
    yield GetPickListLoading();

    final dataResponse = await _taskRepo.getPicklist(isAssign);

    if (dataResponse.data.isNotEmpty) {
      yield GetPickListSuccess(dataResponse.data);
    } else {
      yield GetPickListFailed();
    }
  }
    Stream<OrderListState> getPacklist() async* {
    yield GetPackListLoading();

    final dataResponse = await _taskRepo.getPacklist();
    if (dataResponse.data.isNotEmpty) {
      yield GetPackListSuccess(dataResponse.data);
    } else {
      yield GetPackListFailed();
    }
  }
}
