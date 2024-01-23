import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummyuser_datasource.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummyuser_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dummy_login_event.dart';
part 'dummy_login_state.dart';

class DummyLoginBloc extends Bloc<DummyLoginEvent, DummyLoginState> {
  final _userProvider = DummyUserProvider();
  final userDataSource = DummyUserDataSource();
  DummyLoginBloc() : super(DummyLoginInitial());
  @override
  Stream<DummyLoginState> mapEventToState(DummyLoginEvent event) async* {
    if (event is DummySignInEvent) {
      yield* mapDummySignInToState(
          email: event.email, password: event.password);
    } else if (event is DummySignUpEvent) {
      yield* mapDummySignUpToState(
          email: event.email,
          password: event.password,
          userName: event.userName);
    } else if (event is TokenCreationCommunicationEvent) {
      yield* mapTokenCreationCommunicationToState();
    }
  }

  Stream<DummyLoginState> mapTokenCreationCommunicationToState() async* {
    yield TokenCreationCommunicationLoading();
    final dataResponse = await userDataSource.tokenCreationCommunicationData();
    if (dataResponse.isNotEmpty) {
      yield TokenCreationCommunicationSuccess(token: dataResponse);
    } else {
      yield TokenCreationCommunicationFailed();
    }
  }

  Stream<DummyLoginState> mapDummySignInToState({
    required String email,
    required String password,
  }) async* {
    yield DummySignInLoading();

    final dataResponse = await userDataSource.dummyUserLoginDataSource(
      email: email,
      password: password,
    );
    if (dataResponse.data != null) {
      yield DummySignInSuccess(
        token: dataResponse.data,
      );
    } else {
      yield DummySignInFailed(error: dataResponse.error ?? "");
    }
  }

  Stream<DummyLoginState> mapDummySignUpToState(
      {required String email,
      required String password,
      required String userName}) async* {
    yield DummySignUpLoading();
    final dataResponse = await userDataSource.dummyUserSignUpDataSource(
        email: email, password: password, userName: userName);
    if (dataResponse.data1 == "success") {
      yield DummySignUpSuccess(succesMessage: "signup success");
    } else {
      DummySignupFailed(error: "signup failed");
    }
  }
}
