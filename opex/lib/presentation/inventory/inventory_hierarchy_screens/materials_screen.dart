import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cluster/presentation/inventory/widget/inventory_card.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import '../../mpos/search_card.dart';
import '../inventory_create_new_list.dart';
import '../model/create_variant_model.dart';

class InventoryMaterialScreen extends StatefulWidget {
  final Function(String)? onChangeItem;
  final Function(int)? onChangeItemId;
  final Function(int)? onChangeVariantId;
  final Function(BaseUomData?)? onChangeBaseUom;
  int? groupId;

  InventoryMaterialScreen(
      {Key? key, this.groupId, this.onChangeItem, this.onChangeItemId,this.onChangeVariantId,this.onChangeBaseUom})
      : super(key: key);

  @override
  State<InventoryMaterialScreen> createState() =>
      _InventoryMaterialScreenState();
}

class _InventoryMaterialScreenState extends State<InventoryMaterialScreen> {
  int? select = Variable.item;
  List<InventoryModel> item = [];

  bool isEmptyPage = false;
  bool _hasNextPage = true;
  dynamic _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  int page = 1;
  String url = "";
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  _loadMore() async {
    print("inside load more");
    if (_hasNextPage == true &&
        // _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      page += 1;
      print("inside");
      try {
        context.read<InventoryBloc>().add(GetItemEvent(id: widget.groupId,search:'',url: url));
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  bool isFailed = false;

  @override
  void initState() {
    context.read<InventoryBloc>().add(GetItemEvent(id: widget.groupId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    double h = MediaQuery.of(context).size.height;

    return BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          print("state$state");
          if (state is GetDivisionSuccess) {

            isFailed = false;
            for (var element in state.inventory!) {
              item.add(element);
            }

            _isFirstLoadRunning = false;
            if (state.nextPageUrl != null && state.nextPageUrl!.isNotEmpty) {
              url = state.nextPageUrl ?? "";
              print(url);
              print("Inside if");
              _hasNextPage = true;
            } else {
              print("Inside else");
              _hasNextPage = false;
            }
            print("item${item.length}");
            setState(() {});
        }
          if (state is GetDivisionFailed) {
            setState(() {
              isFailed = true;
            });
          }
          },
        child: Column(children: [
          // SizedBox(height: 20,),
          Text(
            "Select Item",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please search or select a item from the list below for the variant creation process.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff666161),
              fontSize: w / 25,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SearchCard(
            onchange: (String val) {
              print("search value$val");
              context.read<InventoryBloc>().add(GetItemEvent(id: widget.groupId,search: val));
            },
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: w1,
            // height: 328,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffe0e3e5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 8,
                  offset: Offset(1, 1),
                ),
              ],
              color: Color(0xfff7f7f7),
            ),
            child:
            isFailed
                ? Container(
              height: h / 2.5,
              child: Center(
                child: Text("Empty data"),
              ),
            )
                :item.isNotEmpty? LimitedBox(
              maxHeight: h / 2.5,
                  child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                  print("scrolllll end # $scrollEnd");
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;
                    if (isTop) {
                      print('At the top');
                    } else {
                      print('At the bottom');
                      print("urls inside scroll$url");
                      _loadMore();
                    }
                  }
                  return true;
              },
                    child:SmartRefresher(
                      enablePullUp: _hasNextPage && _isFirstLoadRunning
                          ? true
                          : false,
                      controller: refreshController,
                      enablePullDown: false,
                      onLoading: () {
                        // context.read<InventoryBloc>().add(GetStockPartitionEvent(id: authentication.authenticatedUser.organisationCode,url: url));
                      },
                      onRefresh: () {
                        // item.clear();
                        // context.read<InventoryBloc>().add(GetStockPartitionEvent(id: authentication.authenticatedUser.organisationCode,url: ''));
                        // // _firstLoad();
                        // setState(() {});
                        // refreshController.refreshCompleted();
                      },
                      child: ListView.separated(
              itemCount: item.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              primary: false,
              itemBuilder: (context, index) => GestureDetector(
                        child: InventoryCatProductCard(
                      onTap: () {
                        print("Variant FrameWork Id${item[index].variantFrameWorkData?.variantFrameworkId}");
                        print("Variant FrameWork Id${item[index].baseUomData?.uomCode}");
                        select = index;
                        setState(() {
                          Variable.item=index;
                          widget.onChangeItem!(item[index].name ?? "");
                          widget.onChangeItemId!(item[index].id ?? 0);
                          widget.onChangeVariantId!(item[index].variantFrameWorkData?.variantFrameworkId ?? 0);
                          widget.onChangeBaseUom!(item[index].baseUomData);

                        });
                      },
                      division: item[index].name,
                      isSelect: select == index,
              )),
              separatorBuilder: (context, index) => Divider(),
            ),
                    ),
                  ),
                ):customCupertinoLoading(),
          ),
          SizedBox(
            height: 20,
          ),
        ]));
  }
}
