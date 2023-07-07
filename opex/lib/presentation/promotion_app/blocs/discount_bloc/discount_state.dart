part of 'discount_bloc.dart';


abstract class DiscountState extends Equatable {
  const DiscountState();
  @override
  List<Object> get props => [];
}
class GetSegmentListInitial extends DiscountState {}

class GetSegmentListLoading extends DiscountState {}

class GetSegmentListSuccess extends DiscountState {
  final List<GetSegmentList> segments;

  const GetSegmentListSuccess(this.segments);
}

class GetSegmentListFailed extends DiscountState {}
//createOfferPeriod
class OfferPeriodCreateInitial extends DiscountState {}

class OfferPeriodCreateLoading extends DiscountState {}

class OfferPeriodCreateSuccess extends DiscountState {
  final String?  successMessage;


  const OfferPeriodCreateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class OfferPeriodCreateFailed extends DiscountState {
  final String error;

  const OfferPeriodCreateFailed(this.error);
  @override
  List<Object> get props => [];
}

//listOfferPeriod
class GetOfferPeriodListInitial extends DiscountState {}

class GetOfferPeriodListLoading extends DiscountState {}

class GetOfferPeriodListSuccess extends DiscountState {
  final PaginatedResponse offerPeriod;

  GetOfferPeriodListSuccess({required this.offerPeriod});
  @override
  List<Object> get props => [offerPeriod];
}

class GetOfferPeriodListFailed extends DiscountState {
  GetOfferPeriodListFailed();
}

//readOfferPeriod
class GetOfferPeriodReadInitial extends DiscountState {}


class GetOfferPeriodReadLoading extends DiscountState {}

class GetOfferPeriodReadSuccess extends DiscountState {
  final GetOfferPeriod offerPeriod;
  GetOfferPeriodReadSuccess({required this.offerPeriod});
  @override
  List<Object> get props => [offerPeriod];
}

class GetOfferPeriodReadFailed extends DiscountState {
  final String error;
  const GetOfferPeriodReadFailed(this.error);
}
//updateofferPeriod
class OfferPeriodUpdateInitial extends DiscountState {}

class OfferPeriodUpdateLoading extends DiscountState {}

class OfferPeriodUpdateSuccess extends DiscountState {
  final String?  successMessage;


