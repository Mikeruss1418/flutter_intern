import 'package:equatable/equatable.dart';

class SearchParams extends Equatable {
  final String searchtxt;

  const SearchParams({required this.searchtxt});
  @override
  List<Object> get props => [searchtxt];
}
