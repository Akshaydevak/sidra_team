import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/logistic_app/bloc/bloc/logistics_orders_bloc.dart';
import 'package:cluster/presentation/logistic_app/model/logistics_model.dart';
import 'package:cluster/presentation/logistic_app/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../../mpos/search_card.dart';
import '../../order_app/order_view.dart';
import 'order_view.dart';

class NewOrderList extends StatefulWidget {
  const NewOrderList({Key? key}) : super(key: key);

  @override
  State<NewOrderList> createState() => _NewOrderListState();
}

class _NewOrderListState extends State<NewOrderList> {
  @override
  void initState() {
    context.read<LogisticsOrdersBloc>().add(GetLogisticsOrdersEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "New Orders",
          isAction: false,
          action: SvgPicture.string(
            TaskSvg().notificationIcon,
            color: Colors.black,
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SearchCard(),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<LogisticsOrdersBloc, LogisticsOrdersState>(
                  builder: (context, state) {
                    if (state is NewOrdersListSuccess) {
                      return Container(
                        // height: 400,
                        child: ListView.separated(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: state.ordersList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: LogisticOrderView(
                                    variantName: state
                                        .ordersList[index]
                                        .orderLineData
                                        ?.orderLinesMeta
                                        ?.cartData
                                        ?.variantName,
                                  ),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                                //OrderView
                              },
                              child: OrderCard(
                                address:
                                    "${state.ordersList[index].orderLineData?.orderLinesMeta?.cartData?.addressData?.streetName ?? ""}, ${state.ordersList[index].orderLineData?.orderLinesMeta?.cartData?.addressData?.city.toString()}, ${state.ordersList[index].orderLineData?.orderLinesMeta?.cartData?.addressData?.state.toString()}, ${state.ordersList[index].orderLineData?.orderLinesMeta?.cartData?.addressData?.country.toString()}",
                                name: state
                                        .ordersList[index]
                                        .orderLineData
                                        ?.orderLinesMeta
                                        ?.cartData
                                        ?.addressData
                                        ?.fullName ??
                                    "",
                                date: state
                                    .ordersList[index].orderLineData?.created,
                              )),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