  const OfferPeriodUpdateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class OfferPeriodUpdateFailed extends DiscountState {
  final String error;

  const OfferPeriodUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
//deleteofferperiod
class DeleteOfferPeriodInitial extends DiscountState {}

class DeleteOfferPeriodLoading extends DiscountState {}

class DeleteOfferPeriodSuccess extends DiscountState {}

class DeleteOfferPeriodFailed extends DiscountState {}

//channelList
class GetChannelListInitial extends DiscountState {}

class GetChannelListLoading extends DiscountState {}

class GetChannelListSuccess extends DiscountState {
  final PaginatedResponse channelList;

  GetChannelListSuccess({required this.channelList});
  @override
  List<Object> get props => [channelList];
}

class GetChannelListFailed extends DiscountState {
  GetChannelListFailed();
}
//imageUpload
class PostImageDiscontInitial extends DiscountState {}

class PostImageDiscontLoading extends DiscountState {}

class PostImageDiscontSuccess extends DiscountState {
  final int? id;
  const PostImageDiscontSuccess({this.id});
}

class PostImageDiscontFailed extends DiscountState {
  final String? error;
  const PostImageDiscontFailed({this.error});
}

//createOfferGroup

class OfferGroupCreateLoading extends DiscountState {}

class OfferGroupCreateSuccess extends DiscountState {
  final String?  successMessage;

  const OfferGroupCreateSuccess(this.successMessage);

  @override
  List<Object> get props => [];
}

class OfferGroupCreateFailed extends DiscountState {
  final String error;

  const OfferGroupCreateFailed(this.error);
  @override
  List<Object> get props => [];
}
//offerGropList
class GetOfferGroupListInitial extends DiscountState {}

class GetOfferGroupListLoading extends DiscountState {}

class GetOfferGroupListSuccess extends DiscountState {
  final PaginatedResponse offerGroup;

  GetOfferGroupListSuccess({required this.offerGroup});
  @override
  List<Object> get props => [offerGroup];
}

class GetOfferGroupListFailed extends DiscountState {
  GetOfferGroupListFailed();
}

//readOfferGroup
class GetOfferGroupReadInitial extends DiscountState {}


class GetOfferGroupReadLoading extends DiscountState {}

class GetOfferGroupReadSuccess extends DiscountState {
  final GetOfferGroup offerGroup;
  GetOfferGroupReadSuccess({required this.offerGroup});
  @override
  List<Object> get props => [offerGroup];
}

class GetOfferGroupReadFailed extends DiscountState {
  final String error;
  const GetOfferGroupReadFailed(this.error);
}
//updateOfferGroup
class OfferGroupUpdateLoading extends DiscountState {}

class OfferGroupUpdateSuccess extends DiscountState {
  final String?  successMessage;

  const OfferGroupUpdateSuccess(this.successMessage);

  @override
  List<Object> get props => [];
}

class OfferGroupUpdateFailed extends DiscountState {
  final String error;

  const OfferGroupUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
//delteOfferGroup
class DeleteOfferGroupInitial extends DiscountState {}

class DeleteOfferGroupLoading extends DiscountState {}

class DeleteOfferGroupSuccess extends DiscountState {}

class DeleteOfferGroupFailed extends DiscountState {}

//readbasedon
class GetOfferAppliyingBasedOnReadInitial extends DiscountState {}


class GetOfferAppliyingBasedOnReadLoading extends DiscountState {}

class GetOfferAppliyingBasedOnReadSuccess extends DiscountState {
  final GetDiscount discount;
  GetOfferAppliyingBasedOnReadSuccess({required this.discount});
  @override
  List<Object> get props => [discount];
}

class GetOfferAppliyingBasedOnReadFailed extends DiscountState {
  final String error;
  const GetOfferAppliyingBasedOnReadFailed(this.error);
}

//typeAppliying
class TypeAppliyingListPostInitial extends DiscountState {}

class TypeAppliyingListPostLoading extends DiscountState {}

class TypeAppliyingListPostSuccess extends DiscountState {
  final String nextPageUrl;
  final String prevPageUrl;
  final List<GetTypeApplying> typeApply;

   TypeAppliyingListPostSuccess(  {required this.typeApply,required this.nextPageUrl,required this.prevPageUrl,});

  @override
  List<Object> get props => [];
}

class TypeAppliyingListPostFailed extends DiscountState {

  const TypeAppliyingListPostFailed();
  @override
  List<Object> get props => [];
}

//productlist
class ProductListPostInitial extends DiscountState {}

class ProductListPostLoading extends DiscountState {}

class ProductListPostSuccess extends DiscountState {
  final String nextPageUrl;
  final String prevPageUrl;
  final List<ProductListPromotion> productList;

  ProductListPostSuccess({required this.productList,required this.nextPageUrl,required this.prevPageUrl,});

  @override
  List<Object> get props => [];
}

class ProductListPostFailed extends DiscountState {

  const ProductListPostFailed();
  @override
  List<Object> get props => [];
}
//customerGroup
class GetCustomerGroupListInitial extends DiscountState {}

class GetCustomerGroupListLoading extends DiscountState {}

class GetCustomerGroupListSuccess extends DiscountState {
  final PaginatedResponse customerGroup;

  GetCustomerGroupListSuccess({required this.customerGroup});
  @override
  List<Object> get props => [customerGroup];
}

class GetCustomerGroupListFailed extends DiscountState {
  GetCustomerGroupListFailed();
}
//createDiscount
class DiscountCreateInitial extends DiscountState {}

class DiscountCreateLoading extends DiscountState {}

class DiscountCreateSuccess extends DiscountState {
final String?  successMessage;

  const DiscountCreateSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class DiscountCreateFailed extends DiscountState {
  final String error;

  const DiscountCreateFailed(this.error);
  @override
  List<Object> get props => [];
}

//listDiscount
class GetDiscountListInitial extends DiscountState {}

class GetDiscountListLoading extends DiscountState {}

class GetDiscountListSuccess extends DiscountState {
  final PaginatedResponse discountList;

  GetDiscountListSuccess({required this.discountList});
  @override
  List<Object> get props => [discountList];
}

class GetDiscountListFailed extends DiscountState {
  GetDiscountListFailed();
}
//search

class GetSearchedDiscountInitial extends DiscountState {}

class GetSearchedDiscountLoading extends DiscountState {}

class GetSearchedDiscountSuccess extends DiscountState {
  final String nextPageUrl;
  final PaginatedResponse productItem;
  GetSearchedDiscountSuccess({required this.productItem,required this.nextPageUrl
  });
  @override
  List<Object> get props => [productItem];
}

class GetSearchedDiscountFailed extends DiscountState {
  GetSearchedDiscountFailed();
}


//readDiscout
class GetDiscountReadInitial extends DiscountState {}


class GetDiscountReadLoading extends DiscountState {}

class GetDiscountReadSuccess extends DiscountState {
  final DiscountList discountList;
  GetDiscountReadSuccess({required this.discountList});
  @override
  List<Object> get props => [discountList];
}

class GetDiscountReadFailed extends DiscountState {
  final String error;
  const GetDiscountReadFailed(this.error);
}
//deleteDiscount
class DeleteDiscountInitial extends DiscountState {}

class DeleteDiscountLoading extends DiscountState {}

class DeleteDiscountSuccess extends DiscountState {}

class DeleteDiscountFailed extends DiscountState {}

//updateDiscount
class DiscountUpdateInitial extends DiscountState {}

class DiscountUpdateLoading extends DiscountState {}

class DiscountUpdateSuccess extends DiscountState {
  final String?  successMessage;

  const DiscountUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class DiscountUpdateFailed extends DiscountState {
  final String error;

  const DiscountUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}

//selectedvariant
class GetSelectedVariantListInitial extends DiscountState {}

class GetSelectedVariantListLoading extends DiscountState {}

class GetSelectedVariantListSuccess extends DiscountState {
  final PaginatedResponse variants;

  GetSelectedVariantListSuccess({required this.variants});
  @override
  List<Object> get props => [variants];
}

class GetSelectedVariantListFailed extends DiscountState {
  GetSelectedVariantListFailed();
}
//deactivate
class DeactivatePrevPromotionInitial extends DiscountState {}

class DeactivatePrevPromotionLoading extends DiscountState {}

class DeactivatePrevPromotionSuccess extends DiscountState {
  final String?  successMessage;
  final List<ProductListPromotion>? returnList;
  const DeactivatePrevPromotionSuccess( {this.successMessage,this.returnList,});

  @override
  List<Object> get props => [];
}

class DeactivatePrevPromotionFailed extends DiscountState {
  final String error;


  const DeactivatePrevPromotionFailed(this.error,);
  @override
  List<Object> get props => [];
}

//selective
class DeleteSelectiveVariantsInitial extends DiscountState {}

class DeleteSelectiveVariantsLoading extends DiscountState {}

class DeleteSelectiveVariantsSuccess extends DiscountState {
  final String?  successMessage;

  const DeleteSelectiveVariantsSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class DeleteSelectiveVariantsFailed extends DiscountState {
  final String error;

  const DeleteSelectiveVariantsFailed(this.error);
  @override
  List<Object> get props => [];
}
