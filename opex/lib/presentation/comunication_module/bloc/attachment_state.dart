part of 'attachment_bloc.dart';

abstract class AttachmentState extends Equatable {
  const AttachmentState();

  @override
  List<Object> get props => [];
}

class AttachmentInitial extends AttachmentState {}

class UploadPictureLoading extends AttachmentState {}

class UploadPictureSuccess extends AttachmentState {
  final String upload;
  const UploadPictureSuccess({required this.upload});
}

class UploadPictureFailed extends AttachmentState {
  final String error;
  const UploadPictureFailed({required this.error});
}

class UploadVideoLoading extends AttachmentState {}

class UploadVideoSuccess extends AttachmentState {
  final String upload;
  const UploadVideoSuccess({required this.upload});
}

class UploadVideoFailed extends AttachmentState {}

class UploadFilesLoading extends AttachmentState {}

class UploadFilesSuccess extends AttachmentState {
  final String upload;
  const UploadFilesSuccess({required this.upload});
}

class UploadFilesFailed extends AttachmentState {}

class UploadAudioLoading extends AttachmentState {}

class UploadAudioSuccess extends AttachmentState {
  final String upload;
  const UploadAudioSuccess({required this.upload});
}

class UploadAudioFailed extends AttachmentState {}

class UploadGroupProfilePicLoading extends AttachmentState {}

class UploadGroupProfilePicSuccess extends AttachmentState {
  final String? uploadLink;
  final String? message;
  const UploadGroupProfilePicSuccess({this.uploadLink, this.message});
}

class UploadGroupProfilePicFailed extends AttachmentState {
  final String? error;
  const UploadGroupProfilePicFailed({this.error});
}
class UploadLiveAudioLoading extends AttachmentState {}

class UploadLiveAudioSuccess extends AttachmentState {
  final String upload;
  const UploadLiveAudioSuccess({required this.upload});
}

class UploadLiveAudioFailed extends AttachmentState {}
class GetGroupAttachmentsInProfileLoading extends AttachmentState {}

class GetGroupAttachmentsInProfileSuccess extends AttachmentState {
  final ProfileGetModel groupProfileGet;
  const GetGroupAttachmentsInProfileSuccess({required this.groupProfileGet});
}

class GetGroupAttchmentsInProfileFailed extends AttachmentState {}
