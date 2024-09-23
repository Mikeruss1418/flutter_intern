import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/language.dart';
import 'package:movie_app/common/constants/translation.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_expanded.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_listitem.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

import '../../../common/constants/size_constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          )
        ],
      ),
      width: Sizes.dimen_300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                right: Sizes.dimen_8.w,
                left: Sizes.dimen_8.w),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Logo(height: Sizes.dimen_110.h),
          ),
          NavigationListitem(
              title: (Translation.favoriteMovies).t(context), onPressed: () {}),
          NavigationExpanded(
              title: (Translation.language).t(context),
              onPressed: () {
                BlocProvider.of<LanguageBloc>(context)
                    .add(ToggleLangEvent(Language.languages[1]));
              },
              children: Language.languages
                  .map(
                    (e) => e.value,
                  )
                  .toList()),
          NavigationListitem(
              title: (Translation.feedback).t(context), onPressed: () {}),
          NavigationListitem(
              title: (Translation.about).t(context), onPressed: () {}),
        ],
      ),
    );
  }
}
