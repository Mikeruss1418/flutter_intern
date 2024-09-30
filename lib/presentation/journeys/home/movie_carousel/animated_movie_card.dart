import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/journeys/home/movie_carousel/movie_card_widget.dart';

class AnimatedMovieCard extends StatelessWidget {
  final int index;
  final int movieId;
  final String posterpath;
  final PageController pagetcontroller;
  const AnimatedMovieCard(
      {super.key,
      required this.index,
      required this.movieId,
      required this.posterpath,
      required this.pagetcontroller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pagetcontroller,
      builder: (context, child) {
        double value = 1;
        if (pagetcontroller.position.haveDimensions) {
          value = pagetcontroller.page! - index;
          value = (1 - (value.abs() * .1)).clamp(0.0, 1);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Curves.easeIn.transform(value) *
                  // MediaQuery.of(context).size.height *
                  MediaQuery.sizeOf(context).height *
                  0.40,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Curves.easeIn.transform(index == 0 ? value : value * .5) *
                  MediaQuery.sizeOf(context).height *
                  0.45,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        }
      },
      child: MovieCardWidget(movieId: movieId, posterpath: posterpath),
    );
  }
}
