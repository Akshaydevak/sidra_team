part of 'inventory_bloc.dart';



abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}
//jobList
class InventoryInitial extends InventoryState {}

class GetDivisionLoading extends InventoryState {}

class GetDivisionSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
final String? prevPageUrl;
final String? nextPageUrl;
  const GetDivisionSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetDivisionFailed extends InventoryState {
  final String msg;
  GetDivisionFailed(this.msg);
}


class GetUomLoading extends InventoryState {}

class GetUomSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
final String? prevPageUrl;
final String? nextPageUrl;
  const GetUomSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetUomFailed extends InventoryState {
  final String msg;
  GetUomFailed(this.msg);
}

//category
class GetCategoryLoading extends InventoryState {}

class GetCategorySuccess extends InventoryState  {
  final List<InventoryModel> inventory;

  const GetCategorySuccess(
      this.inventory
      );
}

class GetCategoryFailed extends InventoryState {
  final String msg;
  GetCategoryFailed(this.msg);
}
//category
class PicLoading extends InventoryState {}

class PicSuccess extends InventoryState {
  final int data;
  final String url;
  // final List<ListOrdersModel> ordersList;

  const PicSuccess(this.data,this.url);
}

class PicFailed extends InventoryState {}
 //category
class VariantLoading extends InventoryState {}

class VariantSuccess extends InventoryState {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const VariantSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class VariantFailed extends InventoryState {}
//channel
class ChannelLoading extends InventoryState {}

class ChannelSuccess extends InventoryState {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const ChannelSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class ChannelFailed extends InventoryState {}
//channel
class ManufacturerLoading extends InventoryState {}

class ManufacturerSuccess extends InventoryState {
  final List<ManufactureModel>? data;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const ManufacturerSuccess(
      {this.data, this.prevPageUrl, this.nextPageUrl});
}

class ManufacturerFailed extends InventoryState {}
//category
class CombinationLoading extends InventoryState {}

class CombinationSuccess extends InventoryState {
  final List<InventoryModel>? inventory;

  const CombinationSuccess(
      {this.inventory});
}

class CombinationFailed extends InventoryState {}
//return List
class ReturnTypeLoading extends InventoryState {}

class ReturnTypeSuccess extends InventoryState {
  final List<dynamic>? data;

  const ReturnTypeSuccess(
      {this.data});
}

class ReturnTypeFailed extends InventoryState {}
//category
class
CreateVariantLoading extends InventoryState {}

class CreateVariantSuccess extends InventoryState {
  final bool? data;
  final String ?msg;

  const CreateVariantSuccess({this.data,this.msg});
}

class CreateVariantFailed extends InventoryState {
  final String ?msg;
  const CreateVariantFailed({this.msg});
}
//channel
class SiblingLoading extends InventoryState {}

class SiblingSuccess extends InventoryState {
  final List<InventoryModel>? data;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const SiblingSuccess(
      {this.data, this.prevPageUrl, this.nextPageUrl});
}

class SiblingFailed extends InventoryState {}

//category
class InventoryLoading extends InventoryState {}

class InventorySuccess extends InventoryState {
  final List<InventoryModel>? inventory;

  const InventorySuccess(
      {this.inventory});
}

class InventoryFailed extends InventoryState {}

//List
class ListVariantLoading extends InventoryState {}

class ListVariantSuccess extends InventoryState {
  final List<InventoryModel>? data;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const ListVariantSuccess(
      {this.data, this.prevPageUrl, this.nextPageUrl});
}


class ListVariantFailed extends InventoryState {}
//Read
class ReadVariantLoading extends InventoryState {}

class ReadVariantSuccess extends InventoryState {
  final ReadVariantModel? data;
  const ReadVariantSuccess(
      {this.data});
}

class ReadVariantFailed extends InventoryState {}
//Read
class UpdateVariantLoading extends InventoryState {}

class UpdateVariantSuccess extends InventoryState {
  final String? data;
  const UpdateVariantSuccess(
      {this.data});
}

class UpdateVariantFailed extends InventoryState {}
//Read
class DeleteVariantLoading extends InventoryState {}

class DeleteVariantSuccess extends InventoryState {
  final String? data;
  const DeleteVariantSuccess(
      {this.data});
}

class DeleteVariantFailed extends InventoryState {
  final String? data;
  const DeleteVariantFailed(
      {this.data});
}

class GetStockLoading extends InventoryState {}

class GetStockSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetStockSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetStockFailed extends InventoryState {
  final String msg;
  GetStockFailed(this.msg);
}
//Stock


class StockListProductLoading extends InventoryState {}

class StockListProductSuccess extends InventoryState {
  final PaginatedResponse product;

