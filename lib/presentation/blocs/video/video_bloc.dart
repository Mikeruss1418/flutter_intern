import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/domain/use_cases/get_videos.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideos getvideos;
  VideoBloc({required this.getvideos}) : super(VideoState.initial()) {
    on<VideoLoadEvent>(videoLoadEvent);
  }

  Future<void> videoLoadEvent(
      VideoLoadEvent event, Emitter<VideoState> emit) async {
    final Either<AppError, List<VideoEntity>> eitherresponse =
        await getvideos(MovieParams(event.movieId));

    eitherresponse.fold(
      (l) => emit(
          state.copytWith(status: VideoStatus.fail, errorType: l.apperrortype)),
      (video) {
        emit(state.copytWith(status: VideoStatus.success, videos: video));
      },
    );
  }
}
