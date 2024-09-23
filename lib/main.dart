import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/get_trend.dart';
import 'package:movie_app/presentation/journeys/home/home.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

import 'domain/entities/app_error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  init();
  GetTrend getTrend = getit<GetTrend>();
  final Either<AppError, List<MovieEntity>> eitherresponse =
      await getTrend(NoParams());
  eitherresponse.fold(
    (l) {
      log('error');
      log('$l');
    },
    (r) {
      log('List of movies');
      log('$r ');
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 872),
      minTextAdapt: true,
      builder: (context, child) {
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
          home: const Home(),
          // darkTheme: darkmode,
        );
      },
    );
  }
}
