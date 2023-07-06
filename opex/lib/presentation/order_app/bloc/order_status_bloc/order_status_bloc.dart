import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:equatable/equatable.dart';

part 'order_status_event.dart';
part 'order_status_state.dart';

class OrderStatusBloc extends Bloc<OrderStatusEvent, OrderStatusState> {
      final OredrRepo _taskRepo = OredrRepo();

  OrderStatusBloc() : super(MoveOrderToPickingInitial());
     @override
  Stream<OrderStatusState> mapEventToState(OrderStatusEvent event) async* {
    if (event is MoveOrderToPicking) {
      yield* moveToPicking(event.updateOrder);
    }
    else if (event is MoveOrderToPacking) {
      yield* moveToPacking(event.orderCode,event.orderLineIds,event.isPacking,event.isAssignment,event.organizationCode,event.employeeCode);
    }
     else if (event is GetEmployeeListEvent) {
      yield* getEmployeeList();
    }
    // else if (event is GetPackListEvent) {
    //   yield* getPacklist();
    // }
   
  
  }
  Stream<OrderStatusState> getEmployeeList() async* {
    yield GetEmployeeListInitial();

    final dataResponse = await _taskRepo.getEmployeeList();

    if (dataResponse.data.isNotEmpty) {
      yield GetEmployeeListSuccess(dataResponse.data);
    } else {
      yield GetEmployeeListFailed();
    }
  }
   Stream<OrderStatusState> moveToPicking(CreatePickingModel? updateOrder)async* {
    yield MoveOrderToPickingInitial();

    final dataResponse = await _taskRepo.moveToPicking(updateOrder);

    if (dataResponse.data) {
      yield MoveOrderToPickingSuccess(dataResponse.error);
    } else {
      yield MoveOrderToPickingFailed(dataResponse.error);
    }
  }
   Stream<OrderStatusState> moveToPacking(String? orderCode, List<int>? orderLineIds,bool? isPacking,bool? isAssignment,String? organizationCode,String? employeeCode)async* {
    yield MoveOrderToPickingInitial();

    final dataResponse = await _taskRepo.moveToPacking(
      orderCode,orderLineIds,isPacking,isAssignment,organizationCode, employeeCode
    );

    if (dataResponse.data) {
      yield MoveOrderToPickingSuccess(dataResponse.error);
    } else {
      yield MoveOrderToPickingFailed(dataResponse.error);
    }
  }
}

