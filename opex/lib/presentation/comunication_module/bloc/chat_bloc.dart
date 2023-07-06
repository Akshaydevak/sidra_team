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
      yield* getChatScreen(token: event.token,userId: event.userId,pageNo: event.pageNo);
    }
  }
  Stream<ChatState> getChatScreen(
      {required String token, required String userId,required int pageNo}) async* {
        yield ChatScreenGetLoading();
        final dataResponse=await _productData.getChatScreenData(token, userId,pageNo);
        if(dataResponse.messages!=null){
          yield ChatScreenGetSuccess(chatData: dataResponse);
        }else{
          yield ChatScreenGetFailed();
        }
      }
}
