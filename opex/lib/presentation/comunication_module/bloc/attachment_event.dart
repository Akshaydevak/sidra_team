part of 'attachment_bloc.dart';

abstract class AttachmentEvent extends Equatable {
  const AttachmentEvent();

  @override
  List<Object> get props => [];
}

// class UploadPictureEvent extends AttachmentEvent {
//   final File image;
//
//   const UploadPictureEvent({required this.image});
// }
class UploadPictureEvent extends AttachmentEvent {

  final Uint8List image ;
  const UploadPictureEvent( { required this.image,});
}
// class UploadVideoEvent extends AttachmentEvent {
//   final FilePickerResult video;
//   const UploadVideoEvent({required this.video});
// }

class UploadVideoEvent extends AttachmentEvent {
  final Uint8List video;
  const UploadVideoEvent({required this.video});
}

// class UploadFilesEvent extends AttachmentEvent {
//   final FilePickerResult files;
//   const UploadFilesEvent({required this.files});
// }

class UploadFilesEvent extends AttachmentEvent {
  final Uint8List files;
  final String name;
  const UploadFilesEvent({required this.files,required this.name});
}

class UploadAudioEvent extends AttachmentEvent {
  final FilePickerResult audio;
  const UploadAudioEvent({required this.audio});
}
// class UploadLiveAudioEvent extends AttachmentEvent {
//   final File audio;
//   final bool comment;
//   const UploadLiveAudioEvent({required this.audio, required this.comment});
// }
class UploadLiveAudioEvent extends AttachmentEvent {
  final Uint8List audio;
  final bool comment;
  const UploadLiveAudioEvent({required this.audio, required this.comment});
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