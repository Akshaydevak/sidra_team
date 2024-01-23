part of 'dummy_login_bloc.dart';

abstract class DummyLoginEvent extends Equatable {
  const DummyLoginEvent();

  @override
  List<Object> get props => [];
}

class TokenCreationCommunicationEvent extends DummyLoginEvent {}

class DummySignInEvent extends DummyLoginEvent {
  final String email;
  final String password;
  const DummySignInEvent({required this.email, required this.password});
}

class DummySignUpEvent extends DummyLoginEvent {
  final String email;
  final String userName;
  final String password;
  const DummySignUpEvent(
      {required this.email, required this.password, required this.userName});
}
