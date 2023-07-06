part of 'organisation_bloc.dart';



abstract class OrganisationState extends Equatable {
  const OrganisationState();

  @override
  List<Object> get props => [];
}
//jobList
class GetOrganisationListInitial extends OrganisationState {}

class GetOrganisationListLoading extends OrganisationState {}

class GetOrganisationListSuccess extends OrganisationState {
  final List<OrgModel> ordersList;

  const GetOrganisationListSuccess(this.ordersList);
}

class GetOrganisationListFailed extends OrganisationState {}
