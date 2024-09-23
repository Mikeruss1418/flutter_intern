import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_listitem.dart';

import '../../../common/constants/size_constants.dart';

class NavigationExpanded extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final List<String> children;
  const NavigationExpanded(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            )
          ],
        ),
        child: ExpansionTile(
          collapsedShape: const RoundedRectangleBorder(
              side: BorderSide.none), //when collpases if there is?
          shape: const RoundedRectangleBorder(
              side: BorderSide.none), //when expanded
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            for (int i = 0; i < children.length; i++)
              Padding(
                padding: EdgeInsets.only(left: Sizes.dimen_16.w),
                child: NavigationSubListItem(
                  title: children[i],
                  onPressed: onPressed,
                ),
              )
          ],
        ),
      ),
    );
  }
}
