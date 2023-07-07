import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/data_response.dart';
import '../../blocs/discount_bloc/repo&data/dicount_repo.dart';
import '../../blocs/discount_bloc/repo&data/discount_datasource.dart';
import '../../buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import '../../models_promotion/discount_models/model_discount.dart';
import '../../models_promotion/discount_models/model_discount.dart';
import '../../models_promotion/discount_models/model_discount.dart';

part 'negotiation_event.dart';
part 'negotiation_state.dart';

class NegotiationBloc extends Bloc<NegotiationEvent, NegotiationState> {
  final DiscountDataSource _discountDataSource = DiscountDataSource();
  final DiscountRepo _discountRepo = DiscountRepo();
  List<NegotiationList> negotiationList=[];
  String? next;
  NegotiationBloc() : super(NegotiationCreateLoading());


  @override
  Stream<NegotiationState> mapEventToState(NegotiationEvent event,) async* {
    if (event is CreateNegotiationEvent) {
      yield* createNegotiationPost(
        title: event.title.trim(),
        image: event.image,
        description: event.description,
        createdBy: event.createdBy,
        basedOn: event.basedOn,
        customer: event.customer,
        isAvailableforAll: event.isAvailableforAll,
        offerPeriodId: event.offerPeriodId,
        segment: event.segment,
        variants: event.variants,
        cartGpList: event.cartGpList,
        cartValueList: event.cartValueList
      );
    }
    if (event is PaginatedNegotiationListEvent) {
      yield* paginatedNegotiationListState(event.code.trim(),event.prev.trim());
    }
    if (event is SearchPaginatedNegotiationListEvent) {
      yield* getSearchNegotiationListState(event.query.trim());
    }
    else if (event is GetNegotiationReadEvent) {
      yield* getNegotiationRead(event.id);
    }
    if (event is DeleteNegotiationEvent) {
      yield* deleteNegotiation(id: event.id);
    }
    if (event is UpdateNegotiationEvent) {
      yield* updateNegotiationPost(
        id: event.id,
        title: event.title.trim(),
        image: event.image,
        description: event.description,
        createdBy: event.createdBy,
        isActive: event.isActive,
        basedOn: event.basedOn,
        customer: event.customer,
        isAvailableforAll: event.isAvailableforAll,
        offerPeriodId: event.offerPeriodId,
        segment: event.segment,
        variants: event.variants,
        cartGpList: event.cartGpList,
         cartValueList: event.cartValueList
      );
    }

  }

  ////
  Stream<NegotiationState> createNegotiationPost(
      {
        required List<GetCount>? cartValueList,
        required List<GetCount>? cartGpList,
        required int image,
        required String title,
        required List<ProductListPromotion> variants,
        required String? description,
        required String? basedOn,
        required int? offerPeriodId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
      }) async* {
    yield NegotiationCreateLoading();

    final dataResponse = await _discountRepo.createNegotiationPost(

        createdBy: createdBy,
        description: description,
        title: title,
        variants: variants,
        segment: segment,
        offerPeriodId: offerPeriodId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
       cartValueList: cartValueList,
      cartGpList: cartGpList

    );

    if (dataResponse.data ) {
      yield NegotiationCreateSuccess(successMessage: dataResponse.error);
    } else {
      yield NegotiationCreateFailed(
        dataResponse.error ?? "",);
    }

  }

  //
//listDiscount
  Stream<NegotiationState> paginatedNegotiationListState(String code,String prev) async* {
    negotiationList=[];
    yield GetNegotiationListLoading();

    final dataResponse = await _discountRepo.paginatedNegotiationList(code, prev);

    dataResponse.fold((l) => emit(GetNegotiationListFailed()), (r) {
      next = r.nextPage;
      r.data?.forEach((element) {
        negotiationList.add((element));
      });

      emit(GetNegotiationListSuccess(
          discountList: PaginatedResponse(negotiationList, r.nextPage, r.previousUrl)));
    });
  }
  //search
  Stream<NegotiationState> getSearchNegotiationListState(
      String searchQuery) async* {
    negotiationList = [];
    next = null;
    yield GetSearchedNegotiationLoading();

    final dataResponse =
    await _discountRepo.getSearchNegotiationList(searchQuery, next);

    dataResponse.fold((l) => emit(GetSearchedNegotiationFailed()), (r) {
      next = r.nextPage;
      negotiationList = r.data ?? [];

      emit(GetSearchedNegotiationSuccess(productItem: r,nextPageUrl: r.nextPage??""));
    });
  }

  //discountRead
  Stream<NegotiationState> getNegotiationRead(int id) async* {

    yield GetNegotiationReadLoading();

    final dataResponse = await _discountRepo.getNegotiationRead(id);

    if (dataResponse.hasData) {
      print("Susss");
      yield GetNegotiationReadSuccess(negotiationList: dataResponse.data);
    } else {
      yield GetNegotiationReadFailed(dataResponse.error.toString(),
      );
    }
  }
  //deleteDiscoint
  Stream<NegotiationState> deleteNegotiation({required int id}) async* {
    yield DeleteNegotiationLoading();
    final dataResponse = await _discountDataSource.deleteNegotiation(id);
    if (dataResponse == "success") {
      yield DeleteNegotiationSuccess();
    } else {
      yield DeleteNegotiationFailed();
    }
  }

  //updateBuyMore
  Stream<NegotiationState> updateNegotiationPost(
      {
        required bool? isActive,
        required int id,
        required List<GetCount>? cartValueList,
        required List<GetCount>? cartGpList,
        required dynamic image,
        required String title,
        required List<ProductListPromotion> variants,
        required String? description,
        required String? basedOn,
        required int? offerPeriodId,
        required bool? isAvailableforAll,
        required String? createdBy,
        required List<GetSegmentList>? segment,
        required List<GetTypeApplying>? customer,
      }) async* {
    yield NegotiationUpdateLoading();

    final dataResponse = await _discountRepo.updateNegotiationPost(
        isActive: isActive,
        createdBy: createdBy,
        description: description,
        title: title,
        variants: variants,
        segment: segment,
        offerPeriodId: offerPeriodId,
        isAvailableforAll: isAvailableforAll,
        customer: customer,
        basedOn: basedOn,
        image: image,
        id: id,
       cartValueList: cartValueList,
      cartGpList: cartGpList

    );

    if (dataResponse.data ) {
      yield NegotiationUpdateSuccess(successMessage: dataResponse.error);
    } else {
      yield NegotiationUpdateFailed(
        dataResponse.error ?? "",);
    }

  }

}
