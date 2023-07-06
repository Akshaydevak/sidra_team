part of 'dummy_login_bloc.dart';

abstract class DummyLoginState extends Equatable {
  const DummyLoginState();

  @override
  List<Object> get props => [];
}

class DummyLoginInitial extends DummyLoginState {}

class DummySignInLoading extends DummyLoginState {}

class DummySignInSuccess extends DummyLoginState {
  final String? token;
  const DummySignInSuccess({
    required this.token,
  });
}

class DummySignInFailed extends DummyLoginState {
  final String error;
  const DummySignInFailed({required this.error});
}

class DummySignUpLoading extends DummyLoginState {}

class DummySignUpSuccess extends DummyLoginState {
  final String succesMessage;
  const DummySignUpSuccess({required this.succesMessage});
}

class DummySignupFailed extends DummyLoginState {
  final String error;
  const DummySignupFailed({required this.error});
}

class TokenCreationCommunicationLoading extends DummyLoginState {}

class TokenCreationCommunicationSuccess extends DummyLoginState {
  final String token;
  const TokenCreationCommunicationSuccess({required this.token});
}

class TokenCreationCommunicationFailed extends DummyLoginState {}
