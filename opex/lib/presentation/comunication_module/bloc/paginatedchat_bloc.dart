import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:equatable/equatable.dart';

part 'paginatedchat_event.dart';
part 'paginatedchat_state.dart';

class PaginatedchatBloc extends Bloc<PaginatedchatEvent, PaginatedchatState> {
  PaginatedchatBloc() : super(PaginatedchatInitial());
  final CommunicationDatasource _productData = CommunicationDatasource();
  @override
  Stream<PaginatedchatState> mapEventToState(PaginatedchatEvent event) async* {
    if (event is PaginatedChatGetEvent) {
      yield* getPaginatedChat(
          token: event.token, pageNo: event.pageNo, chatId: event.chatId);
    }
  }

  Stream<PaginatedchatState> getPaginatedChat(
      {required String token,
      // required String userId,
      required int pageNo, required String chatId}) async* {
    yield PaginatedChatLoading();
    final dataResponse =
        await _productData.getChatScreenData(token,chatId, pageNo);
    if (dataResponse.messages != null) {
      yield PaginatedChatSuccess(chatData: dataResponse);
    } else {
      yield PaginatedChatFailed();
    }
  }
}
