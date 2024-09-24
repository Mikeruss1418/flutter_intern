import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data_sources/movie_remote_datasource.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';

class MovieReposIml extends MovieRepos {
  final MovieRemoteDatasource remotedatasource;

  MovieReposIml(this.remotedatasource);

  @override
  Future<Either<AppError, List<MoviesModel>>> trending() async {
    try {
      final movies = await remotedatasource.trending();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> nowplaying() async {
    try {
      final movies = await remotedatasource.nowplaying();
      return Right(movies);
    }  on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> popular() async {
    try {
      final movies = await remotedatasource.popular();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> upcoming() async {
    try {
      final movies = await remotedatasource.upcoming();
      return Right(movies);
    }  on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }
}
