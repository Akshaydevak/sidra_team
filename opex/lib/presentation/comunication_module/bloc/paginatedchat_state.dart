part of 'paginatedchat_bloc.dart';

abstract class PaginatedchatState extends Equatable {
  const PaginatedchatState();

  @override
  List<Object> get props => [];
}

class PaginatedchatInitial extends PaginatedchatState {}

class PaginatedChatLoading extends PaginatedchatState {}

class PaginatedChatSuccess extends PaginatedchatState {
  final List<ChatMessagaeData> chatData;
  const PaginatedChatSuccess({required this.chatData});
}
class PaginatedChatFailed extends PaginatedchatState{}
