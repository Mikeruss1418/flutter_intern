part of 'video_bloc.dart';

enum VideoStatus { initial, success, fail }

class VideoState extends Equatable {
  const VideoState({required this.status, this.errorType, this.videos});
  final VideoStatus status;
  final AppErrorType? errorType;
  final List<VideoEntity>? videos;

  static VideoState initial() => const VideoState(status: VideoStatus.initial);

  VideoState copytWith({
    VideoStatus? status,
    AppErrorType? errorType,
    List<VideoEntity>? videos,
  }) =>
      VideoState(
        status: status ?? this.status,
        errorType: errorType ?? this.errorType,
        videos: videos ?? this.videos,
      );

  @override
  List<Object> get props => [status, errorType ?? '', videos ?? []];
}
