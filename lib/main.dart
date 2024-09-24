import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc_observer.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/get_trend.dart';

import 'domain/entities/app_error.dart';
import 'presentation/movie_app.dart';

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

  runApp(MyApp());
}


