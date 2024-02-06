part of 'paginatedchat_bloc.dart';

abstract class PaginatedchatEvent extends Equatable {
  const PaginatedchatEvent();

  @override
  List<Object> get props => [];
}

class PaginatedChatGetEvent extends PaginatedchatEvent {
  final String grpchatId;
  final String chatId;
  final String token;
  final int pageNo;
  const PaginatedChatGetEvent(
      {required this.token,required this.grpchatId, required this.pageNo, required this.chatId});
}
