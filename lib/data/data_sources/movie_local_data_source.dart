import 'package:hive/hive.dart';

import '../tables/movie_table.dart';

abstract class MovieLocalDataSource {
  Future saveMovie(MovieTable movieTable);
  Future<List<MovieTable>> getMovies();
  Future deleteMovie(int movieId);
  Future<bool> checkIfFavorite(int movieId);
}

class MovieLocalDataSourceIml extends MovieLocalDataSource {
  @override
  Future<bool> checkIfFavorite(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');

    /// This code snippet is retrieving all the keys (movieIds) from the Hive box named 'movieBox' and
    /// then iterating over each movieId to fetch the corresponding MovieTable object from the box. It
    /// is essentially fetching all the MovieTable objects stored in the 'movieBox' Hive box and adding
    /// them to a list named `movies`, which represents a list of favorite movies.
    final movieIds = movieBox.keys;
    List<MovieTable> movies = []; //list of favorite movies
    for (var movieId in movieIds) {
      movies.add(movieBox.get(movieId));
    }
    return movies;
  }

  @override
  Future saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
