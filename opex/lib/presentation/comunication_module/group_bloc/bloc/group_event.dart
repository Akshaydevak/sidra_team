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
  final List<GetEmployeeList> userIdList;
  final String groupName;
  final String groupPhotoUrl;
  final String description;
  const CreateGroupEvent( 
      {required this.groupName,
      required this.userIdList,
      required this.token,
      required this.groupPhotoUrl,
      required this.description});
}

class GroupProfileGet extends GroupEvent {
  final String chatid;
  final String token;
  const GroupProfileGet({required this.chatid, required this.token});
}
class GroupProfileGetdata extends GroupEvent {
  final String chatid;
  final String token;
  const GroupProfileGetdata({required this.chatid, required this.token});
}

class GroupLeaveEvent extends GroupEvent {
  final String token;
  final String roomId;
  const GroupLeaveEvent({required this.token, required this.roomId});
}

class GroupMemberAddEvent extends GroupEvent {
  final String token;
  final String chatId;
  final String userId;
  final String emailid;
  final String fname;
  final String lname;
  final String photo;
  const GroupMemberAddEvent({required this.token, required this.chatId, required this.userId,required this.emailid,required this.fname,required this.lname,required this.photo});
}

class GroupMemberDeleteEvent extends GroupEvent {
  final String token;
  final String chatId;
  final String userId;
  const GroupMemberDeleteEvent({required this.token, required this.chatId, required this.userId});
}
class GroupProfileEditEvent extends GroupEvent {
  final String token;
  final String chatId;
  final String groupname;
  final String groupdescription;
  final String? image; 
  const GroupProfileEditEvent({required this.token, required this.chatId, required this.groupname,required this.groupdescription,this.image});
}
class GroupUploadPictureEvent extends GroupEvent {
  final Uint8List image;

  const GroupUploadPictureEvent({required this.image});
}
// class GroupUploadPictureEvent extends GroupEvent {
//   final File image;
//
//   const GroupUploadPictureEvent({required this.image});
// }