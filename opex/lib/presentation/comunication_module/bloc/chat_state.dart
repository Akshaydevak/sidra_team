part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatScreenGetLoading extends ChatState {}

class ChatScreenGetSuccess extends ChatState {
  final List<ChatMessagaeData> chatData;
  const ChatScreenGetSuccess({required this.chatData});
}

class ChatScreenGetFailed extends ChatState {}

class MessagedeleteInitial extends ChatState {}

class MessagedeleteLoading extends ChatState {}

class MessagedeleteSuccess extends ChatState {
  final String msg1;
  const MessagedeleteSuccess({required this.msg1});
}

class MessagedeleteFailed extends ChatState {}
