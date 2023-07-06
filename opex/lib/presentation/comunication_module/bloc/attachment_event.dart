part of 'attachment_bloc.dart';

abstract class AttachmentEvent extends Equatable {
  const AttachmentEvent();

  @override
  List<Object> get props => [];
}

class UploadPictureEvent extends AttachmentEvent {
  final FilePickerResult image;

  const UploadPictureEvent({required this.image});
}

class UploadVideoEvent extends AttachmentEvent {
  final FilePickerResult video;
  const UploadVideoEvent({required this.video});
}

class UploadFilesEvent extends AttachmentEvent {
  final FilePickerResult files;
  const UploadFilesEvent({required this.files});
}

class UploadAudioEvent extends AttachmentEvent {
  final FilePickerResult audio;
  const UploadAudioEvent({required this.audio});
}
class UploadLiveAudioEvent extends AttachmentEvent {
  final File audio;
  const UploadLiveAudioEvent({required this.audio});
}

class UploadGroupProfilePicEvent extends AttachmentEvent {
  final File image;
  const UploadGroupProfilePicEvent({required this.image});
}
class GroupProfileAttachmentsGet extends AttachmentEvent {
  final String chatId;
  final String token;
  const GroupProfileAttachmentsGet({required this.chatId, required this.token});
}