part of 'auth_bloc.dart';




abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

}
class LoginEvent extends AuthEvent {
  final String? email;
  final String? password;
  final String? code;
  const LoginEvent({this.email, this.password, this.code});
}
// class GetEmployeeListEvent extends AuthEvent {
//   const GetEmployeeListEvent();
// }
class GetPickListEvent extends AuthEvent {
  final bool? isAssign;
  const GetPickListEvent({this.isAssign});
}
class GetPackListEvent extends AuthEvent {
  const GetPackListEvent();
}
class SwitchUserAuthGet extends AuthEvent {
  final String? token;
  const SwitchUserAuthGet({this.token});
}