  StockListProductSuccess({required this.product});
  @override
  List<Object> get props => [product];
}

class StockListProductFailed extends InventoryState {}



class GetStockReadLoading extends InventoryState {}

class GetStockReadSuccess extends InventoryState {
  final ReadStockData stockData;
  GetStockReadSuccess({required this.stockData});
  @override
  List<Object> get props => [stockData];
}

class GetStockReadFailed extends InventoryState {
  final String error;
  const GetStockReadFailed(this.error);
}


class CreateVirtualStockInitial extends InventoryState {}

class CreateVirtualStockLoading extends InventoryState {}

class CreateVirtualStockSuccess extends InventoryState {
  final String?  successMessage;

  const CreateVirtualStockSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateVirtualStockFailed extends InventoryState {
  final String error;

  const CreateVirtualStockFailed(this.error);
  @override
  List<Object> get props => [];
}

class CreateMethodTypeLoading extends InventoryState {}

class CreateMethodTypeSuccess extends InventoryState {
  final String?  successMessage;

  const CreateMethodTypeSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateMethodTypeFailed extends InventoryState {
  final String error;

  const CreateMethodTypeFailed(this.error);
  @override
  List<Object> get props => [];
}

class CostMethodTypeListLoading extends InventoryState {}

class CostMethodTypeListSuccess extends InventoryState {
  final PaginatedResponse product;

  CostMethodTypeListSuccess({required this.product});
  @override
  List<Object> get props => [product];
}

class CostMethodTypeListFailed extends InventoryState {}

//reasd

class GetCostMethodTypeReadLoading extends InventoryState {}

class GetCostMethodTypeReadSuccess extends InventoryState {
  final CostingModel costingModel;
  GetCostMethodTypeReadSuccess({required this.costingModel});
  @override
  List<Object> get props => [costingModel];
}

class GetCostMethodTypeReadFailed extends InventoryState {
  final String error;
  const GetCostMethodTypeReadFailed(this.error);
}
//deleteDiscount
class DeleteCostMethodTypeInitial extends InventoryState {}

class DeleteCostMethodTypeLoading extends InventoryState {}

class DeleteCostMethodTypeSuccess extends InventoryState {}

class DeleteCostMethodTypeFailed extends InventoryState {}

//updateDiscount
class CostMethodTypeUpdateInitial extends InventoryState {}

class CostMethodTypeUpdateLoading extends InventoryState {}

class CostMethodTypeUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const CostMethodTypeUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class CostMethodTypeUpdateFailed extends InventoryState {
  final String error;

  const CostMethodTypeUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}

//costmethodCreate
class CreateMethodLoading extends InventoryState {}

class CreateMethodSuccess extends InventoryState {
  final String?  successMessage;

  const CreateMethodSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateMethodFailed extends InventoryState {
  final String error;

  const CreateMethodFailed(this.error);
  @override
  List<Object> get props => [];
}

class CostMethodListLoading extends InventoryState {}

class CostMethodListSuccess extends InventoryState {
  final PaginatedResponse product;

  CostMethodListSuccess({required this.product});
  @override
  List<Object> get props => [product];
}

class CostMethodListFailed extends InventoryState {}

//reasd

class GetCostMethodReadLoading extends InventoryState {}

class GetCostMethodReadSuccess extends InventoryState {
  final CostingModel costingModel;
  GetCostMethodReadSuccess({required this.costingModel});
  @override
  List<Object> get props => [costingModel];
}

class GetCostMethodReadFailed extends InventoryState {
  final String error;
  const GetCostMethodReadFailed(this.error);
}
//deleteDiscount
class DeleteCostMethodInitial extends InventoryState {}

class DeleteCostMethodLoading extends InventoryState {}

class DeleteCostMethodSuccess extends InventoryState {}

class DeleteCostMethodFailed extends InventoryState {}

//updateDiscount
class CostMethodUpdateInitial extends InventoryState {}

class CostMethodUpdateLoading extends InventoryState {}

class CostMethodUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const CostMethodUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class CostMethodUpdateFailed extends InventoryState {
  final String error;

