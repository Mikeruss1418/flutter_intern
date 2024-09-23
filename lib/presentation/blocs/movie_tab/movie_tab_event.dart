part of 'movie_tab_bloc.dart';

sealed class MovieTabEvent extends Equatable {
  const MovieTabEvent();

  @override
  List<Object> get props => [];
}

class MovieTabChangedEvent extends MovieTabEvent {
  final int currentindex;

  const MovieTabChangedEvent({this.currentindex=0});

  @override
  List<Object> get props => [currentindex];
}
