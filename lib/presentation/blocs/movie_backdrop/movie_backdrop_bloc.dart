import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropState.initial()) {
    on<MovieBackdropChangedEvent>(movieBackdropChangedEvent);
  }

  FutureOr<void> movieBackdropChangedEvent(
      MovieBackdropChangedEvent event, Emitter<MovieBackdropState> emit) {
    emit(state.copyWith(
      status: MovieBackdropStatus.success,
      movie: event.movie
    ));
  }
}