  const CostMethodUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}


//pricingType
class PricingTypeLoading extends InventoryState {}

class PricingTypeSuccess extends InventoryState {
  final String?  successMessage;

  const PricingTypeSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class PricingTypeFailed extends InventoryState {
  final String error;

  const PricingTypeFailed(this.error);
  @override
  List<Object> get props => [];
}

class PricingTypeListLoading extends InventoryState {}

class PricingTypeListSuccess extends InventoryState {
  final PaginatedResponse product;

  PricingTypeListSuccess({required this.product});
  @override
  List<Object> get props => [product];
}

class PricingTypeListFailed extends InventoryState {}

//reasd

class PricingTypeReadLoading extends InventoryState {}

class PricingTypeReadSuccess extends InventoryState {
  final CostingModel costingModel;
  PricingTypeReadSuccess({required this.costingModel});
  @override
  List<Object> get props => [costingModel];
}

class PricingTypeReadFailed extends InventoryState {
  final String error;
  const PricingTypeReadFailed(this.error);
}
//deleteDiscount
class DeletePricingTypeInitial extends InventoryState {}

class DeletePricingTypeLoading extends InventoryState {}

class DeletePricingTypeSuccess extends InventoryState {}

class DeletePricingTypeFailed extends InventoryState {}

//updateDiscount
class PricingTypeUpdateInitial extends InventoryState {}

class PricingTypeUpdateLoading extends InventoryState {}

class PricingTypeUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const PricingTypeUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class PricingTypeUpdateFailed extends InventoryState {
  final String error;

  const PricingTypeUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}

//pricingGroup
class PricingGroupLoading extends InventoryState {}

class PricingGroupSuccess extends InventoryState {
  final String?  successMessage;

  const PricingGroupSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class PricingGroupFailed extends InventoryState {
  final String error;

  const PricingGroupFailed(this.error);
  @override
  List<Object> get props => [];
}

class PricingGroupListLoading extends InventoryState {}

class PricingGroupListSuccess extends InventoryState {
  final PaginatedResponse product;

  PricingGroupListSuccess({required this.product});
  @override
  List<Object> get props => [product];
}

class PricingGroupListFailed extends InventoryState {}

//reasd

class PricingGroupReadLoading extends InventoryState {}

class PricingGroupReadSuccess extends InventoryState {
  final CostingModel costingModel;
  PricingGroupReadSuccess({required this.costingModel});
  @override
  List<Object> get props => [costingModel];
}

class PricingGroupReadFailed extends InventoryState {
  final String error;
  const PricingGroupReadFailed(this.error);
}
//deleteDiscount
class DeletePricingGroupInitial extends InventoryState {}

class DeletePricingGroupLoading extends InventoryState {}

class DeletePricingGroupSuccess extends InventoryState {}

class DeletePricingGroupFailed extends InventoryState {}

//updateDiscount
class PricingGroupUpdateInitial extends InventoryState {}

class PricingGroupUpdateLoading extends InventoryState {}

class PricingGroupUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const PricingGroupUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class PricingGroupUpdateFailed extends InventoryState {
  final String error;

  const PricingGroupUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
//
class PricingGpTypeReadLoading extends InventoryState {}

class PricingGpTypeReadSuccess extends InventoryState {
  final ReadCostingData readCostingData;
  PricingGpTypeReadSuccess({required this.readCostingData});
  @override
  List<Object> get props => [readCostingData];
}

class PricingGpTypeReadFailed extends InventoryState {
  final String error;
  const PricingGpTypeReadFailed(this.error);
}

class GPPercentagePostLoading extends InventoryState {}

class GPPercentagePostSuccess extends InventoryState {
  final String?  successMessage;

