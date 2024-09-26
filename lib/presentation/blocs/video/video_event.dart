part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class VideoLoadEvent extends VideoEvent {
  final int movieId;

  const VideoLoadEvent({required this.movieId});
  
  @override
  List<Object> get props => [movieId];
}
