import 'package:movie_app/data/core/apiclient.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/models/movies_result_model.dart';
import "dart:developer";

abstract class MovieRemoteDatasource {
  Future<List<MoviesModel>> trending();
  Future<List<MoviesModel>> popular();
  Future<List<MoviesModel>> nowplaying();
  Future<List<MoviesModel>> upcoming();
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
}
