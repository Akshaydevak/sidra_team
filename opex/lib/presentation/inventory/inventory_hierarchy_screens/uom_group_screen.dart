import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/inventory/widget/inventory_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';

import '../../../common_widgets/loading.dart';
import '../../mpos/search_card.dart';
class InventoryUOMScreen extends StatefulWidget {
  final Function(String)? onChangeUOM;
  final Function(int)? onChangeUOMId;
  int? itemId;
  InventoryUOMScreen({Key? key, this.onChangeUOM,this.onChangeUOMId,this.itemId}) : super(key: key);

  @override
  State<InventoryUOMScreen> createState() => _InventoryUOMScreenState();
}

class _InventoryUOMScreenState extends State<InventoryUOMScreen> {
  int ?select=Variable.uom;
  List<InventoryModel>group=[];

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
        context.read<InventoryBloc>().add(GetUomEvent(id: widget.itemId,search:'',url: url));
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
    context.read<InventoryBloc>().add( GetUomEvent(id: widget.itemId));
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
          if(state is GetDivisionSuccess){

            isFailed = false;
            for (var element in state.inventory!) {
              group.add(element);
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
            print("item${group.length}");
            setState(() {});
            // group=state.inventory??[];
            // setState(() {
            //
            // });
            // for(int i=0;i<=state.inventory.length;i++){
            //   group.add(state.inventory[i].name??"");
            // }
            // print("state${group[0].name}");
          }
          if (state is GetDivisionFailed) {
            setState(() {
              isFailed = true;
            });
          }
        },
        child:
        Column(
            children: [


              Text(
                "Select UOM",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Please search or select a uom from the list below for the variant creation process.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff666161),
                  fontSize:  w/25,
                ),
              ),
              SizedBox(height: 10,),
              SearchCard(
                onchange: (String val) {
                  print("search value$val");
                  context
                      .read<InventoryBloc>()
                      .add(GetGroupEvent(id: widget.itemId,search:val));

                },
              ),
              SizedBox(height: 5,),
              Container(
                width: w1,
                // height: 328,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffe0e3e5), width: 1, ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Color(0xfff7f7f7),
                ),
                child: isFailed
                    ? Container(
                  height: h / 2.5,
                  child: Center(
                    child: Text("Empty data"),
                  ),
                )
                    :group.isNotEmpty? LimitedBox(
                  maxHeight: h / 2.5,
                  child:  NotificationListener<ScrollEndNotification>(
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
                    child: SmartRefresher(
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
                        itemCount: group.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        itemBuilder: (context, index) => GestureDetector(
                            child: InventoryCatProductCard(
                              onTap: (){
                                select=index;
                                setState(() {
                                  Variable.uom=index;
                                  widget.onChangeUOM!(group[index].name??"");
                                  widget.onChangeUOMId!(group[index].id??0);
                                });
                              },
                              division:group[index].name,isSelect: select==index,)),
                        // CatProductCard(division: group[index].name),
                        separatorBuilder: (context, index) => Divider(),
                      ),
                    ),
                  ),
                ):customCupertinoLoading(),
              ),
              SizedBox(height: 20,),
            ]
        )
    );
  }
}
