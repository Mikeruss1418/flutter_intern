part of 'cast_bloc.dart';

enum CastStatus { initial, loading, success, fail }

class CastState extends Equatable {
  const CastState({required this.status, this.errorType, this.casts});
  final CastStatus status;
  final AppErrorType? errorType;
  final List<CastEntity>? casts;

  static CastState initial() => const CastState(status: CastStatus.initial);

  CastState copyWith({CastStatus? status, AppErrorType? errorType, List<CastEntity>? casts}) =>
      CastState(
          status: status ?? this.status, errorType: errorType ??this.errorType, casts:casts ?? this.casts );

  @override
  List<Object> get props => [status, errorType ?? '',casts ?? []];
}
