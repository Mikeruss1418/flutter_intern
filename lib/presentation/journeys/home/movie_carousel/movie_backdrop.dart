import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

class MovieBackdrop extends StatelessWidget {
  const MovieBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: .7,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(Sizes.dimen_40.w)),
        child: Stack(
          children: [
            const FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
            ),
            BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
              builder: (context, state) {
                if (state.status == MovieBackdropStatus.success) {
                  return CachedNetworkImage(
                    imageUrl:
                        '${ApiConstants.BASE_IMAGE_URL}${state.movie?.backdropath}',
                    fit: BoxFit.fitHeight,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.transparent,
            ),
            )
          ],
        ),
      ),
    );
  }
}
