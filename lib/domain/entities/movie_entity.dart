import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';

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
  });

  @override
  List<Object?> get props => [id, title];
  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(
      MovieDetailEntity movieDetailEntity) {
    return MovieEntity(
        posterpath: movieDetailEntity.posterpath,
        id: movieDetailEntity.id,
        backdropath: movieDetailEntity.backdropath,
        title: movieDetailEntity.title,
        voteAverage: movieDetailEntity.voteAverage,
        releasedate: movieDetailEntity.releasedate);
  }
}
