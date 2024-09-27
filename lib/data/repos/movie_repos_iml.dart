import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_datasource.dart';
import 'package:movie_app/data/models/castcrew_model.dart';
import 'package:movie_app/data/models/movie_detail_model.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/models/video_result_model.dart';
import 'package:movie_app/data/tables/movie_table.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';

class MovieReposIml extends MovieRepos {
  final MovieRemoteDatasource remotedatasource;
  final MovieLocalDataSource localDataSource;

  MovieReposIml(this.remotedatasource, this.localDataSource);

  @override
  Future<Either<AppError, List<MoviesModel>>> getTrending() async {
    try {
      final movies = await remotedatasource.getTrending();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MoviesModel>>> getNowPlaying() async {
    try {
      final movies = await remotedatasource.getNowPlaying();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MoviesModel>>> getPopular() async {
    try {
      final movies = await remotedatasource.getPopular();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MoviesModel>>> getUpcoming() async {
    try {
      final movies = await remotedatasource.getUpcoming();
      return Right(movies);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remotedatasource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      //checknetwork
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastDetail(int id) async {
    try {
      final castcrews = await remotedatasource.getCastDetail(id);
      return Right(castcrews);
    } on SocketException {
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id) async {
    try {
      final videos = await remotedatasource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, List<MoviesModel>>> getSearch(
      String searchtxt) async {
    try {
      final movies = await remotedatasource.getSearchItem(searchtxt);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.checknetwork));
    } on Exception {
      return const Left(AppError(AppErrorType.apicall));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfFavorite(int movieId) async {
    try {
      final response = await localDataSource.checkIfFavorite(movieId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getMovies() async {
    try {
      final response = await localDataSource.getMovies();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      final response = await localDataSource
          .saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
