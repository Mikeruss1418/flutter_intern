import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/check_if_added.dart';
import 'package:movie_app/domain/use_cases/delete_movie.dart';
import 'package:movie_app/domain/use_cases/get_movies.dart';
import 'package:movie_app/domain/use_cases/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final DeleteMovie deleteMovie;
  final GetMovies getMovies;
  final CheckIfAdded checkIfAdded;
  FavoriteBloc(
      {required this.saveMovie,
      required this.getMovies,
      required this.checkIfAdded,
      required this.deleteMovie})
      : super(FavoriteState.initial()) {
    on<LoadFavoriteEvent>(loadFavoriteEvent);
    on<ToggleFavoriteEvent>(toggleFavoriteEvent);
    on<DeleteFavoriteEvent>(deleteFavoriteEvent);
    on<CheckIfFavoriteEvent>(checkIfFavoriteEvent);
  }

  Future<void> loadFavoriteEvent(
      LoadFavoriteEvent event, Emitter<FavoriteState> emit) async {
    final Either<AppError, List<MovieEntity>> eitherresponse =
        await getMovies(NoParams());
    eitherresponse.fold(
      (l) => emit(state.copyWith(
          status: FavoriteStatus.fail, errorType: l.apperrortype)),
      (movies) {
        emit(state.copyWith(status: FavoriteStatus.loaded, movies: movies));
      },
    );
  }

  Future<void> toggleFavoriteEvent(
      ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (event.isFavorite) {
      await deleteMovie(MovieParams(event.movieEntity.id));
    } else {
      await saveMovie(event.movieEntity);
    }

    final response = await checkIfAdded(MovieParams(event.movieEntity.id));
    response.fold(
      (l) => emit(state.copyWith(
          status: FavoriteStatus.fail, errorType: l.apperrortype)),
      (r) {
        emit(state.copyWith(status: FavoriteStatus.isFavorite, isFavorite: r));
      },
    );
  }

  Future<void> deleteFavoriteEvent(
      DeleteFavoriteEvent event, Emitter<FavoriteState> emit) async {
    await deleteMovie(MovieParams(event.movieId));
    final Either<AppError, List<MovieEntity>> eitherresponse =
        await getMovies(NoParams());
    eitherresponse.fold(
      (l) => emit(state.copyWith(
          status: FavoriteStatus.fail, errorType: l.apperrortype)),
      (movies) {
        emit(state.copyWith(status: FavoriteStatus.loaded, movies: movies));
      },
    );
  }

  Future<void> checkIfFavoriteEvent(
      CheckIfFavoriteEvent event, Emitter<FavoriteState> emit) async {
    final response = await checkIfAdded(MovieParams(event.movieId));
    response.fold(
      (l) => emit(state.copyWith(
          status: FavoriteStatus.fail, errorType: l.apperrortype)),
      (r) {
        emit(state.copyWith(status: FavoriteStatus.isFavorite, isFavorite: r));
      },
    );
  }
}
