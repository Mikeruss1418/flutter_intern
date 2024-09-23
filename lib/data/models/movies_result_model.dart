import 'movies_model.dart';

class MoviesresultModel {
  List<MoviesModel>? movies;

  MoviesresultModel({this.movies});

  MoviesresultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <MoviesModel>[];
      json['results'].forEach((v) {
        movies!.add(MoviesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['results'] = movies!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
