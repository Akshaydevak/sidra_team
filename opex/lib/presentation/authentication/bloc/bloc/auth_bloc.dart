import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../task_operation/employee_model/employee_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final OredrRepo _taskRepo = OredrRepo();

  AuthBloc() : super(LoginInitial());
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield* login(event.email,event.password,event.code);
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
}
