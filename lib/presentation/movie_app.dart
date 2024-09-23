import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/journeys/home/home.dart';

import '../common/constants/language.dart';
import 'app_localization.dart';
import 'themes/app_colors.dart';
import 'themes/theme_text.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late LanguageBloc languageBloc;
  @override
  void initState() {
    super.initState();
    languageBloc = getit<LanguageBloc>();
  }

  @override
  void dispose() {
    languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 872),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => languageBloc,
          child: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state.status == LanguageStatus.toggled) {
                return MaterialApp(
                  title: 'Movie App',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: AppColors.vulcan,
                    scaffoldBackgroundColor: AppColors.vulcan,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: ThemeText.getTextTheme(),
                    appBarTheme: const AppBarTheme(elevation: 0),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: Language.languages
                      .map(
                        (e) => Locale(e.code),
                      )
                      .toList(),
                  locale:state.locale,
                  //  Locale(Language.languages[0].code),

                  home: const Home(),
                  // darkTheme: darkmode,
                );
              }
              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
