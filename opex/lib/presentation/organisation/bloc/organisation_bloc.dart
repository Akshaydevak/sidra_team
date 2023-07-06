import 'package:bloc/bloc.dart';
import 'package:cluster/presentation/order_app/data/order_repo.dart';
import 'package:cluster/presentation/order_app/model/order_model.dart';
import 'package:equatable/equatable.dart';
import '../data/organisation_repo.dart';
import '../model/org_model.dart';

part 'organisation_event.dart';
part 'organisation_state.dart';

class OrganisationBloc extends Bloc<OrganisationEvent, OrganisationState> {
  final OrganisationRepo _orgRepo = OrganisationRepo();

  OrganisationBloc() : super(GetOrganisationListInitial());
  @override
  Stream<OrganisationState> mapEventToState(OrganisationEvent event) async* {
    if (event is GetOrganisationListEvent) {
      yield* getOrgList();
    }  if (event is GetBusinessListEvent) {
      yield* getBusinessList();
    } if (event is GetOperationalListEvent) {
      yield* getOperationalList();
    }


  }
  Stream<OrganisationState> getOrgList() async* {
    yield GetOrganisationListLoading();

    final dataResponse = await _orgRepo.listOrgModel();

    if (dataResponse.data!=null) {
      yield GetOrganisationListSuccess(dataResponse.data);
    } else {
      yield GetOrganisationListFailed();
    }
  }
  Stream<OrganisationState> getBusinessList() async* {
    yield GetOrganisationListLoading();

    final dataResponse = await _orgRepo.listBusinessModel();

    if (dataResponse.data!=null) {
      yield GetOrganisationListSuccess(dataResponse.data);
    } else {
      yield GetOrganisationListFailed();
    }
  }  Stream<OrganisationState> getOperationalList() async* {
    yield GetOrganisationListLoading();

    final dataResponse = await _orgRepo.listOperationalModel();

    if (dataResponse.data!=null) {
      yield GetOrganisationListSuccess(dataResponse.data);
    } else {
      yield GetOrganisationListFailed();
    }
  }
}
