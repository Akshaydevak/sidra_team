import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/User_Model/user_models.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:cluster/presentation/order_app/data/order_src.dart';
import 'package:equatable/equatable.dart';

import '../../../task_operation/employee_model/employee_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final OredrRepo _taskRepo = OredrRepo();
  final OrderDataSource _dataSource = OrderDataSource();
  AuthBloc() : super(LoginInitial());
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield* login(event.email,event.password,event.code);
    }
    else if (event is SwitchUserAuthGet) {
      yield* switchUserAuthget(token: event.token);
    }
    // else if (event is GetEmployeeListEvent) {
    //   yield* getEmployeeList();
    // }

  }
  Stream<AuthState> login(String? email,String? password, String? code)async* {
    yield LoginLoading();

    final dataResponse = await _taskRepo.login(email,password,code);

    if (dataResponse.hasData) {
      yield LoginSuccess(dataResponse.error);
    } else {
      yield LoginFailed();
    }
  }
  Stream<AuthState> switchUserAuthget({String? token}) async* {
    yield SwitchUserAuthGetLoading();
    final dataResponse = await _dataSource.switchUserAccountGetData(
        token: token ?? "");
    if (dataResponse.hasData) {
      yield SwitchUserAuthGetSuccess(userData: dataResponse.data);
    } else {
      yield SwitchUserAuthGetFailed(error: dataResponse.error);
    }
  }
}
