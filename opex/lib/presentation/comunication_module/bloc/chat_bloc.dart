import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());
  final CommunicationDatasource _productData = CommunicationDatasource();
  @override
  Stream<ChatState>mapEventToState(ChatEvent event)async*{
    if(event is ChatScreenGetEvent){
      yield* getChatScreen(token: event.token,pageNo: event.pageNo,chatId: event.chatId,grpchatId: event.grpchatId);
    }
  }
  Stream<ChatState> getChatScreen(
      {required String token,required String chatId,required String grpchatId, required int pageNo}) async* {
        yield ChatScreenGetLoading();
        final dataResponse=await _productData.getChatScreenData(token, chatId,grpchatId,pageNo);
        if(dataResponse.messages!=null){
          yield ChatScreenGetSuccess(chatData: dataResponse);
        }else{
          yield ChatScreenGetFailed();
        }
      }
}
