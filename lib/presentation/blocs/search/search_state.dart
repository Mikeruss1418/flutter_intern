part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, error }

class SearchState extends Equatable {
  const SearchState({required this.status, this.movies, this.errorType});
  final SearchStatus status;
  final List<MovieEntity>? movies;
  final AppErrorType? errorType;

  static SearchState initial() => const SearchState(status: SearchStatus.initial);

  SearchState copyWith(
          {SearchStatus? status,
          List<MovieEntity>? movies,
          AppErrorType? errorType}) =>
      SearchState(
        status: status ?? this.status,
        movies: movies ?? this.movies,
        errorType: errorType ?? this.errorType,
      );

  @override
  List<Object> get props => [status, movies ?? '', errorType ?? ''];
}