  const GPPercentagePostSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class GPPercentagePostFailed extends InventoryState {
  final String error;

  const GPPercentagePostFailed(this.error);
  @override
  List<Object> get props => [];
}


//createCost
class CreateCostingPostLoading extends InventoryState {}

class CreateCostingPostSuccess extends InventoryState {
  final String?  successMessage;

  const CreateCostingPostSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateCostingPostFailed extends InventoryState {
  final String error;

  const CreateCostingPostFailed(this.error);
  @override
  List<Object> get props => [];
}



class CostingListLoading extends InventoryState {}

class CostingListSuccess extends InventoryState {
  final PaginatedResponse costData;

  CostingListSuccess({required this.costData});
  @override
  List<Object> get props => [costData];
}

class CostingListFailed extends InventoryState {}

//reasd

class CostingReadLoading extends InventoryState {}

class CostingReadSuccess extends InventoryState {
  final CostingReadData costingModel;
  CostingReadSuccess({required this.costingModel});
  @override
  List<Object> get props => [costingModel];
}

class CostingReadFailed extends InventoryState {
  final String error;
  const CostingReadFailed(this.error);
}

//updateDiscount
class CostingUpdateInitial extends InventoryState {}

class CostingUpdateLoading extends InventoryState {}

class CostingUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const CostingUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class CostingUpdateFailed extends InventoryState {
  final String error;

  const CostingUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}

//division
class CreateDivisionLoading extends InventoryState {}

class CreateDivisionSuccess extends InventoryState {
  final String?  successMessage;

