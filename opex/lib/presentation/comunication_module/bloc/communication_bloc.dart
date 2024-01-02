import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:cluster/presentation/comunication_module/communication_repo.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:equatable/equatable.dart';

part 'communication_event.dart';
part 'communication_state.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  CommunicationBloc() : super(CommunicationInitial());
  final CommunicationDatasource _productData = CommunicationDatasource();
  final CommunicationRepository _productRepo = CommunicationRepository();
  @override
  Stream<CommunicationState> mapEventToState(
    CommunicationEvent event,
  ) async* {
    if (event is GetSearchedUserEvent) {
      yield* getSearchedUsers(
          searchQuery: event.searchQuery, token: event.token);
    } else if (event is AddAFriendUserEvent) {
      yield* addAFriendUser(
          token: event.token,
          email: event.email,
          fname: event.fname,
          lname: event.lname,
          photo: event.photo,
          usercode:event.usercode);
    } else if (event is GetChatListEvent) {
      yield* getChatList(token: event.token);
    } else if (event is GetFilterdChatListEvent) {
      yield* getFilteredChatLisBloc(
          chatFilter: event.chatFilter, token: event.token);
    }
  }

  Stream<CommunicationState> getSearchedUsers(
      {required String searchQuery, required String token}) async* {
    yield GetSearchedUsersLoading();

    final dataResponse =
        await _productData.getSearchedUsers(searchQuery, token);
    if (dataResponse.isNotEmpty) {
      yield GetSearchedUsersSuccess(searchedUsers: dataResponse);
    } else {
      yield GetSearchedUsersFailed();
    }
  }

  Stream<CommunicationState> addAFriendUser(
      {required String token,
      required String fname,
      required String lname,
      required String email,
      required String photo,
      required String usercode}) async* {
    yield AddAFriendUserLoadig();
    final dataResponse =
        await _productData.addAFriendUser(token, fname, lname, email, photo,usercode);
    if (dataResponse.id!=null) {
      print("mlskmdksucess");
      yield AddAFriendUserSuccess(chatListData1: dataResponse);
    } else {
      print("kjhkjh failed");
      yield AddAFriendUserFailed(error:"Failed");
    }
  }

  Stream<CommunicationState> getChatList({required String token}) async* {
    yield GetChatListLoading();
    final dataResponse = await _productData.getChatListData(token);
    if (dataResponse.isNotEmpty) {
      yield GetChatListSuccess(chatList: dataResponse);
    } else {
      yield GetChatListFailed();
    }
  }

  Stream<CommunicationState> getFilteredChatLisBloc(
      {required String token, required String chatFilter}) async* {
    yield GetChatListLoading();
    final dataResponse =
        await _productData.getFilteredChatListData(token, chatFilter);
    if (dataResponse.isNotEmpty) {
      yield GetChatListSuccess(chatList: dataResponse);
    } else {
      yield GetChatListFailed();
    }
  }
}
