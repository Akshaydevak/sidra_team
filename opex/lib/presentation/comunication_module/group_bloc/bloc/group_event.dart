part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GetAllRegisteredUsersEvent extends GroupEvent {
  final String token;
  const GetAllRegisteredUsersEvent(this.token);
}

class CreateGroupEvent extends GroupEvent {
  final String token;
  final List<UserModelInventory> userIdList;
  final String groupName;
  final String groupPhotoUrl;
  const CreateGroupEvent(
      {required this.groupName,
      required this.userIdList,
      required this.token,
      required this.groupPhotoUrl});
}

class GroupProfileGet extends GroupEvent {
  final String chatid;
  final String token;
  const GroupProfileGet({required this.chatid, required this.token});
}

class GroupLeaveEvent extends GroupEvent {
  final String token;
  final String roomId;
  const GroupLeaveEvent({required this.token, required this.roomId});
}


