import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/bloc_observer.dart';
import 'package:movie_app/dep_inj/get_it.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'presentation/movie_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setupGetIt();
  final appDocsDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocsDir.path);
  // GetTrend getTrend = getit<GetTrend>();
  // final Either<AppError, List<MovieEntity>> eitherresponse =
  //     await getTrend(NoParams());
  // eitherresponse.fold(
  //   (l) {
  //     log('error');
  //     log('$l');
  //   },
  //   (r) {
  //     log('List of movies');
  //     log('$r ');
  //   },
  // );

  runApp(const MyApp());
}
