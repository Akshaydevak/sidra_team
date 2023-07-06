



part of 'organisation_bloc.dart';

abstract class OrganisationEvent extends Equatable {
  const OrganisationEvent();

  @override
  List<Object> get props => [];

}
class GetOrganisationListEvent extends OrganisationEvent {
  const GetOrganisationListEvent();
}class GetBusinessListEvent extends OrganisationEvent {
  const GetBusinessListEvent();
}class GetOperationalListEvent extends OrganisationEvent {
  const GetOperationalListEvent();
}


