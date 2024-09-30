import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/journeys/home/movie_carousel/animated_movie_card.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialpage;
  const MoviePageView(
      {super.key, required this.movies, required this.initialpage})
      : assert(initialpage >= 0, 'initialpage should be greater than 0');

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.initialpage,
        keepPage: false,
        viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: (Sizes.dimen_10.h)),
      height: MediaQuery.sizeOf(context).height * 0.42,
      child: PageView.builder(
        controller: _pageController,
        // scrollDirection: Axis.vertical,
        pageSnapping: true,
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies[index];
          return AnimatedMovieCard(
              index: index,
              movieId: movie.id,
              posterpath: movie.posterpath,
              pagetcontroller: _pageController);
          // MovieCardWidget(
          //     movieId: movie.id, posterpath: movie.posterpath);
        },
        itemCount: widget.movies.length,
        onPageChanged: (value) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(MovieBackdropChangedEvent(movie: widget.movies[value]));
        },
      ),
    );
  }
}
