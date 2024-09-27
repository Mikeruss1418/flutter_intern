import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class GetTrend extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepos repos;

  GetTrend(this.repos);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams params) async {
    return await repos.getTrending();
  }
}
