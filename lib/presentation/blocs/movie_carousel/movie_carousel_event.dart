part of 'movie_carousel_bloc.dart';

sealed class MovieCarouselEvent extends Equatable {
  const MovieCarouselEvent();

  @override
  List<Object> get props => [];
}

class CarouselLoadEvent extends MovieCarouselEvent {
  final int defaultindex;

  const CarouselLoadEvent({this.defaultindex = 0})
      : assert(defaultindex >= 0, 'defaultindex cannot be less than 0');

  @override
  List<Object> get props => [defaultindex];
}
