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
      yield* getChatScreen(token: event.token,pageNo: event.pageNo,chatId: event.chatId,grpchatId: event.grpchatId,userId:event.userId);
    }
    if(event is Messagedeleteevent){
      yield* deletemsg(token: event.token,chatId: event.chatId,msgId:event.msgId);
    }
  }
  Stream<ChatState> getChatScreen(
      {required String token,required String chatId,required String grpchatId, required int pageNo,required String userId}) async* {
        yield ChatScreenGetLoading();
        final dataResponse=await _productData.getChatScreenData(token, chatId,grpchatId,pageNo,userId);
        if(dataResponse.isNotEmpty){
          yield ChatScreenGetSuccess(chatData: dataResponse);
        }else{
          yield ChatScreenGetFailed();
        }
      }
       Stream<ChatState> deletemsg(
      {required String token,required String chatId,required int msgId}) async* {
        yield MessagedeleteLoading();
        final dataResponse=await _productData.deleteMessage(chatId: chatId, msgId: msgId, token: token);
        if(dataResponse == "Message deleted successfully"){
          yield MessagedeleteSuccess(msg1:"Message deleted");
        }else{
          yield MessagedeleteFailed();
        }
      }
      
}
 

