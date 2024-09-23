import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';

import '../../../../common/constants/size_constants.dart';

class MovieTabCard extends StatelessWidget {
  final int movieId;
  final String title;
  final String posterpath;
  const MovieTabCard(
      {super.key,
      required this.movieId,
      required this.title,
      required this.posterpath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterpath',
              fit: BoxFit.cover,
            ),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              title.toolongtrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

        ],
      ),
    );
  }
}
