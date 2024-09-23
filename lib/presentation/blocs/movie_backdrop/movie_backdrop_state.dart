part of 'movie_backdrop_bloc.dart';

enum MovieBackdropStatus { inital, success, fail }

class MovieBackdropState extends Equatable {
  const MovieBackdropState({required this.status, this.movie});
  final MovieBackdropStatus status;
  final MovieEntity? movie;

  static MovieBackdropState initial() =>
      const MovieBackdropState(status: MovieBackdropStatus.inital);

  MovieBackdropState copyWith(
          {MovieBackdropStatus? status, MovieEntity? movie}) =>
      MovieBackdropState(
          status: status ?? this.status, movie: movie ?? this.movie);
  @override
  List<Object> get props => [status, movie ?? ''];
}
