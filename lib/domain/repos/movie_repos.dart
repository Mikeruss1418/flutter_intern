import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/cast_entity.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/video_entity.dart';

abstract class MovieRepos {
  Future<Either<AppError, List<MovieEntity>>> trending();
  Future<Either<AppError, List<MovieEntity>>> popular();
  Future<Either<AppError, List<MovieEntity>>> upcoming();
  Future<Either<AppError, List<MovieEntity>>> nowplaying();
  Future<Either<AppError, MovieDetailEntity>> getmoviedetail(int id);
  Future<Either<AppError, List<CastEntity>>> getcastcrew(int id);
  Future<Either<AppError, List<VideoEntity>>> getvideo(int id);
}
