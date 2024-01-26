part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatScreenGetEvent extends ChatEvent {
  final String grpchatId;
  final String chatId;
  final String token;
  final int pageNo;
  const ChatScreenGetEvent({required this.token,required this.pageNo,required this.chatId,required this.grpchatId});
}
