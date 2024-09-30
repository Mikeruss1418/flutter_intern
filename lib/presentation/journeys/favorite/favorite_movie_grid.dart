import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_args.dart';

import '../../../data/core/api_constants.dart';
import '../../blocs/favorite/favorite_bloc.dart';
import '../movie_detail/movie_detail_screen.dart';

class FavoriteMovieGrid extends StatelessWidget {
  final List<MovieEntity> movies;
  const FavoriteMovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .7,
          crossAxisSpacing: Sizes.dimen_16.w),
      itemBuilder: (context, index) {
        return Container(
          // margin: EdgeInsets.only(bottom: Sizes.dimen_8.h),
          // padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
            // color: Colors.amber,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailScrren(
                    movieDetailArgs: MovieDetailArgs(movies[index].id),
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.h, 20.h),
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.BASE_IMAGE_URL}${movies[index].posterpath}',
                      fit: BoxFit.contain,
                      width: 200.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => BlocProvider.of<FavoriteBloc>(context)
                          .add(DeleteFavoriteEvent(movieId: movies[index].id)),
                      child: Padding(
                        padding: EdgeInsets.all(Sizes.dimen_12.w),
                        child: Icon(
                          Icons.delete,
                          size: Sizes.dimen_24.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      movies[index].title.toolongtrim(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
