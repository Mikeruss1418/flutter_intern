import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

import '../entities/app_error.dart';

class CheckIfAdded extends UseCase<bool, MovieParams> {
  final MovieRepos repos;

  CheckIfAdded(this.repos);

  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await repos.checkIfFavorite(params.movieId);
  }
}
