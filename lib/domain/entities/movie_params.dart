import 'package:equatable/equatable.dart';
//acts as dataholder for request parameters required to call api

class MovieParams  extends Equatable{
  final int movieId;

  const MovieParams(this.movieId);

  @override
  List<Object?> get props => [movieId];
}