/// The `MovieTable` class in Dart extends `MovieEntity` and includes fields for movie details with
/// optional poster path and methods for conversion to and from `MovieEntity`.

import 'package:hive/hive.dart';

import '../../domain/entities/movie_entity.dart';


part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterPath;  // Poster path can be nullable, if necessary

  const MovieTable({
    required this.id,   // Mark as required
    required this.title, // Mark as required
    this.posterPath,     // Poster path is optional (nullable)
  }) : super(
          id: id,
          title: title,
          posterpath: posterPath?? '',
          backdropath: '',   // Provide default values for the missing parameters
          releasedate: '',
          voteAverage: 0,
          overview: ''
        );

  factory MovieTable.fromMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
      id: movieEntity.id,
      title: movieEntity.title,
      posterPath: movieEntity.posterpath,
    );
  }

  MovieEntity toMovieEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterpath: posterPath ?? '',  // Provide a fallback value if null
      backdropath: '',
      releasedate: '',
      voteAverage: 0,
    );
  }
}
