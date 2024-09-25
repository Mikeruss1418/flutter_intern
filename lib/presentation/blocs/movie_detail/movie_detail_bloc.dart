import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/use_cases/get_movie_details.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails movieDetails;
  MovieDetailBloc({required this.movieDetails})
      : super(MovieDetailState.initial()) {
    on<MovieSelectedDetailEvent>(movieSelectedDetailEvent);
  }

  Future<void> movieSelectedDetailEvent(
      MovieSelectedDetailEvent event, Emitter<MovieDetailState> emit) async {
    final Either<AppError, MovieDetailEntity> eitherresponse =
        await movieDetails(MovieParams(event.movieId));
    eitherresponse.fold(
      (l) => emit(state.copyWith(status: MovieDetailStatus.fail)),
      (movie) {
        return emit(state.copyWith(status: MovieDetailStatus.success,moviedetail: movie));
      },
    );
  }
}
