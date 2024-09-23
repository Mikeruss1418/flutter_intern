import 'package:flutter/material.dart';

import '../../../../domain/entities/movie_entity.dart';
import '../../../widgets/movie_app_bar.dart';
import '../../../widgets/separator.dart';
import 'movie_backdrop.dart';
import 'movie_data.dart';
import 'movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselWidget({
    super.key,
    required this.movies,
    required this.defaultIndex,
  }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const MovieBackdrop(),
        Column(
          children: [
            const MovieAppBar(),
            MoviePageView(
              //list of movies and the default index
              movies: movies,
              initialpage: defaultIndex,
            ),
            const MovieData(),
            const Separator(),
          ],
        ),
      ],
    );
  }
}
