import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String posterpath;
  final int id;
  final String backdropath;
  final String title;
  final num voteAverage;
  final String releasedate;
  final String? overview;

  const MovieEntity({
    required this.posterpath,
    required this.id,
    required this.backdropath,
    required this.title,
    required this.voteAverage,
    required this.releasedate,
    this.overview,
  }) : assert(id !=null, 'Movie id must not be null');

  @override
  List<Object?> get props => [id, title];
  @override
  bool get stringify => true;
}
