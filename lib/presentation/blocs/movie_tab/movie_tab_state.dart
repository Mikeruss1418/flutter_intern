part of 'movie_tab_bloc.dart';

enum MovieTabStatus { inital, success, fail }

class MovieTabState extends Equatable {
  const MovieTabState( {required this.status, this.currentindex, this.movies,this.appErrorType});
  final int? currentindex;
  final List<MovieEntity>? movies;
  final MovieTabStatus status;
  final AppErrorType? appErrorType;

  static MovieTabState initial() =>
      const MovieTabState(status: MovieTabStatus.inital);

  MovieTabState copyWith(
          {MovieTabStatus? status,
          AppErrorType? appErrorType,
          int? currentindex,
          List<MovieEntity>? movies}) =>
      MovieTabState(
          status: status ?? this.status,
          movies: movies ?? this.movies,
          appErrorType: appErrorType??  this.appErrorType,
          currentindex: currentindex ?? this.currentindex);

  @override
  List<Object> get props => [status, currentindex ?? 0, movies ?? [],appErrorType ?? ''];
}
/**
 * enum MovieTabbedStatus { initial, changed, loadError }

class MovieTabbedState extends Equatable {
  final MovieTabbedStatus status;
  final int currentTabIndex;
  final List<MovieEntity> movies;

  const MovieTabbedState({
    this.status = MovieTabbedStatus.initial,
    this.currentTabIndex,
    this.movies,
  });

  @override
  List<Object> get props => [status, currentTabIndex, movies];
}
 */