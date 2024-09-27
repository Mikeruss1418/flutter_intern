import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

import '../entities/app_error.dart';

class DeleteMovie extends UseCase<void, MovieParams> {
  final MovieRepos repos;

  DeleteMovie(this.repos);

  @override
  Future<Either<AppError, void>> call(MovieParams params) async {
    return await repos.deleteMovie(params.movieId);
  }
}
