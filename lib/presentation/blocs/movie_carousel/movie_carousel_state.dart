part of 'movie_carousel_bloc.dart';

enum CarouselStatus { initial, loading, success, error }

class MovieCarouselState extends Equatable {
  const MovieCarouselState({required this.status, this.movies, this.defaultindex});
  final CarouselStatus status;
  final List<MovieEntity>? movies;
  final int? defaultindex;

  static MovieCarouselState initial() =>
      const MovieCarouselState(status: CarouselStatus.initial);

  MovieCarouselState copyWith(
          {CarouselStatus? status, List<MovieEntity>? movies, int? defaultindex}) =>
      MovieCarouselState(
          status: status ?? this.status,
          defaultindex: defaultindex ?? this.defaultindex,
          movies: movies ?? this.movies);
  @override
  List<Object> get props => [status,movies?? [],defaultindex?? 0];
}
