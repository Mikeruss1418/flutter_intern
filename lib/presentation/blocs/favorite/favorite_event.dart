part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteEvent extends FavoriteEvent {
  // final List<MovieEntity> movielist;

  const LoadFavoriteEvent();
  @override
  List<Object> get props => [];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final MovieEntity movieEntity;
  final bool isFavorite;

  const ToggleFavoriteEvent(
      {required this.movieEntity, required this.isFavorite});
  @override
  List<Object> get props => [movieEntity, isFavorite];
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final int movieId;

  const DeleteFavoriteEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}

class CheckIfFavoriteEvent extends FavoriteEvent {
  final int movieId;

  const CheckIfFavoriteEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}
