import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/data/core/api_constants.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterpath;
  const MovieCardWidget(
      {super.key, required this.movieId, required this.posterpath});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular((Sizes.dimen_16.w).toDouble()),
      child: GestureDetector(
        onTap: () {
          
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular((Sizes.dimen_16.w).toDouble()),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterpath',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
