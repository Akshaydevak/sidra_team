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
