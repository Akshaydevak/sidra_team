
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAutoHideAppBarDelegate extends SliverPersistentHeaderDelegate {
  const CustomAutoHideAppBarDelegate({
    @required this.child,
  });

  final Widget? child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: SizedBox(
          child: Material(
            color: Color(0xffF8F7F5),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(
                0,
              ),
              child: DefaultTextStyle.merge(
                style: theme.primaryTextTheme.subtitle1,
                child: IconTheme.merge(
                  data: theme.primaryIconTheme,
                  child: child!,
                ),
              ),
            ),
          ),
        ));
  }

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  bool shouldRebuild(CustomAutoHideAppBarDelegate oldDelegate) =>
      child != oldDelegate.child;
}
