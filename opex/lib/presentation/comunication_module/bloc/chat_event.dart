part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatScreenGetEvent extends ChatEvent {
  final String userId;
  final String token;
  final int pageNo;
  const ChatScreenGetEvent({required this.userId, required this.token,required this.pageNo});
}
