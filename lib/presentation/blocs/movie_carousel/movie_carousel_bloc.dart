import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/use_cases/get_trend.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrend getTrend;
  final MovieBackdropBloc movieBackdropBloc;
  MovieCarouselBloc(this.getTrend, this.movieBackdropBloc)
      : super(MovieCarouselState.initial()) {
    on<CarouselLoadEvent>(carouselLoadEvent);
  }

  Future<void> carouselLoadEvent(
      CarouselLoadEvent event, Emitter<MovieCarouselState> emit) async {
    final moviesEither = await getTrend(NoParams());
    moviesEither.fold(
      (l) => emit(state.copyWith(status: CarouselStatus.error,errorType: l.apperrortype)),
      (movies) {
        movieBackdropBloc.
            add(MovieBackdropChangedEvent(movie: movies[event.defaultindex]));
        return emit(state.copyWith(
            status: CarouselStatus.success,
            movies: movies, //current if on right
            defaultindex: event.defaultindex));
      },
    );
  }
}
