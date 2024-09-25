import 'dart:convert';

import 'package:movie_app/data/core/apiclient.dart';
import 'package:movie_app/data/models/castcrew_model.dart';
import 'package:movie_app/data/models/movie_detail_model.dart';

import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';
import "dart:developer";

abstract class MovieRemoteDatasource {
  Future<List<MoviesModel>> trending();
  Future<List<MoviesModel>> popular();
  Future<List<MoviesModel>> nowplaying();
  Future<List<MoviesModel>> upcoming();
  Future<MovieDetailModel> moviedetail(int id);
  Future<List<CastModel>> castdetail(int id);
}

class MovieremoteDatasourceIml extends MovieRemoteDatasource {
  final Apiclient _client;

  MovieremoteDatasourceIml(this._client);

  @override
  Future<List<MoviesModel>> trending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesresultModel.fromJson(response).movies;
    log('$movies');
    return movies!;
  }

  @override
  Future<List<MoviesModel>> popular() async {
    final response = await _client.get('movie/popular');
    final movies = MoviesresultModel.fromJson(response).movies;
    log('$movies');
    return movies!;
  }

  @override
  Future<List<MoviesModel>> nowplaying() async {
    final response = await _client.get('movie/now_playing');
    final movies = MoviesresultModel.fromJson(response).movies;
    log('$movies');
    return movies!;
  }

  @override
  Future<List<MoviesModel>> upcoming() async {
    final response = await _client.get('movie/upcoming');
    final movies = MoviesresultModel.fromJson(response).movies;
    log('$movies');
    return movies!;
  }

  @override
  Future<MovieDetailModel> moviedetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    log('$movie');
    return movie;
  }

  @override
  Future<List<CastModel>> castdetail(int id) async {
    final response = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    log('$cast');
    return cast!;
  }
}
