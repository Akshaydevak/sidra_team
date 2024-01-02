part of 'communication_bloc.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();

  @override
  List<Object> get props => [];
}

class CommunicationInitial extends CommunicationState {}

class GetSearchedUsersLoading extends CommunicationState {}

class GetSearchedUsersSuccess extends CommunicationState {
  final List<GetEmployeeList> searchedUsers;
  const GetSearchedUsersSuccess({required this.searchedUsers});
}

class GetSearchedUsersFailed extends CommunicationState {}

class AddAFriendUserLoadig extends CommunicationState {}

class AddAFriendUserSuccess extends CommunicationState {
  // final String successMessage;
  CommunicationUserModel chatListData1 = CommunicationUserModel();
  AddAFriendUserSuccess({required this.chatListData1});
}

class AddAFriendUserFailed extends CommunicationState {
  final String error;
  const AddAFriendUserFailed({required this.error});
}

class GetChatListLoading extends CommunicationState {}

class GetChatListSuccess extends CommunicationState {
  final List<CommunicationUserModel> chatList;
  const GetChatListSuccess({required this.chatList});
}

class GetChatListFailed extends CommunicationState {}

class GetFilteredChatListLoading extends CommunicationState {}

class GetFilteredChatListSuccess extends CommunicationState {
  final List<CommunicationUserModel> chatList;
  const GetFilteredChatListSuccess({required this.chatList});
}

class GetFilteredChatListFailed extends CommunicationState {}