  const CreateDivisionSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateDivisionFailed extends InventoryState {
  final String error;

  const CreateDivisionFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class DivisionReadLoading extends InventoryState {}

class DivisionReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  DivisionReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class DivisionReadFailed extends InventoryState {
  final String error;
  const DivisionReadFailed(this.error);
}
//deleteDiscount
class DeleteDivisionInitial extends InventoryState {}

class DeleteDivisionLoading extends InventoryState {}

class DeleteDivisionSuccess extends InventoryState {}

class DeleteDivisionFailed extends InventoryState {}

//updateDiscount
class DivisionUpdateInitial extends InventoryState {}

class DivisionUpdateLoading extends InventoryState {}

class DivisionUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const DivisionUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class DivisionUpdateFailed extends InventoryState {
  final String error;

  const DivisionUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}

//category
class CreateCategoryLoading extends InventoryState {}

class CreateCategorySuccess extends InventoryState {
  final String?  successMessage;

  const CreateCategorySuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateCategoryFailed extends InventoryState {
  final String error;

  const CreateCategoryFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class CategoryReadLoading extends InventoryState {}

class CategoryReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  CategoryReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class CategoryReadFailed extends InventoryState {
  final String error;
  const CategoryReadFailed(this.error);
}
//deleteDiscount
class DeleteCategoryInitial extends InventoryState {}

class DeleteCategoryLoading extends InventoryState {}

class DeleteCategorySuccess extends InventoryState {}

class DeleteCategoryFailed extends InventoryState {}

//updateDiscount
class CategoryUpdateInitial extends InventoryState {}

class CategoryUpdateLoading extends InventoryState {}

class CategoryUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const CategoryUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class CategoryUpdateFailed extends InventoryState {
  final String error;

  const CategoryUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetCategoryListLoading extends InventoryState {}

class GetCategoryListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetCategoryListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetCategoryListFailed extends InventoryState {
  final String msg;
  GetCategoryListFailed(this.msg);
}

//divv
class GetDivisionListLoading extends InventoryState {}

class GetDivisionListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetDivisionListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetDivisionListFailed extends InventoryState {
  final String msg;
  GetDivisionListFailed(this.msg);
}


//group
class CreateGroupLoading extends InventoryState {}

class CreateGroupSuccess extends InventoryState {
  final String?  successMessage;

  const CreateGroupSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateGroupFailed extends InventoryState {
  final String error;

  const CreateGroupFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class GroupReadLoading extends InventoryState {}

class GroupReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  GroupReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class GroupReadFailed extends InventoryState {
  final String error;
  const GroupReadFailed(this.error);
}
//deleteDiscount
class DeleteGroupInitial extends InventoryState {}

class DeleteGroupLoading extends InventoryState {}

class DeleteGroupSuccess extends InventoryState {}

class DeleteGroupFailed extends InventoryState {}

//updateDiscount
class GroupUpdateInitial extends InventoryState {}

class GroupUpdateLoading extends InventoryState {}

class GroupUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const GroupUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class GroupUpdateFailed extends InventoryState {
  final String error;

  const GroupUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetGroupListLoading extends InventoryState {}

class GetGroupListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetGroupListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetGroupListFailed extends InventoryState {
  final String msg;
  GetGroupListFailed(this.msg);
}

//UOM groue
class CreateUomGroupLoading extends InventoryState {}

class CreateUomGroupSuccess extends InventoryState {
  final String?  successMessage;

  const CreateUomGroupSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateUomGroupFailed extends InventoryState {
  final String error;

  const CreateUomGroupFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class UomGroupReadLoading extends InventoryState {}

class UomGroupReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  UomGroupReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class UomGroupReadFailed extends InventoryState {
  final String error;
  const UomGroupReadFailed(this.error);
}
//deleteDiscount
class DeleteUomGroupInitial extends InventoryState {}

class DeleteUomGroupLoading extends InventoryState {}

class DeleteUomGroupSuccess extends InventoryState {}

class DeleteUomGroupFailed extends InventoryState {}

//updateDiscount
class UomGroupUpdateInitial extends InventoryState {}

class UomGroupUpdateLoading extends InventoryState {}

class UomGroupUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const UomGroupUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class UomGroupUpdateFailed extends InventoryState {
  final String error;

  const UomGroupUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetUomGroupListLoading extends InventoryState {}

class GetUomGroupListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetUomGroupListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetUomGroupListFailed extends InventoryState {
  final String msg;
  GetUomGroupListFailed(this.msg);
}

//UOM
class CreateUomLoading extends InventoryState {}

class CreateUomSuccess extends InventoryState {
  final String?  successMessage;

  const CreateUomSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateUomFailed extends InventoryState {
  final String error;

  const CreateUomFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class UomReadLoading extends InventoryState {}

class UomReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  UomReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class UomReadFailed extends InventoryState {
  final String error;
  const UomReadFailed(this.error);
}
//deleteDiscount
class DeleteUomInitial extends InventoryState {}

class DeleteUomLoading extends InventoryState {}

class DeleteUomSuccess extends InventoryState {}

class DeleteUomFailed extends InventoryState {}

//updateDiscount
class UomUpdateInitial extends InventoryState {}

class UomUpdateLoading extends InventoryState {}

class UomUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const UomUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class UomUpdateFailed extends InventoryState {
  final String error;

  const UomUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetUomListLoading extends InventoryState {}

class GetUomListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetUomListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetUomListFailed extends InventoryState {
  final String msg;
  GetUomListFailed(this.msg);
}

//Material
class CreateMaterialLoading extends InventoryState {}

class CreateMaterialSuccess extends InventoryState {
  final String?  successMessage;

  const CreateMaterialSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateMaterialFailed extends InventoryState {
  final String error;

  const CreateMaterialFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class MaterialReadLoading extends InventoryState {}

class MaterialReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  MaterialReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class MaterialReadFailed extends InventoryState {
  final String error;
  const MaterialReadFailed(this.error);
}
//deleteDiscount
class DeleteMaterialInitial extends InventoryState {}

class DeleteMaterialLoading extends InventoryState {}

class DeleteMaterialSuccess extends InventoryState {}

class DeleteMaterialFailed extends InventoryState {}

//updateDiscount
class MaterialUpdateInitial extends InventoryState {}

class MaterialUpdateLoading extends InventoryState {}

class MaterialUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const MaterialUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class MaterialUpdateFailed extends InventoryState {
  final String error;

  const MaterialUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetMaterialListLoading extends InventoryState {}

class GetMaterialListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetMaterialListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetMaterialListFailed extends InventoryState {
  final String msg;
  GetMaterialListFailed(this.msg);
}

//staticGroup
class CreateStaticGroupLoading extends InventoryState {}

class CreateStaticGroupSuccess extends InventoryState {
  final String?  successMessage;

  const CreateStaticGroupSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateStaticGroupFailed extends InventoryState {
  final String error;

  const CreateStaticGroupFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class StaticGroupReadLoading extends InventoryState {}

class StaticGroupReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  StaticGroupReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class StaticGroupReadFailed extends InventoryState {
  final String error;
  const StaticGroupReadFailed(this.error);
}
//deleteDiscount
class DeleteStaticGroupInitial extends InventoryState {}

class DeleteStaticGroupLoading extends InventoryState {}

class DeleteStaticGroupSuccess extends InventoryState {}

class DeleteStaticGroupFailed extends InventoryState {}

//updateDiscount
class StaticGroupUpdateInitial extends InventoryState {}

class StaticGroupUpdateLoading extends InventoryState {}

class StaticGroupUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const StaticGroupUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class StaticGroupUpdateFailed extends InventoryState {
  final String error;

  const StaticGroupUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetStaticGroupListLoading extends InventoryState {}

class GetStaticGroupListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetStaticGroupListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetStaticGroupListFailed extends InventoryState {
  final String msg;
  GetStaticGroupListFailed(this.msg);
}

//brand
class CreateBrandLoading extends InventoryState {}

class CreateBrandSuccess extends InventoryState {
  final String?  successMessage;

  const CreateBrandSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateBrandFailed extends InventoryState {
  final String error;

  const CreateBrandFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class BrandReadLoading extends InventoryState {}

class BrandReadSuccess extends InventoryState {
  final DivisionModels divisionModel;
  BrandReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class BrandReadFailed extends InventoryState {
  final String error;
  const BrandReadFailed(this.error);
}
//deleteDiscount
class DeleteBrandInitial extends InventoryState {}

class DeleteBrandLoading extends InventoryState {}

class DeleteBrandSuccess extends InventoryState {}

class DeleteBrandFailed extends InventoryState {}

//updateDiscount
class BrandUpdateInitial extends InventoryState {}

class BrandUpdateLoading extends InventoryState {}

class BrandUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const BrandUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class BrandUpdateFailed extends InventoryState {
  final String error;

  const BrandUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetBrandListLoading extends InventoryState {}

class GetBrandListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetBrandListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetBrandListFailed extends InventoryState {
  final String msg;
  GetBrandListFailed(this.msg);
}

//attribute
class GetAttributeTypeLoading extends InventoryState {}

class GetAttributeTypeSuccess extends InventoryState {
  final GetDiscount discount;
  GetAttributeTypeSuccess({required this.discount});
  @override
  List<Object> get props => [discount];
}

class GetAttributeTypeFailed extends InventoryState {
  final String error;
  const GetAttributeTypeFailed(this.error);
}

class CreateAttributeLoading extends InventoryState {}

class CreateAttributeSuccess extends InventoryState {
  final String?  successMessage;

  const CreateAttributeSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateAttributeFailed extends InventoryState {
  final String error;

  const CreateAttributeFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class AttributeReadLoading extends InventoryState {}

class AttributeReadSuccess extends InventoryState {
  final AttributeDataModel divisionModel;
  AttributeReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class AttributeReadFailed extends InventoryState {
  final String error;
  const AttributeReadFailed(this.error);
}
//deleteDiscount
class DeleteAttributeInitial extends InventoryState {}

class DeleteAttributeLoading extends InventoryState {}

class DeleteAttributeSuccess extends InventoryState {}

class DeleteAttributeFailed extends InventoryState {}

//updateDiscount
class AttributeUpdateInitial extends InventoryState {}

class AttributeUpdateLoading extends InventoryState {}

class AttributeUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const AttributeUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class AttributeUpdateFailed extends InventoryState {
  final String error;

  const AttributeUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetAttributeListLoading extends InventoryState {}

class GetAttributeListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetAttributeListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetAttributeListFailed extends InventoryState {
  final String msg;
  GetAttributeListFailed(this.msg);
}


//variantFrame
class CreateVarientFrameWorkLoading extends InventoryState {}

class CreateVarientFrameWorkSuccess extends InventoryState {
  final String?  successMessage;

  const CreateVarientFrameWorkSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateVarientFrameWorkFailed extends InventoryState {
  final String error;

  const CreateVarientFrameWorkFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class VarientFrameWorkReadLoading extends InventoryState {}

class VarientFrameWorkReadSuccess extends InventoryState {
  final AttributeDataModel divisionModel;
  VarientFrameWorkReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class VarientFrameWorkReadFailed extends InventoryState {
  final String error;
  const VarientFrameWorkReadFailed(this.error);
}
//deleteDiscount

class DeleteVarientFrameWorkLoading extends InventoryState {}

class DeleteVarientFrameWorkSuccess extends InventoryState {}

class DeleteVarientFrameWorkFailed extends InventoryState {}

//updateDiscount
class VarientFrameWorkUpdateInitial extends InventoryState {}

class VarientFrameWorkUpdateLoading extends InventoryState {}

class VarientFrameWorkUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const VarientFrameWorkUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class VarientFrameWorkUpdateFailed extends InventoryState {
  final String error;

  const VarientFrameWorkUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetVarientFrameWorkListLoading extends InventoryState {}

class GetVarientFrameWorkListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetVarientFrameWorkListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetVarientFrameWorkListFailed extends InventoryState {
  final String msg;
  GetVarientFrameWorkListFailed(this.msg);
}


//item
class CreateItemLoading extends InventoryState {}

class CreateItemSuccess extends InventoryState {
  final String?  successMessage;

  const CreateItemSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateItemFailed extends InventoryState {
  final String error;

  const CreateItemFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class ItemReadLoading extends InventoryState {}

class ItemReadSuccess extends InventoryState {
  final ItemReadModel divisionModel;
  ItemReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class ItemReadFailed extends InventoryState {
  final String error;
  const ItemReadFailed(this.error);
}
//deleteDiscount

class DeleteItemLoading extends InventoryState {}

class DeleteItemSuccess extends InventoryState {}

class DeleteItemFailed extends InventoryState {}

//updateDiscount
class ItemUpdateInitial extends InventoryState {}

class ItemUpdateLoading extends InventoryState {}

class ItemUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const ItemUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class ItemUpdateFailed extends InventoryState {
  final String error;

  const ItemUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetItemListLoading extends InventoryState {}

class GetItemListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetItemListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetItemListFailed extends InventoryState {
  final String msg;
  GetItemListFailed(this.msg);
}

//list for segment
class GroupListSegmentLoading extends InventoryState {}

class GroupListSegmentSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GroupListSegmentSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GroupListSegmentFailed extends InventoryState {
  final String msg;
  GroupListSegmentFailed(this.msg);
}

class UomListSegmentLoading extends InventoryState {}

class UomListSegmentSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const UomListSegmentSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class UomListSegmentFailed extends InventoryState {
  final String msg;
  UomListSegmentFailed(this.msg);
}

class CategoryListSegmentLoading extends InventoryState {}

class CategoryListSegmentSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const CategoryListSegmentSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class CategoryListSegmentFailed extends InventoryState {
  final String msg;
  CategoryListSegmentFailed(this.msg);
}


//division config
class CreateDivisionConfigurationLoading extends InventoryState {}

class CreateDivisionConfigurationSuccess extends InventoryState {
  final String?  successMessage;

  const CreateDivisionConfigurationSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateDivisionConfigurationFailed extends InventoryState {
  final String error;

  const CreateDivisionConfigurationFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class DivisionConfigurationReadLoading extends InventoryState {}

class DivisionConfigurationReadSuccess extends InventoryState {
  final DivisionConfigRead divisionModel;
  DivisionConfigurationReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class DivisionConfigurationReadFailed extends InventoryState {
  final String error;
  const DivisionConfigurationReadFailed(this.error);
}
//deleteDiscount

class DeleteDivisionConfigurationLoading extends InventoryState {}

class DeleteDivisionConfigurationSuccess extends InventoryState {}

class DeleteDivisionConfigurationFailed extends InventoryState {}

//updateDiscount
class DivisionConfigurationUpdateInitial extends InventoryState {}

class DivisionConfigurationUpdateLoading extends InventoryState {}

class DivisionConfigurationUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const DivisionConfigurationUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class DivisionConfigurationUpdateFailed extends InventoryState {
  final String error;

  const DivisionConfigurationUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetDivisionConfigurationListLoading extends InventoryState {}

class GetDivisionConfigurationListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetDivisionConfigurationListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetDivisionConfigurationListFailed extends InventoryState {
  final String msg;
  GetDivisionConfigurationListFailed(this.msg);
}



//warrantyType
class CreateWarrantyTypeLoading extends InventoryState {}

class CreateWarrantyTypeSuccess extends InventoryState {
  final String?  successMessage;

  const CreateWarrantyTypeSuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateWarrantyTypeFailed extends InventoryState {
  final String error;

  const CreateWarrantyTypeFailed(this.error);
  @override
  List<Object> get props => [];
}
//reasd

class WarrantyTypeReadLoading extends InventoryState {}

class WarrantyTypeReadSuccess extends InventoryState {
  final WarrantyTypeRead readData;
  WarrantyTypeReadSuccess({required this.readData});
  @override
  List<Object> get props => [readData];
}

class WarrantyTypeReadFailed extends InventoryState {
  final String error;
  const WarrantyTypeReadFailed(this.error);
}
//deleteDiscount

class DeleteWarrantyTypeLoading extends InventoryState {}

class DeleteWarrantyTypeSuccess extends InventoryState {}

class DeleteWarrantyTypeFailed extends InventoryState {}

//updateDiscount
class WarrantyTypeUpdateInitial extends InventoryState {}

class WarrantyTypeUpdateLoading extends InventoryState {}

class WarrantyTypeUpdateSuccess extends InventoryState {
  final String?  successMessage;

  const WarrantyTypeUpdateSuccess({required this.successMessage});

  @override
  List<Object> get props => [];
}

class WarrantyTypeUpdateFailed extends InventoryState {
  final String error;

  const WarrantyTypeUpdateFailed(this.error);
  @override
  List<Object> get props => [];
}
class GetWarrantyTypeListLoading extends InventoryState {}

class GetWarrantyTypeListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetWarrantyTypeListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetWarrantyTypeListFailed extends InventoryState {
  final String msg;
  GetWarrantyTypeListFailed(this.msg);
}


//uomByGroup
class GetUomByUomGroupListLoading extends InventoryState {}

class GetUomByUomGroupListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetUomByUomGroupListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetUomByUomGroupListFailed extends InventoryState {
  final String msg;
  GetUomByUomGroupListFailed(this.msg);
}

//warranty
class CreateWarrantyLoading extends InventoryState {}

class CreateWarrantySuccess extends InventoryState {
  final String?  successMessage;

  const CreateWarrantySuccess({this.successMessage});

  @override
  List<Object> get props => [];
}

class CreateWarrantyFailed extends InventoryState {
  final String error;

  const CreateWarrantyFailed(this.error);
  @override
  List<Object> get props => [];
}

class GetWarrantyListLoading extends InventoryState {}

class GetWarrantyListSuccess extends InventoryState  {
  final List<InventoryModel>? inventory;
  final String? prevPageUrl;
  final String? nextPageUrl;
  const GetWarrantyListSuccess(
      {this.inventory, this.prevPageUrl, this.nextPageUrl});
}

class GetWarrantyListFailed extends InventoryState {
  final String msg;
  GetWarrantyListFailed(this.msg);
}

class WarrantyReadLoading extends InventoryState {}

class WarrantyReadSuccess extends InventoryState {
  final WarrantyReadModel divisionModel;
  WarrantyReadSuccess({required this.divisionModel});
  @override
  List<Object> get props => [divisionModel];
}

class WarrantyReadFailed extends InventoryState {
  final String error;
  const WarrantyReadFailed(this.error);
}
//deleteDiscount

class DeleteWarrantyLoading extends InventoryState {}

class DeleteWarrantySuccess extends InventoryState {}

class DeleteWarrantyFailed extends InventoryState {}

