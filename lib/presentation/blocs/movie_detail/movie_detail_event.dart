part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieSelectedDetailEvent extends MovieDetailEvent {
  final int movieId;

  MovieSelectedDetailEvent({required this.movieId});

  
  @override
  List<Object> get props => [movieId];
}
