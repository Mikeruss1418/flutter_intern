import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_screen.dart';
import 'package:wiredash/wiredash.dart';

import '../../../common/constants/language.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation.dart';
import '../../blocs/language/language_bloc.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/logo.dart';
import 'navigation_expanded.dart';
import 'navigation_listitem.dart';

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
              title: (Translation.favoriteMovies).t(context),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteScreen(),
                    ));
              }),
          NavigationExpanded(
              // title: (Translation.language).t(context),
              title: 'Languages',
              onPressed: (index) {
                BlocProvider.of<LanguageBloc>(context)
                    .add(ToggleLangEvent(language: Language.languages[index]));
              },
              children: Language.languages
                  .map(
                    (e) => e.value,
                  )
                  .toList()),
          NavigationListitem(
              title: (Translation.feedback).t(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context).show(inheritMaterialTheme: true);
              }),
          NavigationListitem(
              title: (Translation.about).t(context),
              onPressed: () {
                Navigator.of(context).pop();
                _dialog(context);
              }),
        ],
      ),
    );
  }

  void _dialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AboutUsDialog(
          title: Translation.about,
          description: Translation.aboutDescription,
          buttontxt: Translation.okay,
          imagelogo: Image.asset(
            'assets/pngs/tmdb_logo.png',
            height: Sizes.dimen_100,
          ),
        );
      },
    );
  }
}
