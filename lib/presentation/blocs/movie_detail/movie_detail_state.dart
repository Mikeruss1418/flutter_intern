part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, success, fail }

class MovieDetailState extends Equatable {
  const MovieDetailState({required this.status, this.moviedetail, this.errorType});
  final MovieDetailStatus status;
  final MovieDetailEntity? moviedetail;
  final AppErrorType? errorType;

  static MovieDetailState initial() =>
      const MovieDetailState(status: MovieDetailStatus.initial);

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailEntity? moviedetail,
    AppErrorType? errorType,
  }) =>
      MovieDetailState(
          status: status ?? this.status,
          errorType: errorType ?? this.errorType,
          moviedetail: moviedetail ?? this.moviedetail);

  @override
  List<Object> get props => [status, moviedetail ?? ''];
}
