import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/extensions/num_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

import '../../../common/constants/size_constants.dart';
import 'movie_detail_appbar.dart';

class Poster extends StatelessWidget {
  final MovieDetailEntity movie;
  const Poster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(.3),
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie.posterpath}',
            width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              movie.releasedate,
              style: Theme.of(context).textTheme.greySubtitle1,
            ),
            trailing: Text(
              movie.voteAverage.convertToPercentageString(),
              // '${movie.voteAverage}',
              style: Theme.of(context).textTheme.violetHeadline6,
            ),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top:ScreenUtil().statusBarHeight + Sizes.dimen_4.h,
          child: MovieDetailAppBar())
      ],
    );
  }
}
/**
  Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
          child: MovieDetailAppBar(),
        ), */
