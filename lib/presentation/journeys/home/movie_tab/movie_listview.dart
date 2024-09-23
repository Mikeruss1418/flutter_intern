import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/movie_tab_card.dart';

class MovieListview extends StatelessWidget {
  final List<MovieEntity> movies;
  const MovieListview({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 6.h),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final MovieEntity movie = movies[index];
            return MovieTabCard(
                movieId: movie.id,
                title: movie.title,
                posterpath: movie.posterpath);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 14.w,
            );
          },
          itemCount: movies.length),
    );
  }
}
