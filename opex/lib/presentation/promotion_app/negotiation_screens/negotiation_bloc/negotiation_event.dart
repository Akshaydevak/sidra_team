part of 'negotiation_bloc.dart';


abstract class NegotiationEvent extends Equatable{
  const NegotiationEvent();

  @override
  List<Object> get props => [];
}


class CreateNegotiationEvent extends NegotiationEvent {

  final dynamic image;
  final List<GetCount>? cartValueList;
  final List<GetCount>? cartGpList;
  final String title;
  final List<ProductListPromotion> variants;
  final String? description;
  final String? basedOn;
  final int? offerPeriodId;
  final bool? isAvailableforAll;
  final String? createdBy;
  final List<GetSegmentList>? segment;
  final List<GetTypeApplying>? customer;
  const CreateNegotiationEvent( {
    required this.variants,
    required this.description,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.title,
    required this.image,
    required this.cartGpList,
    required this.cartValueList,
    required this.isAvailableforAll,
    required this.customer,
    required this.segment,
  });
  @override
  List<Object> get props => [
    title,
  ];
}
//listnegotiation
class PaginatedNegotiationListEvent extends NegotiationEvent {
  final String code;
  final String prev;
  const PaginatedNegotiationListEvent(this.code, this.prev);
  @override
  List<Object> get props => [this.code];
}
//search
class SearchPaginatedNegotiationListEvent extends NegotiationEvent {
  final String? nextPageUrl;
  final String query;

  const SearchPaginatedNegotiationListEvent({required this.query,this.nextPageUrl});
  @override
  List<Object> get props => [this.query];
}
//readnegotiation
class GetNegotiationReadEvent extends NegotiationEvent {
  final int id;
  const GetNegotiationReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//deletenegotiation
class DeleteNegotiationEvent extends NegotiationEvent {
  final int id;
  const DeleteNegotiationEvent(this.id);
}
//updaternegotiation
class UpdateNegotiationEvent extends NegotiationEvent {

  final dynamic image;
  final List<GetCount>? cartValueList;
  final List<GetCount>? cartGpList;
  final String title;
  final List<ProductListPromotion> variants;
  final String? description;
  final String? basedOn;
  final int? offerPeriodId;
  final bool? isAvailableforAll;
  final String? createdBy;
  final List<GetSegmentList>? segment;
  final List<GetTypeApplying>? customer;
  final int id;
  final bool isActive;

  const UpdateNegotiationEvent( {
    required this.isActive,
    required this.variants,
    required this.description,
    required this.id,
    required this.basedOn,
    required this.offerPeriodId,
    required this.createdBy,
    required this.title,
    required this.image,
    required this.cartGpList,
    required this.cartValueList,
    required this.segment,
    required this.customer,
    required this.isAvailableforAll,
  });
  @override
  List<Object> get props => [
    title,
  ];
}