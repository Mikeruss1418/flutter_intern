import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

abstract class UseCase<Type, Params> {
  /**
   * Type: what does uscase return(output)
   * Params: wht is required to call Api(input)
   */
  Future<Either<AppError, Type>> call(Params params);
}
