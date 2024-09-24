import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/get_now_play.dart';
import 'package:movie_app/domain/use_cases/get_popular.dart';
import 'package:movie_app/domain/use_cases/get_upcoming.dart';

part 'movie_tab_event.dart';
part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopular getPopular;
  final GetNowPlay getNowPlay;
  final GetUpcoming getUpcoming;
  MovieTabBloc(
      {required this.getPopular,
      required this.getNowPlay,
      required this.getUpcoming})
      : super(MovieTabState.initial()) {
    on<MovieTabChangedEvent>(movieTabChangedEvent);
  }

  Future<void> movieTabChangedEvent(
      MovieTabChangedEvent event, Emitter<MovieTabState> emit) async {
    Either<AppError, List<MovieEntity>>? moviesEither;
    switch (event.currentindex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getNowPlay(NoParams());
        break;
      case 2:
        moviesEither = await getUpcoming(NoParams());
        break;
    }
    // emit(state.copyWith(status: MovieTabStatus.success, movies: []));
    moviesEither!.fold(
      (l) => emit(state.copyWith(
          status: MovieTabStatus.fail,
          currentindex: event.currentindex,
          appErrorType: l.apperrortype)),
      (movies) {
        return emit(state.copyWith(
            status: MovieTabStatus.success,
            currentindex: event.currentindex,
            movies: movies));
      },
    );
  }
}
