import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cluster/presentation/inventory/widget/inventory_card.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import '../../mpos/search_card.dart';
import '../inventory_create_new_list.dart';

class InventoryDivisionScreen extends StatefulWidget {
  final Function(String)? onChangeDivision;
  final Function(int)? onChangeDivisionId;

  InventoryDivisionScreen(
      {Key? key, this.onChangeDivision, this.onChangeDivisionId})
      : super(key: key);

  @override
  State<InventoryDivisionScreen> createState() =>
      _InventoryDivisionScreenState();
}

class _InventoryDivisionScreenState extends State<InventoryDivisionScreen> {
  int? select = Variable.division;



  // List<InventoryModel> allVariants = [];
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
        context.read<InventoryBloc>().add(GetDivisionEvent(url: url));
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  bool isFailed=false;
  @override
  void initState() {
    context.read<InventoryBloc>().add(const GetDivisionEvent(search: '',url: ""));
    super.initState();
  }

  List<InventoryModel> division = [];

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    double h=MediaQuery.of(context).size.height;

    return BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          print("State${state}");
          if (state is GetDivisionSuccess) {
            isFailed=false;
            for (var element in state.inventory!) {
              division.add(element);
            }
            print("division listeyyyyyyy ${division.length}");
            // if (division.isEmpty) {
            //   for (var element in state.inventory!) {
            //     division.add(element);
            //   }
            // }
            // else if(_hasNextPage == true){
            //   for (var element in state.inventory!) {
            //     division.add(element);
            //   }
            // }
            // else{ for (var element in state.inventory!) {
            //   if (division.contains(element)) {
            //     print("heyyyyyw we dound ${element.name}");
            //   }
            //   else {
            //     division.add(element);
            //   }
            // }
            // }

            _isFirstLoadRunning = false;
            if (state.nextPageUrl != null && state.nextPageUrl!.isNotEmpty) {
              url=state.nextPageUrl??"";
              print(url);
              print("Inside if");
              _hasNextPage = true;
            } else {
              print("Inside else");
              _hasNextPage = false;
            }
            print("item${division.length}");
            setState(() {});

            // division = state.inventory ?? [];


            // print("state${division[0].name}");
          }
          if (state is GetDivisionLoading) {
            // return   customCupertinoLoading();
          }
          if (state is GetDivisionFailed) {
            setState(() {
              isFailed=true;
            });

            // group.clear();
            // division.clear();
            // setState(() {});

            // print("state${division[0].name}");
          }
        },
        child: Column(children: [
          // SizedBox(height: 20,),
          Text(
            "Select Division",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please search or select a division from the list below for the variant creation process.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff666161),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SearchCard(
            hint: "Search Division",
            onchange: (String val) {
              print("search value$val");
              division.clear();
              context.read<InventoryBloc>().add(GetDivisionEvent(search: val));
              setState(() {

              });
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
            child:isFailed? Container(
              height: h/2.5,
              child: Center(
                child: Text("Empty data"),
              ),
            ):division.isNotEmpty?LimitedBox(
              maxHeight: h/2.5,
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
                child: SmartRefresher(
                  enablePullUp:
                  _hasNextPage && _isFirstLoadRunning ? true : false,
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
                    itemCount: division.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: false,
                    itemBuilder: (context, index) => GestureDetector(
                        child: InventoryCatProductCard(
                          onTap: () {
                            select = index;
                            setState(() {
                              Variable.division = index;
                              widget.onChangeDivision!(
                                  division[index].displayName ?? "");
                              widget.onChangeDivisionId!(division[index].id ?? 0);
                            });
                          },
                          division: division[index].displayName,
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
        ])

    );
  }
}
