import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white, // Navigation bar
                statusBarColor: ColorPalette.primary, // Status bar
              ),
              expandedHeight: 104,
              floating: true,
              pinned: true,
              snap: false,
              titleSpacing: 0,
              backgroundColor: ColorPalette.primary,
              // title: Padding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
              //   child: Text(
              //     "My List",
              //     style: TextStyle(color: Colors.grey, fontSize: 26),
              //   ),
              // ),
              bottom: AppBar(
                elevation: 0,
                titleSpacing: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  systemNavigationBarColor: Colors.white, // Navigation bar
                  statusBarColor: ColorPalette.primary, // Status bar
                ),
                backgroundColor: ColorPalette.primary,
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                  child: Container(
                    height: 48,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black),
                          child: Icon(Icons.date_range),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          Text("bakjfnrvfsdokjgrhknmd"),
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: 80)
                  //the list of the menu
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
