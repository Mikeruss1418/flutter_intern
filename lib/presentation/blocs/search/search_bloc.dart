import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/search_params.dart';
import 'package:movie_app/domain/use_cases/get_searchitem.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchItem getSearchItem;
  SearchBloc({required this.getSearchItem}) : super(SearchState.initial()) {
    on<SearchTermChangedEvent>(searchMovieEvent);
  }

  Future<void> searchMovieEvent(
      SearchTermChangedEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
      //searching only starts when user types more than 2 words

      final Either<AppError, List<MovieEntity>> eitherresponse =
          await getSearchItem(SearchParams(searchtxt: event.searchtxt));
      eitherresponse.fold(
        (l) => emit(state.copyWith(
            status: SearchStatus.error, errorType: l.apperrortype)),
        (r) {
          emit(state.copyWith(status: SearchStatus.success, movies: r));
        },
      );
    
  }
}
