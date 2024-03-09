import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/comunication_module/communication_datasource.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

part 'attachment_event.dart';
part 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  AttachmentBloc() : super(AttachmentInitial());
  final CommunicationDatasource _productData = CommunicationDatasource();
  @override
  Stream<AttachmentState> mapEventToState(AttachmentEvent event) async* {
    // if (event is UploadPictureEvent) {
    //   yield* uploadImageMap(image: event.image);
    // }
    if (event is UploadPictureEvent) {
      yield* uploadImageMap(image: event.image);
    }


    else if (event is UploadVideoEvent) {
      yield* uploadVideoMap(video: event.video);
    } else if (event is UploadFilesEvent) {
      yield* uploadFilesMap(files: event.files);
    } else if (event is UploadAudioEvent) {
      yield* uploadAudioMap(files: event.audio);
    } else if (event is UploadGroupProfilePicEvent) {
      yield* updateGroupPictureMap(imag: event.image);
    }else if(event is UploadLiveAudioEvent){
      yield* uploadLiveAudioMap(files: event.audio);
    }
    else if (event is GroupProfileAttachmentsGet) {
      yield* getGroupProfileAttachmentsDetails(
          chatId: event.chatId, token: event.token);
    }
  }

  // Stream<AttachmentState> uploadImageMap(
  //     {required File image}) async* {
  //   yield UploadPictureLoading();
  //   final dataResponse = await _productData.uploadImageData1(img: image);
  //   if (dataResponse.isNotEmpty) {
  //     yield UploadPictureSuccess(upload: dataResponse);
  //   } else {
  //     yield const UploadPictureFailed(error: "failed");
  //   }
  // }
  Stream<AttachmentState> uploadImageMap(
      {required Uint8List image}) async* {
    yield UploadPictureLoading();
    final dataResponse = await _productData.uploadImageData1(img: image);
    if (dataResponse.isNotEmpty) {
      yield UploadPictureSuccess(upload: dataResponse);
    } else {
      yield const UploadPictureFailed(error: "failed");
    }
  }

  Stream<AttachmentState> uploadVideoMap(
      {required FilePickerResult video}) async* {
    yield UploadVideoLoading();
    final dataResponse = await _productData.uploadImageData(img: video);
    if (dataResponse.isNotEmpty) {
      yield UploadVideoSuccess(upload: dataResponse);
    } else {
      yield UploadVideoFailed();
    }
  }

  Stream<AttachmentState> uploadFilesMap(
      {required FilePickerResult files}) async* {
    yield UploadFilesLoading();
    final dataResponse = await _productData.uploadImageData(img: files);
    if (dataResponse.isNotEmpty) {
      yield UploadFilesSuccess(upload: dataResponse);
    } else {
      yield UploadFilesFailed();
    }
  }

  Stream<AttachmentState> uploadAudioMap(
      {required FilePickerResult files}) async* {
    yield UploadAudioLoading();
    final dataResponse = await _productData.uploadImageData(img: files);
    if (dataResponse.isNotEmpty) {
      yield UploadAudioSuccess(upload: dataResponse);
    } else {
      yield UploadAudioFailed();
    }
  }
   Stream<AttachmentState> uploadLiveAudioMap(
      {required File files}) async* {
    yield UploadLiveAudioLoading();
    final dataResponse = await _productData.uploadLiveAudioData(img:files );
    if (dataResponse.isNotEmpty) {
      yield UploadLiveAudioSuccess(upload: dataResponse);
    } else {
      yield UploadLiveAudioFailed();
    }
  }


  Stream<AttachmentState> updateGroupPictureMap({
    required File imag,
    // required CroppedFile? imag,
  }) async* {
    yield UploadGroupProfilePicLoading();
    final dataResponse = await _productData.updateGroupPicture(imag);
    if (dataResponse.data != null) {
      yield UploadGroupProfilePicSuccess(
          message: dataResponse.error, uploadLink: dataResponse.data);
    } else {
      yield UploadGroupProfilePicFailed(error: dataResponse.error);
    }
  }
   Stream<AttachmentState> getGroupProfileAttachmentsDetails(
      {String? token, String? chatId}) async* {
    yield GetGroupAttachmentsInProfileLoading();
    final dataResponse =
        await _productData.getGroupAttachmentsData(token ?? "", chatId ?? "");
    if (dataResponse.media != null) {
      yield GetGroupAttachmentsInProfileSuccess(groupProfileGet: dataResponse);
    } else {
      yield GetGroupAttchmentsInProfileFailed();
    }
  }

}
