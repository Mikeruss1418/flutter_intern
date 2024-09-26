part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTermChangedEvent extends SearchEvent {
  final String searchtxt;

  const SearchTermChangedEvent({required this.searchtxt});
  @override
  List<Object> get props => [searchtxt];
}
