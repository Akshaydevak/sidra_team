import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/logistic_app/data/logistic_repo.dart';
import 'package:cluster/presentation/logistic_app/model/logistics_model.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:equatable/equatable.dart';

part 'logistics_orders_event.dart';
part 'logistics_orders_state.dart';

class LogisticsOrdersBloc
    extends Bloc<LogisticsOrdersEvent, LogisticsOrdersState> {
  final LogisticsRepo _taskRepo = LogisticsRepo();

  LogisticsOrdersBloc() : super(NewOrdersListInitial());
  @override
  Stream<LogisticsOrdersState> mapEventToState(
      LogisticsOrdersEvent event) async* {
    if (event is GetLogisticsOrdersEvent) {
      yield* getOrderList();
    }
      }
    Stream<LogisticsOrdersState> getOrderList() async* {
      yield NewOrdersListInitial();

      final dataResponse = await _taskRepo.listOrdersModel();

      if (dataResponse.data.isNotEmpty) {
        yield NewOrdersListSuccess(dataResponse.data);
      } else {
        yield NewOrdersListFailed();
      }
    }
  }

