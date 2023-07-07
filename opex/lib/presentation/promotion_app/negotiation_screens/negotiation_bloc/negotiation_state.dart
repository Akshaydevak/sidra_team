part of 'negotiation_bloc.dart';


abstract class NegotiationState extends Equatable {
  const NegotiationState();
  @override
  List<Object> get props => [];
}

class NegotiationCreateLoading extends NegotiationState {}

class NegotiationCreateSuccess extends NegotiationState {
  final String?  successMessage;

  const NegotiationCreateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class NegotiationCreateFailed extends NegotiationState {
  final String error;

  const NegotiationCreateFailed(this.error);
  @override
  List<Object> get props => [];
}

//
//listBuyMore

class GetNegotiationListLoading extends NegotiationState {}

class GetNegotiationListSuccess extends NegotiationState {
  final PaginatedResponse discountList;

  GetNegotiationListSuccess({required this.discountList});
  @override
  List<Object> get props => [discountList];
}

class GetNegotiationListFailed extends NegotiationState {
  GetNegotiationListFailed();
}
//search

class GetSearchedNegotiationLoading extends NegotiationState {}

class GetSearchedNegotiationSuccess extends NegotiationState {
  final String nextPageUrl;
  final PaginatedResponse productItem;
  GetSearchedNegotiationSuccess({required this.productItem,required this.nextPageUrl
  });
  @override
  List<Object> get props => [productItem];
}

class GetSearchedNegotiationFailed extends NegotiationState {
  GetSearchedNegotiationFailed();
}



//readDiscout

class GetNegotiationReadLoading extends NegotiationState {}

class GetNegotiationReadSuccess extends NegotiationState {
  final NegotiationList negotiationList;
  GetNegotiationReadSuccess({required this.negotiationList});
  @override
  List<Object> get props => [negotiationList];
}

class GetNegotiationReadFailed extends NegotiationState {
  final String error;
  const GetNegotiationReadFailed(this.error);
}
//deleteDiscount
class DeleteNegotiationLoading extends NegotiationState {}

class DeleteNegotiationSuccess extends NegotiationState {}

class DeleteNegotiationFailed extends NegotiationState {}

//update
class NegotiationUpdateLoading extends NegotiationState {}

class NegotiationUpdateSuccess extends NegotiationState {
  final String?  successMessage;

  const NegotiationUpdateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class NegotiationUpdateFailed extends NegotiationState {
  final String error;

  const NegotiationUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}