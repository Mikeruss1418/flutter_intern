import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

import '../entities/cast_entity.dart';
import '../entities/movie_params.dart';

class GetCast extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepos repos;

  GetCast(this.repos);
  @override
  Future<Either<AppError, List<CastEntity>>> call(MovieParams params) async {
    return await repos.getcastcrew(params.movieId);
  }
}
