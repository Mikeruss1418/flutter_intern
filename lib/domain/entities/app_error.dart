import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType apperrortype;

  const AppError(this.apperrortype);

  @override
  List<Object> get props => [apperrortype];
}
enum AppErrorType {
  apicall, checknetwork
}