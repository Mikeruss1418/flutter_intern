import 'package:dartz/dartz.dart';

void main() {
  Option<int> someValue = some(10);
  Option<int> noneValue = none();

  someValue.fold(
    () => print('No value'),
    (value) => print('Value is $value'),
  );

  noneValue.fold(
    () => print('No value'),
    (value) => print('Value is $value'),
  );
}