import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/apiclient.dart';
import 'package:movie_app/data/data_sources/movie_remote_datasource.dart';
import 'package:movie_app/data/repos/movie_repos_iml.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/get_now_play.dart';
import 'package:movie_app/domain/use_cases/get_popular.dart';
import 'package:movie_app/domain/use_cases/get_trend.dart';
import 'package:movie_app/domain/use_cases/get_upcoming.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';

final getit = GetIt.instance;

void init() {
  getit.registerLazySingleton<Client>(() => Client());
  getit.registerLazySingleton<Apiclient>(() => Apiclient(getit()));
  getit.registerLazySingleton<MovieRemoteDatasource>(
      () => MovieremoteDatasourceIml(getit()));
  getit.registerLazySingleton<MovieRepos>(() => MovieReposIml(getit()));
  getit.registerLazySingleton<GetTrend>(() => GetTrend(getit()));
  getit.registerLazySingleton<GetUpcoming>(() => GetUpcoming(getit()));
  getit.registerLazySingleton<GetPopular>(() => GetPopular(getit()));
  getit.registerLazySingleton<GetNowPlay>(() => GetNowPlay(getit()));
  getit.registerFactory(() => MovieCarouselBloc(
      getit(), getit())); //for get trend and for movieBackdropbloc
  getit.registerFactory(() => MovieBackdropBloc(getit));
  //to get the same instance of the bloc use this code
  // getit.registerLazySingleton(() => MovieBackdropBloc(getit));
  getit.registerFactory(
    () => MovieTabBloc(getNowPlay: getit(),getPopular: getit(),getUpcoming: getit()),
  );
}
