import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/use_cases/get_cast.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getcrew;
  CastBloc({required this.getcrew}) : super(CastState.initial()) {
    on<CastLoadEvent>(castLoadEvent);
  }

  Future<void> castLoadEvent(
      CastLoadEvent event, Emitter<CastState> emit) async {
    final Either<AppError, List<CastEntity>> eitherresponse =
        await getcrew(MovieParams(event.movieId));

    eitherresponse.fold(
      (l) => emit(state.copyWith(status: CastStatus.fail)),
      (cast) {
        emit(state.copyWith(status: CastStatus.success, casts: cast));
      },
    );
  }
}
