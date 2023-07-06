part of 'auth_bloc.dart';








abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
//jobList
class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String? message;
  // final LogInData? logData;

  const LoginSuccess(this.message, );
}

class LoginFailed extends AuthState {}
// //employee list
// class GetEmployeeListInitial extends AuthState {}

// class GetEmployeeListLoading extends AuthState {}

// class GetEmployeeListSuccess extends AuthState {
//   final List<ListOrdersModel> ordersList;

//   const GetEmployeeListSuccess(this.ordersList);
// }

