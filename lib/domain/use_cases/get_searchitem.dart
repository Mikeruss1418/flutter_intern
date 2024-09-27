import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/search_params.dart';
import 'package:movie_app/domain/repos/movie_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class GetSearchItem extends UseCase<List<MovieEntity>, SearchParams> {
  final MovieRepos repos;

  GetSearchItem(this.repos);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(SearchParams params) async {
    return await repos.getSearch(params.searchtxt);
  }
}
