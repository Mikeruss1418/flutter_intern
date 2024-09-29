part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, loaded, fail, isFavorite }

class FavoriteState extends Equatable {
  const FavoriteState({required this.status, this.isFavorite, this.movies, this.errorType});
  final List<MovieEntity>? movies;
  final bool? isFavorite;
  final FavoriteStatus status;
  final AppErrorType? errorType;

  static FavoriteState initial() =>
      const FavoriteState(status: FavoriteStatus.initial);

  FavoriteState copyWith(
          {FavoriteStatus? status,
          List<MovieEntity>? movies,
          bool? isFavorite, AppErrorType? errorType}) =>
      FavoriteState(
          status: status ?? this.status,
          isFavorite: isFavorite ?? this.isFavorite,
          movies: movies ?? this.movies,
          errorType: errorType ?? this.errorType
          );
  @override
  List<Object> get props => [status, movies ?? '',isFavorite ?? '',errorType ?? ''];
}
