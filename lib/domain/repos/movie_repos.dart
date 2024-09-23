import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

abstract class MovieRepos {
  Future<Either<AppError,List<MovieEntity>>> trending();
  Future<Either<AppError,List<MovieEntity>>> popular();
  Future<Either<AppError,List<MovieEntity>>> upcoming();
  Future<Either<AppError,List<MovieEntity>>> nowplaying();
}
