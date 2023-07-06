import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial());
  final CommunicationDatasource _productData = CommunicationDatasource();
  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if (event is GetAllRegisteredUsersEvent) {
      yield* getAllRegisteredUsers(event.token);
    } else if (event is CreateGroupEvent) {
      yield* createGroupBloc(
          groupName: event.groupName,
          token: event.token,
          uploadPicGroup: event.groupPhotoUrl,
          userIdList: event.userIdList);
    } else if (event is GroupProfileGet) {
      yield* getGroupProfileDetails(chatId: event.chatid, token: event.token);
    } else if (event is GroupLeaveEvent) {
      yield* groupLeaveMap(roomId: event.roomId, token: event.token);
    } 
  }

  Stream<GroupState> getAllRegisteredUsers(String? token) async* {
    yield GetAllRegisteredUsersLoading();
    final dataResponse = await _productData.getAllRegisteredUsers(token);
    if (dataResponse.isNotEmpty) {
      yield GetAllRegisteredUsersSuccess(registeresUsers: dataResponse);
    } else {
      yield GetAllRegisteredUsersFailed();
    }
  }

  Stream<GroupState> getGroupProfileDetails(
      {String? token, String? chatId}) async* {
    yield GetGroupProfileDetailsLoading();
    final dataResponse =
        await _productData.getGroupProfileGetData(token ?? "", chatId ?? "");
    if (dataResponse.groups != null) {
      yield GetGroupProfileDetailsSuccess(profileGetModel: dataResponse);
    } else {
      yield GetGroupProfileDetailsFailed();
    }
  }

 
  Stream<GroupState> createGroupBloc(
      {required String groupName,
      required String token,
      required String uploadPicGroup,
      required List<UserModelInventory> userIdList}) async* {
    yield CreateGroupLoading();
    final dataResponse = await _productData.createGroupData(
        groupName: groupName,
        token: token,
        userIdList: userIdList,
        groupPicUrl: uploadPicGroup);
    if (dataResponse.data1) {
      yield CreateGroupSuccess(successMessage: dataResponse.data2);
    } else {
      yield CreateGroupFailed(error: dataResponse.data2);
    }
  }

  Stream<GroupState> groupLeaveMap(
      {required String token, required String roomId}) async* {
    yield GroupLeaveLoading();
    final dataResponse =
        await _productData.groupLeaveData(roomId: roomId, token: token);
    if (dataResponse.data1) {
      yield GroupLeaveSuccess(successMessage: dataResponse.data2);
    } else {
      yield GroupLeaveFailed(error: dataResponse.data2);
    }
  }
}
