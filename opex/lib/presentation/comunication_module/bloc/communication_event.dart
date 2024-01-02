part of 'communication_bloc.dart';

abstract class CommunicationEvent extends Equatable {
  const CommunicationEvent();

  @override
  List<Object> get props => [];
}

class GetSearchedUserEvent extends CommunicationEvent {
  final String searchQuery;
  final String token;
  const GetSearchedUserEvent({required this.searchQuery, required this.token});
}

class AddAFriendUserEvent extends CommunicationEvent {
  final String token;
  final String fname;
  final String lname;
  final String email;
  final String photo;
  final String usercode;
  const AddAFriendUserEvent(
      {required this.token,
      required this.fname,
      required this.lname,
      required this.email,
      required this.photo,
      required this.usercode
      });
}

class GetChatListEvent extends CommunicationEvent {
  final String token;
  const GetChatListEvent({required this.token});
}

class GetFilterdChatListEvent extends CommunicationEvent {
  final String token;
  final String chatFilter;
  const GetFilterdChatListEvent(
      {required this.token, required this.chatFilter});
}
