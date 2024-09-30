import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/repos/app_repos.dart';
import 'package:movie_app/domain/use_cases/usecase.dart';

class PreferredLang extends UseCase<String, NoParams> {
  final AppRepos repos;

  PreferredLang(this.repos);

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await repos.getPreferredlang();
  }
}
